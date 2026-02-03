Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89903318EF7
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118129; cv=pass; b=gmTcQvq6RQ3mUChkiNdarmP/KntWJTOwLHMOMy43Lr/YFxuxqTZOaD2CMpPhyOhSD9Nb8+HImp30GD0O+AxZbWsZwSSjrYFTRNk+ONk05zogXhx8CeswnTda98KkidgcdXrLrT5eZctEFv6+fgW5HCq4fpSvc67Xfy8/KG1WoHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118129; c=relaxed/simple;
	bh=qO+VlD+Dcupkb73nS8UCEQFWzgnN1lvwsftTUEtez+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H503yBPXs6sq3R/t4dazK+O2tO37rmNmjqsM3cFZH4ofV7+GijRCcK0KwjNc0XZonCpHM4FOIKtuO+JLFuOmZ4dpvcY6fqSmJ0epE8+nc9f9K9JOHfm7YbCHNi4frc4Ykit8/2jgMkjbXCUY1fmd01Pxh0uVcOmPTjbvjrBZsfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PxexWSC0; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxexWSC0"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59deec3d8dcso7228868e87.3
        for <linux-block@vger.kernel.org>; Tue, 03 Feb 2026 03:28:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770118126; cv=none;
        d=google.com; s=arc-20240605;
        b=fKwcR5RjoyVOC47lCfRAs96Fr3PgmYvFNOqTonk2xrJEji7FzgH+f7hFiQxKEe1qre
         sclN3xBwfAW4ycyJuUwqQCV0PjtOwcjFgvw6QUGUAFimGD13ox5zraRDI9apORwxWlwC
         ZLD2L5E/eQQgGnX5hCaazJJzT0Hva6Ym93E+6q3m8TWiLUzccQx/HI3F33FQ9Gtue+Ui
         hsfDERhhBQ89dqoMk6YygitcctOfWC7sGhshPSOXYLzhV9m0yveix4Ndu3v2Y7Y/pd58
         FiP+NrKv9w/nyUUn8WJdFdPSLdtQN/xQcPh1EaP/+c8YG/hd79tX7vB+mQW92O+fAwiV
         QvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2L7+eW6U0AtkWvkzxuzbmoQAqsnrr/k4qm/FKd2Usd4=;
        fh=mGxmtm/qDGeQFsauPqiuKhG/dh2sZ8FxhjIWzo0pJh8=;
        b=T40Ce/CZy8zfdDRsDeAdbNooLkiUruxjcZh/6gr+hSNx3vZ50cFTyNj24f01jNwSYh
         Myq4PmswXUKEE0nnqjBRyoRHh6xrpg3dPZmXKbNPtIxSge/XmPhBBhEZIfpohxywm11D
         JB7cEgCaIbDKji/wqoffixrbeED5ZKPM79vXVEXBL3BQtgtL+SwpbL1tCaP3xOilR1az
         xuxJkCoYPJLQxn1LXYG0/UI0J/EQWi4zcRdHIb4zRctAyIA+0IZNsWd2kr5icJeGY5Y4
         WiBLwtxf6raveV/xQIbk4pGNystw+oz7eJU5JKwpqfvUqADN670XeWWTMTun1dNajUGX
         pYWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770118126; x=1770722926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2L7+eW6U0AtkWvkzxuzbmoQAqsnrr/k4qm/FKd2Usd4=;
        b=PxexWSC0/z13MDyCyRh0UGS9AL22QN0LYJiYvDs9P0ASJOX9GkNLomJHrS6CXIEsEC
         22fQBN2EpAhj5vKNoQMRyYEnJqMXXjEWCnUissedyY00Ptt8O2gIjuxMy8Z8AQfQlt9m
         w3a21q6Wq6KUqrJPKe057V8tGv+SUQRh1U3x8KDapVG/Byi5muUJBIDO6YVlD0HXsdtu
         uUz71tYEuCSeVu+S/BzTfbAiRRLc4He97jvIx5VMBkFmBpa1+VXPgYXCGn8F4hTNPDg3
         1Ciu+ML3EPbzA4MpiGj6I9Wcjb3WVH+L/FEkoP2wqHPPD8Z5CYc1irPOXNW3NZhzl1VT
         6jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770118126; x=1770722926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2L7+eW6U0AtkWvkzxuzbmoQAqsnrr/k4qm/FKd2Usd4=;
        b=SBc3HNaPlHIPSSULBwZd8fBrVOqgUb1TtW0/dRebiM/vd7GZWO8X/oRdy4YKJtcGcq
         ZD9g/4Hkdjkr1S5p+mI0eHIEQ0516+fp+UvRXHT7MNOaHIrrhdNQf0tbe1WAulFAlcyv
         FwJ8M/cQmt3aAjIvfsKQldHReGxlqmTF34lodmltw4JPFUDyKDLzAF27Ek8/LdM1DTz5
         DNCp/9Z+03zyp0kYr9levlGuuoUTvWNUO2kcZTWBjqfbnv3Y9nsn23kzTOPuFhw5tcAx
         hRzX1e9Pl+/HpZ5Z/1xEBZUH3x2jEpzh1DmFofcGTfzs//0tWGwU232FD53yCeUWnShJ
         jBRw==
X-Forwarded-Encrypted: i=1; AJvYcCVZyiXnmcxcqkEWHmLpW4wW6F5Ffd0yu7YntHUiQU7DFMmCA+N9rHWEcSRboaS7lSioGIaDG8p/B5OUhw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw077S+pIarUEwkE4LctABp1BLalAoBEcAj2lhB+hT1fcO8umr3
	Iik1BKgS3B4H6QigPv8VQkBjyWeHITdudbfTO8cGKl9qWglG5Wi2zIKMGr8GTu7T2gLtFYhvf05
	krHbnDfZKtmkcTbuYQUsvWaa+X0RIEcUqjuxMq6Q/rg==
X-Gm-Gg: AZuq6aIwDyvaOwbm9XzvDEd8LWiJo5UOopiitRAuyw3tFLXZ+p8fkFZGra220Z9WRnf
	jhOpnstgyfk1zODfXrgSHG0McOXbOPz52gByoKVyM3z4akVo5OhYD8zp96vNWdZGBKLpVmIjE8V
	yQlEt6+iaJsx05yDZRvbng82HtSt1eJx/DXMtc1DB6kc3T1bcHT/p2ASA3iylh536ZIWeP6ocD2
	R3Wc8hGJN5B1vniQM4xPYB+G0pDQMeU6SSIqbpX0/gxloyVOoo3mKdE7z9NcP7rYnOUVkKZ
X-Received: by 2002:ac2:4c52:0:b0:59e:340:e557 with SMTP id
 2adb3069b0e04-59e1640219bmr5409741e87.19.1770118125586; Tue, 03 Feb 2026
 03:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev>
 <CAPDyKFrGpvjONrDmnNZXv+SME_NCNv-LK8J-Vo88RSz1fuD7rg@mail.gmail.com>
 <787171c6-0b9c-400b-8a95-b331b58e284c@linux.dev> <4777aabd-bc9e-4904-9444-892393aecb15@linux.dev>
 <9e362d5fa2604fb0848ea28866dc45fc@realtek.com> <47ed09fc-047b-4f98-8df3-d11d17678c57@linux.dev>
 <380f75c7adc04cbab38cfd2f82bd0c6d@realtek.com> <d46dcebe-ca58-44c4-87ee-cade2e478572@linux.dev>
 <4205fde06ecd4a7489b03ef25e5e4011@realtek.com> <CAPDyKFoC-dwzcsABNy9pA=GGirBWwcxQhNMeTSSStXHtXmWbcg@mail.gmail.com>
 <0b6fd99b-54a6-45f1-942e-94f707f2fbf5@acm.org> <CAPDyKFqic-rFe95g657MdZHtdPXTmFmYQG4ZSBV56S3DhMEF-A@mail.gmail.com>
 <dc1ac2e5-1db1-49b5-847d-a10a611027ae@acm.org>
In-Reply-To: <dc1ac2e5-1db1-49b5-847d-a10a611027ae@acm.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Feb 2026 12:28:09 +0100
X-Gm-Features: AZwV_Qh3Fj46ISod4rA7hznVA1UsJLGD934Xsv1krBb6KpsuNXejyDCjwAzQWJ0
Message-ID: <CAPDyKFrNHc4FexuTbdWM-Kvo0mn9C51nJN5b=e0jZR8miFho+g@mail.gmail.com>
Subject: Re: [BUG] - Short freezes in gameplay due to MMC_CAP_AGGRESSIVE_PM on
 RTS525A card reader
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Ricky WU <ricky_wu@realtek.com>, 
	Matthew Schwartz <matthew.schwartz@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Feb 2026 at 23:47, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 1/29/26 8:30 AM, Ulf Hansson wrote:
> > Seems reasonable to me, but how do we distinguish that it's a
> > battery-powered device?
>
> RPM can be enabled or disabled from the scripts executed during boot.
> At build time it should be known whether or not the device is battery-
> powered.

Okay, so user space needs to make a decision, no matter what.

The point here from my side, is that the default behaviour differs
(RPM suspend may be allowed at boot - or not), based on the storage
subsystem in charge of the device.

I wonder if it would make sense to try to align the behaviour to
common default, between the subsystems that have enabled support RPM.
Or maybe it's just too late for that.

>
> > Are we considering UFS a technology that is used solely for
> > battery-powered devices or is there something else we consider?
>
> I think there are devices that use UFS and that are not battery-powered,
> e.g. smart TVs.
>
> > Although, a tricky part when moving it upwards into the more common
> > layers, is that those latency constraint values may have a very
> > different impact, as the numbers are platform specific, right?
>
>  From the UFS driver:
>
> cpu_latency_qos_update_request(&hba->pm_qos_req, on ?
>                                 0 : PM_QOS_DEFAULT_VALUE);
>
> In other words, if no block I/O is ongoing the CPU latency is set to
> PM_QOS_DEFAULT_VALUE (-1 or no constraint) and if block I/O is ongoing
> the maximum CPU latency is set to 0 (no CPU power savings allowed). I
> think these parameters are independent of the platform and storage
> device :-)

I see, thanks for sharing the details! :-)

I guess the question then is, do we always want zero latency, which I
assume must be costly from a power savings point of view. At least
during the idle period, while not serving I/O and waiting for the
device to be runtime suspended.

Kind regards
Uffe
