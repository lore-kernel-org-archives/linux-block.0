Return-Path: <prvs=816489328=Damien.LeMoal@wdc.com>
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: "emilne@redhat.com" <emilne@redhat.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>, "dm-devel@redhat.com"
	<dm-devel@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Christoph Hellwig
	<hch@lst.de>, Matias Bjorling <Matias.Bjorling@wdc.com>, Bart Van Assche
	<Bart.VanAssche@wdc.com>
Subject: Re: [PATCH v2 09/11] block: Expose queue nr_zones in sysfs
Date: Fri, 12 Oct 2018 00:41:59 +0000
Message-ID: 
 <BN3PR0401MB1640D90498CA644E582CCE46E7E20@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181011070952.13248-1-damien.lemoal@wdc.com>
 <20181011070952.13248-10-damien.lemoal@wdc.com>
 <1539268936.20703.258.camel@localhost.localdomain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On 2018/10/11 23:42, Ewan D. Milne wrote:=0A=
> So in v2 you moved the #ifdef CONFIG_BLK_DEV_ZONED=0A=
> so that nr_zones is always present?  It was previously=0A=
> changed to keep the request_queue size smaller.=0A=
> =0A=
> Would make more sense to make the nr_zones sysfs=0A=
> code here conditional on CONFIG_BLK_DEV_ZONED?=0A=
> =0A=
=0A=
Yes, I guess it would. #ifdef in c code is normally not welcome, so I was a=
=0A=
little heavy handed with this v2 change to avoid adding any to blk-sysfs.c =
:)=0A=
=0A=
I will rework this and send a v3.=0A=
=0A=
Thanks for the review.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
