Return-Path: <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v8 0/7] ZBC / Zoned block device support
To: Jens Axboe <axboe@kernel.dk>
References: <1476772835-18541-1-git-send-email-damien.lemoal@wdc.com>
 <2a80d950-c831-9ac6-1969-dc6386e58236@kernel.dk>
CC: <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>, Christoph
 Hellwig <hch@lst.de>, "Martin K . Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Shaun Tancheff <shaun@tancheff.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <05d9cbd0-fb78-3f35-cc42-47f58640d184@wdc.com>
Date: Wed, 19 Oct 2016 08:15:49 +0900
MIME-Version: 1.0
In-Reply-To: <2a80d950-c831-9ac6-1969-dc6386e58236@kernel.dk>
Content-Type: text/plain; charset="windows-1252"
Return-Path: damien.lemoal@wdc.com
List-ID: <linux-block@vger.kernel.org>

Jens,

On 10/19/16 00:58, Jens Axboe wrote:
> This is starting to look mergeable to me. Any objections in getting this
> applied for 4.10? Looks like 6/7 should go through the SCSI tree, but I
> can queue up the rest.

Yes, it would be great to get all this queued for 4.10. Indeed 6/7 is
SCSI, but if possible, it would be great to get it in the same tree as
the rest so that a single tree provides full ZBC support.
Martin, any objection ?

Thank you.

Best regards.

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
