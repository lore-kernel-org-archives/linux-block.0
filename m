Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793300907;
	b=UDoVY166pXuxazVE2TF4dEfwKdrW4OaXzLpyRVa+eEwQPw8cjC5Uz8weF2HKXMSzUEug
	 Dl9GhJElQ5ztDHc+5mtgl5Ovt2hKv+sOgFw1VBwVBYhT1a0HAg+ulFUNyBRzY++Fq1IM+
	 tB9HGKTnbzzBrWbhrIkogRp2nascoUUsTzJD6JSl3S242oKEqrhWQB8n5mvmwBH2v4wY7
	 xHuR3C0ZN5ffXn3hXURv4uqSTfyNWDK9zz9UxXbxbp5SkY1E32vqPX3njzJ2NSlfFqCWY
	 hN93WHv54gAO/ASqa9jgk560cao9CkEa/OLS7wl+xvkjwYuMkMn70sUgxPHg85JGpFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793300907;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MqMQ20SWCSHc5gHCKMOa63/Ubwl47XcTPGDKZSMkdYU=;
	b=ASVinvoCRrtrjYhsMJ9ypGZgLeyYSdlvu+nCVAIqo/ZJGMumpZrCFhhiDMwgQcyiMzCr
	 ymDPKY1WkTB6JBLFEKKDdSbg2JyL8K/OWz4hQ2jzSUTcC0tLDwglh0Z1H88Gazq8CvEPX
	 fXrGUCnOzr5n67a5a8IwDQabn4iMpyooA/M3+v/xHoSV3UIvIMPTUhsLH/SrL9dlasszB
	 uNCvmwkIlbauv8U/hPlwIUDsWbdi+19CaoVuP4ZmfeaI0QNcH/nIUZr+zNfLcMQD86Hqb
	 IujRlG4uWo5pro3XClg2c1s7nK40StcsKLMRM2JY1vdpsC9fwzyGtdBHDfuc2FjAUUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="eWwvv+/G";
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A2606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 19:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E1A2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=eWwvv+/G
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6dd7070699eso1949479eaf.3
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793300905; x=1793905705; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MqMQ20SWCSHc5gHCKMOa63/Ubwl47XcTPGDKZSMkdYU=;
        b=eWwvv+/G6GoTY/9JqBPA+J7iMmPJdnYIqYlNkBYhmS6TKfoTt87zMk4A+pW6DwjJN+
         qbYshL5JnkpWMDbdSajHsLpDLR1jklisVu2v3b8AWPrBDwrLsVmJjLVk8NzIq07052GY
         9ezebJp5inIqFrDbuxzpDI3NpUse0ktyhY5+HLPRw+g74BLjo9VoO94J+tE5ofusmdVH
         caL92QGYRtEvNiJJAAkke3oMiAEqoyleVIyxqMhypDsOLc7yDUwIiqOFw5+QLlqeSi5v
         jIhTzfgGddn7aMAG42D45rweenxiXtQD9G6omKRdpoD0cMdH8LZVH3Db9kX6ru5NKPru
         rjCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793300905; x=1793905705;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MqMQ20SWCSHc5gHCKMOa63/Ubwl47XcTPGDKZSMkdYU=;
        b=oL5hzmmQghl2rRtAOC8n1kbRliq+PRRlRVq6ewI8NLQOVloPeq1wBwpH4JwmInDruH
         YT2/cHLfjE2N609r/mPfKKQeBOH9gc1z/27k/vCtPNJPl+TfU9ZbFEDe0MIJjrlMGcil
         E6v/Ah2jOaZGD2vR82rNWziUYwXh9BuV2dvLYv+vdEFZCR8wCtKRuttA9ZibJtdfuzNl
         DEDTiEo2aVY8xnZMRoA1YNcEnZiZunGs2l0GgkqydADJh6mMt/t09cEU/ajKbOkKxFho
         mjW3aS/MQXtZlXaVqV5oBPHQY+y/Waw4V2ljsi3hR3LKoeXxdbjVHQ+uD/JDgYGkz1OA
         zbkQ==
X-Gm-Message-State: AFq9FYIKZSpR1yCV8FNJ+yt1q8ParJWm6kGm8EDByf0bvW0TymU/Udr5
	B5m3oe1RIS4kp4IJ+MohSTO6S7bgOh/0vSMVs4RQWnUN33WyqjoIm1oqwJl26SdwCsM=
X-Gm-Gg: AYBFou0MGNu9ptKwBLheu/H79ljmdZJrx1J/K3lQkULC2vRO4WjIQEuiwq75jscbyxF
	8dOoI/I1WTlNPasIt4KsPzs7W1a4wnxqngPaO3fZYtRD6yK6yOZY+D1w47jflWNv4ddwTmZyQWT
	jAzdbuz4nshD/BFcxpEcPHgwIwmS4tZegW2/jm/r21ALbZMS7OTDa8/7GNm1OWyVlaoegsDJOxL
	XHE6eTUknWKI7VbgqdgoRS3ASz/O9qwpadFZxmvmNj1RPTu7UHUnpEH7MgYFkH6MLQRMCHrYtTq
	9M5G6e2Kb3siNkq9ZbwtWYc/DlHIFOTK9B2ru9ByCHHunxx6srU74t1Eia2st783MhKSf+XzD2u
	HKV/G7VhWp4/7aMbNYduOPBlrQ0x9dzN0v75lUHTMINHJt95QR4wX5uNOtbT7cq8A6BqrwQwSZB
	glVFiX/ANw4R6RqVsCsVETLwHv07gz1lyIIUe4d/DZXrp44q3UBrkcP/D6ul9YPKJo6K/v3nnhW
	q3oc8JkmrvEZMzw5kXxnUYkOGDzWYZKw7YOV6M/2QBbzndXoPeJ0FEqvP3X4vh1rJ4Zbv2e4jAM
	LUULao2RV0KPqDS9ZkI39bBsx0RDD+1uTPxk3TdK/x4gAxuqCW5pIgI8TU7OzLDcYMbRz6JFSAp
	Sak8KlMqOHa+/mH6WEygBHpCESVJjpHQ=
X-Received: by 2002:a05:6820:5719:20b0:6cd:3ffc:e339 with SMTP id 006d021491bc7-714f27899c6mr116171eaf.87.1793300905001;
        Thu, 29 Oct 2026 12:08:25 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2e5b450sm107444eaf.11.2026.10.29.12.08.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2026 12:08:24 -0700 (PDT)
Message-ID: <4876d4a1-7464-488e-ad13-94f19108b131@kernel.dk>
Date: Thu, 29 Oct 2026 13:08:22 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/98] blk-mq: end the request if getting a keyslot fails
To: Eric Biggers <ebiggers@kernel.org>, Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-10-axboe@kernel.dk> <auNBSoa3vscdnr9_@infradead.org>
 <20261029183033.GF1862@quark>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20261029183033.GF1862@quark>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 12:30 PM, Eric Biggers wrote:
> On Thu, Oct 29, 2026 at 05:51:22AM -0700, Christoph Hellwig wrote:
>> Adding Eric for the blk-crypto code.
>>
>> On Wed, Oct 28, 2026 at 10:41:12AM -0600, Jens Axboe wrote:
>>> From: Josef Bacik <josef@toxicpanda.com>
>>>
>>> When blk_crypto_rq_get_keyslot() fails, blk_mq_submit_bio() ends the bio
>>> by hand and frees the request. By then blk_mq_bio_to_request() has done
>>> the IO accounting, which blk_mq_free_request() doesn't undo, so the
>>> in_flight counter never drops and iostat shows a device that is 100%
>>> busy. If the bio went through zone write plugging the zone stays plugged
>>> as well, and every later write to it waits forever.
>>>
>>> Use blk_mq_end_request() like the dispatch path does for a request the
>>> driver rejected, after marking it for zone write plugging.
>>>
>>> Fixes: a892c8d52c02 ("block: Inline encryption support for blk-mq")
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>>  block/blk-mq.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 7400f678258e..c91306f8156f 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -3195,8 +3195,9 @@ void blk_mq_submit_bio(struct bio *bio)
>>>  
>>>  	ret = blk_crypto_rq_get_keyslot(rq);
>>>  	if (ret != BLK_STS_OK) {
>>> -		bio_endio_status(bio, ret);
>>> -		blk_mq_free_request(rq);
>>> +		if (bio_zone_write_plugging(bio))
>>> +			blk_zone_write_plug_init_request(rq);
>>> +		blk_mq_end_request(rq, ret);
>>
>> If blk_mq_end_request does the right thing (it looks like that to
>> me, but I'd rather rely on Eric and Jens for that), we should
>> reorder the blk_crypto_rq_get_keyslot and
>> blk_zone_write_plug_init_request calls so that the extra copy
>> of the blk_zone_write_plug_init_request call is not needed.
> 
> I don't know the blk-mq code super well.  But yes,
> blk_zone_write_plug_init_request() has no dependency on the keyslot;
> in particular the back-merging relies on crypt_ctx, not crypt_keyslot.
> So calling it before blk_crypto_rq_get_keyslot() would be simpler than
> duplicating it in the success and failure cases.
> 
> And yes, blk_mq_end_request() doesn't assume
> blk_crypto_rq_get_keyslot() has succeeded.  On failure crypt_keyslot
> just remains NULL.
> 
> Josef and Jens, what are your expectations about this patch?  Sending
> it as part of a 98-patch series (that didn't get picked up by Sashiko)
> is kind of awkward.  If you need help I'd be glad to send a revised
> version as a standalone patch.  Or you can handle it: up to you.

I should have put this in the cover letter, that's my mistake. But I've
replied to other patches in this thread, and the idea is "congrats, as
the maintainer, you now own this bug" and you are responsible for fixing
it. If the patch is good, feel free to ack it and run with it. If it
needs work, do the work and send it out as any other patch you would. If
you do that, feel free to rewrite it and claim authorship as well,
nobody cares about that part.

So yes, would be great if you could send a revised patch in this case.
Thanks!

-- 
Jens Axboe
