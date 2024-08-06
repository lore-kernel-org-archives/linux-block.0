Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67D170A3A
	for <linux-block@vger.kernel.org>; Tue,  6 Aug 2024 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722977974; cv=none; b=qvPLl7sGqqTY56fNV7nNvRCAnYvmveuHzledyBW6Spb/MemqUnp28jLgp+KaZOvmLD0XN7wviphDSJcgJzfyi5NghKvTLgdbp8FTmqk57H+FO6Pntmf0dNTej7Z7T3DQrT/t0uH51ocWwK3DY/TLXQ55e4sTLtJ7zoeHE1e9wXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722977974; c=relaxed/simple;
	bh=qyUz9Qqv5k5SudOvCxQPX4RBki5RQXyIqfhgrvWKdyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjSUaT/CRBqs1986reTQIKiJs7ukoVRmnNAvCl6skQ3PLNFllXX+lj+thvHjYzTUuOgTqK7s1+u9/uJvKPefdUdRGCL89uK2dp2wpr8aD/ljpttaQ8Vk4Gctuu6D/AyGNOWLV/fPPNql61U71yEXGc/v9xFzKKsvzosl3lGozJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Eb3sUuf/; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Eb3sUuf/"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-654cf0a069eso11410767b3.1
        for <linux-block@vger.kernel.org>; Tue, 06 Aug 2024 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722977971; x=1723582771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqRA/CX/CVDKRMnMKUkE7btXGpws1I/eaVA/YpB62Hc=;
        b=Eb3sUuf/v0kca+XnoKJZRiENpb45DUPlfGi6IMf13qoSoLYimi3mbIv6qhH8hOEh8A
         mtVov7Lo2+nWdrAHGka9zLYVA1Sjmjb3AcjWwDADP1msPFly37oB04+MJAo54CujViTu
         a1vCj3WAE+S3ZIjyJgFSjCbqF+44/OIo599KJgBo80TX+cbW1YJaofC74vUrXxBHwvc3
         sFE1L/cMDbIe99kU4N5IUeNp9/6xTDjzSbnrqVs0378SkaDdfLa0lvtM6stQdlKdcDlN
         DrmYuETjc7TuhIltjqm90BxNzaWLUuccUumCJk4/JR+ilZrg3hf3VdnUc5ty8V2xUoWk
         yVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722977971; x=1723582771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqRA/CX/CVDKRMnMKUkE7btXGpws1I/eaVA/YpB62Hc=;
        b=RJ2nyuF4M1ozkde7KN0eFR6suva4HSBwIUlI4lX34idFQ1/fHH5vF8GGkll5Ruo+kP
         2c9i6onmTXvPDnrwO5mlfBFYPoLCgsdUtDW1RqC2f0kFbok5QtT5Mw6x/6U6fXi4y1Jt
         qtUdQ7oXxpezBpqPoBGDaaLYK3waIheG+tMTZQgAaIcvZMJ8Df9y6Rfg+K2YNKcUTi9H
         TZDEn6uK4cW8EB9/E20yDd9yC9/IPgSAhvcFf2/uc0EwjFY0XAiJkXudu3kab12vsL+d
         kFcL53VmcUc1rz/DaNxRFi2hLnyffUTR6cfCIZxl3Jw2w5fna2DlUNBKXzWoQEOHjgnY
         9M4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWs6Ei0Co35762N8x/zX+5kEfRyADf6USmEM1VNKzE/ISEeBzFVxMLV9p3yQyFqS3Bc8TSCIdfaD7gmB9BHJffmnwrhWxQcOw25Ibw=
X-Gm-Message-State: AOJu0YzPuhGBBVhc+tN7trp9iakB7zYIoJm08ezENWW1INMG0hn221yG
	/qS7a9CdeDL28TtFQoT757jEx2nsRTqovu3dHF+fhcNgqM/C4fhLaUAQEUcSnSo+AzxYVVRSrSa
	fRBHXpeNKXZCsKVTuL+h4P6MtTT+pab3NPAq+
X-Google-Smtp-Source: AGHT+IG+g9ZPIj3c+gMV8h9nbV6S0gFWlT866BH5MDCEFMia55H31Vc+W1m/exuwqdaE7fTnf6/iUgbwZyFG5W1FJkM=
X-Received: by 2002:a05:6902:15c5:b0:e0b:e2ed:b6c9 with SMTP id
 3f1490d57ef6-e0be2edba28mr17255194276.9.1722977971481; Tue, 06 Aug 2024
 13:59:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Aug 2024 16:59:20 -0400
Message-ID: <CAHC9VhQ3LobZks+JtcmOxiDH1_kbjXq3ao8th4V_VXO8VAh6YA@mail.gmail.com>
Subject: Re: [PATCH v20 00/20] Integrity Policy Enforcement LSM (IPE)
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, 
	tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, 
	snitzer@kernel.org, mpatocka@redhat.com, eparis@redhat.com, 
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 3, 2024 at 2:08=E2=80=AFAM Fan Wu <wufan@linux.microsoft.com> w=
rote:
>
> IPE is a Linux Security Module that takes a complementary approach to
> access control. Unlike traditional access control mechanisms that rely on
> labels and paths for decision-making, IPE focuses on the immutable securi=
ty
> properties inherent to system components. These properties are fundamenta=
l
> attributes or features of a system component that cannot be altered,
> ensuring a consistent and reliable basis for security decisions.
>
> ...

There was some minor merge fuzz, a handful of overly long lines in the
comments, and some subject lines that needed some minor tweaking but
overall I think this looks good.  I only see one thing holding me back
from merging this into the LSM tree: an updated ACK from the
device-mapper folks; if we can get that within the next week or two
that would be great.

--=20
paul-moore.com
