Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33828 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752337AbdB1M1a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2017 07:27:30 -0500
MIME-Version: 1.0
In-Reply-To: <20170225182216.GB26447@infradead.org>
References: <1487950971-1131-1-git-send-email-tom.leiming@gmail.com>
 <1487950971-1131-2-git-send-email-tom.leiming@gmail.com> <20170225182216.GB26447@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 28 Feb 2017 20:15:37 +0800
Message-ID: <CACVXFVMjf0trmc8jggdYUm8k1HS+vHa26=godzJ-jQ_23yha0w@mail.gmail.com>
Subject: Re: [PATCH v1 01/14] block: introduce bio_segments_all()
To: Christoph Hellwig <hch@infradead.org>
Cc: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT"
        <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Feb 26, 2017 at 2:22 AM, Christoph Hellwig <hch@infradead.org> wrote:
>> +static inline unsigned bio_segments_all(struct bio *bio)
>> +{
>> +     WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
>> +
>> +     return bio->bi_vcnt;
>> +}
>
> I don't think this helpers really adds any benefit.

IMO the first benefit is that misusing of .bi_vcnt can be warned, and
another one is that we have to introduce this helper if multipage bvec
is supported.

Thanks,
Ming Lei
