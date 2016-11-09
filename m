Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:47522 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750927AbcKIBKC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Nov 2016 20:10:02 -0500
Date: Wed, 9 Nov 2016 02:09:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Jens Axboe <axboe@fb.com>, Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
Message-ID: <20161109010959.GA32126@lst.de>
References: <8eed541f-b4c2-37c9-6650-216f3d0aa92f@fb.com> <21f0cddd-28d9-790d-b4fc-4635cca77ea8@deltatee.com> <9fe151a1-2d9f-28ef-25a7-bbcb01d8d972@fb.com> <c2d69ddc-28c9-bf26-5b06-74d00e88a700@deltatee.com> <6997fb64-aaac-208f-fa89-b8b4567f7321@fb.com> <a74de948-3026-d9b3-6b2e-b9cc1f3c05d4@deltatee.com> <6d532d4a-8d35-f610-65ed-efef949a3686@fb.com> <84693d82-b8dc-42b3-03da-055def7499a0@deltatee.com> <1e0e590b-fde3-a86d-bc60-8e5465928533@fb.com> <84cf8089-7d6d-0146-49fb-91a2d08650b2@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <84cf8089-7d6d-0146-49fb-91a2d08650b2@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Ok, sounds like I'm really the one to blame.  I'll see if I can
find a reproducer.  Damien, or you using device mapper on that
system?
