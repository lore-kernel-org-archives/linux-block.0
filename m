Return-Path: <prvs=7606352ae=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "hch@lst.de" <hch@lst.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "hare@suse.com" <hare@suse.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"keith.busch@intel.com" <keith.busch@intel.com>
Subject: Re: [PATCH 2/5] nvme: register ns_id attributes as default sysfs
 groups
Date: Fri, 17 Aug 2018 20:04:50 +0000
Message-ID: <e3861d6482bef5595720c4e296a1c0e864226323.camel@wdc.com>
References: <20180814073305.87255-1-hare@suse.de>
	 <20180814073305.87255-3-hare@suse.de>
	 <5a4aab8b5f509d8090ad10107b01d11285fe1528.camel@wdc.com>
	 <e4c9ba55-ad92-dcb2-1126-38e5ea4c0a13@suse.de>
	 <f9ad4ed4685e51a7b0378f11d3ce9d0a76235095.camel@wdc.com>
	 <20180817070013.GD11170@lst.de>
In-Reply-To: <20180817070013.GD11170@lst.de>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Fri, 2018-08-17 at 09:00 +-0200, hch+AEA-lst.de wrote:
+AD4- On Tue, Aug 14, 2018 at 03:44:57PM +-0000, Bart Van Assche wrote:
+AD4- +AD4- On Tue, 2018-08-14 at 17:39 +-0200, Hannes Reinecke wrote:
+AD4- +AD4- +AD4- While I have considered having nvme+AF8-nvm+AF8-register+=
AF8-sysfs() returning a
+AD4- +AD4- +AD4- pointer I would then have to remove the 'static' declarat=
ion from the
+AD4- +AD4- +AD4- nvm+AF8-dev+AF8-attr+AF8-group+AF8-12/20.
+AD4- +AD4- +AD4- Which I didn't really like, either.
+AD4- +AD4-=20
+AD4- +AD4- Hmm ... I don't see why the static declaration would have to be=
 removed from
+AD4- +AD4- nvm+AF8-dev+AF8-attr+AF8-group+AF8-12/20 if nvme+AF8-nvm+AF8-re=
gister+AF8-sysfs() would return a pointer?
+AD4- +AD4- Am I perhaps missing something?
+AD4-=20
+AD4- No, I think that would be the preferable approach IFF patching the gl=
obal
+AD4- table of groups would be viable.  I don't think it is, though - we ca=
n
+AD4- have both normal NVMe and LightNVM devices in the same system, so we
+AD4- can't just patch it over.
+AD4-=20
+AD4- So we'll need three different attribut group arrays:
+AD4-=20
+AD4- const struct attribute+AF8-group +ACo-nvme+AF8-ns+AF8-id+AF8-attr+AF8=
-groups+AFsAXQ- +AD0- +AHs-
+AD4- 	+ACY-nvme+AF8-ns+AF8-id+AF8-attr+AF8-group,
+AD4- 	NULL,
+AD4- +AH0AOw-
+AD4-=20
+AD4- const struct attribute+AF8-group +ACo-lightnvm12+AF8-ns+AF8-id+AF8-at=
tr+AF8-groups+AFsAXQ- +AD0- +AHs-
+AD4- 	+ACY-nvme+AF8-ns+AF8-id+AF8-attr+AF8-group,
+AD4- 	+ACY-nvm+AF8-dev+AF8-attr+AF8-group+AF8-12,
+AD4- 	NULL,
+AD4- +AH0AOw-
+AD4-=20
+AD4- const struct attribute+AF8-group +ACo-lightnvm20+AF8-ns+AF8-id+AF8-at=
tr+AF8-groups+AFsAXQ- +AD0- +AHs-
+AD4- 	+ACY-nvme+AF8-ns+AF8-id+AF8-attr+AF8-group,
+AD4- 	+ACY-nvm+AF8-dev+AF8-attr+AF8-group+AF8-20,
+AD4- 	NULL,
+AD4- +AH0AOw-
+AD4-=20
+AD4- and a function to select which one to use.

Hello Christoph,

How about applying the patch below on top of Hannes' patch? The patch below
has the advantage that it completely separates the open channel sysfs
attributes from the NVMe core sysfs attributes - the open channel code
doesn't have to know anything about the NVMe core sysfs attributes and the
NVMe core does not have to know anything about the open channel sysfs
attributes.

Thanks,

Bart.


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8e26d98e9a8f..e0a9e1c5b30e 100644
--- a/drivers/nvme/host/core.c
+-+-+- b/drivers/nvme/host/core.c
+AEAAQA- -2736,7 +-2736,9 +AEAAQA- const struct attribute+AF8-group nvme+AF=
8-ns+AF8-id+AF8-attr+AF8-group +AD0- +AHs-
=20
 const struct attribute+AF8-group +ACo-nvme+AF8-ns+AF8-id+AF8-attr+AF8-grou=
ps+AFsAXQ- +AD0- +AHs-
 	+ACY-nvme+AF8-ns+AF8-id+AF8-attr+AF8-group,
-	NULL, /+ACo- Will be filled in by lightnvm if present +ACo-/
+-+ACM-ifdef CONFIG+AF8-NVM
+-	+ACY-nvme+AF8-nvm+AF8-attr+AF8-group,
+-+ACM-endif
 	NULL,
 +AH0AOw-
=20
+AEAAQA- -3105,8 +-3107,6 +AEAAQA- static void nvme+AF8-alloc+AF8-ns(struct=
 nvme+AF8-ctrl +ACo-ctrl, unsigned nsid)
=20
 	nvme+AF8-get+AF8-ctrl(ctrl)+ADs-
=20
-	if (ns-+AD4-ndev)
-		nvme+AF8-nvm+AF8-register+AF8-sysfs(ns)+ADs-
 	device+AF8-add+AF8-disk(ctrl-+AD4-device, ns-+AD4-disk, nvme+AF8-ns+AF8-i=
d+AF8-attr+AF8-groups)+ADs-
=20
 	nvme+AF8-mpath+AF8-add+AF8-disk(ns, id)+ADs-
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 7bf2f9da6293..b7b19d3561a4 100644
--- a/drivers/nvme/host/lightnvm.c
+-+-+- b/drivers/nvme/host/lightnvm.c
+AEAAQA- -1190,10 +-1190,29 +AEAAQA- static NVM+AF8-DEV+AF8-ATTR+AF8-12+AF8=
-RO(multiplane+AF8-modes)+ADs-
 static NVM+AF8-DEV+AF8-ATTR+AF8-12+AF8-RO(media+AF8-capabilities)+ADs-
 static NVM+AF8-DEV+AF8-ATTR+AF8-12+AF8-RO(max+AF8-phys+AF8-secs)+ADs-
=20
-static struct attribute +ACo-nvm+AF8-dev+AF8-attrs+AF8-12+AFsAXQ- +AD0- +A=
Hs-
+-/+ACo- 2.0 values +ACo-/
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(groups)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(punits)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(chunks)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(clba)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(ws+AF8-min)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(ws+AF8-opt)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(maxoc)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(maxocpu)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(mw+AF8-cunits)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(write+AF8-typ)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(write+AF8-max)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(reset+AF8-typ)+ADs-
+-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(reset+AF8-max)+ADs-
+-
+-static struct attribute +ACo-nvm+AF8-dev+AF8-attrs+AFsAXQ- +AD0- +AHs-
+-	/+ACo- version agnostic attrs +ACo-/
 	+ACY-dev+AF8-attr+AF8-version.attr,
 	+ACY-dev+AF8-attr+AF8-capabilities.attr,
+-	+ACY-dev+AF8-attr+AF8-read+AF8-typ.attr,
+-	+ACY-dev+AF8-attr+AF8-read+AF8-max.attr,
=20
+-	/+ACo- 1.2 attrs +ACo-/
 	+ACY-dev+AF8-attr+AF8-vendor+AF8-opcode.attr,
 	+ACY-dev+AF8-attr+AF8-device+AF8-mode.attr,
 	+ACY-dev+AF8-attr+AF8-media+AF8-manager.attr,
+AEAAQA- -1208,8 +-1227,6 +AEAAQA- static struct attribute +ACo-nvm+AF8-dev=
+AF8-attrs+AF8-12+AFsAXQ- +AD0- +AHs-
 	+ACY-dev+AF8-attr+AF8-page+AF8-size.attr,
 	+ACY-dev+AF8-attr+AF8-hw+AF8-sector+AF8-size.attr,
 	+ACY-dev+AF8-attr+AF8-oob+AF8-sector+AF8-size.attr,
-	+ACY-dev+AF8-attr+AF8-read+AF8-typ.attr,
-	+ACY-dev+AF8-attr+AF8-read+AF8-max.attr,
 	+ACY-dev+AF8-attr+AF8-prog+AF8-typ.attr,
 	+ACY-dev+AF8-attr+AF8-prog+AF8-max.attr,
 	+ACY-dev+AF8-attr+AF8-erase+AF8-typ.attr,
+AEAAQA- -1218,33 +-1235,7 +AEAAQA- static struct attribute +ACo-nvm+AF8-de=
v+AF8-attrs+AF8-12+AFsAXQ- +AD0- +AHs-
 	+ACY-dev+AF8-attr+AF8-media+AF8-capabilities.attr,
 	+ACY-dev+AF8-attr+AF8-max+AF8-phys+AF8-secs.attr,
=20
-	NULL,
-+AH0AOw-
-
-static const struct attribute+AF8-group nvm+AF8-dev+AF8-attr+AF8-group+AF8=
-12 +AD0- +AHs-
-	.name		+AD0- +ACI-lightnvm+ACI-,
-	.attrs		+AD0- nvm+AF8-dev+AF8-attrs+AF8-12,
-+AH0AOw-
-
-/+ACo- 2.0 values +ACo-/
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(groups)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(punits)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(chunks)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(clba)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(ws+AF8-min)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(ws+AF8-opt)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(maxoc)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(maxocpu)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(mw+AF8-cunits)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(write+AF8-typ)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(write+AF8-max)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(reset+AF8-typ)+ADs-
-static NVM+AF8-DEV+AF8-ATTR+AF8-20+AF8-RO(reset+AF8-max)+ADs-
-
-static struct attribute +ACo-nvm+AF8-dev+AF8-attrs+AF8-20+AFsAXQ- +AD0- +A=
Hs-
-	+ACY-dev+AF8-attr+AF8-version.attr,
-	+ACY-dev+AF8-attr+AF8-capabilities.attr,
-
+-	/+ACo- 2.0 attrs +ACo-/
 	+ACY-dev+AF8-attr+AF8-groups.attr,
 	+ACY-dev+AF8-attr+AF8-punits.attr,
 	+ACY-dev+AF8-attr+AF8-chunks.attr,
+AEAAQA- -1255,8 +-1246,6 +AEAAQA- static struct attribute +ACo-nvm+AF8-dev=
+AF8-attrs+AF8-20+AFsAXQ- +AD0- +AHs-
 	+ACY-dev+AF8-attr+AF8-maxocpu.attr,
 	+ACY-dev+AF8-attr+AF8-mw+AF8-cunits.attr,
=20
-	+ACY-dev+AF8-attr+AF8-read+AF8-typ.attr,
-	+ACY-dev+AF8-attr+AF8-read+AF8-max.attr,
 	+ACY-dev+AF8-attr+AF8-write+AF8-typ.attr,
 	+ACY-dev+AF8-attr+AF8-write+AF8-max.attr,
 	+ACY-dev+AF8-attr+AF8-reset+AF8-typ.attr,
+AEAAQA- -1265,25 +-1254,35 +AEAAQA- static struct attribute +ACo-nvm+AF8-d=
ev+AF8-attrs+AF8-20+AFsAXQ- +AD0- +AHs-
 	NULL,
 +AH0AOw-
=20
-static const struct attribute+AF8-group nvm+AF8-dev+AF8-attr+AF8-group+AF8=
-20 +AD0- +AHs-
-	.name		+AD0- +ACI-lightnvm+ACI-,
-	.attrs		+AD0- nvm+AF8-dev+AF8-attrs+AF8-20,
-+AH0AOw-
-
-void nvme+AF8-nvm+AF8-register+AF8-sysfs(struct nvme+AF8-ns +ACo-ns)
+-static umode+AF8-t nvm+AF8-dev+AF8-attrs+AF8-visible(struct kobject +ACo-=
kobj,
+-				     struct attribute +ACo-attr, int index)
 +AHs-
+-	struct device +ACo-dev +AD0- container+AF8-of(kobj, struct device, kobj)=
+ADs-
+-	struct gendisk +ACo-disk +AD0- dev+AF8-to+AF8-disk(dev)+ADs-
+-	struct nvme+AF8-ns +ACo-ns +AD0- disk-+AD4-private+AF8-data+ADs-
 	struct nvm+AF8-dev +ACo-ndev +AD0- ns-+AD4-ndev+ADs-
-	struct nvm+AF8-geo +ACo-geo +AD0- +ACY-ndev-+AD4-geo+ADs-
+-	struct device+AF8-attribute +ACo-dev+AF8-attr +AD0-
+-		container+AF8-of(attr, typeof(+ACo-dev+AF8-attr), attr)+ADs-
=20
-	if (+ACE-ndev)
-		return+ADs-
+-	if (dev+AF8-attr-+AD4-show +AD0APQ- nvm+AF8-dev+AF8-attr+AF8-show)
+-		return attr-+AD4-mode+ADs-
=20
-	switch (geo-+AD4-major+AF8-ver+AF8-id) +AHs-
+-	switch (ndev ? ndev-+AD4-geo.major+AF8-ver+AF8-id : 0) +AHs-
 	case 1:
-		nvme+AF8-ns+AF8-id+AF8-attr+AF8-groups+AFs-1+AF0- +AD0- +ACY-nvm+AF8-dev=
+AF8-attr+AF8-group+AF8-12+ADs-
+-		if (dev+AF8-attr-+AD4-show +AD0APQ- nvm+AF8-dev+AF8-attr+AF8-show+AF8-1=
2)
+-			return attr-+AD4-mode+ADs-
 		break+ADs-
 	case 2:
-		nvme+AF8-ns+AF8-id+AF8-attr+AF8-groups+AFs-1+AF0- +AD0- +ACY-nvm+AF8-dev=
+AF8-attr+AF8-group+AF8-20+ADs-
+-		if (dev+AF8-attr-+AD4-show +AD0APQ- nvm+AF8-dev+AF8-attr+AF8-show+AF8-2=
0)
+-			return attr-+AD4-mode+ADs-
 		break+ADs-
 	+AH0-
+-
+-	return 0+ADs-
 +AH0-
+-
+-const struct attribute+AF8-group nvm+AF8-dev+AF8-attr+AF8-group +AD0- +AH=
s-
+-	.name		+AD0- +ACI-lightnvm+ACI-,
+-	.attrs		+AD0- nvm+AF8-dev+AF8-attrs,
+-	.is+AF8-visible	+AD0- nvm+AF8-dev+AF8-attrs+AF8-visible,
+-+AH0AOw-
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9ba6d67d8e0a..2503f8fd54da 100644
--- a/drivers/nvme/host/nvme.h
+-+-+- b/drivers/nvme/host/nvme.h
+AEAAQA- -551,7 +-551,7 +AEAAQA- static inline void nvme+AF8-mpath+AF8-stop=
(struct nvme+AF8-ctrl +ACo-ctrl)
 void nvme+AF8-nvm+AF8-update+AF8-nvm+AF8-info(struct nvme+AF8-ns +ACo-ns)+=
ADs-
 int nvme+AF8-nvm+AF8-register(struct nvme+AF8-ns +ACo-ns, char +ACo-disk+A=
F8-name, int node)+ADs-
 void nvme+AF8-nvm+AF8-unregister(struct nvme+AF8-ns +ACo-ns)+ADs-
-void nvme+AF8-nvm+AF8-register+AF8-sysfs(struct nvme+AF8-ns +ACo-ns)+ADs-
+-extern const struct attribute+AF8-group nvme+AF8-nvm+AF8-attr+AF8-group+A=
Ds-
 int nvme+AF8-nvm+AF8-ioctl(struct nvme+AF8-ns +ACo-ns, unsigned int cmd, u=
nsigned long arg)+ADs-
 +ACM-else
 static inline void nvme+AF8-nvm+AF8-update+AF8-nvm+AF8-info(struct nvme+AF=
8-ns +ACo-ns) +AHsAfQA7-
+AEAAQA- -562,7 +-562,6 +AEAAQA- static inline int nvme+AF8-nvm+AF8-registe=
r(struct nvme+AF8-ns +ACo-ns, char +ACo-disk+AF8-name,
 +AH0-
=20
 static inline void nvme+AF8-nvm+AF8-unregister(struct nvme+AF8-ns +ACo-ns)=
 +AHsAfQA7-
-static inline void nvme+AF8-nvm+AF8-register+AF8-sysfs(struct nvme+AF8-ns =
+ACo-ns) +AHsAfQA7-
 static inline int nvme+AF8-nvm+AF8-ioctl(struct nvme+AF8-ns +ACo-ns, unsig=
ned int cmd,
 							unsigned long arg)
 +AHs-
