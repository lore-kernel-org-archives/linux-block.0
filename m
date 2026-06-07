Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D183313E29
	for <linux-block@vger.kernel.org>; Sun,  7 Jun 2026 18:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780858225; cv=pass; b=F45XXQGiYmiYQPz3W+DZ5b9O3mBcxYJln+1MFZVnHPm3ZRBm6hMU9H5eI9Te4Mp9cy5wAXHkF1kr2GIhhB/VprySG42oVemvrQ0uCsccjzCZXwi4x3xsr+CVe1Vr+wWtltx5gvjNq8KBpmajQ/cOrw07uLLpJ0ju+V2FavC5MAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780858225; c=relaxed/simple;
	bh=enJrSkwMqMmwcpL+DS3hK+eOcN4yf95dByD1gaft9bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BnSRKE1Xgdyly8rfqKSTisK6qCCYgzjSsvEtyPMirHCt/1edpXY+9LLiehQpWsLSecbSL8Qx8RQsxWYt2pUKmZTuuAM9WP1Dr8DdRRaW1i/mVevu0GpF1jg3v5bqDlImAa/8CHgMGzjWcy/aQ9M8n6HbLcl7v/pPPfVVemSUE38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A8iqymRq; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A8iqymRq"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa68cf03bfso3557738e87.0
        for <linux-block@vger.kernel.org>; Sun, 07 Jun 2026 11:50:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780858221; cv=none;
        d=google.com; s=arc-20240605;
        b=jLQfNy1zvSnToEuvpY6sZ4XRNSFq/cjvcys6yuQiN10gEexcb8FUmXggQtSGPxmBnD
         7p050I5/3gDkP0jYTF8Js5sqaIvOh9JAxdIK0t25u4wVUICMK9mzCAMj61bOyzHImYOg
         T4kFOQ6OTM86Ir0av0skAVMSb6yvPglfJKa0no000JHmEoYLhuXEykeCpD04FcB292eT
         to5+bEGGeXrhpWy5mx9M3+nxPCL5fTi/g6Cgxr0gTGldvZ5b4vlTFtAqmqW49PJf4SjC
         CvcLo6v/f+GWoOLZXFXspIjdLPwMEArzgiyMWRvvVmTpqyT22NTzqhn0X0+Ul+NAukPC
         u69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=StevZkX+l2LssCSpRbjkHFIjHXciO8MSHo+kfSg32cE=;
        fh=dU2X2A/dk0+4XNnFOjX2iOo6Q5YIphtC+ZLBK6Hf0Ns=;
        b=cDn0krW25pQr3jmMCAlUjgFXcXTPppEp7nIv44US4ncLy1ix5wHyXIt8jAXfYGrjkE
         VSFRdV/TEfq3MVoXkiLnQykZqbS58fXtJQJsBq9DcepQl4BD5bQM7Gyxu0A/i2weqaV5
         YI9Z4adTC0WwJSzf/IHltwnokWWYGsqXnG3YtgKD6CJVWpDAjgMvFVgroGnxjB2123fX
         IjSb4PvEf5seduCPAEkVHRP6U9G3+2eyBdt3MZFXn1y+XqB0Riu6FO5J04fp49o1gx3L
         7a6148ZPN1deKol+pGSQHNCL9nx9DadFXcNeL4gR1u9BqqHqwlB2b7xqxj46f8Ov0RVo
         c8yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780858221; x=1781463021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StevZkX+l2LssCSpRbjkHFIjHXciO8MSHo+kfSg32cE=;
        b=A8iqymRqkxFkOgGi39XL3bYHOFtUHb4vAhfzYmsQ5Vbf/Lfz4jYRN58FUhR4bfcwSx
         NZuer3z/KBPLZtJiAvRYepHK9vlNl0qA/Fg+gE4FBbKbUGuS2Hz8f2Cd/zVrtHAbbzQE
         4iZp2bB7adAyYNP98zpHlwduCXMGTkQRNODhZ0+/yKVIZidCwnGtG6kFHFECjWdYqGak
         rmgcjkWAdQuFs9mZfDyr4FSHwiTOc9H9kzzineUEB70865y3yHzEMTe4a4/Dd5U4uu4x
         Xe5SJy0hu6CzXRrsTMmLuexu7buxoiYC7H1OO5EEkbXjbGSombrgT6wb8fWgCUCLYDi3
         pNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780858221; x=1781463021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=StevZkX+l2LssCSpRbjkHFIjHXciO8MSHo+kfSg32cE=;
        b=ULe9+He3IHH2HA1IwRu5Ottq0Rauxc/W4hIl70A5P1XEyU7MjH55B1/FdB/ngh/rv2
         Inva89/3NWGgMTADrZ04plVM4Es4BJ7xgH7lbx2Wcoqo+nCJiHwLTW7c0qdrCkBMOzVd
         JycO9pRCN8cFbOaMQlNALFWmr82RpM79U1fasw7CP+Dqi2Q0FVfIme17j61xZnVE1/6W
         jKibI8l5yQrn2GsE9A1AMIiHpgEbC6zz3g5BTHArgam+qi08P8NgLcC44ddQCBsiike3
         VPf5ONhMMAgvlWIt/RQ54papkJ7o7MhaqkHkmw2VmhOGwFvCoyORM3BNzCXj9MTbZg9J
         OTaQ==
X-Forwarded-Encrypted: i=1; AFNElJ8F/lSme+37mO2FZ+ZECZndev7NPurPPaZ9fJuHIs26BnFDgUBllig2jCmCtn+bLlca+H+BMiVmo4CM9Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzH12G0bVdeQZoqfA8L08MCG/n2gwyADDIsdMS6IwFTzUHQ/Kw
	iKoSsOzRW31ALuWtGleGhMoajS4hj2G8fai8bC7pudKpDcERcK3Pxmby/xqdx+1AkZSDC9AWULP
	CB9GkKThLPW5+5AjpTyeTYxNXE+ohVpXov76BoXP7mA==
X-Gm-Gg: Acq92OHKE2Z7LO+j1oL1Kcv6Mg1+G/NyiW2py7PDOp7CgoLKyDe7zqIGrj1whAC85TF
	/GT036Z5cta/6ept3g5vXPIDOjvWQS4GWjwPVoXiYRKXgnLROTsaxpB7x/4ardMa4ljBi1+tY3Z
	78EsZad/BDTOfetGmsovzZHefuYnMtZjqP26iVZIdLARi5+V6dm7Oicy7cVrDtkGNRGHUU0eQb9
	xT1SPo1yeIGsokAbm2KgnQPa2/XeW+r5RigHgju+UmfkIPzUnuzy/TXz0S95xuGwP6mK2gX7hPc
	SbbVcmjUMvs1GKpF2aP7VcNZYDqYkzzIep5ZS3CjPA/eZJ+XeEY=
X-Received: by 2002:a05:6512:3093:b0:5aa:728f:24ec with SMTP id
 2adb3069b0e04-5aa87b62b8emr3636073e87.3.1780858220642; Sun, 07 Jun 2026
 11:50:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604105347.168322-1-marco.crivellari@suse.com> <178068011170.856067.204306158214952007.b4-ty@b4>
In-Reply-To: <178068011170.856067.204306158214952007.b4-ty@b4>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Sun, 7 Jun 2026 20:50:09 +0200
X-Gm-Features: AVVi8CdBTjc-dpzpfFYaqyGqD-53y8_JEXO6VA-vB30SAeQG9iyuo8XdmAWmDNw
Message-ID: <CAAofZF4LX5O187x4Xd4bjCij0C+ST=BC-Ka2P0TMcpYng3iPcw@mail.gmail.com>
Subject: Re: [PATCH] block: Add WQ_PERCPU to alloc_workqueue users
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 7:21=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
>
> On Thu, 04 Jun 2026 12:53:47 +0200, Marco Crivellari wrote:
> > This continues the effort to refactor workqueue APIs, which began with
> > the introduction of new workqueues and a new alloc_workqueue flag in:
> >
> >    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl=
_wq")
> >    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> >
> > The refactoring is going to alter the default behavior of
> > alloc_workqueue() to be unbound by default.
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] block: Add WQ_PERCPU to alloc_workqueue users
>       commit: 7e712f292e7f01e91d09e83eb7b9526f77f66c71
>

Many thanks!

--=20

Marco Crivellari

SUSE Labs
