Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:56225 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752640AbcKHUVY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Nov 2016 15:21:24 -0500
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
To: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
References: <366c9429-1bf8-a385-c8b3-a7e6c06a9907@deltatee.com>
 <8eed541f-b4c2-37c9-6650-216f3d0aa92f@fb.com>
 <21f0cddd-28d9-790d-b4fc-4635cca77ea8@deltatee.com>
 <9fe151a1-2d9f-28ef-25a7-bbcb01d8d972@fb.com>
 <c2d69ddc-28c9-bf26-5b06-74d00e88a700@deltatee.com>
 <6997fb64-aaac-208f-fa89-b8b4567f7321@fb.com>
 <a74de948-3026-d9b3-6b2e-b9cc1f3c05d4@deltatee.com>
 <6d532d4a-8d35-f610-65ed-efef949a3686@fb.com>
 <84693d82-b8dc-42b3-03da-055def7499a0@deltatee.com>
CC: <linux-block@vger.kernel.org>, Mike Snitzer <snitzer@redhat.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <1e0e590b-fde3-a86d-bc60-8e5465928533@fb.com>
Date: Tue, 8 Nov 2016 13:21:09 -0700
MIME-Version: 1.0
In-Reply-To: <84693d82-b8dc-42b3-03da-055def7499a0@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/08/2016 12:55 PM, Logan Gunthorpe wrote:
> Hey,
>
> I've attached the output of dmesg from a working boot and the output of
> mount.
>
> Pretty much all the file systems are ext4. We have some experimental
> nvme devices in this system which I did try removing to eliminate that
> possibility.
>
> Let me know if you need anything else.

You're using dm, that might be related. Mike, have you tried booting
for-4.10/block and checking if dm works fine?

-- 
Jens Axboe

