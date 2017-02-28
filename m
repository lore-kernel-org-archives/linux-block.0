Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:35705 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751968AbdB1MUQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2017 07:20:16 -0500
MIME-Version: 1.0
In-Reply-To: <20170225182306.GC26447@infradead.org>
References: <1487950971-1131-1-git-send-email-tom.leiming@gmail.com>
 <1487950971-1131-3-git-send-email-tom.leiming@gmail.com> <20170225182306.GC26447@infradead.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 28 Feb 2017 20:18:53 +0800
Message-ID: <CACVXFVOzaZ70UB8+1WM1Xukb=PRi9-C13GSDy8YtQda+WMrOSA@mail.gmail.com>
Subject: Re: [PATCH v1 02/14] block: introduce bio_remove_last_page()
To: Christoph Hellwig <hch@infradead.org>
Cc: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT"
        <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, Feb 26, 2017 at 2:23 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Fri, Feb 24, 2017 at 11:42:39PM +0800, Ming Lei wrote:
>> MD need this helper to remove the last added page, so introduce
>> it.
>
> If MD really has a valid use case for this it should open code the
> operation.  The semantics look deeply fishy to me.

Thinking about MD's case further, and looks bio_add_page() won't
fail at all in case that queue's limit isn't applied in bio_add_page()
in future.

So I will change MD's handling in this case and avoid to introduce
bio_remove_last_page() in V2.

Thanks,
Ming Lei
