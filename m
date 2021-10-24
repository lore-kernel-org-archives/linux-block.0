Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B910C433EF
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 17:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1495B60E75
	for <linux-block@archiver.kernel.org>; Sun, 24 Oct 2021 17:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhJXRUq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 24 Oct 2021 13:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJXRUq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 24 Oct 2021 13:20:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A4FC061745
        for <linux-block@vger.kernel.org>; Sun, 24 Oct 2021 10:18:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id s19so8181695wra.2
        for <linux-block@vger.kernel.org>; Sun, 24 Oct 2021 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MCHEg4QeUiAP7r6w3RH+b+3kdo5sOWuvYIUPWW/c8Nk=;
        b=WiG8DAb9obADE2Os4XdUmVLCN+xgf3c7vUTgW3OrO7ZsXjpfM1TJLcB9YrgQXJUDMB
         UI1AgCRAVHo/M/ep6Tj/qbBJOiKpSYoaLo0FX1Kih/9cUAi3Kny7FguYCSyC+7+HXjyn
         SIFzZp72wYCFyP1//pqb+w+lplToZ02Ff/Af1jLbmMzxcEyRD+5txAIds5OPwMN3knMU
         YSq1B3MKn4UOzFthb2scy55s31aqtCoPlxYiITkUzBgdKE49BpS5COQrWyNu16u9mOo1
         FRk1gqowVSdDbsLDGBoCvZGV5wOQl6KJASQ9CainpqETuwvE+r9xgSXaaN3Drltf4+dR
         VUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MCHEg4QeUiAP7r6w3RH+b+3kdo5sOWuvYIUPWW/c8Nk=;
        b=4RVrZ9cE7VXLfdRCEau6pNDKnrsAac7KgWGzvuMX4FP1bGW+ieA/v0fF77FSurZH9t
         a9AwgcUrO+AjV0URxEo3tWHj640U/GzTPXmYaQFRYKivHNuo4x8j/qQN1SAOQ5rKPEPz
         aPNqiHCfz6Bd52K4VtJFOEO3wo7JyXh9O/1DllhVU1xQFlG1xpG7zr5VnboiuWTq4gJ8
         Ni6HdzcGF0tI8jAzSXtqrx0+uqcBDU8ywBSYETt96Yue8axTF1Sc6X2dI0fJL+Ri7BAR
         XN8maNedrBJBRIF43tjBZn5f2PumZfSMeqfIHJuWOV/to5kzk5kljszeq5eAz6T3s17n
         sFJA==
X-Gm-Message-State: AOAM5328JccrKafUEFZ4IXnLPtfAWvvsL6fuYKPkdTYutC2qeNhPeCmq
        mOzhxg0ikZTaRrw7e2FYj6h8ZzUXnMc=
X-Google-Smtp-Source: ABdhPJxAHVCi0IrbHIZWlaejt8ZLv8mu9QPZXLPeNTMVMkoiJqOSO+kNNnHv5nkEoGSt6X2JkBBCqQ==
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr16544782wrd.16.1635095903699;
        Sun, 24 Oct 2021 10:18:23 -0700 (PDT)
Received: from [192.168.8.198] ([185.69.144.165])
        by smtp.gmail.com with ESMTPSA id o2sm10620443wrg.1.2021.10.24.10.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 10:18:23 -0700 (PDT)
Message-ID: <92d445d3-9905-525c-945f-33074ff49fa2@gmail.com>
Date:   Sun, 24 Oct 2021 18:17:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/5] block: kill unused polling bits in
 __blkdev_direct_IO()
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>
References: <cover.1635006010.git.asml.silence@gmail.com>
 <2e63549f6bce3442c27997fae83082f1c9f4e6c3.1635006010.git.asml.silence@gmail.com>
 <9200437d-d5b7-fca2-b8e3-32a01603b281@gmail.com>
 <5fb75a75-c06b-1ede-3989-69cf7e7e69bc@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <5fb75a75-c06b-1ede-3989-69cf7e7e69bc@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/24/21 16:09, Jens Axboe wrote:
> On 10/23/21 10:46 AM, Pavel Begunkov wrote:
>> On 10/23/21 17:21, Pavel Begunkov wrote:
>>> With addition of __blkdev_direct_IO_async(), __blkdev_direct_IO() now
>>> serves only multio-bio I/O, which we don't poll. Now we can remove
>>> anything related to I/O polling from it.
>>>
>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>> ---
>>>    block/fops.c | 20 +++-----------------
>>>    1 file changed, 3 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/block/fops.c b/block/fops.c
>>> index 8800b0ad5c29..997904963a9d 100644
>>> --- a/block/fops.c
>>> +++ b/block/fops.c
>>> @@ -190,7 +190,6 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>>>    	struct blk_plug plug;
>>>    	struct blkdev_dio *dio;
>>>    	struct bio *bio;
>>> -	bool do_poll = (iocb->ki_flags & IOCB_HIPRI);
>>>    	bool is_read = (iov_iter_rw(iter) == READ), is_sync;
>>>    	loff_t pos = iocb->ki_pos;
>>>    	int ret = 0;
>>> @@ -216,12 +215,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>>>    	if (is_read && iter_is_iovec(iter))
>>>    		dio->flags |= DIO_SHOULD_DIRTY;
>>>    
>>> -	/*
>>> -	 * Don't plug for HIPRI/polled IO, as those should go straight
>>> -	 * to issue
>>> -	 */
>>> -	if (!(iocb->ki_flags & IOCB_HIPRI))
>>> -		blk_start_plug(&plug);
>>
>> I'm not sure, do we want to leave it conditional here?
> 
> For async polled there's only one user and that user plug already...

It's __blkdev_direct_IO() though, covers both sync and async

-- 
Pavel Begunkov
