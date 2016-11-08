Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44455 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752818AbcKHTDx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Nov 2016 14:03:53 -0500
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <366c9429-1bf8-a385-c8b3-a7e6c06a9907@deltatee.com>
 <8eed541f-b4c2-37c9-6650-216f3d0aa92f@fb.com>
 <21f0cddd-28d9-790d-b4fc-4635cca77ea8@deltatee.com>
 <9fe151a1-2d9f-28ef-25a7-bbcb01d8d972@fb.com>
Cc: linux-block@vger.kernel.org,
        Stephen Bates <stephen.bates@microsemi.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c2d69ddc-28c9-bf26-5b06-74d00e88a700@deltatee.com>
Date: Tue, 8 Nov 2016 12:03:51 -0700
MIME-Version: 1.0
In-Reply-To: <9fe151a1-2d9f-28ef-25a7-bbcb01d8d972@fb.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hey,

I haven't check 82a78cd, but when I tried reverting the commit in
yesterdays version there were conflicts, as a subsequent patch removed
the defines that the specific patch operated on.

Logan


On 08/11/16 12:01 PM, Jens Axboe wrote:
> On 11/08/2016 11:59 AM, Logan Gunthorpe wrote:
>> Hi Jens,
>>
>> Thanks for the quick reply. I just built 82a78cd and I'm seeing the same
>> problem as reported.
> 
> Hmm, very odd. Does it work if you run that branch and revert the commit
> you bisected as troublesome, b685d3d65ac7?
> 
