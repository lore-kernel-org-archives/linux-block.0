Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A2316197
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 09:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692182; cv=none; b=KTMM7Wnz5co+CBhU2aRnQW2DeqiGdXCr9OoB1TPkCHvQsqv+9klvORI07g/t8ciGDVcRC7ltjV93TlCD9Mtusy6dOORZdw2ITA04vMyb407IEn6Xh80JuXLIfxvoOEHMc/onqFjOeXLjbEuCUyNHiUyHu630eD2Etq2HNLavlus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692182; c=relaxed/simple;
	bh=2mgd3//n/wZtcFmLNUZFSqZOY+F6NSFwRBFEhdq2oLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bPg0Oe798epkDmgqwiLLtQF6sZiLrlg7afMagti2QeHg8xewjUYmmtuiFEwP4481R1Y4063ifLKyRAfipa0V9DbZldZDhHUMvmwVrG5o69+5+gWOmV3/oxzPtYphVXrO2kDQZ2j3OlVEVKktD+iFlLxTcSCbgEzoe9xnNg6XZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=RQAwVaPR; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="RQAwVaPR"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-37fd6e91990so6755581fa.3
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 01:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1767692178; x=1768296978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v+/OtRt3+dds5MB84nDKjz2f5/VwqfpS7MjK/ZI73s=;
        b=RQAwVaPRdtusSJrVmK4hqM9InrxL02x+qNC6b6R76U1/uwvhvjgPZLcWYNQSaDe+X0
         rVYhNH0rz4JxacRp7ckfJBR3+Oz27Ucg3T83IcQy1H2A7nsVdgwgg3VlKEb3E4QutEQG
         NQVKHL0W1aLxIcR1dszkvLuAXZuHrXW0NEhR/JJo8hjBvrhMWr3cKk+9GqzaM5boFzea
         chuHxv92vCm+zqs78PXqYhxGsK+Ih30WkIzuph5lq8BoKJ9/3os2apjBD38B3IdSjbzN
         MO52drTIf8/8LYNPttkdPZw/tTmlCPGls6RXJrIoTW5rlFiE+3WtjlJR4XkcnDF+iT1x
         KSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767692178; x=1768296978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3v+/OtRt3+dds5MB84nDKjz2f5/VwqfpS7MjK/ZI73s=;
        b=mSrxQHZJXPU+kkWZKLB6wSnCIaRgHkiV26eSEr+ikrIuw4PNL6MQUwCvWoz2mFYlMH
         Qv9vymNZ37V7qlLr1+5NjpGYdlVGvhHLNZoPuSHPFY5iWqDh3yZuVuBtJyaekuD+uTpd
         pJatXannVmTzSXkYDsh7JeET780jPXKhKU/5EP3ZF+kQ8E4cvFlEANr2f3XX4+i6PBT1
         eYotMXsonryn8FTP7FiAuOoHqa6Vz6VNve23PjC5DDgeWMWHJgIxr5aoci7O34Vin1hz
         kh9O8vfx0vE91ADN1KgVb9PzpmjKH0HKHtan37j6tDtJqo31bFl1uJQZWPGvcQenPkms
         TFEQ==
X-Gm-Message-State: AOJu0YzEaY5xxaGxnuvNL4t3z+UbCZGdxaN3obh1809luYWYw7XEWimr
	tLBo6lYksRdBQWHURfWmtJ1snrPLGrj0Aq/iW2WB4DNCW8//+asEafQ/Y+mxi/vcwY55zEgaS0Y
	yAltEipchuoBjdlBM35S0c8wp0Ve2Do7bmB9oEplfu6wx5D5pWOGQ
X-Gm-Gg: AY/fxX7DT78/hZiDbRsDGVaczSdQQSIwRcj9uTzatQ4X+brqQJYV0KCGDTibn5pGDm6
	KAJ1YYxgYA9U/8SFMGq4H2U44YV1zSaQs9IxAvHzG2Fv/EGx40AGNlJfPAen8AYWlFju+/YMSAU
	OOFFCK8dumAQk4q7FV5BQT5X9lwZZTMtdmkogsVE2nlxndP+TtVaGTqX0DkseKJVObIhTkeh8ed
	lCodt9OHcNtXs/KTC13YkFr0JQmQf1bOdkFIgYHc3dLLI2z+Ia8k43neHIbA39pTR8NVUs=
X-Google-Smtp-Source: AGHT+IEKtEmaL7k0fdp6X8Mrkei3cVosMtOmWYts/0ZaFgptFSRZwxWYNF61GbM0u9FH4dilx0MXiCK9yZaVRbRFGRo=
X-Received: by 2002:a2e:be86:0:b0:37f:c796:7867 with SMTP id
 38308e7fff4ca-382eaa09e04mr7625991fa.13.1767692177669; Tue, 06 Jan 2026
 01:36:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205124733.26358-1-haris.iqbal@ionos.com>
In-Reply-To: <20251205124733.26358-1-haris.iqbal@ionos.com>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Tue, 6 Jan 2026 10:36:06 +0100
X-Gm-Features: AQt7F2qodDvwqzArjBNMrw3hb83cu9ofQw5200sWYT2_05i1TbAFmLpaoVV85Uc
Message-ID: <CAJpMwyjjjpwRB7u1PKN4wR_HCwk6XB9cDFGO9S4tTrSAKFabqw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Misc patches for RNBD
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, bvanassche@acm.org, 
	jinpu.wang@ionos.com, grzegorz.prajsner@ionos.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 1:47=E2=80=AFPM Md Haris Iqbal <haris.iqbal@ionos.co=
m> wrote:
>
> Hi Jens,
>
> Please consider to include following changes for next merge window.

Gentle ping.

>
> Florian-Ewald Mueller (1):
>   rnbd-srv: Fix server side setting of bi_size for special IOs
>
> Jack Wang (1):
>   rnbd-srv: fix the trace format for flags
>
> Md Haris Iqbal (3):
>   block/rnbd-proto: Handle PREFLUSH flag properly for IOs
>   block/rnbd-proto: Check and retain the NOUNMAP flag for requests
>   rnbd-srv: Zero the rsp buffer before using it
>
> Zhu Yanjun (1):
>   block: rnbd: add .release to rnbd_dev_ktype
>
>  drivers/block/rnbd/rnbd-clt-sysfs.c |  8 +++++++
>  drivers/block/rnbd/rnbd-clt.c       | 18 ++++++++-------
>  drivers/block/rnbd/rnbd-proto.h     | 18 ++++++++++++++-
>  drivers/block/rnbd/rnbd-srv-trace.h | 22 ++----------------
>  drivers/block/rnbd/rnbd-srv.c       | 36 +++++++++++++++++++++--------
>  5 files changed, 63 insertions(+), 39 deletions(-)
>
> --
> 2.43.0
>
