Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46723C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F3E20881
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 15:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KtC0MJsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbfA2PjH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 10:39:07 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38871 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfA2PjH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 10:39:07 -0500
Received: by mail-io1-f68.google.com with SMTP id l14so16630671ioj.5
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 07:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QL8/Pl6W2BZ7GXSeIsBtNG+iXdPSeE2eIT+9csF7YAY=;
        b=KtC0MJsjU3J1VnW4fajxhvRKhgXfP+AqCRgkyUFGxCZmgC7SQqwjnDi33rAaX/Sv2A
         HAYv0XGIUr52dRVCbtnRnCrXuQfYMtq+2YBAGqRnsbxyKhY3NrTfWTmQl7Tmg/u9m3f8
         4Nm19zfVjH/lCsGqN84bqlv++y2CAGsborRUEUvdSmDhTY+1rRWn2rVfVNhye1/TXlcZ
         6o7mcLq9owqkRhDYA19x5ekQIu3y6vIFJrP+pelYyhE554XOO/1/Jsd/BqdAYH3iNLJk
         ctbvrtJb0r4FTlpzsGDMKEvLXdtBNBvVUGXDNdCprLRlC6/icnCojAiGpyB5SsR7AqxI
         TtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QL8/Pl6W2BZ7GXSeIsBtNG+iXdPSeE2eIT+9csF7YAY=;
        b=edNeaLqcPmHSWrZyo7+uanNTdXUQMVsZ6RRoUPSvR0VeVCX2ZEG/FVViu2EHsPoXBq
         P4Yrhu/06psN3CyxtrpkAK2P5eAQjO3rCaRS9clEsniH/PU7MeOwaJUaZl3kJXPm3qKN
         4f2orrlQ+MRgCb5mvpkJfnWdTJjrEyx/5P8k64rJ/JbU4PNNKuzT/SuC6WjP9BBAcab1
         hoAYikpoMirepOe2JkMCadfRVo/IW8BHWeNs6LHgU3d8cDoOp8JFxMdWorvlHxDsdG2W
         jsbB2xd8DJasU8rTNrwiHBeaHtg6+M9EOTuY4bUNtquL6qJV+455NkxUQirQ5Vtiraoa
         nqYA==
X-Gm-Message-State: AHQUAuY2kAdzzSocL+5bfyr6a4uqUt49MZk8LDkjDtwdnoLoWwzbw6go
        c9SbbeTHM+mI8S1eqEhmIj8q1Q==
X-Google-Smtp-Source: ALg8bN4AaZMZy0ngJiDVMJUAqh1I4TRCAvN/mUFkM/aWhhvojYSkE1Bgz/DKbZgECXIb9SSoOiYcAQ==
X-Received: by 2002:a5d:87d8:: with SMTP id q24mr14723099ios.89.1548776346273;
        Tue, 29 Jan 2019 07:39:06 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h64sm1880494itb.14.2019.01.29.07.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 07:39:04 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jann Horn <jannh@google.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>, hch@lst.de,
        jmoyer@redhat.com, Avi Kivity <avi@scylladb.com>
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-6-axboe@kernel.dk>
 <CAG48ez1ZM5KxjYGuDysZfNDQ_RjrrXWAM=vwyOfRi=oFdby1mQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0145f6d5-5796-02bf-d9a3-22a9a1d2df80@kernel.dk>
Date:   Tue, 29 Jan 2019 08:39:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1ZM5KxjYGuDysZfNDQ_RjrrXWAM=vwyOfRi=oFdby1mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 8:35 AM, Jann Horn wrote:
> On Mon, Jan 28, 2019 at 10:35 PM Jens Axboe <axboe@kernel.dk> wrote:
>> The submission queue (SQ) and completion queue (CQ) rings are shared
>> between the application and the kernel. This eliminates the need to
>> copy data back and forth to submit and complete IO.
> [...]
>> +static int io_import_iovec(struct io_ring_ctx *ctx, int rw,
>> +                          const struct io_uring_sqe *sqe,
>> +                          struct iovec **iovec, struct iov_iter *iter)
>> +{
>> +       void __user *buf = u64_to_user_ptr(sqe->addr);
>> +
>> +#ifdef CONFIG_COMPAT
>> +       if (in_compat_syscall())
>> +               return compat_import_iovec(rw, buf, sqe->len, UIO_FASTIOV,
>> +                                               iovec, iter);
>> +#endif
>> +
>> +       return import_iovec(rw, buf, sqe->len, UIO_FASTIOV, iovec, iter);
>> +}
> 
> This code can run in kthread context, right? I think
> in_compat_syscall() might not work if this is a kthread launched by a
> compat task; I don't see anything that propagates the compat flag to
> the kthread.

Good catch, yes it can. We should just carry this information in
sqe_submit for this out-of-line purpose. I'll make that change.

-- 
Jens Axboe

