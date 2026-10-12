Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77F48C8A3
	for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808196; cv=pass; b=MTN/spq6TPiRc8B3OFTPCILLT+eurX1XKTYQepjPtPb9tCx45EgIM6EAqbeqWFxXavYqyuSIdrorSILWYEQt8MKyb18FSFolg+NLJID3f64D31XIc5Q9FYvJ5JfF3Z7NmnsKrvNL8sFfpZ/DceGqXBMVjKcKpUWNZF2mUSaau+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808196; c=relaxed/simple;
	bh=aQzmNXGcSuNt0+K5ClfmF3eNMN4LgrYdBCU5stJ1AOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omARsmVI7zcuBQ137gSxFZQzmTImQFqiMOCaxI1wWZBVydxMckCZ7oVJWTGu7PK5uJxY7BI9XDgQpg0siYt7cxqWSrfL8CP10scIDCZNq2B6pTXqCRJM7XCjH+RB/SK5qlO3hcaPoG4+JTr5IA2rOcHvlFPzISFBP0VLpLoT+HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bNgFZl2r; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNgFZl2r"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53505bc6524so88430671cf.0
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2026 05:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791808192; cv=none;
        d=google.com; s=arc-20260327;
        b=ssA+N+TLOtzoF5tD1OcgCEWaTxFcIfv3p7kaz1R67QasqMDkndEaiogNw28SOTQziR
         2XsQXMh8Wyu5Ez9IcZ6ylclef2o3eUQG3BrK0O/9A8qQrGbtVt6L1cVeyujS6hKfYZ1r
         PqhqPtgA5Gi8zD/vFnuB2dzgDVJaPxh+rd+DyiNY9T/VrsV75K4+67BLi5dOu7cdQ0fz
         Cvs5qTrjcSoXT+MPlSovMPeZdvV4oKft5h3flLB/et2xAMqSS0sWuRsMDE/Z5o9XGZr+
         hTKQTUGgkPhbCFZwDqod4ErJtgBLqxNoZmnKrvhC7mkSesMC1eyr2qMjfL81Xcqg1z7G
         riAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oIWHaUCymsWkNNoIa2i603tTFbvYNzqXmd5C/K5ZBAc=;
        fh=UHsOACSx5GJioecbFRkN/sJWPRhL1s72/aJaidm2dac=;
        b=Wp0F9Uckgq2RcwLwEA4q9eWlL6LrVsTlNzvx/NJ3C6pO9P/y0DnqcD9Y7NqX334/ZQ
         T8sR55nNkjtCfimMvDkIYV183l6WASE5GJ1RGSQth1HEYgpzwVw1p1dXtwIS6mICMWTu
         D+T5LFyJK0G7mu1a/jgXVoURRQgThLHNbHWLowt2Tgxrb5TwKz2gOw0Pkbx2lV5yuDVz
         VxKrQZ4QxJ+5ywDCDHgNGMQtthlPlnRXlC92Iz+apfKca5Dm4xsseDRO01k0ijzfsRra
         VWbBeZm0Sdpe03KAaPafTxjUfimpp4fdtDmkvssBof0eDcmY8JPzry2SGBGH4TTSkzMr
         ejNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791808192; x=1792412992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oIWHaUCymsWkNNoIa2i603tTFbvYNzqXmd5C/K5ZBAc=;
        b=bNgFZl2rvVOD7o+57JRalBQkhhKWsdI7ANbrFsD6lTF+FQms9t0oOsvcXir/5/o9WD
         tC0UOrwGpXk8Wmk1YvDzKPKRkwkkZZ5VPH1V9oEywI1rPfq2U1wNlsLGa33U/KY9orfH
         7a7K1OMVa06+HqqMl4L6knQEWHD+fes7GAo8tkbEywDVvUrNOsSl4/MFp0qwgHTTw0Z+
         KzWwn3WI4pGtmnUohKT6ZLWtrMfDpXlUOH1nZ+Z5lpTShOvQWFpBzS0g6LeJHQmdiLLC
         6fTNhf+ZOuzfysIun1qfBgg80P+ImFSluLNdVTuyVECF4usVs4NuBSLrvaOJTMRWad4w
         LBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791808192; x=1792412992;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oIWHaUCymsWkNNoIa2i603tTFbvYNzqXmd5C/K5ZBAc=;
        b=s0V8ISWJ+0fB7pWDwdlVeez9gxNNDja04zc2i8ry3oVqf04NG8VHcAXQVg1JgjrL8D
         oZ/ffF0kKazN5dnufgonnTkDY4VPOHZXEVMLiaiKZV19yodG/AAdxxNBgLvolR2RCQmm
         PzBDCWkBYOlH8DWo8MUaYP75kTBKgwSnoNPiBvLV8LxD9NponU0zXY/lMfuTrqMf1Xmo
         cckB10ZHcYVf032+7zOg76AbHr6MQhE1/AgVQ+y4oaGqmniw2FJ0AeIpR8VlmH9zeI2T
         K0yi/jFyWgWB08q+fPf8JE5dfzHgk8RLUjk5pIpBO16Q+bjmL5Q+a+eqoNEmPslsaix7
         2JUg==
X-Forwarded-Encrypted: i=1; AKwUvBwexDWyNpw/xQtNKyimTH4FLJsRrSvBE3fkUWYExbo6azX5yzqMKml3yhoeg6nTKdgwEvg5dHHLrbdQow==@vger.kernel.org
X-Gm-Message-State: AFq9FYKFtt0MbJAteNbuCeGYzRVxtu693vX6mDRUmK09Rh4A3oRSO8O7
	sWpi2KVBErlDJPhkskhYVen1ZbqN8NwDXUFX+GZexy2LKzY8slpzPtGZ6i2SCbZbMDpyFXuiEJz
	9F6BD574fjLcLvLjxzH4+5QFsmOp8gLc=
X-Gm-Gg: AYBFou3yH7khoiOUiy6fJt2uINCPHOG042iXfjKA7Ex5UIfN4753meA068nTfG5TmyQ
	/BaYt7iDTRj7oUb/boGEkmrtZspN0Sgxfhg5+11l5lDCId9cuj+wV9XJYl41Z4VnjvKrZU65BWP
	8/0Zl9hvKDOMRhvXbNhirKAQRE8HEhFDmaCCjPGvf1KKEmC7MW44X/RD3CSYHgguXION6CHIF8y
	A2N06cbiPDDUBBMMoVTHTnnQogvv18aPT1tPI6U16YZFqKeTOwPp8tr930kXROlmJigcxSFOrTI
	QBVwl8Vgn0UIAw4YTF/zs884u0odVPeut0ifDCZHd3ua3zBSemrdR0SWr2KQINFmMaMlHDC716I
	qy3HcRSGUvzKoZ37TLvSWlbv8g1+BIACnL7+aits8n0hTfv6+DUWi2sxjjAiI3u4q+4DkdHwnYh
	nq87ULdXFoY2FDCLLjEKxX6ATU3h39Z7ZKdKtpfBv1mV0kTKd0Sv6QsteQpl9wdoVyiqB0C8TZy
	bqA+iOlNqA7vzi7rw+xVHp2ztgdd21vWAw7Ydg4
X-Received: by 2002:a05:622a:1813:b0:535:271c:8e99 with SMTP id
 d75a77b69052e-535a60739cemr140833231cf.6.1791808192160; Mon, 12 Oct 2026
 05:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011051906.60397-1-jain.sm@gmail.com> <20261011051906.60397-3-jain.sm@gmail.com>
 <20261012122112.GA31242@lst.de>
In-Reply-To: <20261012122112.GA31242@lst.de>
From: shashank Jain <jain.sm@gmail.com>
Date: Mon, 12 Oct 2026 17:59:40 +0530
X-Gm-Features: AclHuK_PEl7KjQBeQ9EW7hUgBDCPywXTmc6ppL-X9j-cIvzZh0Thn-Gl3haHU4I
Message-ID: <CA+FWx=n=66eHOgMFb=unfgqFrhw3prW0EOf1bYHfLATV2-o1_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: fix the length of a smaller last zone in blkdev_get_zone_info()
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, Hannes Reinecke <hare@suse.de>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Martin K. Petersen" <mkp@kernel.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026, Christoph Hellwig wrote:
> Can you add this to blktests as a reproducer?

Will do. I'll send a blktests test under tests/zbd/ that sets up a zoned
null_blk device with a smaller last zone and checks that BLKREPORTZONEV2
without BLK_ZONE_REP_CACHED matches BLKREPORTZONE, and that the cached
report's last-zone length does not extend past the device. I'll post it
to the blktests project separately and reference this series.

Thanks,
Shashank

On Mon, Oct 12, 2026 at 5:51=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sun, Oct 11, 2026 at 10:49:06AM +0530, Shashank Mohan Jain wrote:
> > blkdev_get_zone_info() sets the length of every zone to the zone size
> > of the device. The last zone of a zoned block device may be smaller
> > than the others: blk_revalidate_zone_cb() accepts that and remembers
> > the capacity of that zone in disk->last_zone_capacity. For such a zone
> > the length reported from the cached information is too large, and
> > start + len is beyond the end of the device. A conventional last zone
> > is also given the capacity of a full zone.
> >
> > Example with a zoned null_blk device of 10 MiB (20480 sectors) with
> > 4 MiB zones, last zone:
> >
> >   BLKREPORTZONE:       start 16384 len 4096 capacity 4096
> >   BLKREPORTZONEV2 with
> >   BLK_ZONE_REP_CACHED: start 16384 len 8192 capacity 4096
>
> Can you add this to blktests as a reproducer?
>
> The patch looks good:
>
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
