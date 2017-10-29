Return-Path: <anish.jhaveri@paviliondata.com>
From: Anish Jhaveri <anish.jhaveri@paviliondata.com>
To: Guan Junxiong <guanjunxiong@huawei.com>, Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "Shenhong (C)" <shenhong09@huawei.com>, "Sagi
 Grimberg" <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Keith
 Busch" <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>, "Johannes
 Thumshirn" <jthumshirn@suse.de>, niuhaoxin <niuhaoxin@huawei.com>
Subject: RE: [PATCH 06/17] block: introduce GENHD_FL_HIDDEN
Date: Sun, 29 Oct 2017 08:00:00 +0000
Message-ID: <DM3PR17MB0825BEF3B830E3ADF08688B097580@DM3PR17MB0825.namprd17.prod.outlook.com>
References: <20171023145126.2471-1-hch@lst.de>
 <20171023145126.2471-7-hch@lst.de> <20171024213959.GB23307@redhat.com>
 <20171028063825.GA14261@lst.de>
 <dc988a8a-8c88-fe20-34a0-de5cdd615b6b@huawei.com>
 <20171028074245.GA15510@lst.de>
 <99f3c781-71ce-f915-d6f4-88d6dd115876@huawei.com>
In-Reply-To: <99f3c781-71ce-f915-d6f4-88d6dd115876@huawei.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Saturday, October 28, 2017 3:10 AM,  Guan Junxiong wrote:

>Does it mean some extra works such as:
>1) showing the path topology of nvme multipath device
Isn't connection to the target suppose guide the host to the shortest and f=
astest path available path or so called most optimized path. Sysfs entry ca=
n easily store that as we store path related info over there.=20

>2) daemon to implement immediate and delayed failback
This is also based on target, whenever target is ready for immediate or del=
ayed failback it will let the connect from host succeed. Until then host is=
 in reconnecting state across all path until it finds an optimized or un-op=
timized path. Why is this extra daemon needed ?
=20
>4) grouping paths besides ANA
Why we cannot use NS Group here.

Would be good idea to move away from legacy way of doing things for NVME de=
vices. NVME Multipath implementation by Christoph is very simple. How about=
 not making it super complicated. =20

Best regards,
Anish
