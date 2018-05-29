Return-Path: <daniel.verkamp@intel.com>
From: "Verkamp, Daniel" <daniel.verkamp@intel.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Jens Axboe <axboe@kernel.dk>, "Busch, Keith" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Sagi Grimberg
	<sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: RE: [PATCH 08/14] nvmet: implement the changed namespaces log
Date: Tue, 29 May 2018 16:59:05 +0000
Message-ID: <A5F28D4A728A7E41839CDC5C3B5A01E8B74D2527@FMSMSX103.amr.corp.intel.com>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-9-hch@lst.de>
In-Reply-To: <20180526102735.31404-9-hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

 [...]

> +static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, u32 nsi=
d)
> +{
> +	mutex_lock(&ctrl->lock);
> +	if (ctrl->nr_changed_ns < NVME_MAX_CHANGED_NAMESPACES) {
> +		ctrl->changed_ns_list[ctrl->nr_changed_ns++] =3D
> +			cpu_to_le32(nsid);
> +	} else if (ctrl->nr_changed_ns =3D=3D NVME_MAX_CHANGED_NAMESPACES) {
> +		ctrl->changed_ns_list[0] =3D cpu_to_le32(0xffffffff);
> +	}

Unless I'm missing it happening somewhere else, the list-full case that set=
s element 0 to 0xffffffff should also explicitly zero out the rest of the l=
ist to satisfy the "remainder of the list shall be zero-filled" wording in =
the spec, since the other changed_ns_list entries will be filled with non-z=
ero NSIDs when we get here.

-- Daniel
