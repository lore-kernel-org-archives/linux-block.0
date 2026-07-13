Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D7F2765E2
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957854; cv=pass; b=AQ6Gd1TU1JMv51/Msw/WevwbXPU1ezG1H9zXf1ThD4ocNK5b9iWgJdXFTnq/fkcbUx7xhWNhU1V78HJSp4rHtsAhRkGdty52g/Nq6+YpqYJG5NiXzVdlaVi23w0AIVknPWGb5oJIbqvIgZy7emfg8Cj4lmNtvVwPQ5r5nYdiagU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957854; c=relaxed/simple;
	bh=3mECq0JgKQxu+65FqIfg6qBb9bwB9oI7Lmlwod5ymao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkmdvrowkS3xDsLF+LrLnAoJ4/eHWCN9ASxweSXj7Xohk8Tl7AVQABXXSCOKOmJ/lTXmQ/p4XtcIhqrQEA0fXkTRt0ACkcMI6g5IqokOhE/E3JhMuu9FzMDpcXom0oJchz4Xo+e9pIrDfkOYsEf4ghDukzOmqHoNv3EbAoZrbjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gsEOBe+w; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gsEOBe+w"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7e9faea93a1so596385a34.1
        for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 08:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783957851; cv=none;
        d=google.com; s=arc-20260327;
        b=Jv/KxIQrwuwsVts+B8qwhFqx9duO56fy7lsZAFzW+B3cu5K11ZQ7tck0F7zOGFmIZg
         W5sAy7X/gsISjmW5523PyGi+ltDH6kHrSfwZASvb7X0MluAdlipibuGHf76OH4wMWA38
         laDF3Dw4f/a6wSK3HeMfmbXluW+WTuim9aHZoFFGzaBuU1cfGIIRYmf0z0PT15cg9LiF
         LdCyGezd5ib+Prh83qb34oH5Jhr+j6+5X0aK6I+nLIy4Kk1v45Bv4JTNNranA85HMsyI
         4ydjKXLswiBriZO0MiH7EyGd01JJB7t/Q71/bXjwTSqzQTy/+Ee8+gT7TDZ9vlQf1ziw
         59fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3mECq0JgKQxu+65FqIfg6qBb9bwB9oI7Lmlwod5ymao=;
        fh=mer38Gp4qowsyfVEJy/YlrisxAK35jpeCL89bOHZfCs=;
        b=icApYUfu30Npjb2TwP0LxngJdcMX8qzVpXCU9HPFvnrSs2hIab+VHeeLB/vtq5Sud8
         tdZUS6XRCpURSyxRixZqnF0bkF8GuTiNL0vgdK6AyVppuYkpfDNj2NWKlldCjC+hJoT0
         /g1PUePL+Su499dCZYPsWcDmvvlwqSP/aqWRdb2ijpyE59UHr6vAclin9N+vhvRphdJf
         i+Z7ooWklyF1aL0Ia1naBhTJoRH2vU5/H9tZGduwoKwB2LYdfbCTN5q+2H/QyBVeAK9R
         Bv4pHfLi82a3VoIQTEIcP8P+Ka/2frCc4rXJCOfIYxIPN4oGaY/2vpmqMge4ra6p1usQ
         B7+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783957851; x=1784562651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3mECq0JgKQxu+65FqIfg6qBb9bwB9oI7Lmlwod5ymao=;
        b=gsEOBe+wIyNi+N+Y3DYT3ewaeUbTGU/25iTY6t5gwTvo50Ha/Pppkph49XdFrYJ9/j
         jIIJn03KaJkTEPGJVUu4eJyLpQLoMZ9GzNknaqAxnwAidNb97l7VJlDZYEicBkYY7wm/
         8qjIZ3oM8ZbdfHr/XzyAtJRg3yjryLMaaQdsRQ0OF0LjAExZ17hXX7vbTHJDPrAslyiS
         cFzlfTyAyYqNgRevkCO5Wwx8jW8oYZ0YHAwh7ucG7Es2qWa03W8PdM406LBbEnVRWy9v
         0Pf6nIDpPfFtHXrDnazsbvgsW+RqhkyJVppRz/fA3HW7qwnX4kquonwZFL9xynJ2x/R5
         Ne0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957851; x=1784562651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mECq0JgKQxu+65FqIfg6qBb9bwB9oI7Lmlwod5ymao=;
        b=hX9Y5m5qWCksrfbAm6s2qyvMSmwQxooZ3YWaVqKCHzB4koa0CERvyofnZrtdAVZOS0
         5os1TF+VobN7lk1eIrf7pN9SiheijAnIkQlRO3X1cZ2q0EzvaTF7YPsRGGKsC8de50VG
         MiDja7sxLfWjOu69gn6XTHDaAALI9Csf2BculnHtO6ZUvmhAAM2pSg13TqdyEgbKSgHP
         b6JPkBP0O9iHrW4DEOYpCY+GNTahU9Y0xtWAVjt8wefBj8kRuolxe7Ju1nU/x4xkEvm/
         OZ0YP9mLTGaEXduj8Mnc9aez6hK3Q/snPp7PyMSZFHMz1OIbf/UONKL72ntZnA4VVrbN
         lsWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9k+4EW6SX8yWuZ1DYXGXx0k3ioV2JxP5jzwz5iFY7udCYXaSqa75DlCBdN5E/i1IdihUMmtjZKAjrMFw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Dcd7SDWSh5ZRZGWnmyZPTr5Rf3ApziE+uFla5JLMVhRLbiBE
	yLVoUnWeKgvxruWy8YChV8m50uGVFvw6z0iTH42yGa6siZo9HmA77CQUmqKwjD0vGkA1WHNM/I/
	h0t6uG5JORYWSToXxH1l39nsenIl9yfZacYhR5/yLZw==
X-Gm-Gg: AfdE7cnlqUCORLHKn7+7qwa8neOYvY89HteSznpNlh8Vt2uzwtmKzBHLXqrWRcfd+BY
	3XlFa+ixjLOsWmvtZzu1ftQe3KXzE9sqSNWuzL1CEo3kPsBRBH+iUshgT/oGfkFPv3hB68En8Cv
	NKXooF2Ey54/lIIGvk5Jrh5vhnu1BcNujZiYhvdItTWBreLm9gygIvzd7G16g/lp6xdcGHJ/HZ+
	HFIlM/LOC46Sg5bG7poj6TTYOAagBnwdfom+9HAnphYdU9W1+zvzCSNLVaHpaaLTJBf/RwgRw==
X-Received: by 2002:a05:6830:650f:b0:7e9:e702:a9d1 with SMTP id
 46e09a7af769-7ec097b58famr3955386a34.4.1783957851185; Mon, 13 Jul 2026
 08:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627054220.2174166-1-csander@purestorage.com> <yq1cxwrdgmx.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1cxwrdgmx.fsf@ca-mkp.ca.oracle.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 13 Jul 2026 08:50:39 -0700
X-Gm-Features: AUfX_mwkxpGgZJY4pVFOcqA7Ferj1yZzrVgo2oA_tVNxLSUmFMmyocci83-Ncfw
Message-ID: <CADUfDZoGyu-EWxT5tN41K24oFwu8p4mmxFRsHcDpLBoAY6Y0Yw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] block: use integrity interval instead of sector as seed
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 4:09=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Caleb,
>
> > The block integrity layer currently sets the integrity seed (initial
> > reference tag) in units of 512-byte sectors.
>
> ... because that is the fundamental addressing unit in the block layer.
>
> > However, Type 1 and Type 2 ref tags are actually in units of integrity
> > intervals.
>
> They are not in units of anything until they reach their final
> protection envelope.
>
> > On devices with integrity interval size > 512 bytes, ref tags are
> > seeded incorrectly.
>
> The bip seed is whatever the caller decides it should be. The integrity
> interval size is irrelevant. As is the destination LBA.
>
> > But REQ_OP_ZONE_APPEND operations don't have their ref tags remapped,
> > so the ref tags using units of sectors will be stored to the device.
>
> Then there's a problem with how we handle REQ_OP_ZONE_APPEND. For NVMe,
> the PIREMAP flag should address this issue by remapping the written ref
> tags based on their ultimate destination LBA.

Yes, it looks like PIREMAP should allow this to work. But Christoph
reported that ref tags weren't working correctly with
REQ_OP_ZONE_APPEND:
https://lore.kernel.org/linux-block/20260624080014.1998650-3-hch@lst.de/T/#=
u

Christoph, were you testing with an NVMe ZNS device?

Thanks,
Caleb
