Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA634DCD6
	for <linux-block@vger.kernel.org>; Wed,  1 Jul 2026 19:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935799; cv=pass; b=FcI4ZrHKJVFcHP08LnQ3amAsKk/6prq/4hxFEnIdrrmZnT6BNPWgI9BFPbvIfdiIHO4fY1tby/2jsC7M+dIatLGMbCS8IBiiyiAP7Er0dDgpAH6ADlE9J/o04UfdQpwrYlaEHifId+xCyrXo6CPrYUnAfaOWTsVvVrP+OLlH0xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935799; c=relaxed/simple;
	bh=KoFkJKqOZpBo9LxusJau6YmmTGqiKlHE4BPUGelmuaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiir2JCq8Xg0geiYP4v+sY43cfTessMEmGkHql74BmYzpCZ+t4xri5Slzmq1iBkyiyvd7OccbfaXr9jhFRvG3IC2PgMNTeRgEzlwllp7sSOwca1XL2Fxb4P2vsTzV+50vLycIaQmqBquAvqRskmgWNYGhR5gL5Y8RrG1EhVlfMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RPTdIJgb; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RPTdIJgb"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6a30bb83cc9so41903eaf.2
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2026 12:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782935795; cv=none;
        d=google.com; s=arc-20260327;
        b=jqLwUHBwqH/cvWix2BC0L+NvYyxuzitNifj4R/6tMu4IIkcnw2we3wT4Dob9K8y34t
         VMxkrS0BvtLqMgFs37/9eHs1kY1qmMCXBPZevlip5UNPD2Aq0BTkzOMoU8S4BX+HOVBa
         hoeWBoyq4+gAl7rZAzwitlPtOGdFTghKsUaOluW83DuP8JXzRoKlosmRhDH9sCzEDifj
         pWSOwIjKz+k9n/VRhlrJ/joVZtVVCvlyL8H2DWa5PQyQu3GKE8c6atWD7jp+96dJpxCT
         RNXX3PtRLwH44hq48gg3Yx/KpNpFq/nvvSw8Hd+ngs/3bsg7mUKA+4JE+gKSd+GonRxR
         KJ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mtIVN0DqJBgCNlfEAAUMuGRPuwtbmUfKPGcnXNrwZLM=;
        fh=ELCGB7n0ZNgYiCcJ80JmeQ1+5GECUr2By+Sn7gO6Uug=;
        b=bVjH9jEnrBv+YOShKIS1i9zafffeJWP6VIIEy0/+LSayxdYkCjWe70UIT7s7efISnM
         0QF5ukxTlCXXYcUmSJyn6sMHtZEFjEUefJY11UhdfQy3m4PFfGpdCJDlC3WLVbFpWlno
         yyfCN6freFHZKnY/T+E0k6fzYSRGXATKS//gdSZ9RB5++NfSknkHteOJgXuGcSyztHp0
         MO1h9ohTTdGJPun6q19PGRdx5GF0MFr1gJfVXo975FHGJ/Kt6VWPrfz+J0ylMFPXQiBi
         CE10yzEkZ6FdWK6SoqU29wv8ATyXAmJHQBnOCYybc1K+x8Ass22LC4VDySO/WnTHywtQ
         gxVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782935795; x=1783540595; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mtIVN0DqJBgCNlfEAAUMuGRPuwtbmUfKPGcnXNrwZLM=;
        b=RPTdIJgbadMMMI77vkIsKOaFJYsysluGNmgen+IR0V80ycKF7UOkcEijW97k3md5nE
         7MNcD51WwHnziverBts1qSSELmGIiSLAWZaYpwXb0dMWAxdyBxgIoetCpWnAtcYq1/5H
         Rvz+K2Sggd9LAVrqMwQCovypGAqdyq5nY4gGsIMpe/DOnlouY1wZkjjAQguHWDE23Gew
         S6jlFDLhH65+UxfrJMK2aBOYYWlpYuMyu9TI8FCEk2Q3FDKK2TlGoC7tL2vr0P23BWt/
         D87VcZs8tAz5i3ZhdCvkqbE928thbhsWHmPziB4tU7xNi+bhpf/ZNp6StO4328Unwd4G
         LIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782935795; x=1783540595;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtIVN0DqJBgCNlfEAAUMuGRPuwtbmUfKPGcnXNrwZLM=;
        b=brC7btOe7bMxQIe2bSfmGM6uTjijkZh9SVMg+WZV1kYd1yw5dXtQxSBfdERdnegRQu
         oRYFL+jl8Kb98KsHVfFV1MKFoopmTuhH7efIup9JOcFwpsNH9LhSceDXRQnZYtC0bVR1
         8wP9NlijbrzbowHIAiY2VDEH1ddTAPPXiEm+hG9N2PkAhpyTSJnhDQZkMdP/1c7qkIqw
         J+Xd/b+BTcON2ILYTcrXqEnQsx5n63WdbN/G8GVsOiXdjB6SagMclnp0PkhwEIJWKdwg
         KjhmZFYYRk19MPWCdQ5BcaN6lgHlVDWMfi6s90vXldTQo1eSamv5zQj6BgdOYesAjO3g
         yF9A==
X-Forwarded-Encrypted: i=1; AFNElJ+AH/wLk6azlDUWueWt8f6LPZ44i1MspM5DTzmVs6Ch23UQeVshM5z+++uyKXMthRlmT7zcvSY/URv9bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcDD7KCYlGZ3wbUIvJwCdHj3X2Nn4BotsNmAy0yjPx7jhh32ac
	rTTAxvfte0+1Myvdygivj5dGJpjKf6Bj/tGt37N4TIw+XUMMMt8Xm26Krgox4BuFwHBg5p938ke
	XN16SeS5/XdW9Iqt8SMNqbj3YpFaq0IMS5oBo14yYfw==
X-Gm-Gg: AfdE7cm/oVpGZ0RutF47Pk4JMZxBPVOfGSDIyPmEDYonFd0G0FbWqGG46f2Ccphj8gh
	n1Q/ZeOdp3cHmIUkW+zHIOfcXMwMmhTHIAx6TF4IwNDvoJt6AHJlOqwTPsemHUVHDuNIJRDfRnr
	K41UMcSr0LbxwT+INxLzdaNNRnNJwPlwNAH+tFLdHVK04ZINDNtoGshjmpLozvmaZYQGOCIrJIB
	H8odyy8H1y9FHV2NxdrygAat3Yp6H7V8kZz7yK3Ro3OPtzLAFcC0fBngWChvtG5tytMeRmWEbnl
	xVETwTkm
X-Received: by 2002:a05:6820:7705:b0:6a0:ee7d:80ea with SMTP id
 006d021491bc7-6a30974705amr995871eaf.0.1782935795443; Wed, 01 Jul 2026
 12:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627054220.2174166-1-csander@purestorage.com> <20260627054220.2174166-2-csander@purestorage.com>
In-Reply-To: <20260627054220.2174166-2-csander@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 1 Jul 2026 12:56:24 -0700
X-Gm-Features: AVVi8CcoTxYjhA4dG7f1i1JCHKMq7tvfJVmlu_uynO4PEoI0alXFMGjmDjqio0g
Message-ID: <CADUfDZqE6JLLbugK+qYe=XFSLV5zUwFEQ6qRqvJ-=uVs8OtfVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] block: use integrity interval instead of sector as seed
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 26, 2026 at 10:42=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> bio_integrity_setup_default() and blk_integrity_iterate() set the
> integrity seed (initial reference tag) to the absolute address in the
> block device in units of 512-byte sectors. However, Type 1 and Type 2
> ref tags are actually the least significant bits of the integrity
> interval number. On devices with integrity interval size > 512 bytes,
> the ref tag seed thus isn't the correct initial ref tag. The ref tag
> seed is correctly incremented/decremented in units of integrity
> intervals in bio_integrity_map_iter(), bio_integrity_advance(), and
> blk_integrity_interval().
>
> For REQ_OP_{WRITE,READ}, blk_integrity_{prepare,complete}() covers up
> this ref tag seed discrepancy by adding/subtracting the difference
> between the initial integrity interval and ref tag values to/from each
> ref tag in the protection information. However, REQ_OP_ZONE_APPEND can
> also carry PI but doesn't go through blk_integrity_prepare() because the
> final data location on the zoned block device isn't known until the
> operation completes. As a result, the REQ_OP_ZONE_APPEND PI ref tags
> start from the ref tag seed, which isn't in integrity interval units.
> Subsequent reads of the appended blocks will fail to remap the ref tags
> from the expected integrity interval numbers to sector numbers.
>
> Additionally, NVMe and many SCSI transports support offloading ref tag
> remapping to the device by specifying the expected initial ref tag in
> the command. The kernel doesn't currently take advantage of this, always
> remapping ref tags in software for reads and writes and setting the
> expected initial ref tag to the integrity interval. Setting the ref tag
> seed in units of integrity intervals would be a prerequisite to allowing
> the kernel to skip the software remapping and pass the ref tag seed as
> the expected initial ref tag in the command.
>
> So compute the ref tag seed in units of integrity intervals instead of
> sectors to avoid relying on ref tag remapping for the conversion.

Martin, are you okay with this updated commit message? Would be nice
to get this fix in so auto-integrity works correctly for zone appends
on 4KB-integrity-interval devices.

Thanks,
Caleb


>
> Fixes: 0512a75b98f8 ("block: Introduce REQ_OP_ZONE_APPEND")
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/bio-integrity.c | 3 ++-
>  block/t10-pi.c        | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index b23e2434d80c..d20f9002c7c9 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -102,12 +102,13 @@ void bio_integrity_free_buf(struct bio_integrity_pa=
yload *bip)
>
>  void bio_integrity_setup_default(struct bio *bio)
>  {
>         struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_d=
isk);
>         struct bio_integrity_payload *bip =3D bio_integrity(bio);
> +       u64 seed =3D bio->bi_iter.bi_sector >> (bi->interval_exp - SECTOR=
_SHIFT);
>
> -       bip_set_seed(bip, bio->bi_iter.bi_sector);
> +       bip_set_seed(bip, seed);
>
>         if (bi->csum_type) {
>                 bip->bip_flags |=3D BIP_CHECK_GUARD;
>                 if (bi->csum_type =3D=3D BLK_INTEGRITY_CSUM_IP)
>                         bip->bip_flags |=3D BIP_IP_CHECKSUM;
> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index a19b4e102a83..e58d5eb6cefb 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -308,18 +308,19 @@ static blk_status_t blk_integrity_iterate(struct bi=
o *bio,
>                                           struct bvec_iter *data_iter,
>                                           bool verify)
>  {
>         struct blk_integrity *bi =3D blk_get_integrity(bio->bi_bdev->bd_d=
isk);
>         struct bio_integrity_payload *bip =3D bio_integrity(bio);
> +       u64 seed =3D data_iter->bi_sector >> (bi->interval_exp - SECTOR_S=
HIFT);
>         struct blk_integrity_iter iter =3D {
>                 .bio =3D bio,
>                 .bip =3D bip,
>                 .bi =3D bi,
>                 .data_iter =3D *data_iter,
>                 .prot_iter =3D bip->bip_iter,
>                 .interval_remaining =3D 1 << bi->interval_exp,
> -               .seed =3D data_iter->bi_sector,
> +               .seed =3D seed,
>                 .csum =3D 0,
>         };
>         blk_status_t ret =3D BLK_STS_OK;
>
>         while (iter.data_iter.bi_size && ret =3D=3D BLK_STS_OK) {
> --
> 2.54.0
>
