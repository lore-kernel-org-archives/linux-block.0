Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55277 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751749AbcKHTUQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Nov 2016 14:20:16 -0500
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
To: Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>
References: <366c9429-1bf8-a385-c8b3-a7e6c06a9907@deltatee.com>
 <8eed541f-b4c2-37c9-6650-216f3d0aa92f@fb.com>
 <21f0cddd-28d9-790d-b4fc-4635cca77ea8@deltatee.com>
 <9fe151a1-2d9f-28ef-25a7-bbcb01d8d972@fb.com>
 <c2d69ddc-28c9-bf26-5b06-74d00e88a700@deltatee.com>
CC: <linux-block@vger.kernel.org>,
        Stephen Bates <stephen.bates@microsemi.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <6997fb64-aaac-208f-fa89-b8b4567f7321@fb.com>
Date: Tue, 8 Nov 2016 12:19:58 -0700
MIME-Version: 1.0
In-Reply-To: <c2d69ddc-28c9-bf26-5b06-74d00e88a700@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/08/2016 12:03 PM, Logan Gunthorpe wrote:
> Hey,
>
> I haven't check 82a78cd, but when I tried reverting the commit in
> yesterdays version there were conflicts, as a subsequent patch removed
> the defines that the specific patch operated on.

Can you try and boot for-4.10/block instead?

-- 
Jens Axboe

