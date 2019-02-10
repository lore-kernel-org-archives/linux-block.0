Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93147C282CC
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 13:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC032145D
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 13:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NwV98S99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfBJNjc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 08:39:32 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37548 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfBJNjb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 08:39:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so3965293pfb.4
        for <linux-block@vger.kernel.org>; Sun, 10 Feb 2019 05:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jeTlcIsqIlzUMtuhBiluQu/anBI1oH0U3YTpaDkJB2w=;
        b=NwV98S99bQ896wt5nLakcST+KrvDouISiFMXSPF6uokM3oFHFD9Ta0LtUWdFDyDb23
         FwqQ+VaTLvFlct8dCRfSI4TloBFg7NDh+D/kbOwF5vMEID47DL8IKrNpmPBT9OdJTqrC
         2IylcaFmuvFJ/wSTzGmZpOKq3oVpeLiydYA1LyAtnnjBcKKNYE/mSJ3XV5QcOkeh5tC7
         TnknY9nfIWUtZCLuXfzosuT/jstGuCYKeJ7g5+WJ3TZqLsFa1CjL0Uz8Ps6Ihc6XbV9C
         zFdlMl7jw/YlN8G78Bpq++Gv/4rMKE/hFbugyYBTeMP0JsdZFdupczDoqOt/6JSIc9RE
         RDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jeTlcIsqIlzUMtuhBiluQu/anBI1oH0U3YTpaDkJB2w=;
        b=RZzeiYfpt+G9+eJWfp6wHaswBgoCy9UG3IuqcQtqKwH8shbUYYjgnDTw/JQ+x2BFdT
         HNmn+r2gaCNDQUG12wX4vEFTo/KJXzNIPJi4rmG6aNty0t/qKu2XCDo860nt1Dl84aZD
         JNMUx75E2DJEn4GY806XrqmMvcvt53NT3WolZzyZr/4RAdJgXZINjvg2aaLRYLYxVgJo
         WcPrUsawBTtsGcQmgqJj1ZQWYemEDUum+AT2sxUS3EugXkItTKF5+MJU/jKMzgdpzsaV
         vD70XJKj1pF7cNjxr07lj8bFqMqCYhenAwjEu6ocsvqtPi1w8F3lkWds2K/SzBqEOgPK
         FuVA==
X-Gm-Message-State: AHQUAuZPDqoDzZHFMrhrryAMXnYPbmjr9YL/7n3zgcieBYMJ6DIaJO/w
        19K65bBKJoEam02mhYQqPbZTPA==
X-Google-Smtp-Source: AHgI3IZnjDgIQBGBIiGUyYgc9gEBPgV/Ne5A5ncYpOz0pG6O2zOPBSHT4yc3+FJbPDJOQqym0N4c7A==
X-Received: by 2002:a63:1b4b:: with SMTP id b11mr14473155pgm.10.1549805970652;
        Sun, 10 Feb 2019 05:39:30 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id j9sm10800983pfi.86.2019.02.10.05.39.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 05:39:29 -0800 (PST)
Subject: Re: [PATCH 19/19] io_uring: add io_uring_event cache hit information
To:     Hannes Reinecke <hare@suse.de>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk
References: <20190209211346.26060-1-axboe@kernel.dk>
 <20190209211346.26060-20-axboe@kernel.dk>
 <ca60183a-bb43-930c-8bf1-026c2528723d@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cf52bd37-4891-dfe3-8673-9a836e01b6c8@kernel.dk>
Date:   Sun, 10 Feb 2019 06:39:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ca60183a-bb43-930c-8bf1-026c2528723d@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/19 2:36 AM, Hannes Reinecke wrote:
> On 2/9/19 10:13 PM, Jens Axboe wrote:
>> Add hint on whether a read was served out of the page cache, or if it
>> hit media. This is useful for buffered async IO, O_DIRECT reads would
>> never have this set (for obvious reasons).
>>
>> If the read hit page cache, cqe->flags will have IOCQE_FLAG_CACHEHIT
>> set.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>   fs/io_uring.c                 | 7 ++++++-
>>   include/uapi/linux/io_uring.h | 5 +++++
>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 11a549b5dcbf..d7a10484d748 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -587,11 +587,16 @@ static void io_fput(struct io_kiocb *req)
>>   static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
>>   {
>>   	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
>> +	unsigned ev_flags = 0;
>>   
>>   	kiocb_end_write(kiocb);
>>   
>>   	io_fput(req);
>> -	io_cqring_add_event(req->ctx, req->user_data, res, 0);
>> +
>> +	if (res > 0 && (req->flags & REQ_F_FORCE_NONBLOCK))
>> +		ev_flags = IOCQE_FLAG_CACHEHIT;
>> +
>> +	io_cqring_add_event(req->ctx, req->user_data, res, ev_flags);
>>   	io_free_req(req);
>>   }
>>   
>> diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
>> index e23408692118..24906e99fdc7 100644
>> --- a/include/uapi/linux/io_uring.h
>> +++ b/include/uapi/linux/io_uring.h
>> @@ -69,6 +69,11 @@ struct io_uring_cqe {
>>   	__u32	flags;
>>   };
>>
>> +/*
>> + * io_uring_event->flags
>> + */
>> +#define IOCQE_FLAG_CACHEHIT	(1U << 0)	/* IO did not hit media */
>> +
>>   /*
>>    * Magic offsets for the application to mmap the data it needs
>>    */
>>
> 
> Hmm. The point of this patch being ... what?
> Just setting a newly introduced flag seems to be a bit pointless.
> Unless it has some magic interaction with io_cqring_add_event().
> But then that function would have had to have knowledge of that flag 
> already, which would be ... odd.

Not sure I follow your concern here. The kernel doesn't use the flag,
we just set it. It's used to inform the application of whether or
not the given read was a cachehit, or if it had to be served by
media.

-- 
Jens Axboe

