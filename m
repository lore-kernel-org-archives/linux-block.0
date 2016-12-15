Return-Path: <Damien.LeMoal@wdc.com>
Subject: Re: [RFC] block: check partition alignment
To: Stefan Haberland <sth@linux.vnet.ibm.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20161214164706.45543-1-sth@linux.vnet.ibm.com>
 <40f04360-5137-8504-fd2c-0861c7856a7a@wdc.com>
Cc: hoeppner@linux.vnet.ibm.com, sebott@linux.vnet.ibm.com
From: Damien Le Moal <damien.lemoal@wdc.com>
Message-ID: <64f82273-adc6-ce79-5d1f-ae4b54efd240@wdc.com>
Date: Thu, 15 Dec 2016 09:55:36 +0900
MIME-Version: 1.0
In-Reply-To: <40f04360-5137-8504-fd2c-0861c7856a7a@wdc.com>
Return-Path: damien.lemoal@wdc.com
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-block@vger.kernel.org>


> sd.c ensures that the logical block size (sector size in sd.c) is a
> power of 2 between 512 and 4096. So you can use:
> =

> if (p.start & (bdev_physical_block_size(bdev) - 1))

Sorry, that was a little too short as a complete proof:
sd.c ensures that the logical block size (sector size in sd.c) is a
power of 2 between 512 and 4096, and the physical block size is a power
of 2 number of logical blocks. So the physical block size is also always
a power of 2.

> =

> Or use div_u64_rem to avoid an error on 32 bits builds.
> =

> Best regards.
> =


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
