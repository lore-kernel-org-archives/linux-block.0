Return-Path: <decui@microsoft.com>
From: Dexuan Cui <decui@microsoft.com>
To: "hch@lst.de" <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Bart Van Assche <Bart.VanAssche@sandisk.com>, "hare@suse.com"
	<hare@suse.com>, "hare@suse.de" <hare@suse.de>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jth@kernel.org" <jth@kernel.org>
Subject: RE: Boot regression (was "Re: [PATCH] genhd: Do not hold event	lock
 when scheduling workqueue elements")
Date: Thu, 9 Feb 2017 07:35:19 +0000
Message-ID: <MWHPR03MB26698583CE04682F588ACAD4BF450@MWHPR03MB2669.namprd03.prod.outlook.com>
References: <1485822639.2669.16.camel@sandisk.com>
 <532c55c4-15da-d2f9-401c-36bc4343756b@suse.com>
 <MWHPR03MB2669B8A45A07846AF0A06E46BF4F0@MWHPR03MB2669.namprd03.prod.outlook.com>
 <MWHPR03MB26699D4657FB67A535972208BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
 <1486436195.2791.1.camel@sandisk.com>
 <MWHPR03MB26695ACBEBDB30E3E2E108FBBF430@MWHPR03MB2669.namprd03.prod.outlook.com>
 <MWHPR03MB2669125A47D3CB7EB530D084BF430@MWHPR03MB2669.namprd03.prod.outlook.com>
 <9199d528-f220-5b77-d657-c510ca210067@kernel.dk>
 <MWHPR03MB26697302F28F9C2C7D7390D4BF420@MWHPR03MB2669.namprd03.prod.outlook.com>
 <b21e5580-ed75-6150-3c83-43ecbb0292a5@kernel.dk>
 <20170208180314.GA17838@lst.de>
In-Reply-To: <20170208180314.GA17838@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

> From: hch@lst.de [mailto:hch@lst.de]
> Sent: Thursday, February 9, 2017 02:03
> To: Jens Axboe <axboe@kernel.dk>
> Cc: Dexuan Cui <decui@microsoft.com>; Bart Van Assche
> <Bart.VanAssche@sandisk.com>; hare@suse.com; hare@suse.de; Martin K.
> Petersen <martin.petersen@oracle.com>; hch@lst.de; linux-
> kernel@vger.kernel.org; linux-block@vger.kernel.org; jth@kernel.org
> Subject: Re: Boot regression (was "Re: [PATCH] genhd: Do not hold event l=
ock
> when scheduling workqueue elements")
>=20
> On Wed, Feb 08, 2017 at 10:43:59AM -0700, Jens Axboe wrote:
> > I've changed the subject line, this issue has nothing to do with the
> > issue that Hannes was attempting to fix.
>=20
> Nothing really useful in the thread.  Dexuan, can you throw in some
> prints to see which command times out?

My colleagues have sent you the logs in another thread.

Thanks for looking into this!

-- Dexuan
