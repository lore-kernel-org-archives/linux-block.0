Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6936A3033E7
	for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791733502; cv=pass; b=GJE1cqYWYAzuHext3M8JOX3l3B/rDbW3Jehl0tCB0rJd/tBw/zZ/nIbEfyyU3ElMhDp4b2zPri4iGudh+l4gGUCEbcQNKQE1NUqCldXqEt0pl2Oq5x5u4zZdw95hTZpadTNsVoMnV/kFH6kaQV4zb8tb/6wVSV6zuDtS+5v5Zag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791733502; c=relaxed/simple;
	bh=6PTL+Y5xBP60WaVey/AEHQGQD9gpt6fmHlYPvz+QoNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JG9BPsGoRoV+SjvM2xERTCfPbrkmYqmQ68a8oDSiqctAbLLkr3OPaqn0VZD6wIoOPTBfypT0jACt5B8o8zvwpGoYEYzjrOF4zD98UWouSHpgfnlXKuwKfMCkW+dvwR0m3SWBS25Ka9OI5Vp2weI/ed+5qov9ECUq16g5AkYT/cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUo9nJoz; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUo9nJoz"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-53391022dc0so14285751cf.2
        for <linux-block@vger.kernel.org>; Sun, 11 Oct 2026 08:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791733500; cv=none;
        d=google.com; s=arc-20260327;
        b=J+FWgXkkPrMuHREUGaCJigjfRaWOUyfTBKWSBO+Q+/bK2fGyZJnti6akGZnRRTmsw6
         /6ln1VVpXJBSGnM5EpBoFdA6g3Dc47lU8KoKWlRWYM08HFeWnmU2tmmEElcE1/sgNYEz
         WekMPJ0DLo38FLLhxXLAwWdRTxLDGRydrMe8Irasqt9t7jrY+NUt4+Wg7Y8rEqiqtbqA
         +39uagST8A4W57LbbjcalMZ4x+/8Uj0HBlbO1sCE4cEgHyEchrlhOh6zTRCsfhreroo4
         AayM7hvq5Nu90x7yLhTIkE5Dx+sblWEZd4iXL+Taz7STnWBm8WWRTbs7TH0iAzvKC1M3
         XAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mdktJhqdYq3GRvhawHItOJ6wrK1i5Q8hbqyZyvmCYls=;
        fh=Rfs471vpsoo/EzTmdPw7s1bYGjzO5aT6x3A3cxa3VYs=;
        b=skFIQ8PMZa8X2Ynmuo18ovRRmrLAgv3Nz3wymUv0Awj54vtihZUMSo6sng1AT2rRgB
         iZ22P/St0LnSbKTJMk8tSycTkWCVelUTUF19cnvfyxX4nrgYqh1ZkBe/6jhyTtsLyGKr
         kzELPFkdParV/h4hHDAsEZMupHBv53Uvs6vOLBRFdwpo5OmrF6CYHUd9kElAofuhco/G
         LDYDNCde/i2g/WGsv+N/rvrteOdBj8xgHX6qkVgoCf2xKUf/rUkwB42pJrqVuwkrZWaR
         gmZMdXeyxZY4azDsuOWJwKtdMJAoVmgPl7t1/gNerl6NqKaJkLiZTyA1Sn8zpROtZ2Ou
         U9sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791733500; x=1792338300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mdktJhqdYq3GRvhawHItOJ6wrK1i5Q8hbqyZyvmCYls=;
        b=EUo9nJozQw02X98Ct3tEXk6wn3nrwYUr/1FT1sD376jSnLUi1hVRWJsc4S4gIABlMg
         frEw/BS+FW7mfB0JMj+Kb4BKiAhLaqovn3JoeJoww/A4lzCH5U52TwZo+wDVNpwrLUkQ
         d+c8xzfLdRBgfpgr2XRkS3NyBeFZTSHDkRJ+vebzRJ0PMubxUFsRtsKikmEIU2ESh2L3
         GvPVeJLnbM9lrkavHfmaU9RV0lBWG/cSAre63xsivWjih6JAdQA1KmmDH/dX0y5c7uNV
         C2NHKZVwifJzcJQdriPMM9HCS3r0FTGi+VK0hr9B9fKdKZACqSsCQNsJ/xs9jMb1M79R
         R61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791733500; x=1792338300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mdktJhqdYq3GRvhawHItOJ6wrK1i5Q8hbqyZyvmCYls=;
        b=Xfy5oEmHNDa1RkJ47BbvIm2/49pCeHV/4qpl7bag5Hx+QY4IBDuDpde11uYVNiodKE
         8mCpiijQlu7eZdePZW9yBE5Gkr1dLtHQwJLaYhlGPYyAti3MG5ySJKG6eXte775zLmFa
         Jeiy0AqOozYJxklcWDVqema9v77usuE4Ag6CgpPbj2Uq6ryCq4ZyM7m8/NvUSPlESZ4u
         21w0ahC2sEFime+eZqLzI8xhngHgUyAIdR006CBNOZHoqFLiwvwIN7yMPUZJi2QYiQgj
         X7T5UF96Juy8W6yuybH7Nz79VujAa+eMSuWFYnm1AYY4rKs0Oc6lNBzJo8Tu41s6tJ9o
         XsKg==
X-Forwarded-Encrypted: i=1; AKwUvBwEYAhbsFc9rbZLYyCvmIxGJ4vILr7GEQZvL+IyxkeodblWjwRcwlaHJFO4d+xY/fJkiZv+7MXKp81NcQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLKfQNeXDaIFqXIGVhCPttP76I28Nr0tiCWOvpqq9JZLhrS3eN0
	/HQG1vtkfEZx7DFkow5ajdFNN39mBKp8k2S4t22TfTCGkROZl4dNSGbFhXDLEnQRn0JASWt2NVX
	HO98azkGzKbm/tMfCX0i9HLYPoiZ4LYc=
X-Gm-Gg: AYBFou1Amv8qpGOQDlYY849zMtz7hlg2NcE1Y2S62cXPJ5DREZSWg6O/axQvaggmMJq
	naXGLwOMdyZC0uDMZGYWNhge+7A7JgpG4sT6SmPdnHFTr1HR216vr6F0EPkVPXaNEh4TxHdIr95
	EM5BkQMWCiSMbxKFBkHss4EmhgfQO4aIxTmYOymKDn3+UPXUv9MaNVO+PvjN7KhyeniH7EPN3fq
	3EspC+nwYztnagwpeAG3avyrC/9MuPPeBvENlJ7TAS5mn/2KIupl8fYmMT6as+YLKAe38dF4gxp
	Sq34VpSMmVAY+njo/7kwZRq30D0LCZ0viXVsVa4ju4wBkEAl7YUJD2P6OyxHqMU7F5FcuuBsC7G
	HQ7QvK6sghqhvR0TirRxWwrg9+UNUgT+Sxgtf9ojHXLFqEje53AxySeB5qkaxOUhArXROLS/aGW
	gIFiJDXnFS+PSJ3DIA80Vcjs7XjbH+cAOK3K/hXB3vmzw0ofHBy2EtrQnxytJv5MsKrh2TRAAyU
	3F1vxnqsv+nIygVikOND9J+/mKcBKo=
X-Received: by 2002:a05:622b:98:20b0:535:a5fb:6461 with SMTP id
 d75a77b69052e-535a5fb6a85mr80969221cf.76.1791733500202; Sun, 11 Oct 2026
 08:45:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011051906.60397-1-jain.sm@gmail.com> <20261011051906.60397-2-jain.sm@gmail.com>
 <e146448b-5210-4215-821f-181c91625141@kernel.org>
In-Reply-To: <e146448b-5210-4215-821f-181c91625141@kernel.org>
From: shashank Jain <jain.sm@gmail.com>
Date: Sun, 11 Oct 2026 21:14:49 +0530
X-Gm-Features: AclHuK_vW5uLKdbCkt3Wwb_YBZ5joWn4Fojb_E9Aoddw1Wc_Ifd1J7tCy2EN_g8
Message-ID: <CA+FWx=n7E+z_LE-jRchZQzBBK8O3vbaq554GA7-D_1e_AS+V-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: only use the cached zone report if
 BLK_ZONE_REP_CACHED is set
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Hannes Reinecke <hare@suse.de>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026, Damien Le Moal wrote:
> Can you reverse this if to be "if (rep.flags & BLK_ZONE_REP_CACHED) {" ..=
.
> Also, the condition should probably be:
>         if ((rep.flags & BLK_ZONE_REP_CACHED) &&
>             blkdev_has_cached_report_zones(bdev))

Reworked exactly as suggested and reposted as v2:
  https://lore.kernel.org/all/20261011154018.48913-1-jain.sm@gmail.com/

blkdev_has_cached_report_zones() is now used from the ioctl, so I moved
it (with its comment) above blkdev_report_zones_ioctl(). Patch 2 is
unchanged and carries your Reviewed-by. Retested on zoned null_blk.

Thanks,
Shashank

On Sun, Oct 11, 2026 at 8:16=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 2026/10/11 7:19, Shashank Mohan Jain wrote:
> > BLKREPORTZONEV2 takes the flags field of struct blk_zone_report as an
> > input. With BLK_ZONE_REP_CACHED the report is built from the zone
> > information cached by the block layer. Without it, BLKREPORTZONEV2 is
> > documented to behave like BLKREPORTZONE and to get the report from the
> > device: this is what the changelog of the commit that added the ioctl
> > and the comments in include/uapi/linux/blkzoned.h say.
> >
> > blkdev_report_zones_ioctl() only uses the flag to validate the input
> > and calls blkdev_report_zones_cached() for every BLKREPORTZONEV2
> > request. A caller that passes flags =3D=3D 0 gets the cached report, in
> > which implicitly open, explicitly open and closed zones all have the
> > condition BLK_ZONE_COND_ACTIVE, and an explicitly opened empty zone is
> > reported as empty.
> >
> > Example with a zoned null_blk device (10 MiB, 4 MiB zones) after
> > BLKOPENZONE on zone 0, and a write of 8 sectors to zone 1 followed by
> > BLKCLOSEZONE:
> >
> >   BLKREPORTZONE:             zone 0 cond 0x3 (EXP_OPEN)
> >                              zone 1 cond 0x4 (CLOSED)
> >   BLKREPORTZONEV2, flags 0:  zone 0 cond 0x1 (EMPTY)
> >                              zone 1 cond 0xff (ACTIVE)
> >
> > The uapi header marks BLKREPORTZONE as deprecated in favour of
> > BLKREPORTZONEV2. A program that follows this and does not ask for
> > cached information can no longer tell open zones from closed ones, and
> > is handed BLK_ZONE_COND_ACTIVE, which is only defined for the cached
> > report.
> >
> > Call blkdev_report_zones_cached() only if BLK_ZONE_REP_CACHED is set,
> > and blkdev_report_zones() otherwise.
> >
> > Tested with zoned null_blk devices in qemu: a program that compares
> > the reports of BLKREPORTZONE and BLKREPORTZONEV2 with flags 0 after
> > the sequence above finds the differences before this change and none
> > with it. The report with BLK_ZONE_REP_CACHED is unchanged.
> >
> > Fixes: b30ffcdc0c15 ("block: introduce BLKREPORTZONESV2 ioctl")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
> > ---
> > Prepared with Claude Code (Anthropic), model Claude Opus 5.5
> > (claude-opus-5-5).
> >
> >  block/blk-zoned.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> > index 475aa16bc4..9555eae91a 100644
> > --- a/block/blk-zoned.c
> > +++ b/block/blk-zoned.c
> > @@ -400,6 +400,13 @@ int blkdev_report_zones_ioctl(struct block_device =
*bdev, unsigned int cmd,
> >       case BLKREPORTZONEV2:
> >               if (rep.flags & ~BLK_ZONE_REPV2_INPUT_FLAGS)
> >                       return -EINVAL;
> > +             if (!(rep.flags & BLK_ZONE_REP_CACHED)) {
> > +                     ret =3D blkdev_report_zones(bdev, rep.sector,
> > +                                               rep.nr_zones,
> > +                                               blkdev_copy_zone_to_use=
r,
> > +                                               &args);
> > +                     break;
> > +             }
> >               ret =3D blkdev_report_zones_cached(bdev, rep.sector, rep.=
nr_zones,
> >                                        blkdev_copy_zone_to_user, &args)=
;
>
> Can you reverse this if to be "if (rep.flags & BLK_ZONE_REP_CACHED) {" an=
d to
> call blkdev_report_zones_cached if the condition is true? That would be a=
 lot
> more logical.
>
> Also, the condition should probably be:
>
>         if ((rep.flags & BLK_ZONE_REP_CACHED) &&
>             blkdev_has_cached_report_zones(bdev))
>
> to be more efficient and avoid a call to blkdev_report_zones_cached() whi=
ch will
> turn into a regular device report zones.
>
>
> --
> Damien Le Moal
> Western Digital Research
