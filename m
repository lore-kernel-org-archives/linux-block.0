Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757F52E414
	for <linux-block@vger.kernel.org>; Mon, 20 Apr 2026 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776690727; cv=none; b=ibExbIUQr4Qf2q8zNsH0HUbdlOiA/yFtA+u/5o/o4cYTwFS4JMHYJLJIxrvE5S0+bED1p8v4V/jR6Eywo0Z4xhRKm14fOsAAFSNXbdOrd6YpxAWPjeQ6uSTLhJpiM7h/wabXqNCh1xvR3lXlnYs6Dp4In4Pqw+wQc3fnCXEyOi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776690727; c=relaxed/simple;
	bh=unTlZmvymtrAosC1gc38VchUcqWpH3KjnweqTsHal+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOzKkDZr3whwP+keyZyqOmg9yLUrHbNwVMBYw0GyBEChzldnXvqz1G5MlHCqOIGdRZ3YlKm4/4fpr5qDpGKx1F+c0opSRBmb7lvvEGfX2nAXhgddcAFLj6kJ1BF51Bn6b3iMuaJBy8/cXYCkVYa0LCbEql7ZFApRcXKqcuCFafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UShMC9sP; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UShMC9sP"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43fe62837baso1810224f8f.3
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2026 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776690725; x=1777295525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CD9/SaQbaCJB7OvL/7Y9DGnFoX5Sh5QHuy91IeKetc0=;
        b=UShMC9sPKIXAABkt2mxYVW3M3DS441d3L8BNgNeqUm8wTqC5qurMYG1DGn//6WVfuw
         gKhEL5iwKPVEjK4R+/+OpdX1Nj5vw4jVwusZ+SIHuJj3z+jsezJJjs3pNgUz/+LyqIlN
         XfszX3TksYhJpeLydcJUbnh8TbkHOIHZ14fkcq2UXA3qGE3MeRvOIrzAzGHU39uzKtjw
         kg6a0Oy+QGLODZIbK02gStk7xI9QGC9AhL5rPl+hRBfOCfIWYgq7PmZkzBTPhRSTlozZ
         RCdHPtmh7cFllmFCOdtrZflqEtcZCOEzuvoeJA4kbDDVwARqzqIlN1gMoauTc+tJ59QT
         Ftpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776690725; x=1777295525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CD9/SaQbaCJB7OvL/7Y9DGnFoX5Sh5QHuy91IeKetc0=;
        b=I2MrlAdz6QZOkPZa6/xQmjL7WB/uYKHgpXvBYoqHLtejjgHn/oTdujTS0/mX8Ceaze
         8aNGxiLikpoZ3U77MuIHBVDNUP2rImWU5kCCuyShNWbHDoaoLFF2IVox0hLxERPF2kHJ
         RYoVRyzT7PMn3XIgMfznb3efQfCMJ3Wa74sbZkIAXDCXzy2VeO6I2mR239jA5ORaSzXH
         Ge/76OiuTxzbQyTFHvHlXGbVwBBEai6vi+Zebg811VJDhO8IEB7V0cossH/iURVIDmoZ
         vBc6u0NauxfSvIy4tk6+RyQobtvEc2ilf3xNpti2puV4DwIqwQyE3YdoH07o81f4SO0M
         gAuw==
X-Forwarded-Encrypted: i=1; AFNElJ/sM91f1fXpefoJwflMyAI8W/6IlKmvRz2kBTlaahhPUEKeTRQqT0KPphOJg+NDGmTyri66EqaMXABAZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAUUk3qYB2plOygLy2IYmbZYlyjECdGhizbBPujCrTCjKtOst7
	rdAhuBEm/EgumrUoKz8kOwli+JBSfH7LPrB7P7H0B7lF57G4KhEC9Sh+K9vs/lfyt/Y=
X-Gm-Gg: AeBDievOpOiEuF0nJwy6d9HFjKiOBBH7fEZXYPADOOdPlseuS/0W1a/bUtRa54lNIz0
	vKNxN2bD586UsdKJoUNAJy6IzV9pyM1JjauRHL3yS3nSM/RnfHk2jEroUYwTV9X2P/IzfuVko05
	+kdvi4PxqgVMFa998YS+SEAD65GzjBcn+BcBP85gMt/YnAPudxlcPZhTgj4xf2SsTMC6XLxaRoL
	BI37PqlotTKe3AJBDJw3TEUOkKc/wiFYP+WFAL4qB9QIqXv/ET0DTVtmxAAiZGy5sjoXawIVx5P
	aAsqtEbhtWszBddsHV89Gyy4RPICYFJAC/6tXkOlofl0W1AOvoAdRXV5+PMWSIAel86KexKguQL
	sGBJFGlrZzqwRniLFageguapOMcp3OFggnXMNqCQzVM5oLfte6AuBA1hXqEHeMwkTmLmdoBrPll
	l2x3tHG+VLm847k+Fft/Y+7Il27ekME2K3LwHPW8AgOnUtArUYlQ==
X-Received: by 2002:a05:6000:25c4:b0:43c:f52b:8003 with SMTP id ffacd0b85a97d-43fe3dfd332mr19870492f8f.36.1776690724775;
        Mon, 20 Apr 2026 06:12:04 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d112sm32580385f8f.29.2026.04.20.06.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 06:12:03 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: atomlin@atomlin.com
Cc: James.Bottomley@HansenPartnership.com,
	MPT-FusionLinux.pdl@broadcom.com,
	aacraid@microsemi.com,
	akpm@linux-foundation.org,
	axboe@kernel.dk,
	bigeasy@linutronix.de,
	chandrakanth.patil@broadcom.com,
	chenridong@huawei.com,
	chjohnst@gmail.com,
	frederic@kernel.org,
	hare@suse.de,
	hch@lst.de,
	jinpu.wang@cloud.ionos.com,
	juri.lelli@redhat.com,
	kashyap.desai@broadcom.com,
	kbusch@kernel.org,
	kch@nvidia.com,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	liyihang9@h-partners.com,
	longman@redhat.com,
	martin.petersen@oracle.com,
	maz@kernel.org,
	megaraidlinux.pdl@broadcom.com,
	ming.lei@redhat.com,
	mingo@redhat.com,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	mproche@gmail.com,
	mst@redhat.com,
	neelx@suse.com,
	nick.lange@gmail.com,
	peterz@infradead.org,
	ranjan.kumar@broadcom.com,
	ruanjinjie@huawei.com,
	sagi@grimberg.me,
	sathya.prakash@broadcom.com,
	sean@ashe.io,
	shivasharan.srikanteshwara@broadcom.com,
	sreekanth.reddy@broadcom.com,
	steve@abita.co,
	suganath-prabu.subramani@broadcom.com,
	sumit.saxena@broadcom.com,
	tglx@kernel.org,
	tom.leiming@gmail.com,
	vincent.guittot@linaro.org,
	virtualization@lists.linux.dev,
	wagi@kernel.org,
	yphbchou0911@gmail.com
Subject: Re: [PATCH v11 03/13] lib/group_cpus: Add group_mask_cpus_evenly()
Date: Mon, 20 Apr 2026 15:11:52 +0200
Message-ID: <20260420131152.243488-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416192942.1243421-4-atomlin@atomlin.com>
References: <20260416192942.1243421-4-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Maybe I'm missing some background here, I noticed group_mask_cpus_evenly()
is called inside irq_create_affinity_masks() and the "numgrps" it is this_vecs 
in the latter.

Looking to group_cpus_evenly(), seems it is possible to have this_vecs
equals to 0, indeed this function return NULL if numgrps == 0:

>488 struct cpumask *group_cpus_evenly(unsigned int numgrps, unsigned int *nummasks)
>489 {
>[...]
>495 
>496     if (numgrps == 0)
>497         return NULL;

Without it, I guess the kmalloc() in `group_mask_cpus_evenly()` will return ZERO_SIZE_PTR:

>+struct cpumask *group_mask_cpus_evenly(unsigned int numgrps,
>+				       const struct cpumask *mask,
>+				       unsigned int *nummasks)
>+{
> 
> [...]
> 
>+	masks = kcalloc(numgrps, sizeof(*masks), GFP_KERNEL);
>+	if (!masks)
>+		goto fail_node_to_cpumask;

and this value is then passed to `__group_cpus_evenly()`.

Should this check be added or it is not needed? Or maybe rely on `ZERO_OR_NULL_PTR()` ?

Thanks!

--

Marco Crivellari

SUSE Labs
