Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933799AbcKHVIs (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Nov 2016 16:08:48 -0500
Date: Tue, 8 Nov 2016 16:08:46 -0500
From: Mike Snitzer <snitzer@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
Message-ID: <20161108210846.GA2729@redhat.com>
References: <366c9429-1bf8-a385-c8b3-a7e6c06a9907@deltatee.com>
 <8eed541f-b4c2-37c9-6650-216f3d0aa92f@fb.com>
 <21f0cddd-28d9-790d-b4fc-4635cca77ea8@deltatee.com>
 <9fe151a1-2d9f-28ef-25a7-bbcb01d8d972@fb.com>
 <c2d69ddc-28c9-bf26-5b06-74d00e88a700@deltatee.com>
 <6997fb64-aaac-208f-fa89-b8b4567f7321@fb.com>
 <a74de948-3026-d9b3-6b2e-b9cc1f3c05d4@deltatee.com>
 <6d532d4a-8d35-f610-65ed-efef949a3686@fb.com>
 <84693d82-b8dc-42b3-03da-055def7499a0@deltatee.com>
 <1e0e590b-fde3-a86d-bc60-8e5465928533@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1e0e590b-fde3-a86d-bc60-8e5465928533@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 08 2016 at  3:21pm -0500,
Jens Axboe <axboe@fb.com> wrote:

> On 11/08/2016 12:55 PM, Logan Gunthorpe wrote:
> >Hey,
> >
> >I've attached the output of dmesg from a working boot and the output of
> >mount.
> >
> >Pretty much all the file systems are ext4. We have some experimental
> >nvme devices in this system which I did try removing to eliminate that
> >possibility.
> >
> >Let me know if you need anything else.

I'm not seeing Logan's above message (with dmesg) on linux-block
archives.  So I cannot yet appreciate which DM targets are in play.

> You're using dm, that might be related. Mike, have you tried booting
> for-4.10/block and checking if dm works fine?

I haven't tried for-4.10/block yet.  But I should be able to try it this
week.
