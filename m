Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F7F38F94F
	for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014093; cv=pass; b=VGfaTpK0YfwOWaTk61Mor+EgpSxfNwpFPNXy6hKtH2e20mN48k6rWqQmzrrklQtp7HrMG/wPRb4vPsd0lSKjZfcheQJWVw87t3Q/sQ3jR+JpJo6QaJgS51H7YDHd2uGvZN44eQYZO1Doqnfn/Msqbq+bD6JPjopK9XjqRgDa4Lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014093; c=relaxed/simple;
	bh=P+nn7GxNNTTR4z83VRm4nDPbYz8l5IDhZ9xoBNCdUfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWWL+r636/GQ7zdUdpDy5ed7fClkIUpt7H3808kmorXEkrM54PfRAAX3W84G04LMGFmY+DIFKqcGCBdt1OiBXs591n4PcvnU15JJU35j0SlxQSs2EW60S0RqQ16F2wlFUaj+jMtIsHTkIC5M2UaC7FTJZNH2V0Iu+S1+SzL1TNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=EHUjEWbA; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="EHUjEWbA"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38707d4c8b9so75244181fa.2
        for <linux-block@vger.kernel.org>; Wed, 25 Feb 2026 02:08:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772014090; cv=none;
        d=google.com; s=arc-20240605;
        b=EbdtXaICSUQ6aXW9NBA0i3HWOIAsXBOAe7XwkLklYnzO6Pavj4mHPgMT0t7KEY/1o7
         1drsMKrVmR3WvNLWoOUlkdsEwIepoYIIvYUPqn5+Ugw6wxGCCUT34o+cocUAI41vtsrF
         gny5kFjEyOTR/JVcFgzSS3hDUqwNxtWbmHAkJAc9dGPi8EB7ykk/l8Y+CW3p84Mpd2GP
         4feYlAkxHD2df/xOdAB18/0M2LBJ4tBqx6/P3R90zZQR24D3w9qbwpv8i64gHMiEgW38
         Q3VGp6FvYcy8+vVhgjJs6+YyHqmzT7YvYu9BoFKql/HW2RAuQt8ybv07ee21mYb0V1cI
         VL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P+nn7GxNNTTR4z83VRm4nDPbYz8l5IDhZ9xoBNCdUfk=;
        fh=qX60OB6vfOiu3xb9OJ0zZmCnRE4W2253cpE2BRzARo0=;
        b=X27UWif65WxDnLKnP7zP+0dENb9oqMEgDVP8My5jY9mDfqB5wz5gQ2WL22fFNV036+
         YU1Leynwgi3aPvihIVOL0m1y2ma6FWXr0YjOV1+mlqFI7GYjxVYjg4CEtKJec81/Hp+F
         CYPzWiKWZyGzlqDXOlBQT7cs2t5fNXZBxew/3oI79sYFLMDO0781QAMLSaxLxaQzjoec
         Uw10c93unjj/r2r6hYstVEZ7mPfnEdvZRclVGmPxUAE6JaT/ChpPf55JlEnQnpkC9cxc
         Y6YlPHAzrHolJL0Z9Kn5H34lxV/iUS1XxDxc4DhDToKbHKSt/cVaS5iSe1lyKFbClPBS
         kMxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1772014090; x=1772618890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+nn7GxNNTTR4z83VRm4nDPbYz8l5IDhZ9xoBNCdUfk=;
        b=EHUjEWbAmES8Sf83245PgtIM8NbuFiFAiI2agIi42ooPvjuPeMZUkyJ6AL1iZlIuM9
         RxbLTm1ut57NfxMO9zTSXN9FCCWRkA2iprpqJrHj+T1WdSbxDVmZ4XfSBZnj2U/yT7TJ
         70SmgInM23E8fCP/TeHF0vozWxBM7MBDmTghms4xq3LLRV9kBG5cVy8eCeZHQM1Cz3EB
         LaMbglT25bSg/I9OZKB72d8o68aD/Zy/MxbNxHTXTCFS3Ltf191tavlga03a25E31ZKm
         vkIn+7uBgHpOEiNYN2ZRKMzWMdHJj1vtC3uUg/TtA/+Ik/urSZ7Wr1RVDn0C+0NqcAU2
         UcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014090; x=1772618890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P+nn7GxNNTTR4z83VRm4nDPbYz8l5IDhZ9xoBNCdUfk=;
        b=vGWw9Em7SKYTHST6xUTKSv0MvbgnldllBWdEGBPv8wP8f1Ou17I2XqxHEJXJxda3L+
         +xIIGNL+qffGIsqOGI83PWINvtftk8sitVZrrPooBKI2lC5/6bkFrjPlmc1ucgm3XkRV
         U9enD4Ze/Ac9i+3VmZ+imyk4FSyPsql0GI0iV+4S+oo/vfE7Blpt+Rcj/T/ARU/Bdgxf
         HWuKhWYgjbSrK9NKhzuT9TjcmlJGaYJmFhZV5YqYOmbFKKkjrImnWPe4f6qhVxoNwfqU
         UlQxJWccJJwXTerQ1XSSPtHKzYw57YA0LT/cD27URJzGPAZnyTI11LkCDBRFxZhPwO+O
         1wxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG9ZOqZt3tGtOFvXAZZSybBKpF2kRebthH2PPQr4JxDQaMWLEuswrhrrRk84NrTN6NxO7uL1AviGOsBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0m01xj+yqg/dxPb6NJFBDstbl8W9sr5IOonJHoRUovBx41OYa
	avNa1a/eQnLsudDiAnIEUeh84FrVDvj8kuMuZgdkigw6lUNovl1316pEGB6pOW+UUA5UqqxzjZL
	o6/UCNWMQDh/NIsLkjOrD8vGAw1lBil2pDsIP11THhA==
X-Gm-Gg: ATEYQzynZSkudY9lyhMjcXwN1icO5E7VvKtmHXmCDXZeUjsZ9Oz6YMNWzM5NcwgUrg/
	ixc2c/RsbQ1RE67Gn6DpF9X5RCGHbw0JuEQY3hPnu0knp8b2M6mgJ/VqiMMmAGbJmYU3h37E0aN
	gtLgTa+Ye8KLQRyHFncylhBJgvX7FLxAuvAy15lCU7b1lMJ69E10HoXeincn7AhiWZlkhmhztl2
	MaispfKfOvdgKlpQevPy2gFVhr4Zkxb/PMSs2ao1trIAXuNsk4aqpD4klxGbfSoIP+Mgif4uxgP
	4HUA1DclZ510d9g4exxphNQe54f3hbW+G2NHbgA6S/MTV0S0iIUT7gpgTm8ctnA0CFxT
X-Received: by 2002:a05:651c:324e:b0:387:421c:3cc with SMTP id
 38308e7fff4ca-389e2bb0ca7mr6069021fa.16.1772014089948; Wed, 25 Feb 2026
 02:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local> <aY77ogf5nATlJUg_@shinmob>
 <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com> <40edeeec-dbc3-4aef-ac86-691e1ed2ed06@acm.org>
In-Reply-To: <40edeeec-dbc3-4aef-ac86-691e1ed2ed06@acm.org>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Wed, 25 Feb 2026 11:07:58 +0100
X-Gm-Features: AaiRm53Zv-ldie7aCzcsDbQaCCWr2F8I9cWxTChkMF5C5q2noC0qJ-esR5e6yic
Message-ID: <CAJpMwygzTcBnKVp=bJWZpW9X5JdcP9Lj4H1BRBu2bNV_kGyDQQ@mail.gmail.com>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
To: Bart Van Assche <bvanassche@acm.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Daniel Wagner <dwagner@suse.de>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu" <tytso@mit.edu>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Christian Brauner <brauner@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
	"willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz" <vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 6:08=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 2/15/26 1:18 PM, Haris Iqbal wrote:
> > A possible feature for blktest could be integration with something
> > like virtme-ng.
> > Running on VM can be versatile and fast. The run can be made parallel
> > too, by spawning multiple VMs simultaneously.
> Hmm ... this probably would break tests that measure performance and
> also tests that modify data or reservations of a physical storage
> device.

Performance related tests can be skipped when running in a virtual environm=
ent.
Regarding data modification, if the tests do not involve any crash or
reboot, then the VMs can be started in "snapshot" mode. This gives a
number of advantages.
a) Data modifications will not persist once the VM is shut down. This
means the disk will be clean for the next test cycle.
b) Using just a single set of qcow files, one can bring up any number
of VMs in snapshot mode. The data written while the VM is running can
be safely read/modified, but it disappears after a reboot.

>
> Bart.
