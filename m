Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35954 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbcKIB00 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Nov 2016 20:26:26 -0500
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
To: Christoph Hellwig <hch@lst.de>
References: <8eed541f-b4c2-37c9-6650-216f3d0aa92f@fb.com>
 <21f0cddd-28d9-790d-b4fc-4635cca77ea8@deltatee.com>
 <9fe151a1-2d9f-28ef-25a7-bbcb01d8d972@fb.com>
 <c2d69ddc-28c9-bf26-5b06-74d00e88a700@deltatee.com>
 <6997fb64-aaac-208f-fa89-b8b4567f7321@fb.com>
 <a74de948-3026-d9b3-6b2e-b9cc1f3c05d4@deltatee.com>
 <6d532d4a-8d35-f610-65ed-efef949a3686@fb.com>
 <84693d82-b8dc-42b3-03da-055def7499a0@deltatee.com>
 <1e0e590b-fde3-a86d-bc60-8e5465928533@fb.com>
 <84cf8089-7d6d-0146-49fb-91a2d08650b2@wdc.com>
 <20161109010959.GA32126@lst.de>
CC: Jens Axboe <axboe@fb.com>, Logan Gunthorpe <logang@deltatee.com>,
        <linux-block@vger.kernel.org>, Mike Snitzer <snitzer@redhat.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <b3d8c5fa-b930-b21f-3986-1ff94611c7f9@wdc.com>
Date: Wed, 9 Nov 2016 10:25:39 +0900
MIME-Version: 1.0
In-Reply-To: <20161109010959.GA32126@lst.de>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org


On 11/9/16 10:09, Christoph Hellwig wrote:
> Ok, sounds like I'm really the one to blame.  I'll see if I can
> find a reproducer.  Damien, or you using device mapper on that
> system?

No LVM/md/dm used on boot. Mount is direct to the block device (SSDs
with ext4). The devices are simple SSDs, so no polling involved.

The hangs suspiciously look like they are either background write or
flush. So I was wondering if it is indeed related to FLUSH/FUA as Logan
suggested or the background write stuff, rather than the direct-IO
optimization & polling.

Will try again/bisect to see if I can get more info.

Cheers.

-- 
Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
