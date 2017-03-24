Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33221 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdCXGa3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2017 02:30:29 -0400
MIME-Version: 1.0
In-Reply-To: <87tw6j8be6.fsf@notabene.neil.brown.name>
References: <20170316161235.27110-1-tom.leiming@gmail.com> <20170316161235.27110-3-tom.leiming@gmail.com>
 <87tw6j8be6.fsf@notabene.neil.brown.name>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 24 Mar 2017 14:30:27 +0800
Message-ID: <CACVXFVNugXT5NA2_1UODDpcbhb_gHmF5M1-FAAoAy592tow8Rw@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] md: move two macros into md.h
To: NeilBrown <neilb@suse.com>
Cc: Shaohua Li <shli@kernel.org>, Jens Axboe <axboe@fb.com>,
        "open list:SOFTWARE RAID (Multiple Disks) SUPPORT"
        <linux-raid@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Mar 24, 2017 at 1:57 PM, NeilBrown <neilb@suse.com> wrote:
> On Fri, Mar 17 2017, Ming Lei wrote:
>
>> Both raid1 and raid10 share common resync
>> block size and page count, so move them into md.h.
>
> I don't think this is necessary.
> These are just "magic" numbers.  They don't have any real
> meaning and so don't belong in md.h, or and .h file.

The thing is that RESYNC_PAGES is needed in the following patch 3:

     [PATCH v3 03/14] md: prepare for managing resync I/O pages in clean way

so how about moving the macros into raid1-10.h? Cause you suggest
to create that header for holding the introduced helpers in patch3.

Thanks,
Ming
