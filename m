Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430B33C1D52
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808931; cv=pass; b=SS23J4JP66BY9fB6aKoBaMcETyR7cZGCc9TWineXfditQhgzjwFL6ka6D41jgfqepLAQ4JRzpDryLgzXucMWtaOMPk8GBS7bynWvew0iNgbBjgKxbs/FkAC4rNMMyyvN4K7evDigTH20s9zSYSz0MoFz4VlAEW52z1TKbJA/Chw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808931; c=relaxed/simple;
	bh=gZ+ZE2irNcCkbIJzz5yMUxpWrnl3D7VkqM+gD/VpeLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvM0rUztId7JKlcQ3tT+2xwoh8NC9ExKAxu4iXVsCtc4axsPk1jT/QfRz9CBE7VUlSaSDlSyJR3eFwHYeO8Ftk7zUiq3mWSqBjPfiAwfRqBMc3Jqc8MxwqOj1F2Kyze7HGCR2buEeqNHCoE/ucdPyXB05aXFaNpYxJGwuAyG3ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgV5C7mw; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgV5C7mw"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-535179e995bso25116341cf.0
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 05:42:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791808929; cv=none;
        d=google.com; s=arc-20260327;
        b=qRyLkOreT1QaPsh4e+U83M6aW1IGp3ieMxgcohN7bhuRCniGrdhdGZw2lleA0b+bgl
         U91LQYjyqIpOv1E0Gh0O5oucsYUETUDKgKjFM/OPJGVDQtEUo/tQGUqXOVsHWaLk0ET6
         eI/Loplct3+C8Zu1g7CX91ZvseS2YX/yLHkNtsuWr5zkInualJdz5NqADkItWLBqjTqd
         nkFyAbfjZ99SM0fRG3Djccuq9x+iZyYB3hdXk2z/BTOXiKNDx0b42StOmpQOV5oA69jc
         Plk3mAER9nbpYmvM5Ramq2ScuAUI0j9vaEVNJm+WUe2iHadmTdcqixmQVqW1wOo6p92Q
         cjjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XLvTYpWxwPTdcMS4isD9oU1yCHW9ZVlEU7PXJurtVs8=;
        fh=ehfzCEH9jaiqR2zWZkyTe2fDt4T4yguDqBVu4RAtmJw=;
        b=G35BnCSaVwBI9F3H2OWmsxGV0NZZfw2gITrUDYLSEEyIquO8UTC8EaqpSy3Ee2gaye
         9HgXCS4+jmWOawf8zQZ1mviekao9EVMCjMcNxjevE8iiyVhT8OML8Qj8SBwYepSwaXlm
         p7BMRBBsBoBvtyij6reUliEDVAsRU4IC50wtkARhQdIC7EFp5iqrCeEl4k1AF1MpWOLM
         y94YuT9SXwu11QvGVtQPlwfyTFdzpzXEzsbRCodTQ/zKdU7kHhLnFgenXBSg6b8DyVnO
         kFI8MnamXHC0IzIWp3RoQpAwj4wj6+y5WDbEyhkTjBKMUuFn454vRlcSpH3CStS8vKJV
         z0Vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791808929; x=1792413729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XLvTYpWxwPTdcMS4isD9oU1yCHW9ZVlEU7PXJurtVs8=;
        b=MgV5C7mwWjOq0Hdk4u/OiYRw7XEkLs7VtwlWQ9/M6YTFhR0gV/qzjQdqHWBvzmVs/f
         kVNXcBIX5j0SWR0pcuuCURmGr9pndHHP1eCG3Gk5ea4uoR6ncmkKxtqq48aGk51198vv
         dQo+xm2k1XLfC//92RFL8/W3PmzHny/mk5WIxPdw7FCKmJVSyxdq00gxg+lLhv7FiYyI
         kgacOR7dhb+2nejP4FQs76Y9tKzaODUzzOeyfSq943AIK6BZpmcTDG/AB64n4aCsWsR+
         +VCoRrjevwwhUD0sIgCQH4XP6HIgRFqKKxiFaduJnZMwUJ7mOwzngiFXU3vTGfiINpkD
         dZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791808929; x=1792413729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLvTYpWxwPTdcMS4isD9oU1yCHW9ZVlEU7PXJurtVs8=;
        b=lO50hz7DfSmPXO+fjfDh2wq37+txJCObaVlS/rnoczwJk3GGkKXPkpdscffYwH+WmB
         mTyecEQ5tBB0qL+6RYT3ahcLKqXuuYyvh9H3FLlJ/N5334vksQ3KguEB58F8egLesium
         qPvxF56hct3bnTNP7GbzAmYzWpy+rxCweMSq+cxEUMz9iDPDaw+kYxN7bUhF/0/ECmnG
         BPw7gYObq7+qzp2hKi7lHERXvIoh1b7VXMooWElSY7A/0GWCZZEHjNfGkZkQgjfpx7H4
         XFePzyOmDc9M/J+FjasYuLDWLCX7coiH9UXQwXCQ6sCrN6XLkwfZC3nOPGnrB9i+2zAn
         t8MQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfIZPt/dHcxUR1eOplW02aLpooS2gLbNxhkewGY/Gt6yg2Bs5UYnXK9tsOcTkvU5aySq3mKvtdzDi8Kg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIQX37aploOhPyHtjTtuiZpVpGaK0qbm4q+9NnYrpVtHPwDG2RX
	QkiLKJX29Vxf1HOCOaImySce/8+L9nrwEm1nE24JGrNuageSbibHtM0ivfPRz/pete3us+u9vBa
	aTAmfReAAX6uHHy9GT/oYEEvQV6M1zlk=
X-Gm-Gg: AYBFou3/FrvZHKr7YacFELITviy0nDJYCUfz6/hMi2voBO9PtuzE6+BtfS7yopmYtr9
	ZJDNeksUkkGWR/o6VLxa0BdmcOHWLQeangdMff7NTg23BXctoPswgRBk0se8+OvZ1nzpeL5/FC9
	ChONM9qpHRFqd2nKLUNOB0fNDq66Jo9L2fuZsFSHzQx4vFx8FgQ/fyg4DtGkVFwPgGMB5s1RDpD
	4z1fWjQ/n7cjnmVjeKmId+2+ipo+PTWahSqQ2CkE3kJfsKKmaDxO7qeoASnFt1XhIXeKKsztIyU
	s1AT1Aw9ODGQidPFUv/EHIufOIRzYes6j72VhxyJ5oe3WrhHpPMS6rUjS1GWIEoLiwENp1xlTp9
	JunFGlKJTJe9Ti9dq79wpSNxSVCesMBJy2lcOJwbWGz3qLh4XJn6ylyLxiR9zmj85h7s4EJWQje
	qkH4TxhpGUyIjuCYofmhNWTX1z/+fEBF4bUgdr75J5DkYUTJC7NoWGPfewUKaz2hwqY2EEzbr30
	jHTHe5o78mtw1PHeQabfl23pNGBJPnVMRxsPv3/
X-Received: by 2002:a05:622a:908:b0:535:2818:96eb with SMTP id
 d75a77b69052e-5359fa71b69mr143345491cf.24.1791808928110; Mon, 12 Oct 2026
 05:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011051906.60397-1-jain.sm@gmail.com> <20261011051906.60397-3-jain.sm@gmail.com>
 <20261012122112.GA31242@lst.de> <CA+FWx=n=66eHOgMFb=unfgqFrhw3prW0EOf1bYHfLATV2-o1_A@mail.gmail.com>
 <09399f27-11eb-431b-914d-397f42de9dc3@kernel.org>
In-Reply-To: <09399f27-11eb-431b-914d-397f42de9dc3@kernel.org>
From: shashank Jain <jain.sm@gmail.com>
Date: Mon, 12 Oct 2026 18:11:54 +0530
X-Gm-Features: AclHuK8hQNk2gI97zQz-VM1322jb3tqxRIS3mXkTKLOB9Z2zsNL0Wvwn8f4-lFc
Message-ID: <CA+FWx=kgeR8tz46tijYE-s=v+PTJjGfM+3ucQOo0ZuDyqFdYQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: fix the length of a smaller last zone in blkdev_get_zone_info()
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Hannes Reinecke <hare@suse.de>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026, Damien Le Moal wrote:
> How do you plan to issue a BLK_ZONE_REP_CACHED report? "blkzone report"
> does not have that yet. I am planning to send a patch for it.

Good point. Two options, and I am happy to follow your preference:

- Use "blkzone report" with the cached flag once your util-linux patch
  lands - that matches the existing zbd tests and avoids a bundled tool.
  I would hold the blktests submission until it is available.
- Or carry a small C helper in the blktests src/ directory that issues
  BLKREPORTZONEV2 with BLK_ZONE_REP_CACHED directly, so the test is
  self-contained and does not depend on the util-linux version.

I lean towards the first, to match the zbd conventions and your blkzone
work; tell me which you prefer and I will align the test with it.

Thanks,
Shashank

On Mon, Oct 12, 2026 at 6:07=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 2026/10/12 14:29, shashank Jain wrote:
> > On Mon, Oct 12, 2026, Christoph Hellwig wrote:
> >> Can you add this to blktests as a reproducer?
> >
> > Will do. I'll send a blktests test under tests/zbd/ that sets up a zone=
d
> > null_blk device with a smaller last zone and checks that BLKREPORTZONEV=
2
> > without BLK_ZONE_REP_CACHED matches BLKREPORTZONE, and that the cached
> > report's last-zone length does not extend past the device. I'll post it
> > to the blktests project separately and reference this series.
>
> How do you plan to issue a BLK_ZONE_REP_CACHED report? "blkzone report" d=
oes not
> have that yet. I am planning to send a patch for it.
>
> >
> > Thanks,
> > Shashank
> >
> > On Mon, Oct 12, 2026 at 5:51=E2=80=AFPM Christoph Hellwig <hch@lst.de> =
wrote:
> >>
> >> On Sun, Oct 11, 2026 at 10:49:06AM +0530, Shashank Mohan Jain wrote:
> >>> blkdev_get_zone_info() sets the length of every zone to the zone size
> >>> of the device. The last zone of a zoned block device may be smaller
> >>> than the others: blk_revalidate_zone_cb() accepts that and remembers
> >>> the capacity of that zone in disk->last_zone_capacity. For such a zon=
e
> >>> the length reported from the cached information is too large, and
> >>> start + len is beyond the end of the device. A conventional last zone
> >>> is also given the capacity of a full zone.
> >>>
> >>> Example with a zoned null_blk device of 10 MiB (20480 sectors) with
> >>> 4 MiB zones, last zone:
> >>>
> >>>   BLKREPORTZONE:       start 16384 len 4096 capacity 4096
> >>>   BLKREPORTZONEV2 with
> >>>   BLK_ZONE_REP_CACHED: start 16384 len 8192 capacity 4096
> >>
> >> Can you add this to blktests as a reproducer?
> >>
> >> The patch looks good:
> >>
> >>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
>
> --
> Damien Le Moal
> Western Digital Research
