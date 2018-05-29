Return-Path: <daniel.verkamp@intel.com>
From: "Verkamp, Daniel" <daniel.verkamp@intel.com>
To: Christoph Hellwig <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Jens Axboe <axboe@kernel.dk>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Hannes Reinecke <hare@suse.com>, Sagi Grimberg
	<sagi@grimberg.me>, "Busch, Keith" <keith.busch@intel.com>, Hannes Reinecke
	<hare@suse.de>
Subject: RE: [PATCH 09/14] nvmet: Add AEN configuration support
Date: Tue, 29 May 2018 17:15:34 +0000
Message-ID: <A5F28D4A728A7E41839CDC5C3B5A01E8B74D2557@FMSMSX103.amr.corp.intel.com>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-10-hch@lst.de>
In-Reply-To: <20180526102735.31404-10-hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Return-Path: daniel.verkamp@intel.com
List-ID: <linux-block@vger.kernel.org>

[...]
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-
> cmd.c
> index 82d521f60a43..20d9ce5064f8 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -432,6 +432,16 @@ static void nvmet_execute_set_features(struct
> nvmet_req *req)
>  		req->sq->ctrl->kato =3D DIV_ROUND_UP(val32, 1000);
>  		nvmet_set_result(req, req->sq->ctrl->kato);
>  		break;
> +		val32 =3D le32_to_cpu(req->cmd->common.cdw10[1]);
> +		if (val32 & ~NVMET_AEN_SUPPORTED) {
> +			status =3D NVME_SC_INVALID_FIELD | NVME_SC_DNR;
> +			break;
> +		}

This looks overly restrictive - a host sending a Set Features with e.g. the=
 health critical warning bits set in CDW11 will get a failure.  As far as I=
 can tell, this isn't allowed by the spec;  Set Features - Asynchronous Eve=
nt Configuration and the health log page have been mandatory since NVMe 1.0=
, and presumably support for the corresponding health log page related AER =
bits is also mandatory (these were the only bits available in NVMe 1.0).  I=
 think it should be fine to just allow the user to set any (valid) combinat=
ion of bits here, while still only triggering the NS Changed notification.

Thanks,
-- Daniel
