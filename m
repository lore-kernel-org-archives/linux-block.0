Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5CBC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF8D20660
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 21:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mGbaFVZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF8D20660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbeLAJIp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:08:45 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36329 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeLAJIo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 04:08:44 -0500
Received: by mail-io1-f68.google.com with SMTP id m19so5777574ioh.3
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 13:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DTCiJHEIPhwqKmFmtBvCXYEnbAfU2WekbVfHr/8KqJk=;
        b=mGbaFVZmG4vH4xh7ywtItGaz+LpDCqWKJJT6Tb6NNGa/DyK05Lsco0nw0Yi+0s7vNG
         +Ddb/uvIImesxYtrFIkaU8FDls6Smsb01qhlrkt13hwFUJww6oL0OHnDcWH4wAz4JeYy
         rEVn1MsGK9s7YEjSGjRPFCY/3qCZcH6yQ3J+2p5jBjjb3DtGa2ssJLJxtqH72i1ozxEy
         7+KTfNdSaV5eMci8hhuv6wA0OlIQWzm91unPsa+UoaJHHACkYSuqLTLamsYbY3ofrd2n
         u6PZKxvbIQhVbxsvEg5Me11PXOgc9GJhpPDa4ZRMXDcdt2NkFjBlJWLKB1024opu1ggN
         vQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DTCiJHEIPhwqKmFmtBvCXYEnbAfU2WekbVfHr/8KqJk=;
        b=m8xTmyxeJsBSPHkw3GZ2N3tGmbiDedqgsExiuozywLolmduAHFYOBw/gASv4LMavXs
         +TLXqhg3gkCDS+xfiTDLwoe58Qrk0ZV12kx7z/5Q8C3NcRM4H+XjSY/vwxFz/chGRdQI
         sdXKXfpQTl/Y0fq1mUPRLPfrWwdnjQyHHzox7iwx6zgXsfYv8esOOyH92yTIjIjBJ2Pr
         pAj0fYZAJWZr1zkNl83uTxaJL372UsMuvDFoQvxGg+0JmlcxdrSFhUDyDKA/nU//+qh/
         rhcimuie/K7FSFljMi8QvY0wIu+f7nCt6eYVBOWmCv6ce8xnMRYZxdAF4tX03GuhwgFr
         ndlw==
X-Gm-Message-State: AA+aEWYJBmuXTG8HHNm746p+rSaTH7TlAMfv+K/Ykk4xwZlQpM3815C5
        MQXMTF+WCEGbQx1cFwgSNlv9zg==
X-Google-Smtp-Source: AFSGD/UhDroKxs2FHfUCa3j/nD7f+RvP/2uOk0pUhPls4zbyWIVwjv5nAqGVcZhRx7NIF1ao9z0Oig==
X-Received: by 2002:a5e:d607:: with SMTP id w7mr6156844iom.75.1543615080760;
        Fri, 30 Nov 2018 13:58:00 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f21sm207454itc.14.2018.11.30.13.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 13:57:59 -0800 (PST)
Subject: Re: [PATCH 27/27] aio: add support for pre-mapped user IO buffers
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, hch@lst.de
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-28-axboe@kernel.dk>
 <x49pnum5jfv.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8dc2ea1d-b6a4-728b-7550-87d32240989c@kernel.dk>
Date:   Fri, 30 Nov 2018 14:57:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x49pnum5jfv.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 2:44 PM, Jeff Moyer wrote:
> Hi, Jens,
> 
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> If we have fixed user buffers, we can map them into the kernel when we
>> setup the io_context. That avoids the need to do get_user_pages() for
>> each and every IO.
>>
>> To utilize this feature, the application must set both
>> IOCTX_FLAG_USERIOCB, to provide iocb's in userspace, and then
>> IOCTX_FLAG_FIXEDBUFS. The latter tells aio that the iocbs that are
>> mapped already contain valid destination and sizes. These buffers can
>> then be mapped into the kernel for the life time of the io_context, as
>> opposed to just the duration of the each single IO.
>>
>> Only works with non-vectored read/write commands for now, not with
>> PREADV/PWRITEV.
>>
>> A limit of 4M is imposed as the largest buffer we currently support.
>> There's nothing preventing us from going larger, but we need some cap,
>> and 4M seemed like it would definitely be big enough.
> 
> Doesn't this mean that a user can pin a bunch of memory?  Something like
> 4MB * aio_max_nr?
> 
> $ sysctl fs.aio-max-nr
> fs.aio-max-nr = 1048576
> 
> If so, it may be a good idea to account the memory under RLIMIT_MEMLOCK.

Yes, it'll need some kind of limiting, right now the limit would indeed
be aio-max-nr * 4MB. 4G isn't terrible, but...

RLIMIT_MEMLOCK isn't a bad idea.

> I'm not sure how close you are to proposing this patch set for realz.
> If it's soon (now?), then CC-ing linux-api and writing man pages would
> be a good idea.  I can help out with the libaio bits if you'd like.  I
> haven't yet had time to take this stuff for a spin, sorry.  I'll try to
> get to that soonish.

I am proposing it for real, not sure how long it'll take to get it
reviewed and moved forward. Unless I get lucky. 4.22 seems like a more
viable version than 4.21.

I'll take any help I can get on the API/man page parts. And/or testing!

> The speedups are pretty impressive!

That's why I put them in there, maybe that'd get peoples attention :-)

-- 
Jens Axboe

