Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44581 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754042AbcKHTra (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Nov 2016 14:47:30 -0500
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <366c9429-1bf8-a385-c8b3-a7e6c06a9907@deltatee.com>
 <8eed541f-b4c2-37c9-6650-216f3d0aa92f@fb.com>
 <21f0cddd-28d9-790d-b4fc-4635cca77ea8@deltatee.com>
 <9fe151a1-2d9f-28ef-25a7-bbcb01d8d972@fb.com>
 <c2d69ddc-28c9-bf26-5b06-74d00e88a700@deltatee.com>
 <6997fb64-aaac-208f-fa89-b8b4567f7321@fb.com>
Cc: linux-block@vger.kernel.org,
        Stephen Bates <stephen.bates@microsemi.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a74de948-3026-d9b3-6b2e-b9cc1f3c05d4@deltatee.com>
Date: Tue, 8 Nov 2016 12:47:00 -0700
MIME-Version: 1.0
In-Reply-To: <6997fb64-aaac-208f-fa89-b8b4567f7321@fb.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hey,

On 08/11/16 12:19 PM, Jens Axboe wrote:
> Can you try and boot for-4.10/block instead?

Yup. I'm seeing the same issue with that branch too. (b57d74a)

Thanks,

Logan
