Return-Path: <Damien.LeMoal@wdc.com>
Subject: Re: BUG: Hung task timeouts in for-4.10/dio
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
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
CC: Logan Gunthorpe <logang@deltatee.com>, <linux-block@vger.kernel.org>, Mike
 Snitzer <snitzer@redhat.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <07e8aa41-30fd-5d1b-23de-d803d6b3c322@wdc.com>
Date: Wed, 9 Nov 2016 11:55:45 +0900
MIME-Version: 1.0
In-Reply-To: <f1a21c70-8161-7e2a-5945-5305637fde8e@kernel.dk>
Content-Type: text/plain; charset="windows-1252"
Return-Path: damien.lemoal@wdc.com
List-ID: <linux-block@vger.kernel.org>


Jens,

On 11/9/16 11:45, Jens Axboe wrote:
> I just committed the work-around. But yes, let's have a logical revert
> and require that REQ_SYNC be set for REQ_FUA|REQ_PREFLUSH to avoid it
> being this fragile.

Great ! Thank you.

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
