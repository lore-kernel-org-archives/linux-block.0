Return-Path: <prvs=7391cfe80=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "ps@pks.im" <ps@pks.im>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "ming.lei@redhat.com"
	<ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix NPE when resuming SCSI devices using blk-mq
Date: Fri, 27 Jul 2018 15:03:09 +0000
Message-ID: <6f00aeea242c20be1e2709bb00d27d79a8a8facf.camel@wdc.com>
References: 
 <b712b87a509dc64619a3aec7c673935ed09be5de.1531488173.git.ps@pks.im>
	 <fda284b59b2401d3d44a1343f809b98a8ae69be7.camel@wdc.com>
	 <20180726083850.GB1674@ncase>
	 <62ddc886d005b91bd6a1bd8775259bb0b5cbe2b2.camel@wdc.com>
	 <20180727123533.GA1588@xps>
In-Reply-To: <20180727123533.GA1588@xps>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-07-27 at 14:35 +-0200, Patrick Steinhardt wrote:
+AD4- +ADw-1+AD4AWw-   53.411700+AF0- BUG: unable to handle kernel NULL poi=
nter dereference at 00000000000001a8
+AD4- +ADw-4+AD4AWw-   53.411733+AF0- RIP: 0010:blk+AF8-set+AF8-runtime+AF8=
-active+-0x2d/0x50

Are you sure commit 4fd41a8552af (+ACI-SCSI: Fix NULL pointer dereference i=
n
runtime PM+ACIAOw- December 2015) is in your kernel tree?

Bart.
