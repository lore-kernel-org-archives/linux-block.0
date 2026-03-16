Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748553CF02A;
	Mon, 16 Mar 2026 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679979; cv=none; b=r6rgt8i8guf6jJGuTL5ofAo3LWM5Vn/TH4V9hmkLci+oCy9YKYGsrwQgBdJIQ+2Jb02XUPM+64EoKHMjcFCR1F3tO+6WgRehVm1aLn5fxktsMTbm/NrszO/es19flP7/+duuklqHQwNFfIXR21u9RNRxlR6f5CKGgS4gMKMvxHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679979; c=relaxed/simple;
	bh=n2ZZvNSKCO7Qqbl/CspkrWB4t4FewtIakESdvWdHCro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsN1eV+AEl+RVmOmftQxgos+1meY+vr/OOR29LZnG+jr/NQX3ElX536Oqa9fhW7iIUMfzK9pQ4flCTcHeLm3/yTqDj2qUcrVMWuxIWa9gQGmiFvAgg6t7sBuYK2jIDUTjT6Dy0Cucvmt/jcDowBAvJrDhdyvPIsPAL/yh8ZTm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cz0+dET2; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cz0+dET2"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fZLkH5BvXzlfl5l;
	Mon, 16 Mar 2026 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1773679971; x=1776271972; bh=/s9UOxwghqWOM5ckdQB07A4x
	B1n+KcMdhPaZB2Le2Ko=; b=cz0+dET2uDu27jdRjMUOVrwm5AZPY3+FNKZGUr0J
	yXmljRZr91zs+Jr4lWHpZrwmWYeWiIOe6ud/Xac2LZKj9qQ2EQAnAl4T0Un4gHUu
	JgU0qGM3J1mdiMQrnWSDLew1jgRGJSXyYThYxzOqEmnwTAZIMGPsx394HRGF+tn5
	9AFjv4Ks9lveN2S0LlEoMoEsjjRBZXgVIaOKlTlhwMw+7CxAD1fR5yM36D/eM6wv
	0vQVFh625P+A6ZNkxTs5+gmEhP4AtczVNVXOo84zFxH3bEkfTzGvh/qgtBUbjDUG
	7nTQuqXgs0JRbb6o4SyLTXbpOLkK7TKnENPiM8XZnc6Wzg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YeBsVHamJlc3; Mon, 16 Mar 2026 16:52:51 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fZLk940c4zlfl7l;
	Mon, 16 Mar 2026 16:52:49 +0000 (UTC)
Message-ID: <6b088e89-cdef-437a-b6ec-60c65fb4cf4c@acm.org>
Date: Mon, 16 Mar 2026 09:52:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Omit a redundant pm_runtime_mark_last_busy() call
 in blk_post_runtime_resume()
To: Markus Elfring <Markus.Elfring@web.de>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Felix Gu <ustc.gu@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
References: <ccebfd2b-0806-4ab4-bda8-2b043427bce5@web.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ccebfd2b-0806-4ab4-bda8-2b043427bce5@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/26 7:15 AM, Markus Elfring wrote:
> The device's last busy timestamp was set in a wrapper function since
> the commit 18c1fe53d186867243f4cf17f4eef60737a16c4c ("PM: runtime:
> Mark last busy stamp in pm_request_autosuspend()").
> Thus delete a pm_runtime_mark_last_busy() call before
> a pm_request_autosuspend() call.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   block/blk-pm.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/block/blk-pm.c b/block/blk-pm.c
> index 8d3e052f91da..d6eab3193a20 100644
> --- a/block/blk-pm.c
> +++ b/block/blk-pm.c
> @@ -181,7 +181,6 @@ void blk_post_runtime_resume(struct request_queue *q)
>   	spin_lock_irq(&q->queue_lock);
>   	old_status = q->rpm_status;
>   	q->rpm_status = RPM_ACTIVE;
> -	pm_runtime_mark_last_busy(q->dev);
>   	pm_request_autosuspend(q->dev);
>   	spin_unlock_irq(&q->queue_lock);
>   

Isn't it expected that the Coccinelle script is shared when a patch is
posted that has been generated by Coccinelle? Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
