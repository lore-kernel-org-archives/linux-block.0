Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44439 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbcKHS7R (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Nov 2016 13:59:17 -0500
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
References: <366c9429-1bf8-a385-c8b3-a7e6c06a9907@deltatee.com>
 <8eed541f-b4c2-37c9-6650-216f3d0aa92f@fb.com>
Cc: linux-block@vger.kernel.org,
        Stephen Bates <stephen.bates@microsemi.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <21f0cddd-28d9-790d-b4fc-4635cca77ea8@deltatee.com>
Date: Tue, 8 Nov 2016 11:59:14 -0700
MIME-Version: 1.0
In-Reply-To: <8eed541f-b4c2-37c9-6650-216f3d0aa92f@fb.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Jens,

Thanks for the quick reply. I just built 82a78cd and I'm seeing the same
problem as reported.

Logan

On 08/11/16 11:21 AM, Jens Axboe wrote:
> On 11/08/2016 11:16 AM, Logan Gunthorpe wrote:
>> Hi guys,
>>
>> We were looking at testing the new IO polling improvements and we built
>> a kernel from the 'for-4.10/dio' (64ead7d) branch in linux-block.
>> However this branch seems to cause hung tasks when booted. Most
>> noticeably, dhclient seems to always hang as it tries to read from it's
>> leases file, and that means networking does not work on the computers we
>> tested on. Other tasks seemed to hang occasionally and randomly.
>>
>> We tested on two machines with radically different hardware but both
>> running Debian Jessie.  (One is a dual-socket server system with the
>> root FS on an HDD and the other is an off the shelf commodity
>> motherboard with root on an SSD.)
>>
>> We performed a bisect to find the culprit commit to be:
>>
>> [b685d3d65ac791406e0dfd8779cc9b3707fea5a3] block: treat REQ_FUA and
>> REQ_PREFLUSH as synchronous
>>
>> I've attached a bisect log.
> 
> I don't think that's right. The version you ran has a bug in the stats
> code. Please update to the current for-4.10/dio branch (82a78cd682bf)
> and I think you'll have more luck.
> 
