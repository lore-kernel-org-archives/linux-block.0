Return-Path: <Umesh.Patel@wdc.com>
From: Umesh Patel <Umesh.Patel@wdc.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: BIO request larger than our storage device supports in linux
 kernel 4.x
Date: Wed, 8 Mar 2017 18:20:40 +0000
Message-ID: <CY1PR0401MB1353D1D8B5FB4E58AE1ABA5EE12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
References: <CY1PR0401MB13538108F3DFD6738AFC8A34E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
 <CY1PR0401MB1353279ED2A07E69F8ED42B5E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
 <04c47362-2e9d-b32a-fb98-14113b45b6f7@kernel.dk>
 <CY1PR0401MB1353F97FF898FB07AB7E5AD3E12E0@CY1PR0401MB1353.namprd04.prod.outlook.com>
 <211c3042-5f72-def6-4ede-510fa99ef683@kernel.dk>
In-Reply-To: <211c3042-5f72-def6-4ede-510fa99ef683@kernel.dk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

You are doing it wrong, you should be writing this as a blk-mq driver.
Not only would that fix your issue, it would also solve a host of other iss=
ues that I'm sure your driver has since it hasn't even been reviewed.




[Umesh] : This has been working since 2.x kernel to till 3.18. It has this =
issue only in 4.x.



Thanks
Western Digital Corporation (and its subsidiaries) E-mail Confidentiality N=
otice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or l=
egally privileged information of WDC and/or its affiliates, and are intende=
d solely for the use of the individual or entity to which they are addresse=
d. If you are not the intended recipient, any disclosure, copying, distribu=
tion or any action taken or omitted to be taken in reliance on it, is prohi=
bited. If you have received this e-mail in error, please notify the sender =
immediately and delete the e-mail in its entirety from your system.
