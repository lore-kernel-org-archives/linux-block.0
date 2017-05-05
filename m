Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kys@microsoft.com" <kys@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "sthemmin@microsoft.com" <sthemmin@microsoft.com>
Subject: Re: [PATCH] block-mq: set both block queue and hardware queue restart
 bit for restart
Date: Fri, 5 May 2017 19:52:12 +0000
Message-ID: <1494013930.2744.16.camel@sandisk.com>
References: <1491437781-3565-1-git-send-email-longli@exchange.microsoft.com>
	 <1491438735.2787.18.camel@sandisk.com>
	 <BN3PR03MB2227E6DBCAE0365A013B7972CE0D0@BN3PR03MB2227.namprd03.prod.outlook.com>
	 <1491450335.8994.1.camel@sandisk.com>
	 <DM5PR03MB2490E70D9B18A701A81005C8A00D0@DM5PR03MB2490.namprd03.prod.outlook.com>
	 <1491868058.4199.28.camel@sandisk.com>
	 <BN3PR03MB2227E7A0189829B68BE83DBFCE020@BN3PR03MB2227.namprd03.prod.outlook.com>
	 <BN3PR03MB2227328E61F98787E89B36B5CEEB0@BN3PR03MB2227.namprd03.prod.outlook.com>
In-Reply-To: <BN3PR03MB2227328E61F98787E89B36B5CEEB0@BN3PR03MB2227.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2017-05-05 at 08:58 +0000, Long Li wrote:
> > > From: Bart Van Assche [mailto:Bart.VanAssche@sandisk.com]
> > >=20
> > > Can you repeat your test with kernel v4.11-rc6?
> > > The patches that went into the block layer for v4.11-rc6 should be
> > > sufficient to fix this: [ ... ]
>=20
> Testing went well. There were no I/O hangs.

Hello Long,

Thanks for having run these tests and thanks for the feedback!

Bart.=
