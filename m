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
Date: Tue, 14 Aug 2018 15:20:33 +0000
Message-ID: <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>
References: <20180814073305.87255-1-hare@suse.de>
	 <20180814073305.87255-3-hare@suse.de>
In-Reply-To: <20180814073305.87255-3-hare@suse.de>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Tue, 2018-08-14 at 09:33 +-0200, Hannes Reinecke wrote:
+AD4- +-const struct attribute+AF8-group +ACo-nvme+AF8-ns+AF8-id+AF8-attr+A=
F8-groups+AFsAXQ- +AD0- +AHs-
+AD4- +-	+ACY-nvme+AF8-ns+AF8-id+AF8-attr+AF8-group,
+AD4- +-	NULL, /+ACo- Will be filled in by lightnvm if present +ACo-/
+AD4- +-	NULL,
+AD4- +-+AH0AOw-
+AFs- ... +AF0-
+AD4- -void nvme+AF8-nvm+AF8-unregister+AF8-sysfs(struct nvme+AF8-ns +ACo-n=
s)
+AD4- -+AHs-
+AD4- -	struct nvm+AF8-dev +ACo-ndev +AD0- ns-+AD4-ndev+ADs-
+AD4- -	struct nvm+AF8-geo +ACo-geo +AD0- +ACY-ndev-+AD4-geo+ADs-
+AD4- +-		return+ADs-
+AD4- =20
+AD4-  	switch (geo-+AD4-major+AF8-ver+AF8-id) +AHs-
+AD4-  	case 1:
+AD4- -		sysfs+AF8-remove+AF8-group(+ACY-disk+AF8-to+AF8-dev(ns-+AD4-disk)-=
+AD4-kobj,
+AD4- -					+ACY-nvm+AF8-dev+AF8-attr+AF8-group+AF8-12)+ADs-
+AD4- +-		nvme+AF8-ns+AF8-id+AF8-attr+AF8-groups+AFs-1+AF0- +AD0- +ACY-nvm+=
AF8-dev+AF8-attr+AF8-group+AF8-12+ADs-
+AD4-  		break+ADs-
+AD4-  	case 2:
+AD4- -		sysfs+AF8-remove+AF8-group(+ACY-disk+AF8-to+AF8-dev(ns-+AD4-disk)-=
+AD4-kobj,
+AD4- -					+ACY-nvm+AF8-dev+AF8-attr+AF8-group+AF8-20)+ADs-
+AD4- +-		nvme+AF8-ns+AF8-id+AF8-attr+AF8-groups+AFs-1+AF0- +AD0- +ACY-nvm+=
AF8-dev+AF8-attr+AF8-group+AF8-20+ADs-

This patch introduces a really ugly dependency between the NVMe core code a=
nd
the lightnvm code, namely that the lightnvm code has to know at which posit=
ion
in the nvme+AF8-ns+AF8-id+AF8-attr+AF8-groups it can fill in its attribute =
group pointer. Have
you considered to make nvme+AF8-nvm+AF8-register+AF8-sysfs() return an attr=
ibute group
pointer such that the nvme+AF8-ns+AF8-id+AF8-attr+AF8-groups can be changed=
 from a global into
a static array?

Thanks,

Bart.
