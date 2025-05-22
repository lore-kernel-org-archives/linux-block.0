Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1ECC2EF
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 03:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747885314; cv=none; b=PkICKVJi/Uoc+gORXoPO0rojxwiLU4ScFmGCMWPzUwPzwihmy+xky/vIQOb446JD2qf4uLHt+65ehxtSLBp8OBxgUtsbGFOvA+zqZNA36bu4uewIjbu2isPr5kBBjp76y4rpQH8Xt/vR/HaYZYHeTdel/VvROpMyi5GRuyJ8W4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747885314; c=relaxed/simple;
	bh=HBScnbgXfYg1npgwMt1RM7LKDOWbnQ9o/suv1Pq/r6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLrj75np+pGvYp9W4oIu4ETXB4VRZUACDyPhqDMmgAxH86fXM9mSjEMM+f3KPqVmkAeozh6fgoERTuQVDWpFBaqqSKk3UKJLbPybKJirLBR6aluK+K/pJ97OTFqeADN1ZqSevXFSMjWGiEC3fKNzPoO4Ipq7MVaxggt6eigopmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=RQXhAk8B; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="RQXhAk8B"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30e7ee5fe74so1197976a91.3
        for <linux-block@vger.kernel.org>; Wed, 21 May 2025 20:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747885312; x=1748490112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBScnbgXfYg1npgwMt1RM7LKDOWbnQ9o/suv1Pq/r6w=;
        b=RQXhAk8Bup5Twg6bUzIkXgI2xzeHChmqOb+kSt8gffcBmaa9iFH7IN+bByyFjHqkSQ
         CtthLXek9a2pLM1nXVW3iZW+HlGIhoMWJW8XDj35fAyMznlNl5hs/vY39sYRCL8Q/SgU
         7J/jh9SoKmBRrhqxsYpZvT8MwOUFLA0+r80Q2hODYVnmZgzPI+JpGVg7GrAsdxK6BD/e
         ItyigyO11AAT6SXzk961wax9ZSA5Rwugx/8hamlRgAgWLnPLZT6dOZIhMt7ijDj3WoVI
         pdSRnM889+SnmerRLIJ+CP1OYbNwnqZWRed8R4hEIG8xz25cepyw2yz01NAvudy5THHz
         ENbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747885312; x=1748490112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBScnbgXfYg1npgwMt1RM7LKDOWbnQ9o/suv1Pq/r6w=;
        b=Lgn7ntfM0KRbfxG60uyf7l0nC1j0bPBG2USmjMEYyCdhzY+2bb7cnTKWOp66J42Ptn
         JEtMhXW6oZoxTnKzuJ3K/J/Jw6w01Bp91IF1l6WA8K+YHClexj13anW+snVFDzZFTkpE
         AEIvbdiUDeWAiLLraAe/H36H31xu4Wn1FFed+oFEupy/6RfIZqDOv9k/igGUm1EpzlF3
         iSoRzFuYBH9OIsb6QPJKVkz/vRf1xG/KkG1mlhqfT0oL32YYern+w96ac/DHBKkjsVZP
         Fs9UHopIj40hkUCjzWY5Hh/KVFMV/qE7QENK8LVAAEL0f7JvuastQVkpD7pSZaqgj9mZ
         1XGg==
X-Forwarded-Encrypted: i=1; AJvYcCVRlMiD2uoPPe3IPg3WXNUNuvS/Tnd/n9/jhRDyKaJ4OkmT11l7SETDtguvw8Zxv5kEYma3/DCPyn4Zaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDEFmPd/OqoC2GbkbH4QfDKghDxGMo2vBNWgDmNfLMMpY34TWE
	mvA3i0NVd9Pk5aUOWB/QSZ6dLqTUbYVeXxh9BdAjKj73bgRzAu79gAY1G/2XDMcEbsPYE8pbHVS
	jD4GbOFDvUJsyqNAi8T0AkL3D//jLnINhzOh7PO6ZBA==
X-Gm-Gg: ASbGncuUYC6huqi/1Y1Kv9PNVYrtXIw9eH+OqenX/Qg0L6yJKyI2yqsfLqi31zb7RVM
	WPSHeitFgCC+GQbGdd9lXh3vLBYUhRd40ZGGc10CAavRohlBWQzfpsvser0oHclprIsCKFOgSN7
	bA0TdhfgxFRFw66zguHN08LdtuoKedUik=
X-Google-Smtp-Source: AGHT+IGda+5bq83C2vCx6Qhv8W1Rt9AFozwlZQHFi8YdLSvUxrGZKF3CwqMWcxGA9bKJgBLgVx39dE+l/sNjWXxBNn8=
X-Received: by 2002:a17:902:d54c:b0:224:10a2:cad1 with SMTP id
 d9443c01a7336-231d45168bcmr132689515ad.10.1747885311779; Wed, 21 May 2025
 20:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521223107.709131-1-kbusch@meta.com> <20250521223107.709131-4-kbusch@meta.com>
 <CADUfDZqVeaR=15drRFvdrgGyFhyQ=FtscaZycVrQ0pd-PGei=A@mail.gmail.com>
 <CADUfDZqC0kiLTDFv3kXNaDr25rb+6RGG3cW3r=mox2vdihpsow@mail.gmail.com> <aC6Ymfrn1cZablbE@kbusch-mbp>
In-Reply-To: <aC6Ymfrn1cZablbE@kbusch-mbp>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 21 May 2025 20:41:40 -0700
X-Gm-Features: AX0GCFsQfzu0SNWx-sq1Kg89QEuY68BuwaPPePwdWhEJwqQoCBv44eCGmxTu4u8
Message-ID: <CADUfDZr8DJUPhLvVFK9OPSv015VDSBGNv7z_rrioHFAqOALUOg@mail.gmail.com>
Subject: Re: [PATCH 3/5] nvme: add support for copy offload
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 8:23=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Wed, May 21, 2025 at 05:51:03PM -0700, Caleb Sander Mateos wrote:
> > On Wed, May 21, 2025 at 5:47=E2=80=AFPM Caleb Sander Mateos
> > >
> > > alloc_size should be sizeof(*range) * i? Otherwise this exceeds the
> > > amount of data used by the Copy command, which not all controllers
> > > support (see bit LLDTS of SGLS in the Identify Controller data
> > > structure). We have seen the same behavior with Dataset Management
> > > (always specifying 4 KB of data), which also passes the maximum size
> > > of the allocation to bvec_set_virt().
> >
> > I see that was added in commit 530436c45ef2e ("nvme: Discard
> > workaround for non-conformant devices"). I would rather wait for
> > evidence of non-conformant devices supporting Copy before implementing
> > the same spec-noncompliant workaround. It could be a quirk if
> > necessary.
>
> Right, that's exactly why I didn't bother allocating tighter to what the
> command actually needs. The number of devices that would have needed a
> DSM quirk for the full 4k was untenable, so making the quirk behavior
> the default was a sane compromise. I suppose Copy is a more enterprisey
> feature in comparison, so maybe we can count on devices doing dma
> correctly?

For the record, that change broke Linux hosts sending DSM commands to
our NVMe controller, which was validating that the SGL length exactly
matches the number of data bytes implied by the command. I'm sure
we're in the minority of NVMe controller vendors in aggressively
validating the NVMe command parameters, but it was unfortunate to
discover this change in Linux's behavior. We have since relaxed the
validation on the controller, so we wouldn't reject these Copy
commands. But the extra data in the NVMe command is still wasteful for
transports like NVMe/TCP in-capsule data where the entire data is
unconditionally transferred to the controller.
It would be great to start with a presumption of spec compliance. But
by all means, if we find a significant fraction of controller
implementations can't tolerate a sub-page data buffer, we can apply
the workaround from DSM.

Best,
Caleb
