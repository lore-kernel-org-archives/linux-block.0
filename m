Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4BEC5479D
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 17:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237249AbjAIR1v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 12:27:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbjAIR1V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 12:27:21 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7EA1C1
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 09:27:19 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id g20so4880720iob.2
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 09:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHXvGgEJl9eaO3mOBW9vWXVnI2VO8B60EvEFrwQyz+U=;
        b=h+5fGZi+zwDm6SA7gsaba83k41nvrMQMK43WrYRqCSAVD0bvKjtTe273hryhdUJbRn
         JyKEvJvNpzpiFlw9AdgnzHqrF6vEAlzIkvtfsHt2ZKDqwqpYUSt5bxGiqLfBXywSNpwd
         glwES9vsycgT3H/PiYHbi9TNBa0KKXDZ6yaKVpec85sjjQkAO95dKOqmqxIN/cHBB/U2
         INHIqOqqatVex6aUIbSDIRuzYH6GjIK3Gsm032tI7WTxPt/OIG4C3EqDmloJLhKcpfgX
         c1PKyIrzRKSkczEjCBBj7DpWJrZK3ZswBXdy0fIAJNRX1wA2yX2aPBZKeaff6bUeAmc1
         Fk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHXvGgEJl9eaO3mOBW9vWXVnI2VO8B60EvEFrwQyz+U=;
        b=VQQvcN2oTZ23hJTDOgvEqAxCV2jnzdX6DptrtWX09uSM0WoMIxELVgQBrgiPNzIBqc
         UHmtLjNICgpkQ9goxaLR+GiCaCKiNGOGAbRaTJfP7jIvzZRtynXI6FhClZhfqgicDwPC
         XSYKmu2lfYKMVnAORwA2J652ZhiZqe0aFFhzSo8yVHTqbn2hOLRM5gdCdbwubeJKB68V
         PvULPGYYDyVX6uxew8sRWHGQJ8u3iSSDMf36/u1/0CtbVnGGfemFsiJNIC+m9D2qsU3p
         Jb1nQfN1vMAJRfwZaHEHXwTWzzw0DTg7/D41pTRlY81mjMKNnNVFs8sv+mvTm+ziy4Ic
         ZoCw==
X-Gm-Message-State: AFqh2koOptdtLCGSKvbU6pD6j9oMPiGtjqEaEUZevtFQQp3BGvry+4+p
        324NSZbnc/JtsI+98O78NOL37A==
X-Google-Smtp-Source: AMrXdXvtKHRAqb15E0W05m01Njdmp3xZx3201ok7Hi+t/QQ5HEbqAq9UO3tKTw4l8ZVdLS34DZEtAA==
X-Received: by 2002:a6b:7808:0:b0:6db:3123:261 with SMTP id j8-20020a6b7808000000b006db31230261mr8485411iom.2.1673285238507;
        Mon, 09 Jan 2023 09:27:18 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id m12-20020a026d0c000000b003758bcba4b5sm2854856jac.153.2023.01.09.09.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 09:27:17 -0800 (PST)
Message-ID: <0113e8b2-0ce4-e0f1-7924-bb5389d168de@kernel.dk>
Date:   Mon, 9 Jan 2023 10:27:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 7/7] iov_iter, block: Make bio structs pin pages rather
 than ref'ing if appropriate
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <d86e6340-534c-c34c-ab1d-6ebacb213bb9@kernel.dk>
 <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
 <167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk>
 <1880793.1673257404@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1880793.1673257404@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 2:43?AM, David Howells wrote:
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>>> A field, bi_cleanup_mode, is added to the bio struct that gets set by
>>> iov_iter_extract_pages() with FOLL_* flags indicating what cleanup is
>>> necessary.  FOLL_GET -> put_page(), FOLL_PIN -> unpin_user_page().  Other
>>> flags could also be used in future.
>>>
>>> Newly allocated bio structs have bi_cleanup_mode set to FOLL_GET to
>>> indicate that attached pages are ref'd by default.  Cloning sets it to 0.
>>> __bio_iov_iter_get_pages() overrides it to what iov_iter_extract_pages()
>>> indicates.
>>
>> What's the motivation for this change?
> 
> DIO reads in most filesystems and, I think, the block layer are
> currently broken with respect to concurrent fork in the same process
> because they take refs (FOLL_GET) on the pages involved which causes
> the CoW mechanism to malfunction, leading (I think) the parent process
> to not see the result of the DIO.  IIRC, the pages undergoing DIO get
> forcibly copied by fork - and the copies given to the parent.
> Instead, DIO reads should be pinning the pages (FOLL_PIN).  Maybe
> Willy can weigh in on this?
> 
> Further, getting refs on pages in, say, a KVEC iterator is the wrong
> thing to do as the kvec may point to things that shouldn't be ref'd
> (vmap'd or vmalloc'd regions, for example).  Instead, the in-kernel
> caller should do what it needs to do to keep hold of the memory and
> the DIO should not take a ref at all.

Makes sense!

>> It's growing struct bio, which we can have a lot of in the system. I read
>> the cover letter too and I can tell what the change does, but there's no
>> justification really for the change.
> 
> The FOLL_* flags I'm getting back from iov_iter_extract_pages() can be mapped
> to BIO_* flags in the bio.  For the moment, AFAIK, I think only FOLL_GET and
> FOLL_PIN are necessary.  There are three cleanup types: put, unpin and do
> nothing.

That would work, or if they fit into a ushort, there is room that could
be utilized for that. My main knee jerk reaction is just plopping a full
into in there for 2 bits of state, really. I try pretty hard to not
succumb to struct bloat, particularly on the hot path and when we can
have lots of them. So that part needs to be done more carefully in v5.

-- 
Jens Axboe

