Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FC820F066;
	Tue, 29 Apr 2025 10:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745923813; cv=none; b=i9lJr7rPnKlbadq8lqtDyEg+77tZtwUi5Z+cj/da5X9Zhp45sxqFmn/3eFK6uG0mihs5TtRaFeZ/dMBIQp5l2LyLldKDr5efHhRUSlydE3GCoPQOTyMKSQGewZsnAGkzZsfVKmTp71F+OPFWzhevV/Bhb6HItF5nIjNLKb7i2+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745923813; c=relaxed/simple;
	bh=/H9jtpvIwykomOU+wV6fTo7HmYbpV8+nL7gqIlX9XZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sE1yZIPRsZ3oRe66EqLSykELUonwRM2VF1Y7gFiYxgNU0zUseH0++1a+nZtVyq5Na583nLgbbjG/aXpqLa13apAJhqDfdpPbW4tUa9pOIlKws7poFYAEIxCRk+odaEL1p1k2qQdmziz7s9iosGBolQ7QUNfCcKla/llldNRcCuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wdk16tps; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wdk16tps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2A5C4CEE3;
	Tue, 29 Apr 2025 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745923812;
	bh=/H9jtpvIwykomOU+wV6fTo7HmYbpV8+nL7gqIlX9XZ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wdk16tpsjK0cuV5jscYLhtTax8e4FmbIXmw/dhmTJGWT8G4HYu/kMASBTE28+kieq
	 TLffW8REGYgjK2x6Hhr/mImhQqmWnMrBrHp1H9bwDck70HMR7pcvpC9ZEgcQM+xrXj
	 vmTNvzxfj7RZdW9znfokk/E8Lif9t6ck8WSz1iRoSA/nbeIFlo0XlmIp4FqTTi74gV
	 2TkSq8Ca5g2ACZt0k/n7PrAJQnvlFUXvwOQ6xIJdWxy6SwxJ/fwPvwUcMe7QXqKWEL
	 3g/a1l61jqpoK6FdwFobtRLDGayu8DB+IIbzeJHCP0f4Xh/PlVFnuwVKrvdxxeb5oV
	 9DltsZTZCzE8Q==
Message-ID: <adca39d3-04fc-45f5-8e34-0d06714f0ff9@kernel.org>
Date: Tue, 29 Apr 2025 19:50:11 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: remove test of io priority level
To: Aaron Lu <ziqianlu@bytedance.com>, Jens Axboe <axboe@kernel.dk>
Cc: Kexin Wei <ys.weikexin@h3c.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250429082934.GA3896701@bytedance>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250429082934.GA3896701@bytedance>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 17:29, Aaron Lu wrote:
> Ever since commit eca2040972b4("scsi: block: ioprio: Clean up interface
> definition"), the io priority level is masked and can no longer be larger
> than IOPRIO_NR_LEVELS so remove this now useless test.
> 
> The actual test of io prio level is done in ioprio_value() where any
> invalid input of class/level/hint will result in an invalid class being
> passed to the syscall, this is introduced in commit 01584c1e2337("scsi: 
> block: Improve ioprio value validity checks").
> 
> Reported-by: Kexin Wei <ys.weikexin@h3c.com>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
> ---
> Kexin reported a LTP/ioprio_set03 case failure, where the test would
> pass IOPRIO_CLASS_BE with priority level 8 and see if kernel would
> return error. Turned out she is using an old kernel header where the
> change introduced in commit 01584c1e2337("scsi: block: Improve ioprio
> value validity checks") isn't available. During troubleshooting, I find
> this priority level test confusing and misleading so I think it should
> be removed.

What is confusing and misleading about the fact that we support only 8 priority
levels (0 to 7) and should check for it ?

With that said, the test is indeed redundant for the BE and RT class because we
have:

int ioprio_check_cap(int ioprio)
{
	int class = IOPRIO_PRIO_CLASS(ioprio);
	int level = IOPRIO_PRIO_LEVEL(ioprio);

And the macro IOPRIO_PRIO_LEVEL() will mask the level value to something between
0 and 7, always. So necessarily, level will always be lower than
IOPRIO_NR_LEVELS. So please reword your commit message to explain that rather
than describe what a user may or may not use when setting an ioprio field.
And also simplify the patch:

diff --git a/block/ioprio.c b/block/ioprio.c
index 73301a261429..f0ee2798539c 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -46,12 +46,8 @@ int ioprio_check_cap(int ioprio)
                         */
                        if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
                                return -EPERM;
-                       fallthrough;
-                       /* rt has prio field too */
-               case IOPRIO_CLASS_BE:
-                       if (level >= IOPRIO_NR_LEVELS)
-                               return -EINVAL;
                        break;
+               case IOPRIO_CLASS_BE:
                case IOPRIO_CLASS_IDLE:
                        break;
                case IOPRIO_CLASS_NONE:


>  block/ioprio.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/block/ioprio.c b/block/ioprio.c
> index 73301a261429f..60364d3faf800 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -46,11 +46,8 @@ int ioprio_check_cap(int ioprio)
>  			 */
>  			if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_NICE))
>  				return -EPERM;
> -			fallthrough;
> -			/* rt has prio field too */
> +			break;
>  		case IOPRIO_CLASS_BE:
> -			if (level >= IOPRIO_NR_LEVELS)
> -				return -EINVAL;
>  			break;
>  		case IOPRIO_CLASS_IDLE:
>  			break;


-- 
Damien Le Moal
Western Digital Research
