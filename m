Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC4CC169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 23:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746DE20869
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 23:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kj6ZBv3e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfBHXbZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:31:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35487 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfBHXbZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 18:31:25 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so2245034pgs.2
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 15:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KlfMTgmX2NfU22H2w+0xcSJUb5o5sqV65hBDA15F2+M=;
        b=kj6ZBv3enlxyT61P3RzTKQmQBJ3b0s8NJ8ERnLvyqByrMQO0wsHJ1SQTKb3StdCSpN
         6n3PsYvigivYq53I/gHh81r9Ks3ISxFqw9jciuW/ia79kE/ihYQYxQ0q4jq3Mn+0BO+y
         +9HXgIPaIOmy5QVqqtb3dm8DwCh3iJRpqlCcI1H7RAl+T7Z048xjlDUmAAFeYbwzz3Dt
         gob9cjaiBxdPnBJC3fzJ0yfhXOQTkUxr/ezCXAQ+ANY97KCUAc5kNojG31YTviDeluuo
         s1JTXfRbU4kEJd+PzRG0AYRL4R+7RR6pm5UV2AUFuLEjDY/FT6pxwgoCpGcf38JSPSTl
         kN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KlfMTgmX2NfU22H2w+0xcSJUb5o5sqV65hBDA15F2+M=;
        b=Y2wJLZMfA0Ycz8UzGPg6o2vmimFCmTKJGsH35ofg3b0E1fy3fEUNZGjlGceqkdqDET
         hF7WFvn25VOEAA8YEm4/ifbiswFrxNjf9zoEuo1UWj73SGyDSyi/oyfs8XJmUGyPrNjE
         /a2JuebtHucprGCambfI8Jm8A05bPJqXEX+KmsfcOPtmPf7Ayyw3Nkt3LkrfSZJT8Clu
         PNnaqNXbdvhyrfEs917NjsBpFSPzFtDRnSdFGswLNO39WQnrCsAjhOJz8cSoGzsHYPRL
         HrYgLLgS9EuyrCpG9ibBiheoUWeZleMgaZ9cu/PTExkTDdcGzbCD811bv9rlyQJ1mZsu
         z/Qw==
X-Gm-Message-State: AHQUAuapEe2HOfL3dcF6h2X7IjYjc8rgCJICk72Q0CFtFfFenHvmOfG5
        4WQBsY6LO0NqCnzL6CqnTtEBtg==
X-Google-Smtp-Source: AHgI3IaPGxagKVXV8/gqC6RQyeRjve46eJFgm5+btL+lBdetJ0dItB3DiT9gfCvKYm7ElRgVEYMBwQ==
X-Received: by 2002:a63:134a:: with SMTP id 10mr21299762pgt.83.1549668684930;
        Fri, 08 Feb 2019 15:31:24 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f6sm5652855pfc.88.2019.02.08.15.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 15:31:24 -0800 (PST)
Subject: Re: [PATCH 06/19] io_uring: add fsync support
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20190208173423.27014-1-axboe@kernel.dk>
 <20190208173423.27014-7-axboe@kernel.dk>
 <CAG48ez1zUf9GqZyoD3XEEYyeg2zrBSAO5uKT3MKHOPMk6eujDQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3fb6c108-63c2-6eb4-8e7e-006580277f9f@kernel.dk>
Date:   Fri, 8 Feb 2019 16:31:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1zUf9GqZyoD3XEEYyeg2zrBSAO5uKT3MKHOPMk6eujDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/8/19 3:36 PM, Jann Horn wrote:
> On Fri, Feb 8, 2019 at 6:34 PM Jens Axboe <axboe@kernel.dk> wrote:
>> From: Christoph Hellwig <hch@lst.de>
>>
>> Add a new fsync opcode, which either syncs a range if one is passed,
>> or the whole file if the offset and length fields are both cleared
>> to zero.  A flag is provided to use fdatasync semantics, that is only
>> force out metadata which is required to retrieve the file data, but
>> not others like metadata.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
> [...]
>> +static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>> +                   bool force_nonblock)
>> +{
>> +       struct io_ring_ctx *ctx = req->ctx;
>> +       loff_t sqe_off = READ_ONCE(sqe->off);
>> +       loff_t sqe_len = READ_ONCE(sqe->len);
>> +       loff_t end = sqe_off + sqe_len;
>> +       unsigned fsync_flags;
>> +       struct file *file;
>> +       int ret, fd;
>> +
>> +       /* fsync always requires a blocking context */
>> +       if (force_nonblock)
>> +               return -EAGAIN;
>> +
>> +       if (unlikely(sqe->addr || sqe->ioprio))
>> +               return -EINVAL;
>> +
>> +       fsync_flags = READ_ONCE(sqe->fsync_flags);
>> +       if (unlikely(fsync_flags & ~IORING_FSYNC_DATASYNC))
>> +               return -EINVAL;
>> +
>> +       fd = READ_ONCE(sqe->fd);
>> +       file = fget(fd);
> 
> This always runs on the workqueue, right? Is it possible to call
> fget() on a workqueue?

Oops yes, I've now split that into a io_prep_fsync() and io_fsync()
part so that it works correctly with this new method. Also added a
liburing test for this.

-- 
Jens Axboe

