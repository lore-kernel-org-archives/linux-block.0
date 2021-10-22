Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25787C433F5
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 10:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F06946108B
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 10:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbhJVLBV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 07:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhJVLBU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 07:01:20 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C156AC061764
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 03:59:02 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w19so51972edd.2
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 03:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=yvnoQxI0rClrSilvRBpoSvXAplPaEG+C0g/dbSnlW3s=;
        b=MEkTqFCfgGMbWne1aG+QFkqB4gGXktiI388bHh1rHMoJ68eDmzt0muqrASx0M6APEz
         88cFCTHWl7kLWqEcY6IscmVMK3sfwrjIpbNgt4xdIbPohcM8YRRLDDJvpRwYO7lmDhdu
         8wg3HUhJiA0Eb+ceBXHc8dZK/+Wfuk6V467wzzbeA9FY57umDLrjN15xFybfpfJgUTRm
         AcVwq1F9X7KxJ8fRhIb7F+QGfw+UrpfIP0UcuYmtG+7Ddu+1PH5RBP2tZ5o7vPnzdvpx
         LYX9Dae6R84XBFtrVlYOSO1sMwGaWHFZ3ALDN/4UEZCwB3sQmGqdPMxBCSBTCT7GEm5G
         Zgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yvnoQxI0rClrSilvRBpoSvXAplPaEG+C0g/dbSnlW3s=;
        b=mzLMptrjEy6m4nTVMlxPYgVxASrOINAC22imB0dk2X9GdYHYp5ZO/TX+UwNSayN8Xm
         GzjgMPi5XGUqah/8zJ/fT/xQVBSWifMcSv1wfF+APQAMJLjP5rXeBL2fD4skGT+AyTSi
         iSPcZplkUm+MtQU5VRYPxwTClyE+ojj6xbEd6+vQUpEWAHFYkIfOt+s/6tDc0asNYkiT
         DbwTTPm9/kvQeCnQdGOdM4zZGW8nO4BCTT6GiFxMG435Rmw0MsB3QNm/Ept6kCBv4r/q
         85gtdR+6NWrHPeR6iK8okO99fr0wmbYip2/s6WjsfpNO3TtpMrTjt8WiNypPBBVSdJHC
         Ubxw==
X-Gm-Message-State: AOAM532he76E6wuUTn3mUx8cXDM4BjSKaRvSrgfU5W4ifDwNA2GikDVE
        j92eB8fTP+zVNAyyEkSe1Rc9klecEn4=
X-Google-Smtp-Source: ABdhPJwMplxyicZFgcrxQbGD7nJnTKwxtpfuqg1qBAdwPS6fjKc+DJBhQ8u72/dAk94ry0QkLntiTQ==
X-Received: by 2002:a17:906:a382:: with SMTP id k2mr14110058ejz.454.1634900341298;
        Fri, 22 Oct 2021 03:59:01 -0700 (PDT)
Received: from [192.168.8.198] ([148.252.133.195])
        by smtp.gmail.com with ESMTPSA id h18sm3602338ejt.29.2021.10.22.03.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 03:59:00 -0700 (PDT)
Message-ID: <7d512f98-d86f-1e5a-dd7d-d8d27cbbd39b@gmail.com>
Date:   Fri, 22 Oct 2021 11:58:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 03/16] block: optimise req_bio_endio()
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <8061fa49096e1a0e44849aa204a0a1ae57c4423a.1634676157.git.asml.silence@gmail.com>
 <20211022095856.2ymvvuz3xrtcuyw3@shindev>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20211022095856.2ymvvuz3xrtcuyw3@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/22/21 10:58, Shinichiro Kawasaki wrote:
> Hello Pavel,
> 
> Recently I tried out for-next branch and observed that simple dd command to
> zonefs files causes an I/O error.
> 
> $ sudo dd if=/dev/zero of=/mnt/seq/0 bs=4096 count=1 oflag=direct
> dd: error writing '/mnt/seq/0': Input/output error
> 1+0 records in
> 0+0 records out
> 0 bytes copied, 0.00409641 s, 0.0 kB/s
> 
> At that time, kernel reported warnings.
> 
> [90713.298721][ T2735] zonefs (nvme0n1) WARNING: inode 1: invalid size 0 (should be 4096)
> [90713.299761][ T2735] zonefs (nvme0n1) WARNING: remounting filesystem read-only
> 
> I bisected and found that this patch triggers the error and warnings. I think
> one liner change is needed in this patch. Please find it below, in line.

[...]
> -	if (req_op(rq) == REQ_OP_ZONE_APPEND && error == BLK_STS_OK) {
>> +	} else if (req_op(rq) == REQ_OP_ZONE_APPEND) {
>>   		/*
>>   		 * Partial zone append completions cannot be supported as the
>>   		 * BIO fragments may end up not being written sequentially.
>>   		 */
>> -		if (bio->bi_iter.bi_size)
>> +		if (bio->bi_iter.bi_size == nbytes)
> 
> I think the line above should be,
> 
> 		if (bio->bi_iter.bi_size != nbytes)

You're right, that was a stupid mistake, thanks!

Jens, will you fold it in or would you prefer a patch?


> Before applying the patch, the if statement checked "bi_size is not zero".
> After applying the patch, bio_advance(bio, nbytes) moved after this check.
> Then bi_size is not decremented by nbytes and the check should be "bi_size is
> not nbytes". With this modification, the I/O error and the warnings go away.
> 
>>   			bio->bi_status = BLK_STS_IOERR;
>>   		else
>>   			bio->bi_iter.bi_sector = rq->__sector;
>>   	}
>>   
>> +	bio_advance(bio, nbytes);
>> +
>> +	if (unlikely(rq->rq_flags & RQF_QUIET))
>> +		bio_set_flag(bio, BIO_QUIET);
>>   	/* don't actually finish bio if it's part of flush sequence */
>>   	if (bio->bi_iter.bi_size == 0 && !(rq->rq_flags & RQF_FLUSH_SEQ))
>>   		bio_endio(bio);
>> -- 
>> 2.33.1
>>
> 

-- 
Pavel Begunkov
