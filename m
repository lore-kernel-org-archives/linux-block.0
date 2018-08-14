Return-Path: <prvs=7571f9cb6=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "keith.busch@intel.com"
	<keith.busch@intel.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.com" <hare@suse.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
Date: Tue, 14 Aug 2018 15:44:57 +0000
Message-ID: <f9ad4ed4685e51a7b0378f11d3ce9d0a76235095.camel@wdc.com>
References: <20180814073305.87255-1-hare@suse.de>
	 <20180814073305.87255-3-hare@suse.de>
	 <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>
	 <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de>
In-Reply-To: <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-08-14 at 17:39 +-0200, Hannes Reinecke wrote:
+AD4- While I have considered having nvme+AF8-nvm+AF8-register+AF8-sysfs() =
returning a
+AD4- pointer I would then have to remove the 'static' declaration from the
+AD4- nvm+AF8-dev+AF8-attr+AF8-group+AF8-12/20.
+AD4- Which I didn't really like, either.

Hmm ... I don't see why the static declaration would have to be removed fro=
m
nvm+AF8-dev+AF8-attr+AF8-group+AF8-12/20 if nvme+AF8-nvm+AF8-register+AF8-s=
ysfs() would return a pointer?
Am I perhaps missing something?

Thanks,

Bart.
