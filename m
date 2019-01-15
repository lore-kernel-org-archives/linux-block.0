Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B929BC43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 17:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8868220866
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 17:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OsPG+5rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbfAOR03 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:26:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33135 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388276AbfAOR02 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 12:26:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so1641768pfb.0
        for <linux-block@vger.kernel.org>; Tue, 15 Jan 2019 09:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ogtRUeGImP39/VjN7mbv4Yo4t7I3CdTvFhnlkn2b7u4=;
        b=OsPG+5rgGYoYacLQl8wm1Z2X1+FQKoGY9igfFNejAo48MhgB8JGFqO/V+c8dD1NiN9
         2hwr5ia1xRubKB0nN9JId+Zp9CGahQnGZ+LfGRNu7kFSZD4A1clRhIzUoso2vHb2oBGU
         FGv/6vCc1pkkgOQJ4uRiE8uEVCeRlr3SXSXPTIOOh+R4lHjUQdYdfQ6S+GUUsg/JNL4M
         vgFxoLOUx2zjC28WtGz8Y4YJaMRyXr5wWOLv3kSYrba5L4ZtlYF/Ir1+uNhzet7GWpY/
         fMsKBswESe1vxsHKwAeqfqiGBiEPD1Qf8yJT7SDo2BBVJ8YCU5+rUe9AEiQwUZb3jCmO
         8Gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ogtRUeGImP39/VjN7mbv4Yo4t7I3CdTvFhnlkn2b7u4=;
        b=uPv56AFAWPsa5kRmETqr0ZmPaIzoTzYJOH+Bdri+FDFQMcsuhWJ3VZ9bm3dMtwVNpP
         VDBEcvMRoucgjWArwi+qHsSzbc+FINaWhM7nFTdFxgAilUG019igeMHtyomsK73NXxVg
         rNLEAeRRbPVxGLHJvhaVDfXUUynT600c7S1G3N8ZVfNpQB4/ACQcn+ZG+R8dGZJYMTkO
         wKjHjqWV5aEGkNAIh/6mJ5i1i0XJ//WhTbX7eeza/x+66/7I5ViN0kuDKgKMVtyvE8f6
         P8kZpZUWqW3OcLXdK2zS5koDw3VAXiEPwiN6N+AizMW/9NoZxMy5sQ843U+mkrdRNRUB
         wFqQ==
X-Gm-Message-State: AJcUukdH+55h5OOSpxWHePMsS5cD/NGDSvKpuL+HuoxXUUzRZPAFhr3G
        zIxfxOLGN29jrOPAhCclziFc4Q==
X-Google-Smtp-Source: ALg8bN4c/P9brhLTSO3Pp6W5ZdMYlcV2uQ3HxZsCEJRVpoPLV4Wr4GFQV9S5mMkzFeOtcVMXZUJOvw==
X-Received: by 2002:a62:6799:: with SMTP id t25mr5083466pfj.139.1547573186643;
        Tue, 15 Jan 2019 09:26:26 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 184sm5166660pfe.106.2019.01.15.09.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 09:26:25 -0800 (PST)
Subject: Re: [PATCH 05/16] Add io_uring IO interface
From:   Jens Axboe <axboe@kernel.dk>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com
References: <20190115025531.13985-1-axboe@kernel.dk>
 <20190115025531.13985-6-axboe@kernel.dk> <20190115095134.6286b7d6@lwn.net>
 <5e1fe0b7-7998-d15d-267b-4dbbc01b0b53@kernel.dk>
Message-ID: <a101eebf-d232-7a31-ee81-ba43c36ff794@kernel.dk>
Date:   Tue, 15 Jan 2019 10:26:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5e1fe0b7-7998-d15d-267b-4dbbc01b0b53@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/15/19 9:55 AM, Jens Axboe wrote:
> On 1/15/19 9:51 AM, Jonathan Corbet wrote:
>> On Mon, 14 Jan 2019 19:55:20 -0700
>> Jens Axboe <axboe@kernel.dk> wrote:
>>
>> So the [0/16] cover letter seems to have gone astray this time?
> 
> It did go out, but I forgot to add a Subject line to it...
> 
> https://marc.info/?l=linux-block&m=154752095709422&w=2
> 
> 
>>> The submission queue (SQ) and completion queue (CQ) rings are shared
>>> between the application and the kernel. This eliminates the need to
>>> copy data back and forth to submit and complete IO.
>>>
>>> IO submissions use the io_uring_sqe data structure, and completions
>>> are generated in the form of io_uring_sqe data structures. The SQ
>>> ring is an index into the io_uring_sqe array, which makes it possible
>>> to submit a batch of IOs without them being contiguous in the ring.
>>> The CQ ring is always contiguous, as completion events are inherently
>>> unordered and can point to any io_uring_iocb.
>>>
>>> Two new system calls are added for this:
>>>
>>> io_uring_setup(entries, iovecs, params)
>>> 	Sets up a context for doing async IO. On success, returns a file
>>> 	descriptor that the application can mmap to gain access to the
>>> 	SQ ring, CQ ring, and io_uring_iocbs.
>>
>> Looking at the code, it would appear that the "iovecs" parameter doesn't
>> actually exist.
> 
> Indeed, need to update that commit message. and io_uring_iocbs should
> now be io_uring_sqes.
> 
> The iovec/file registration is done through io_uring_register(2).

Updated commit message which covers both this one, and the
IORING_ENTER_GETEVENTS below.

http://git.kernel.dk/cgit/linux-block/commit/?h=io_uring&id=d14a06629baef2b0701dbd01ac9c9066f73065ec

-- 
Jens Axboe

