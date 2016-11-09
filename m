Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:47403 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbcKIRDT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Nov 2016 12:03:19 -0500
To: Damien Le Moal <damien.lemoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
References: <6d532d4a-8d35-f610-65ed-efef949a3686@fb.com>
 <84693d82-b8dc-42b3-03da-055def7499a0@deltatee.com>
 <1e0e590b-fde3-a86d-bc60-8e5465928533@fb.com>
 <84cf8089-7d6d-0146-49fb-91a2d08650b2@wdc.com>
 <20161109010959.GA32126@lst.de>
 <b3d8c5fa-b930-b21f-3986-1ff94611c7f9@wdc.com>
 <a6d1d368-04a2-e999-a610-abd96add81a9@fb.com>
 <03cda65e-3a82-6ccd-861b-67a55888eb19@kernel.dk>
 <98e85291-21b6-e961-dfa8-abdc6b2fbb68@wdc.com>
 <13243c58-167c-6535-d920-be79004e72ce@kernel.dk>
 <20161109024036.GA1379@lst.de>
 <f1a21c70-8161-7e2a-5945-5305637fde8e@kernel.dk>
 <07e8aa41-30fd-5d1b-23de-d803d6b3c322@wdc.com>
Cc: linux-block@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        Stephen Bates <stephen.bates@microsemi.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <61d8d344-6eb3-95b8-8f54-114b149871de@deltatee.com>
Date: Wed, 9 Nov 2016 10:03:12 -0700
MIME-Version: 1.0
In-Reply-To: <07e8aa41-30fd-5d1b-23de-d803d6b3c322@wdc.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hey,

I just tested with the latest for-4.10/block branch and it looks like it
fixed our problem.

Thanks!

Logan

On 08/11/16 07:55 PM, Damien Le Moal wrote:
> 
> Jens,
> 
> On 11/9/16 11:45, Jens Axboe wrote:
>> I just committed the work-around. But yes, let's have a logical revert
>> and require that REQ_SYNC be set for REQ_FUA|REQ_PREFLUSH to avoid it
>> being this fragile.
> 
> Great ! Thank you.
> 
