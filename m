Return-Path: <SRS0=fNpn=NX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC64DC43441
	for <linux-block@archiver.kernel.org>; Mon, 12 Nov 2018 16:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745DD22503
	for <linux-block@archiver.kernel.org>; Mon, 12 Nov 2018 16:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SDxKf6J+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745DD22503
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeKMCVA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:21:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33720 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbeKMCVA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Nov 2018 21:21:00 -0500
Received: by mail-pl1-f196.google.com with SMTP id w22-v6so4597215plk.0
        for <linux-block@vger.kernel.org>; Mon, 12 Nov 2018 08:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7R7FHdKyApG52FL3cohq5W8IYqkdTXOmc84t/InYjZ0=;
        b=SDxKf6J+XuTRcv+k/r4CHKbP5kR0wouQN85V543UPYzoLyKFxkn144EgNDUAC1UcFg
         O6cZeAYrRpDfuOD8I6T3OqqVX49O8erL4MQC5+eB5FyqJnSQ/EQTSpdGPSlIm8PKOyJE
         SFN/rMjUr6aqLSKr/OBZDv8FMkCmM2RIkV53v/6nTcyj3XmgbIzwHHXrqJ1pE48GRxcU
         lGTzQCfFVxIefhM6a6aYGIZXEWZHnZ5jc/IZwplyqK9sJTMattlPaTAAMXrnSqIPLxmz
         9c6hmqeQ9e4cTu5nZX+exXq0EVdzO7++ZRKiE6qG39w4VcYVB7lzOn556JMbS4VXKGdm
         nGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7R7FHdKyApG52FL3cohq5W8IYqkdTXOmc84t/InYjZ0=;
        b=qv+wsJgu8GhHUSFUOz1EHHN48Ud3sNGStklQF+YAiuFWSKCEyK0D8laIgia84brbyi
         PA2lNeeh5cW32zG8oxk3oFWL2httdb8OifnQ6sUPT1uWpG3DPILBT1g0bPOPQZexgtES
         F1czwvYbwnRppdh2+yzFQnGQMrKwB8THU/2XL1eyOWNtwQWWjAYSdmh4/qyMNl/30OIi
         IBT1eZSB4FSh5qV7EtuSzxzWVcL2F3ZOv/mwZsQAHUH1785nGgDsx2ngxTUwbgdeSAUA
         Fig0CKrWA1jHj71Gj+eONAQydwopOegdNE2wE9SAebva4pGlOErQqDfNhVeQam+mcuL/
         8hrw==
X-Gm-Message-State: AGRZ1gJYDhdUPdRTVYhT04MaGcDQC8vlvEhdR0YFUKVqo9iKN5JkQmRi
        Bdakj4tqgspDqLThFxeNPgiO4lMR+m8=
X-Google-Smtp-Source: AJdET5eQ1GqtQeZgOVX/FgaPgXqDynj1IibsM6mwRAjPHWzU0y3veyNOyJxprJh3VJR0ssLANRcQbw==
X-Received: by 2002:a17:902:166:: with SMTP id 93-v6mr1535460plb.68.1542040022068;
        Mon, 12 Nov 2018 08:27:02 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d65-v6sm23231574pfc.144.2018.11.12.08.27.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 08:27:01 -0800 (PST)
Subject: Re: [PATCH 4/6] block: avoid ordered task state change for polled IO
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        linux-block@vger.kernel.org
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-5-axboe@kernel.dk>
 <653c9f83-157c-dca9-aa3b-02903dc81f5b@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e213ca38-19c0-70ca-e4d0-096c48d5b4b8@kernel.dk>
Date:   Mon, 12 Nov 2018 09:26:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <653c9f83-157c-dca9-aa3b-02903dc81f5b@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Message-ID: <20181112162659.P96piiNSJZo8GHdFQcBNk7HkVQ7fGHaoXiI23q-9PfQ@z>

On 11/12/18 2:35 AM, jianchao.wang wrote:
> Hi Jens
> 
> On 11/10/18 11:13 PM, Jens Axboe wrote:
>> We only really need the barrier if we're going to be sleeping,
>> if we're just polling we're fine with the __set_current_state()
>> variant.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/block_dev.c | 25 +++++++++++++++++++++----
>>  1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/block_dev.c b/fs/block_dev.c
>> index c039abfb2052..e7550b1f9670 100644
>> --- a/fs/block_dev.c
>> +++ b/fs/block_dev.c
>> @@ -237,12 +237,23 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
>>  
>>  	qc = submit_bio(&bio);
>>  	for (;;) {
>> -		set_current_state(TASK_UNINTERRUPTIBLE);
>> +		/*
>> +		 * Using non-atomic task state for polling
>> +		 */
>> +		__set_current_state(TASK_UNINTERRUPTIBLE);
>> +
>>  		if (!READ_ONCE(bio.bi_private))
>>  			break;
> 
> When we don't use polling, the blkdev_bio_end_io_simple may come on a different cpu before
> submit_bio returns 
> For example,
> __blkdev_direct_IO_simple
>   qc = submit_bio(&bio) 
>                                           blkdev_bio_end_io_simple
>                                             WRITE_ONCE(bio.bi_private, NULL)
>                                             wake_up_process(waiter)
>   __set_current_state(TASK_UNINTERRUPTIBLE)                              
>   READ_ONCE(bio.bi_private)

While I agree that you are right, that's an existing issue. The store
barrier implied by set_current_state() doesn't fix that.

How about this variant:

http://git.kernel.dk/cgit/linux-block/commit/?h=mq-perf&id=036ba7a8d1334889c0fe55d4858d78f4e8022f12

which then changes the later wake up helper patch to be:
 
http://git.kernel.dk/cgit/linux-block/commit/?h=mq-perf&id=f8c3f188425967adb040cfefb799b0a5a1df769d

-- 
Jens Axboe

