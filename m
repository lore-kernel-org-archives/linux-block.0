Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f177.google.com ([209.85.217.177]:34767 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbdBNBE2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2017 20:04:28 -0500
MIME-Version: 1.0
In-Reply-To: <20170213134654.GB22818@infradead.org>
References: <1486724177-14817-1-git-send-email-tom.leiming@gmail.com>
 <1486724177-14817-2-git-send-email-tom.leiming@gmail.com> <20170213134654.GB22818@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 14 Feb 2017 09:04:26 +0800
Message-ID: <CACVXFVNN3Gtm4Ut5KCmx8REbMYnh3Y2+sAZPto7F40fvGyZ=zw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] block: introduce bio_clone_bioset_partial()
To: Christoph Hellwig <hch@infradead.org>
Cc: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT"
        <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Feb 13, 2017 at 9:46 PM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Feb 10, 2017 at 06:56:13PM +0800, Ming Lei wrote:
>> md still need bio clone(not the fast version) for behind write,
>> and it is more efficient to use bio_clone_bioset_partial().
>>
>> The idea is simple and just copy the bvecs range specified from
>> parameters.
>
> Given how few users bio_clone_bioset has I wonder if we shouldn't
> simply add the two new arguments to it instead of adding another
> indirection.

For md write-behind, looks we have to provide the two arguments,
could you explain a bit how we can do that by adding another indirection?

>
> Otherwise looks fine:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

-- 
Ming Lei
