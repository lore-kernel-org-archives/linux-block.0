Received: from mta0.migadu.com (out-217.mta0.migadu.com [91.218.175.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7FD3E7173
	for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 10:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170846; cv=none; b=iFd/TplaD0dBopSgcuXnrQdVaka3ItLTPLyWAq5cqzkWFYmBogjZtEl79vnpiCjJjB/BXBpcNfYe7IsTTxQn6JTvkhM25GZeA5p8HPNj2u/7/PJpGNyUl4rMFuw5lk4lmrr2EN3sInL4qaKskx7emUXbYWLW7CFWiSxpGczWQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170846; c=relaxed/simple;
	bh=L8sCA1hR0yKQaKvtbOB+F+dFt6CAS+8pOknhGBWJJP0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nIvs+0LlCxpNo5xvKlpDdC0DM2Xf9XELgYmnxjwn1BBJprKpXYjZrStOOrrc4r762vihhRHdElvXs/yKtjUyv6Ubw9s/OZE40TxzuzWwg5HzjUusVbuQTnk2/e5RZ53VMYoX14v4ueAYb3G4YlG9M1pdCmEmcXAM/P/+h9BibXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JpqhbaVW; arc=none smtp.client-ip=91.218.175.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JpqhbaVW"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=L8sCA1hR0yKQaKvtbOB+F+dFt6CAS+8pOknhGBWJJP0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788170842; v=1; x=1788775642;
 b=JpqhbaVWQx16Tqxk1v+JNW04XHFGh1rf7K5LAiGL6GP5C0qfSQZY2fT2u2uRsd6z59wXIZP5
 J6RecwpRCzPFfFVo5O9w1RY/0dwzqaB761Gnm7LPSAI/ymG76uJ/3pN+Ogz5BQvxrXWunde0SsA
 hzEm8JxKEjwd2wxVCP2ha+Rk=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5c7f071e8e369887;
	Mon, 31 Aug 2026 10:07:12 +0000
X-Mizu-Trace-ID: 5c7f071e8e369887
X-Migadu-Flow: FLOW_OUT
Message-ID: <276b50cc-6b92-425f-8f70-25b2fade14c0@linux.dev>
Date: Mon, 31 Aug 2026 18:07:06 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, hch@lst.de, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2 2/3] loop: replace simple_strtol() with kstrtoint()
To: bvanassche@acm.org, axboe@kernel.dk
References: <20260831100305.695116-1-cui.tao@linux.dev>
 <20260831100305.695116-3-cui.tao@linux.dev>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <20260831100305.695116-3-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Hi Bart,

在 2026/8/31 18:03, Tao Cui 写道:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> simple_strtol() is deprecated and swallows errors.  Use kstrtoint()
> in the max_loop setup code; an invalid option keeps the default and
> now says so.
> 
> Only mark max_loop_specified when the option was parsed successfully.
> With simple_strtol() a garbage string yields max_loop = 0, and
> loop_probe()'s "max_loop_specified && max_loop" check short-circuits
> on 0, so legacy autoloading is not capped.  Keeping max_loop at its
> default while still setting max_loop_specified would instead turn the
> default into a hard upper bound for dynamic device creation.  This
> mirrors what max_loop_param_set_int() already does for the module
> parameter.
> 

Thanks for the review!

After sending v1 I noticed a regression in this patch, so I'll follow
up with a v2 of just this one (1/3 and 3/3 are unchanged and keep your
Reviewed-by).

With simple_strtol() a garbage max_loop= string yields max_loop = 0,
and loop_probe()'s "max_loop_specified && max_loop" check
short-circuits on 0, so legacy autoloading was not capped.  In v1 an
invalid string keeps max_loop at its default value while
max_loop_specified is still set to true, which turns the default into
a hard upper bound for dynamic device creation.  The v2 only marks
max_loop_specified when kstrtoint() succeeds, mirroring
max_loop_param_set_int():

 	if (kstrtoint(str, 0, &max_loop))
+	{
 		pr_warn("loop: invalid max_loop, keeping default\n");
+		return 1;
+	}
 #ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
 		max_loop_specified = true;
 #endif

This was pointed out by an AI-assisted review of v1, so I've left your
Reviewed-by off this one for now.  Could you take another look when
you have a chance?

Thanks,
Tao

> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> ---
> Changes in v2:
> - move max_loop_specified = true under the success path, pointed out
>   by an AI-assisted review of v1.
> ---
>  drivers/block/loop.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 68a9cc7aeb13..126f42580632 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -2341,7 +2341,10 @@ module_exit(loop_exit);
>  #ifndef MODULE
>  static int __init max_loop_setup(char *str)
>  {
> -	max_loop = simple_strtol(str, NULL, 0);
> +	if (kstrtoint(str, 0, &max_loop)) {
> +		pr_warn("loop: invalid max_loop, keeping default\n");
> +		return 1;
> +	}
>  #ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
>  	max_loop_specified = true;
>  #endif

