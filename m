Return-Path: <prvs=7568bcc2f=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hare@suse.de" <hare@suse.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "keith.busch@intel.com"
	<keith.busch@intel.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "hare@suse.com" <hare@suse.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 3/6] nvme: register ns_id attributes as default sysfs
 groups
Date: Mon, 13 Aug 2018 19:51:16 +0000
Message-ID: <a15ed0c9327ffd79615e2b9f0d1f2cec8e5d330a.camel@wdc.com>
References: <20180730071227.22887-1-hare@suse.de>
	 <20180730071227.22887-4-hare@suse.de>
In-Reply-To: <20180730071227.22887-4-hare@suse.de>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-07-30 at 09:12 +-0200, Hannes Reinecke wrote:
+AD4- +AEAAQA- -3061,11 +-3066,7 +AEAAQA- static void nvme+AF8-alloc+AF8-ns=
(struct nvme+AF8-ctrl +ACo-ctrl, unsigned nsid)
+AD4- =20
+AD4-  	nvme+AF8-get+AF8-ctrl(ctrl)+ADs-
+AD4- =20
+AD4- -	device+AF8-add+AF8-disk(ctrl-+AD4-device, ns-+AD4-disk, NULL)+ADs-
+AD4- -	if (sysfs+AF8-create+AF8-group(+ACY-disk+AF8-to+AF8-dev(ns-+AD4-dis=
k)-+AD4-kobj,
+AD4- -					+ACY-nvme+AF8-ns+AF8-id+AF8-attr+AF8-group))
+AD4- -		pr+AF8-warn(+ACIAJQ-s: failed to create sysfs group for identifica=
tion+AFw-n+ACI-,
+AD4- -			ns-+AD4-disk-+AD4-disk+AF8-name)+ADs-
+AD4- +-	device+AF8-add+AF8-disk(ctrl-+AD4-device, ns-+AD4-disk, nvme+AF8-n=
s+AF8-id+AF8-attr+AF8-groups)+ADs-
+AD4-  	if (ns-+AD4-ndev +ACYAJg- nvme+AF8-nvm+AF8-register+AF8-sysfs(ns))
+AD4-  		pr+AF8-warn(+ACIAJQ-s: failed to register lightnvm sysfs group for=
 identification+AFw-n+ACI-,
+AD4-  			ns-+AD4-disk-+AD4-disk+AF8-name)+ADs-

Hello Hannes,

Have you noticed that nvme+AF8-nvm+AF8-register+AF8-sysfs() also registers =
sysfs attributes
and hence that the attributes registered by that function should be merged =
into
the nvme+AF8-ns+AF8-id+AF8-attr+AF8-groups array?

Thanks,

Bart.
