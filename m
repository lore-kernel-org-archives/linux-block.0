Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45A3EB0E1
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 13:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810518; cv=pass; b=rU54WzA+/fWxc12plIMZOxVkNOlmf6wpmt84s6Ylzd/lBmeGBMurSFrowrV5qZp04p6hxMXPkYoDLk7EqQ+fa8fI3SbV7zSTTxRoP18LE7N4+MLK5xgvX1BWc4kk5lj0fZJyDbxWH9ipxKGiaDzhv/2g8LUGWP4IfFeRxfRDHWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810518; c=relaxed/simple;
	bh=9TnWb3s6PU7JSbOQWmXYCgTaHNi6mp73s3c+kMKdxes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTHqSPmo3wV9Wn3vtvs9lsI2o4qfk6YTeWamaerzlwZ0piq3vhMeeATeKEawjFbJ2AdREsiUIlbi8546H8/qTfsvL6vFfMR953Z5A8qyJ34ivpFxqUpb2Oep+Bi1qlwZdR+kB2soqxU5swVk8AaVDkoAeqDl7VsO5yzNPceCOgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4hK4ZWk; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4hK4ZWk"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5351d76e1baso22552111cf.1
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 06:08:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791810515; cv=none;
        d=google.com; s=arc-20260327;
        b=NUX/i3enoFa2mGvFn6wBHEgX0e3h4m33ZUJcxa7CfxO6GUaBWpaVTB3DmcWAVpUU5i
         X5oOjuxNdJiHebaxB6XxTcYTWxxJgKv3fX1dov9+zD8a5aFe1LI3SNbRSLFYnwYCmiaI
         ZaYP8tYethk0f4j3l3P6gbv7VRe09z1Lskc5DVDfIw/ECq+uzyy86kX/FArswqhMr4+i
         iwt2BdwrUjzhSpTqEjBTeXWQNYVS/2Z0h4RSazNgdajax8V/3P8eEFInomjDmB/DsvFl
         dAdvvLluueGC4sd0M9grrjL7Yo0Elq2Rho+0x6rikUS/PUboRFxU1K22A4tgKaifI1D3
         twVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+qDKiqWWRqUrMR9txVGzWq2WKoa0wiQp+MrbYwWuAb0=;
        fh=vzhfYAq0T6cH6zPRDVea6l3yhM94xcrCJj4wczGJT/Y=;
        b=D3eZ/06snB1sU8j4edBYerpxnpE3KUXNACWmgS9TDfIBbX5Zjksyju5R8wVNdttgRV
         VrAhzl6f3v9zkyNuWauWDTd95Y8xOFsHAGA8c396vKmajDlzITLn3EFLuQM07cyoIhMG
         8yTPmxtnQabMfQAUOVIPRVdhyUUo/W6+9axJNzkCaWik05ksb64/rrhhbQw8nKpIeExP
         Zh9TvUL0QvuZC/q3vjfOLnc6+44k9I5ovwzAWAAXJsjxmNVamGdSePv7vRnhlCdiJurW
         supw95cR2jYE5ZNQGRMFiy6OWg3Qc+A72vsKo4l3+7QMxg6Az+ux+dFxSpfjrenTmaTa
         C3Kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791810515; x=1792415315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+qDKiqWWRqUrMR9txVGzWq2WKoa0wiQp+MrbYwWuAb0=;
        b=Z4hK4ZWkaZC70sJtHjoSnZZ3R0BKFi1XWDifaLbp6MzOTJnFR5bKx2+1XF4ELsFsOs
         E6mfEbeInBrxqgDTLGAnvpG7RIrlTVOZLs2M2aujmbY6MYdkUkEoCke7sigbWLCr9+eA
         ULDMmJYN+a1DwV/MYLrHZMFI+V/MmS9eZC5cY67UT5fBUXz5MgDrsjiDV/+4GNZnSC6i
         JMfhoopM5J9eE3dPO7WoNKmjMGruf3bRACpzKvPJjD2bHufFPGGgAJkubuwJYx8R3ZRL
         wsXb+lfkmjxN3tI2H/AxggUocn0RVC8oK/bsw86fCPW3vp9on8zxhuIg5jcpYzRGb2V1
         mIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791810515; x=1792415315;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+qDKiqWWRqUrMR9txVGzWq2WKoa0wiQp+MrbYwWuAb0=;
        b=oXc+qlLhOy3xMxGjJXC+8+ZQlxRwpxIen2CZrdhnL5KlunHh7RmI+UA8qlNKKv378e
         HMb0WH0CqG6GSaiQySVyr888UGBXh8EGpyUTL+cBPLdRxPw4+akBwaZ8Qv0xktXMSs3G
         p9odxbC+OVaLjjmU1ztOe0C4+KBe1OPaHRNfIqjCZSAIr4tY9pwUUu3CwxDHKkUBk+sj
         71GJmTfcPAIofMr6QagjWyU52T01gi3MzaZSpYamr3oS3Ek5JMjqgDVRrwGG7Qg8Gvik
         7W2KrabxxRvMvq3OGyHT+HXoOZ6NCowYKdqxBDFSjMUxrnWOJVt1axzQ78gDrx9BAhMH
         I/Qw==
X-Forwarded-Encrypted: i=1; AKwUvBwc8d+Gpfuk9lvvJuWUxE56ncr9c6Cscm5S4D2TB9i63bZtHsAyfd2vgu/MQmwi/JTImNqxUoGyHvds9w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJzym4h11HBIo0Iutl6HpO0ikkL5vd+9JdKUFRwK7TsP4Gfrd18
	IaBCxvhYombnhC1Ps8FPcMeZBipyU6lr52k24iuYm++tiuc5zHHXgweQ2X09qjq405ks0yGcz99
	bNFXx/whULMgB73N8e+gN55cuOnIacNI=
X-Gm-Gg: AYBFou2MyulOVwIiEPtjfyOyEVLU6R5paCgUtXAMIpDhgUaugLIhC9YcVKtVS2ZY+2g
	t2SzQ3C11pqHqq3F1ztBDQJmY2YDT1CDG3Sl7r85MuPvFC2akeZ2AIVsiGjCbGpVWd2hZ1FqIuR
	z8Q3G4IeWRzi+oflF/PL02Uq//G0vHtlpnjsDonZ3FG6jR3JyMAkvXbzt3aFmQALvkmiRSERSrG
	Hnd5v6vrzisuxxHO9xFCqlpDqJRlSaNB1GmJ9F0Q5Zdp24dq+7YRSJrQi62uRctENP2v+Mi/8zV
	SaZkv2TpL0KOpWcKPD9z+NXqmj8QEfGNTvIP7vcov20A1j0wx2g3D9+9A/RWRre7vL4p9a/Cwtu
	kcx6WEK+/Cv6K5eZ9Y/JcbFoZO6OQczrjEwEqRjq3WYwiUloitEjhAO6FU/G9hdoAVlWOwsk1W7
	gKXDZuuq2/7FzwgMBDfYM2BC5JM6+4q7jf4uZFWhdpSUJIq3gFtJ9FJCBItbBc9VpJh6SgfKkD9
	sm7BpdVtetfvpGO5xCBKqQmO9M4hg==
X-Received: by 2002:a05:622a:e35a:20b0:533:2daf:c0bc with SMTP id
 d75a77b69052e-535a5e37b30mr90679591cf.0.1791810515475; Mon, 12 Oct 2026
 06:08:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011051906.60397-1-jain.sm@gmail.com> <20261011051906.60397-3-jain.sm@gmail.com>
 <20261012122112.GA31242@lst.de> <CA+FWx=n=66eHOgMFb=unfgqFrhw3prW0EOf1bYHfLATV2-o1_A@mail.gmail.com>
 <09399f27-11eb-431b-914d-397f42de9dc3@kernel.org> <CA+FWx=kgeR8tz46tijYE-s=v+PTJjGfM+3ucQOo0ZuDyqFdYQw@mail.gmail.com>
 <0da1bc26-b3ed-4bfa-b75d-2d1696cc0cfb@kernel.org> <CA+FWx=ko-dj3SORcHcvDpP7abWAmD1JH0o4COPsZc2U7kimTvw@mail.gmail.com>
 <04251d5f-c251-49f7-8690-565c9b203690@kernel.org>
In-Reply-To: <04251d5f-c251-49f7-8690-565c9b203690@kernel.org>
From: shashank Jain <jain.sm@gmail.com>
Date: Mon, 12 Oct 2026 18:38:24 +0530
X-Gm-Features: AclHuK_IeifSqwqfSuwQJ_dYfF-pCRt55Ri5tFzGXW39QtQ3e0rtZvRF1C7ic6M
Message-ID: <CA+FWx=mY7WcyR0D1ik4i4ZTZHFWtTw=Y32306jA7sEiv_SPtHw@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: fix the length of a smaller last zone in blkdev_get_zone_info()
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Hannes Reinecke <hare@suse.de>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026, Damien Le Moal wrote:
> Maybe add a prep patch that defaults to BLKREPORTZONEV2 (without
> BLK_ZONE_REP_CACHED) if BLKREPORTZONEV2 is defined.
> And a second patch that adds the --cached option for BLK_ZONE_REP_CACHED.

Will do - a 2-patch series: 1/2 makes "blkzone report" use BLKREPORTZONEV2
(without BLK_ZONE_REP_CACHED) when the ioctl is defined in the headers,
keeping the current device-report behaviour; 2/2 adds "--cached" for
BLK_ZONE_REP_CACHED. I will CC you.

Thanks,
Shashank

On Mon, Oct 12, 2026 at 6:35=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 2026/10/12 14:53, shashank Jain wrote:
> > On Mon, Oct 12, 2026, Damien Le Moal wrote:
> >> I was thinking on adding a "--cached" option to control the use of
> >> BLK_ZONE_REP_CACHED.
> >> If you want to take on such patch, go ahead. CC me on it and I will re=
view.
> >
> > Thanks - yes, I will take it: a "--cached" option to "blkzone report"
> > that selects BLKREPORTZONEV2 with BLK_ZONE_REP_CACHED, leaving the
> > default report via the device (BLKREPORTZONE) unchanged. I will post it
> > to util-linux and CC you. The blktests reproducer will then use
> > "blkzone report --cached" rather than a bundled helper.
>
> Maybe add a prep patch that defaults to BLKREPORTZONEV2 (without
> BLK_ZONE_REP_CACHED) if BLKREPORTZONEV2 is defined.
>
> And a second patch that adds the --cached option for BLK_ZONE_REP_CACHED.
>
> >
> > Thanks,
> > Shashank
> >
> > On Mon, Oct 12, 2026 at 6:15=E2=80=AFPM Damien Le Moal <dlemoal@kernel.=
org> wrote:
> >>
> >> On 2026/10/12 14:41, shashank Jain wrote:
> >>> On Mon, Oct 12, 2026, Damien Le Moal wrote:
> >>>> How do you plan to issue a BLK_ZONE_REP_CACHED report? "blkzone repo=
rt"
> >>>> does not have that yet. I am planning to send a patch for it.
> >>>
> >>> Good point. Two options, and I am happy to follow your preference:
> >>>
> >>> - Use "blkzone report" with the cached flag once your util-linux patc=
h
> >>>   lands - that matches the existing zbd tests and avoids a bundled to=
ol.
> >>>   I would hold the blktests submission until it is available.
> >>
> >> We should leave "blkzone report" to get the device report as before, t=
o avoid
> >> breaking anything for user with the "active" condition being returned.
> >> I was thinking on adding a "--cached" option to control the use of
> >> BLK_ZONE_REP_CACHED.
> >>
> >> If you want to take on such patch, go ahead. CC me on it and I will re=
view. The
> >> patches I need to send to add depop support will take some more time.
> >>
> >>> - Or carry a small C helper in the blktests src/ directory that issue=
s
> >>>   BLKREPORTZONEV2 with BLK_ZONE_REP_CACHED directly, so the test is
> >>>   self-contained and does not depend on the util-linux version.
> >>>
> >>> I lean towards the first, to match the zbd conventions and your blkzo=
ne
> >>> work; tell me which you prefer and I will align the test with it.
> >>>
> >>> Thanks,
> >>> Shashank
> >>>
> >>> On Mon, Oct 12, 2026 at 6:07=E2=80=AFPM Damien Le Moal <dlemoal@kerne=
l.org> wrote:
> >>>>
> >>>> On 2026/10/12 14:29, shashank Jain wrote:
> >>>>> On Mon, Oct 12, 2026, Christoph Hellwig wrote:
> >>>>>> Can you add this to blktests as a reproducer?
> >>>>>
> >>>>> Will do. I'll send a blktests test under tests/zbd/ that sets up a =
zoned
> >>>>> null_blk device with a smaller last zone and checks that BLKREPORTZ=
ONEV2
> >>>>> without BLK_ZONE_REP_CACHED matches BLKREPORTZONE, and that the cac=
hed
> >>>>> report's last-zone length does not extend past the device. I'll pos=
t it
> >>>>> to the blktests project separately and reference this series.
> >>>>
> >>>> How do you plan to issue a BLK_ZONE_REP_CACHED report? "blkzone repo=
rt" does not
> >>>> have that yet. I am planning to send a patch for it.
> >>>>
> >>>>>
> >>>>> Thanks,
> >>>>> Shashank
> >>>>>
> >>>>> On Mon, Oct 12, 2026 at 5:51=E2=80=AFPM Christoph Hellwig <hch@lst.=
de> wrote:
> >>>>>>
> >>>>>> On Sun, Oct 11, 2026 at 10:49:06AM +0530, Shashank Mohan Jain wrot=
e:
> >>>>>>> blkdev_get_zone_info() sets the length of every zone to the zone =
size
> >>>>>>> of the device. The last zone of a zoned block device may be small=
er
> >>>>>>> than the others: blk_revalidate_zone_cb() accepts that and rememb=
ers
> >>>>>>> the capacity of that zone in disk->last_zone_capacity. For such a=
 zone
> >>>>>>> the length reported from the cached information is too large, and
> >>>>>>> start + len is beyond the end of the device. A conventional last =
zone
> >>>>>>> is also given the capacity of a full zone.
> >>>>>>>
> >>>>>>> Example with a zoned null_blk device of 10 MiB (20480 sectors) wi=
th
> >>>>>>> 4 MiB zones, last zone:
> >>>>>>>
> >>>>>>>   BLKREPORTZONE:       start 16384 len 4096 capacity 4096
> >>>>>>>   BLKREPORTZONEV2 with
> >>>>>>>   BLK_ZONE_REP_CACHED: start 16384 len 8192 capacity 4096
> >>>>>>
> >>>>>> Can you add this to blktests as a reproducer?
> >>>>>>
> >>>>>> The patch looks good:
> >>>>>>
> >>>>>>
> >>>>>> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >>>>
> >>>>
> >>>> --
> >>>> Damien Le Moal
> >>>> Western Digital Research
> >>
> >>
> >> --
> >> Damien Le Moal
> >> Western Digital Research
>
>
> --
> Damien Le Moal
> Western Digital Research
