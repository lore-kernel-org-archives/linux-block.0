Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795128309;
	b=a7hz0XQYV/xo+kLDLK8UoWzZWVcMLM3ozNPyT7rRVoosEmZNA66D1AvR7L0eBonPP4fk
	 Vf3qOhXFH+le8549iWMFqBT2e2qo03NIdm1y53guKV5BQhydlcu2ZIb1nBb55TgLYjsGo
	 NU9qGY3NU88q7mt4Jw7umLZXywiUKBPu1nUbeq0pxqhWOZP8EuU/kTRf0ha4K/W7gGLXY
	 a2bBb3BIw+OhN+0CVfGzFu9E0tixjyO+hb92bZ21WUPcs9hQnMDIvVuyYLu683QJYAw5Q
	 8d9NySlJKJDSL7RGz7y/NQng8/o4deXGeiMr3DWAEWtRZ3QCARbrtIktmv29fI8MZGQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795128309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=loFCLmyZ5e+oKb4lypNtX85tyQq3Dij1rucPTMpgb8M=;
	b=EP2Td+v/icOA4LVLzOtP00lduk2r90lc7L6QOeAzlAKdMlnf49424oWqActCfVui3khy
	 tBnR4CiPDEEiPeQ75yq514Jo8XUYLIObpA4Bq1jK5CBk5ewzWnS0iZrFclujqSVTJQp3b
	 6B3rtsp6Bk16UJP/pFRRFD7FaVP3yPQ5Accg9aujLUPatbh+5xyz2gi+vRMq6QoPEdBb7
	 mDkrPfB+/SJ4NGKN2fO961SC/ZnvrEgVI8G53YNNBmkvcd8Yt4NHho8INwda9HWCDfj4g
	 8ddq8bHzUk6g7wtnIpZDE5o//bJQiUw5fNywc0EYpbG0nd+EfOfPaMLGnTocArKNPSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=MEl2CWv4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3556606A330
	for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 22:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3556606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=MEl2CWv4
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8231ccb04a0so9819a34.0
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 14:45:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795128307; cv=none;
        d=google.com; s=arc-20260327;
        b=ayXTEUfwoPoEThP0CZqUHyf9WxKHY9rRCdiP0akoBjfMfzo7a56bWqYq6AsY0ZXUa9
         NmPOXW6JXTjO2y3flcdn80GiJoNSS7rNd22Kdmpie5SMTExx5l786ODTJLkX7CNW7I7Y
         5qxUoxoEdcL5zMseEgEunHA0R2FNeMW7oXUrjZRocNM/yWE6JA0kag2Zullpo1wyKc0r
         WE2xCE5SX+1uH1TWoCLPzawQTC/9XwOdMfKGVHpMvpe2j2xSb+7qQJ75LqlkSMw9dMUv
         +o4Ft/sTrGEvYHqtx+jylKSoPTzKy2inp5t4IbNqL9uZmAS+78RvCnCA67/WYIqYap29
         4gnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=loFCLmyZ5e+oKb4lypNtX85tyQq3Dij1rucPTMpgb8M=;
        fh=izhAmFrCvFu5srGo9Xa/KL/0Lre3UwcwQLZvitMbS0o=;
        b=poQXXKE45mEywKFqgih1z6nBx/4/+GhTeqSgjdo2GUiXHQKTCdUqHjI0Wp8D+VacqH
         UgSlUoyTvxK6Fe8D2oBVnYMSFy/Q+Jh3FRk5ghWBykKT3Q8QBDIebnhFv/xLLNHNT0Dy
         eiDbM8tMMA5D2wEREH47mHhtHIaLBWmmrZemmfdQZq7yBevL9GqvFWBdkPK6UG1DJBQi
         p7Blu/4R/pv2zzYVDFxODj4w0RnwepCx7qrKds2tftVLLSvhFFrqDL5NuzjH03zvPIDe
         ZHSbG5LNje+EWvVl3FpfydenPYFH769sA27cbvv/GlMG+Iffb/Kl0qfmB8y7BY/5cPV4
         sRuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1795128307; x=1795733107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=loFCLmyZ5e+oKb4lypNtX85tyQq3Dij1rucPTMpgb8M=;
        b=MEl2CWv4FRmrWb3C9pFXpT3FtYCN6hhUYuTxxf3nKxLT5QmBoFN+JlidjEP169NQx/
         tD39PvE9II2Z6tJFbN3CGet7NsoHw89Xy8YxVXLwBQNOWJZoivFB7mnes7kkR2MMXDWY
         C84WPxjqSf18u2CjMIcwMBC06zxf7IPs/VU0b51B9fXXTGHPTGJUiFPxJdBN8T4oVNLh
         pBn2zum1QZ1MU4C5gEP4szDafsaSrj0QrBZ+T+fPRT7/LqDXAWJVIwbZ1lwiNA9K4xvo
         rojvWVreW58cJciydKYbCCVYZ7FL7NEJw56ASZBx+E5deXI2Il//QWaDYS0VeZJ0+F/a
         PqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795128307; x=1795733107;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=loFCLmyZ5e+oKb4lypNtX85tyQq3Dij1rucPTMpgb8M=;
        b=qWJVZtgJHl7r6ehcA5dIy5VC3yYoWcRiSFmMZPKJoEYUYlwF/Kj91x4eVHXZsr28lz
         XqCftcn33tjA+9pY1s7/Kz1dxdld8PJIhJ6Xk3XbltzxhcxmdE7HZ5Seu+X1zcusSwWg
         3XgS477PrJOrCB+lNU/ml6GFM0I+IaRx7IaeNRShG1lxasxQI9LbilxJ6jKodxJ1+alD
         32enaEci4i4/sUGvZtnbfgVFQTxDTakNcbwi6KA4V25EsJptY6QeIqhQo1pD7jXarTk8
         eVG2fC+d/viQ/kJQ/ealEDZcB7ZEEVAICRAvRal0/snA6gWA8a6HX7GNuNKTtENzGWJC
         D/zg==
X-Forwarded-Encrypted: i=1; AL+hErGska6uZTPAEIIwR+cHED7oyIjOEx4/enlyDtW3GE+ibfEuabCEdpo/EhZjJp4ovbYbcnh8PkESqxNlCA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9nkRznlE5K+SfiCrOauvSk82qcwU1aI/den5Jd80kPjKqL7Fuf
	VjkeV84/VVZf6potG4sA1JZliSSUEP5GnRSi/Bq5HHHoOJogYiF2CKwy7Gv489g8yJChsLG+yT6
	/K66eUau5nhi80TPx4bZDtU0IVtYkoP95SyYFDI9lAw==
X-Gm-Gg: AYBFou2/OAiy9uMOT5rcbPtfeszYiXnuQ54f+ze03YiRM6f7DFJZUYGwoGVNzxEuTuP
	d3bEMPFj12JTMvnsh5MgL1zcxae52e/iYxldtPsy5N2d7vxSA8o3XdUZpc4vzBwq2RtoC41YJ19
	j7tJs4DzTtIiUxzCaYWoCAxJxx0mpyU6n+5D/WY7hBBC/BnEkyuvU2o8UkgEak1jhhSqkP/q6Zn
	VNgD0ayneHIvf5bOpW2Q1sWMV6fxT+U/O8hohIpqY0E3mvvRJ4AZOmx9JgVIjEY8nX1yReC+8kR
	Pl3aq4MtpYuJERVHF0F1rLNNu/6JZn7zchL8fBFv8BNRpZraSMzIa/RM9uyaZzFstn5hCIMz+bZ
	lYBzAFKMPw8I7NZwXuBU6nplVXb0AjLHItIr6
X-Received: by 2002:a05:6820:3504:20b0:71a:fbe0:a6d4 with SMTP id
 006d021491bc7-71b39325f06mr1304500eaf.1.1795128307460; Thu, 19 Nov 2026
 14:45:07 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118154053.13218-1-zakaria.belkadi@inria.fr>
In-Reply-To: <20261118154053.13218-1-zakaria.belkadi@inria.fr>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 19 Nov 2026 14:44:55 -0800
X-Gm-Features: AclHuK-20fKaJbwldjq_qAX_xBJaBiJ2DaYwt5DufQcV7VQJOK-PRVYssNvtcQE
Message-ID: <CADUfDZqgU8Hc934Oe8MTanj57W97AmoQ+VzNK2MSLC0pato0EQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] block: pin user PI pages for writing when ref tags
 are remapped
To: Zakaria Belkadi <zakaria.belkadi@inria.fr>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, florence.schadle@ssi.gouv.fr, 
	frederic.tronel@centralesupelec.fr, louis.rilling@irisa.fr, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 7:42=E2=80=AFAM Zakaria Belkadi
<zakaria.belkadi@inria.fr> wrote:
>
> For an O_DIRECT write that carries a user protection-information buffer
> (io_uring PI attribute), the PI pages are pinned as a data source,
> without FOLL_WRITE: io_prep_rw_pi() imports the buffer as ITER_SOURCE,
> and bio_integrity_map_user() pins the pages and normally uses them
> directly. It copies them to a kernel buffer only if they are misaligned
> or in too many segments.
>
> If the integrity profile of the device has BLK_INTEGRITY_REF_TAG,
> blk_mq_start_request() -> blk_integrity_prepare() then remaps the
> reference tags in place in those pages. So the kernel stores into
> whatever page backs the buffer, including a page the caller can only
> read.
>
> Write access to one such device is therefore enough to make the kernel
> write into any page the user can map for reading, wherever that page
> comes from. Two examples, both tested: the page cache page of a file
> the user can only read, and the shared zero page.
>
> Pin the pages for writing when the request is a write and the profile
> has a reference tag. A read-only buffer is then refused, and a
> never-written anonymous buffer gets its own page.
>
> Fixes: 3d8b5a22d404 ("block: add support to pass user meta buffer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zakaria Belkadi <zakaria.belkadi@inria.fr>

Yeah, this looks serious. It's pretty much an arbitrary overwrite
primitive for pages that should be read-only to the process: userspace
can choose the starting address of the metadata buffer so the bytes it
wants to update are part of a PI tuple ref tag field, it can choose
the seed to determine what ref tag value to match, and it can choose
the block device offset to determine what value to write in its place.
It does require userspace to have write access to a metadata-enabled
block device. (Though on kernels with ublk enabled and
UBLK_F_INTEGRITY support, a CAP_SYS_ADMIN process could use ublk to
create such a device...)

> ---
> Resend: my first attempt today went out with an HTML part and was
> rejected by the lists. Sorry for the noise to those who got it
> directly.
>
> Found by a source review assisted by an LLM. I first sent this
> privately to Jens and security@kernel.org on 16 November, because I had
> missed that Documentation/process/security-bugs.rst asks to treat such
> a finding as public. So I resend it here as a normal patch; sorry for
> the duplicate. The patch in the private mail was truncated, please use
> this one.
>
> I reproduced it myself. A reproducer is available on request.
>
> Affected version: mainline v7.4-rc3 (aebb72744764); both cases below
> were observed on it. The path exists since the commit in Fixes, v6.14.
>
> Path (line numbers at v7.4-rc3):
>   io_uring/rw.c:220, io_prep_rw_pi(): for a write, the PI buffer is
>     imported as ITER_SOURCE.
>   block/bio-integrity.c:368, bio_integrity_map_user(): the pages are
>     pinned without FOLL_WRITE (lib/iov_iter.c:1784) and normally used
>     directly.
>   block/blk-mq.c:1377, blk_mq_start_request() -> blk_integrity_prepare()
>     -> blk_set_t10_map_ref() (block/t10-pi.c:483) stores into them:
>         if (ref =3D=3D virt && ref !=3D ref_tag)
>                 put_unaligned_be32(ref_tag, &pi->ref_tag);
>
> Setup: QEMU guest, emulated NVMe namespace with T10-DIF type 1. Root
> gives one unprivileged user (uid 1000, no supplementary groups, no
> capabilities) ownership of the device node of that namespace, and
> nothing else. That user does one io_uring O_DIRECT write to it.
>
> 1. PI buffer =3D read-only mapping of a file. The file is on another disk
>    and belongs to root (mode 0444); the user can write neither. The
>    write changed the reference tag stored in the file, as seen through
>    the mapping, through pread() and by root. After dropping the page
>    cache the old content was back: the cached page was changed, not
>    marked dirty.
>
> 2. PI buffer =3D never-written anonymous memory (shared zero page). On
>    v7.4-rc3 the zero page is read-only, and the kernel oopses with a
>    write fault in blk_integrity_remap(). Up to v7.1 the x86-64 zero
>    page is writable, so the store lands: on stable 6.18.58 the write
>    succeeded, and a new, independent anonymous mapping then read the
>    reference tag where there should be zeros.
>
> These two pages are only examples. The device is the one thing the user
> was given, and it does not limit where the store lands: that depends
> only on what the user maps as the PI buffer.
>
> Conditions: a device whose integrity profile has a reference tag (NVMe
> PI type 1/2; SCSI DIF type 1/2 by the source, not tested), opened for
> writing with O_DIRECT. What is stored is the 4-byte reference tag of
> the device, at the tag positions, not data the caller chooses freely.
>
> Fix tested on v7.4-rc3, same user: both buffers above are refused (the
> write fails with EIO), with no fault and no change to the file or to
> the zero page; a never-written writable buffer gets its own page; a
> normal writable buffer works as before. Not tested: v6.14 to v7.1 with
> the fix, stacked devices.
>
> The patch makes such writes refuse a read-only PI buffer. If those must
> keep working, the PI buffer could be bounced instead, always or only
> when pinning for writing fails. I can test another fix.

CoW pages should get copied to a writable page in
iov_iter_extract_pages(), so that leaves only memory explicitly mapped
read-only into the process. Seems pretty unlikely that any users would
intentionally do that (they would have had to initialize the metadata
while it was writable and then mprotect(PROT_READ) it before issuing
the write I/O). So this approach seems fine to me. Might have made
more sense to disable ref tag remapping for IORING_RW_ATTR_FLAG_PI
I/Os from the start, but would be a UAPI-breaking change to do that
now.

>
>  block/bio-integrity.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index d3df726e0..3ee2d49d8 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -487,6 +487,14 @@ int bio_integrity_map_iter(struct bio *bio, struct u=
io_meta *meta)
>                 return -EINVAL;
>
>         it.count =3D integrity_bytes;
> +
> +       /*
> +        * blk_integrity_prepare() remaps the reference tags of a write i=
n
> +        * place, so the PI pages are written. Pin them for writing.
> +        */
> +       if (bio_op(bio) =3D=3D REQ_OP_WRITE && (bi->flags & BLK_INTEGRITY=
_REF_TAG))
> +               it.data_source =3D ITER_DEST;

Could probably drop the bio_op(bio) =3D=3D REQ_OP_WRITE check; reads will
also write to the metadata buffer in blk_reftag_remap_complete()
(though they will already have data_source =3D ITER_DEST).

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

> +
>         ret =3D bio_integrity_map_user(bio, &it);
>         if (!ret) {
>                 bio_uio_meta_to_bip(bio, meta);
>
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> --
> 2.39.5
>
>
