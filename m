Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0817BD9
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 00:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747874870; cv=none; b=D/6fbjmiYJ3VWhkrtztlVb6e46S+/7Ek6Ou8Gv9z8dsdKSkv+KwSTCzXGl78r/cf1wosSgleNaK/8IAxosTrLCBW8w7eMr88SAIkgKqBE57Y0H0YGa9lVtADq2C32oAHM2iTf+Q+AQr40CmHB7aFgSlLhOZy9FFy85JdpqLUIuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747874870; c=relaxed/simple;
	bh=ayqwJeW5842Wi3V+qc3m4xUAW29XKtJPJbAJ4jp9V44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIwnurME3Ynaq7tDsGH/UypxYRsaJRRdmaaC8dX5EM6w4BPqitUVNPd2Xj7wdW3EnyEbg7EwRtelyDQQC13XuSDyYYcTVdkO3fF9yQpafRCN0SKde1d1QBMciNy08ViiPquKymWm98qv+IWM6FY1T+mTwn038W6zURwYnAOAWdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RMtAfhfN; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RMtAfhfN"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-30e7ee5fe74so1171414a91.3
        for <linux-block@vger.kernel.org>; Wed, 21 May 2025 17:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747874867; x=1748479667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFm6VYvt4nCIipBjdMX5whNhULhZ+Ox0rjwTUFTeIpk=;
        b=RMtAfhfNpCYpJAkeomwrwnBrqgQwbaW2f4+I9Pq0qr2tkw+WE54kYYzn3udltT1QXg
         BtSbwcvIO31N2fKvslkN3wfUtUsnfVXsATyMdaslVXWMXENxIUmPgsegFZBNDGIZxJ0D
         iEC+R+uu1jkygkRG6pzFolo20LgP2RObCsi6Xqr2YGaKXHlkF2FNVivSMK2wCtFSmHJA
         kLuXDzRKMRO/5+m8dVFoRSEL8mHEb3PehDERalPlAbpNrifRBFL+KLEbNcgQhVccW3OO
         h2kp4bwNfGLT3q0uOGE/2xJzAOHHezzCyMW4E/iK8zeDz8JHCUedA2qv2nE5VosjcvTb
         GADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747874867; x=1748479667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFm6VYvt4nCIipBjdMX5whNhULhZ+Ox0rjwTUFTeIpk=;
        b=fpvxGywGZbZCJnFhIF2n0BjuJAOBKnQr3GaYqWKonG42+AcfwaU1nGLvb02bV5FIim
         33UuLphJRg5RV/2foF+76FoTRP7j1so+Ku2wm5JeN0vKhBz0PKIbZNnrG3RT3NtlXvm0
         WoCqFPmZWHAc929SMdX+Odzvn+mA0Y91B1q35Osj7SEfcegezwCScZ67VgKZm+xBrmss
         +l2g+R9vbIfEgB3+6rzVZ2Bx9shMQIAfSVN/TGO7XbXou0leNPizFQ4ayOQukwhsomoS
         3jGFr0J2RGwwIvNmDgHqjBlzSletogIwC9c8hiQ2uN4JPe4L6bQbPWK7h8jEond/qA0E
         /WjQ==
X-Gm-Message-State: AOJu0YxsG5ha6rEwIPRgkZtAUNXP3Oq/hoitugRP4Guan4KcSCS41Nh7
	avDuKVCcBOj0q/o92Uk9j+Qboc3ekoZKhwi+LvCwP8nC8qDRmAvE8xMksrs5MWL3Qik9AOSS8DV
	lkuyWYau3evTuveabEIuWCYlavKNU0auJBeo/zhwNDHdKrsrP4CYEsIM=
X-Gm-Gg: ASbGnctOdn0zC06cdYdKekdqwIGL9IP+wXd9Vxl1+5yMMXjeE9x5N9JauGD5eEE5V39
	Y+8inkuNOzzuqoDDrcUvuKEjZNcm4WfewVbOXSGgo1uSGR9/k5aczwmUr2NZqNYkxJrXdeg+pZp
	GAuQVFkIlsk4PynEVCyA7ARfJjYCj/4YY=
X-Google-Smtp-Source: AGHT+IH/Df+HHabZZ3U6kIjtDxwpcsLkpoBs0yjZNbUvj4VyEnBVF5+JH6RcXPyLfYaxFAe1BXNScE4lLrfQq32++lE=
X-Received: by 2002:a17:903:1b6d:b0:224:1ed8:40e9 with SMTP id
 d9443c01a7336-231d453569dmr124758195ad.13.1747874867317; Wed, 21 May 2025
 17:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521223107.709131-1-kbusch@meta.com> <20250521223107.709131-4-kbusch@meta.com>
In-Reply-To: <20250521223107.709131-4-kbusch@meta.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 21 May 2025 17:47:36 -0700
X-Gm-Features: AX0GCFu37TdXY2qh55C4Ohdo2kWmHPDgoRQgZPJosdYcmAkzbqGe-o7G2MKnhx4
Message-ID: <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 3:31=E2=80=AFPM Keith Busch <kbusch@meta.com> wrote=
:
>
> From: Keith Busch <kbusch@kernel.org>
>
> Register the nvme namespace copy capablities with the request_queue

nit: "capabilities"

> limits and implement support for the REQ_OP_COPY operation.
>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/core.c | 61 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/nvme.h     | 42 ++++++++++++++++++++++++++-
>  2 files changed, 102 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f69a232a000ac..3134fe85b1abc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -888,6 +888,52 @@ static blk_status_t nvme_setup_discard(struct nvme_n=
s *ns, struct request *req,
>         return BLK_STS_OK;
>  }
>
> +static inline blk_status_t nvme_setup_copy(struct nvme_ns *ns,
> +               struct request *req, struct nvme_command *cmnd)
> +{
> +       struct nvme_copy_range *range;
> +       struct req_iterator iter;
> +       struct bio_vec bvec;
> +       u16 control =3D 0;
> +       int i =3D 0;

Make this unsigned to avoid sign extension when used as an index?

> +
> +       static const size_t alloc_size =3D sizeof(*range) * NVME_COPY_MAX=
_RANGES;
> +
> +       if (WARN_ON_ONCE(blk_rq_nr_phys_segments(req) >=3D NVME_COPY_MAX_=
RANGES))

Should be > instead of >=3D?

> +               return BLK_STS_IOERR;
> +
> +       range =3D kzalloc(alloc_size, GFP_ATOMIC | __GFP_NOWARN);
> +       if (!range)
> +               return BLK_STS_RESOURCE;
> +
> +       if (req->cmd_flags & REQ_FUA)
> +               control |=3D NVME_RW_FUA;
> +       if (req->cmd_flags & REQ_FAILFAST_DEV)
> +               control |=3D NVME_RW_LR;
> +
> +       rq_for_each_copy_bvec(bvec, req, iter) {
> +               u64 slba =3D nvme_sect_to_lba(ns->head, bvec.bv_sector);
> +               u64 nlb =3D nvme_sect_to_lba(ns->head, bvec.bv_sectors) -=
 1;
> +
> +               range[i].slba =3D cpu_to_le64(slba);
> +               range[i].nlb =3D cpu_to_le16(nlb);
> +               i++;
> +       }
> +
> +       memset(cmnd, 0, sizeof(*cmnd));
> +       cmnd->copy.opcode =3D nvme_cmd_copy;
> +       cmnd->copy.nsid =3D cpu_to_le32(ns->head->ns_id);
> +       cmnd->copy.nr_range =3D i - 1;
> +       cmnd->copy.sdlba =3D cpu_to_le64(nvme_sect_to_lba(ns->head,
> +                                               blk_rq_pos(req)));
> +       cmnd->copy.control =3D cpu_to_le16(control);
> +
> +       bvec_set_virt(&req->special_vec, range, alloc_size);

alloc_size should be sizeof(*range) * i? Otherwise this exceeds the
amount of data used by the Copy command, which not all controllers
support (see bit LLDTS of SGLS in the Identify Controller data
structure). We have seen the same behavior with Dataset Management
(always specifying 4 KB of data), which also passes the maximum size
of the allocation to bvec_set_virt().

> +       req->rq_flags |=3D RQF_SPECIAL_PAYLOAD;
> +
> +       return BLK_STS_OK;
> +}
> +
>  static void nvme_set_app_tag(struct request *req, struct nvme_command *c=
mnd)
>  {
>         cmnd->rw.lbat =3D cpu_to_le16(bio_integrity(req->bio)->app_tag);
> @@ -1106,6 +1152,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, str=
uct request *req)
>         case REQ_OP_DISCARD:
>                 ret =3D nvme_setup_discard(ns, req, cmd);
>                 break;
> +       case REQ_OP_COPY:
> +               ret =3D nvme_setup_copy(ns, req, cmd);
> +               break;
>         case REQ_OP_READ:
>                 ret =3D nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
>                 break;
> @@ -2119,6 +2168,15 @@ static bool nvme_update_disk_info(struct nvme_ns *=
ns, struct nvme_id_ns *id,
>                 lim->max_write_zeroes_sectors =3D UINT_MAX;
>         else
>                 lim->max_write_zeroes_sectors =3D ns->ctrl->max_zeroes_se=
ctors;
> +
> +       if (ns->ctrl->oncs & NVME_CTRL_ONCS_NVMCPYS && id->mssrl && id->m=
cl) {

Are the checks of MSSRL and MCL necessary? The spec says controllers
that support Copy are not allowed to set them to 0.

Best,
Caleb

> +               u32 mcss =3D bs * le16_to_cpu(id->mssrl) >> SECTOR_SHIFT;
> +               u32 mcs =3D bs * le32_to_cpu(id->mcl) >> SECTOR_SHIFT;
> +
> +               lim->max_copy_segment_sectors =3D mcss;
> +               lim->max_copy_sectors =3D mcs;
> +               lim->max_copy_segments =3D id->msrc + 1;
> +       }
>         return valid;
>  }
>
> @@ -2526,6 +2584,9 @@ static int nvme_update_ns_info(struct nvme_ns *ns, =
struct nvme_ns_info *info)
>                         nvme_init_integrity(ns->head, &lim, info);
>                 lim.max_write_streams =3D ns_lim->max_write_streams;
>                 lim.write_stream_granularity =3D ns_lim->write_stream_gra=
nularity;
> +               lim.max_copy_segment_sectors =3D ns_lim->max_copy_segment=
_sectors;
> +               lim.max_copy_sectors =3D ns_lim->max_copy_sectors;
> +               lim.max_copy_segments =3D ns_lim->max_copy_segments;
>                 ret =3D queue_limits_commit_update(ns->head->disk->queue,=
 &lim);
>
>                 set_capacity_and_notify(ns->head->disk, get_capacity(ns->=
disk));
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 51308f65b72fd..14f46ad1330b6 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -404,6 +404,7 @@ enum {
>         NVME_CTRL_ONCS_WRITE_ZEROES             =3D 1 << 3,
>         NVME_CTRL_ONCS_RESERVATIONS             =3D 1 << 5,
>         NVME_CTRL_ONCS_TIMESTAMP                =3D 1 << 6,
> +       NVME_CTRL_ONCS_NVMCPYS                  =3D 1 << 8,
>         NVME_CTRL_VWC_PRESENT                   =3D 1 << 0,
>         NVME_CTRL_OACS_SEC_SUPP                 =3D 1 << 0,
>         NVME_CTRL_OACS_NS_MNGT_SUPP             =3D 1 << 3,
> @@ -458,7 +459,10 @@ struct nvme_id_ns {
>         __le16                  npdg;
>         __le16                  npda;
>         __le16                  nows;
> -       __u8                    rsvd74[18];
> +       __le16                  mssrl;
> +       __le32                  mcl;
> +       __u8                    msrc;
> +       __u8                    rsvd81[11];
>         __le32                  anagrpid;
>         __u8                    rsvd96[3];
>         __u8                    nsattr;
> @@ -956,6 +960,7 @@ enum nvme_opcode {
>         nvme_cmd_resv_acquire   =3D 0x11,
>         nvme_cmd_io_mgmt_recv   =3D 0x12,
>         nvme_cmd_resv_release   =3D 0x15,
> +       nvme_cmd_copy           =3D 0x19,
>         nvme_cmd_zone_mgmt_send =3D 0x79,
>         nvme_cmd_zone_mgmt_recv =3D 0x7a,
>         nvme_cmd_zone_append    =3D 0x7d,
> @@ -978,6 +983,7 @@ enum nvme_opcode {
>                 nvme_opcode_name(nvme_cmd_resv_acquire),        \
>                 nvme_opcode_name(nvme_cmd_io_mgmt_recv),        \
>                 nvme_opcode_name(nvme_cmd_resv_release),        \
> +               nvme_opcode_name(nvme_cmd_copy),                \
>                 nvme_opcode_name(nvme_cmd_zone_mgmt_send),      \
>                 nvme_opcode_name(nvme_cmd_zone_mgmt_recv),      \
>                 nvme_opcode_name(nvme_cmd_zone_append))
> @@ -1158,6 +1164,39 @@ struct nvme_dsm_range {
>         __le64                  slba;
>  };
>
> +struct nvme_copy_cmd {
> +       __u8                    opcode;
> +       __u8                    flags;
> +       __u16                   command_id;
> +       __le32                  nsid;
> +       __u64                   rsvd2;
> +       __le64                  metadata;
> +       union nvme_data_ptr     dptr;
> +       __le64                  sdlba;
> +       __u8                    nr_range;
> +       __u8                    format;
> +       __le16                  control;
> +       __le16                  cev;
> +       __le16                  dspec;
> +       __le32                  lbtl;
> +       __le16                  lbat;
> +       __le16                  lbatm;
> +};
> +
> +#define NVME_COPY_MAX_RANGES   128
> +struct nvme_copy_range {
> +       __le32                  spars;
> +       __u32                   rsvd4;
> +       __le64                  slba;
> +       __le16                  nlb;
> +       __le16                  cetype;
> +       __le16                  cev;
> +       __le16                  sopt;
> +       __le32                  elbt;
> +       __le16                  elbat;
> +       __le16                  elbatm;
> +};
> +
>  struct nvme_write_zeroes_cmd {
>         __u8                    opcode;
>         __u8                    flags;
> @@ -1985,6 +2024,7 @@ struct nvme_command {
>                 struct nvme_download_firmware dlfw;
>                 struct nvme_format_cmd format;
>                 struct nvme_dsm_cmd dsm;
> +               struct nvme_copy_cmd copy;
>                 struct nvme_write_zeroes_cmd write_zeroes;
>                 struct nvme_zone_mgmt_send_cmd zms;
>                 struct nvme_zone_mgmt_recv_cmd zmr;
> --
> 2.47.1
>
>
