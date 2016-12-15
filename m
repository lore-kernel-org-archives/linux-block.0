Return-Path: <Damien.LeMoal@wdc.com>
Subject: Re: [RFC] block: check partition alignment
To: Christoph Hellwig <hch@infradead.org>
References: <20161214164706.45543-1-sth@linux.vnet.ibm.com>
 <20161214170719.GA3599@infradead.org>
 <5824c17b-a7d7-60a1-6bb7-287257aaf67a@wdc.com>
 <20161215084553.GA19716@infradead.org>
Cc: Stefan Haberland <sth@linux.vnet.ibm.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 hoeppner@linux.vnet.ibm.com, sebott@linux.vnet.ibm.com
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <88308b2d-de52-b97a-2001-96da7e9f5d1f@wdc.com>
Date: Thu, 15 Dec 2016 17:56:00 +0900
MIME-Version: 1.0
In-Reply-To: <20161215084553.GA19716@infradead.org>
Return-Path: damien.lemoal@wdc.com
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>



On 12/15/16 17:45, Christoph Hellwig wrote:
> On Thu, Dec 15, 2016 at 10:33:47AM +0900, Damien Le Moal wrote:
>> For a regular block device, I agree. But in Stephan case, I think that
>> the check really needs to be against the physical block size, with the
>> added condition that the bdev is a DASD device (similarly to the zone
>> alignment check for zoned block devices).
> =

> Then they need to expose a chunk_size.  physical block size is defined
> as not having a meaning for the kernel.

Or create the block device with the logical block size set to the
physical sector size. Which would be even more simple and in fact
correct in this case since only physically aligned accesses make sense
for DASD.

-- =

Damien Le Moal, Ph.D.
Sr. Manager, System Software Research Group,
Western Digital Corporation
Damien.LeMoal@wdc.com
(+81) 0466-98-3593 (ext. 513593)
1 kirihara-cho, Fujisawa,
Kanagawa, 252-0888 Japan
www.wdc.com, www.hgst.com
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.
