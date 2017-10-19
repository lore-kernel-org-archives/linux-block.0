Return-Path: <jthumshirn@suse.de>
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,  Keith Busch <keith.busch@intel.com>,  Sagi Grimberg <sagi@grimberg.me>,  Hannes Reinecke <hare@suse.de>,  linux-nvme@lists.infradead.org,  linux-block@vger.kernel.org
Subject: Re: [PATCH 11/17] nvme: get rid of nvme_ctrl_list
References: <20171018165258.23212-1-hch@lst.de>
	<20171018165258.23212-12-hch@lst.de>
Date: Thu, 19 Oct 2017 09:22:09 +0200
In-Reply-To: <20171018165258.23212-12-hch@lst.de> (Christoph Hellwig's message
	of "Wed, 18 Oct 2017 18:52:52 +0200")
Message-ID: <mqd60bb7gbi.fsf@linux-x5ow.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

I'm not sure if the removel of the major number module_param is good
from an ABI POV. This could lead to some unexpected results for those
poor souls that used it.

Apart from that,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

--=20
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)
Key fingerprint =3D EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
