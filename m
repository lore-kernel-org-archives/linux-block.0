Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A908B26770A
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872283; cv=none; b=sR4/TX0+IA6C0EjkJMaY4+bg0E5S4q+L+jZF01GtMrq4urKyKIVlbmDYOpJHL8l91yHmPsZAv8R4Jz5G1B8dt9+B3J2fkmXfFjiBb1ZgPWxX0/AWh5nQhZe9L/9oUrZxxk9+PzKm3tkPVlzapxqIxFzJmPwz3tU6nXA68sEyTyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872283; c=relaxed/simple;
	bh=oxBvzwvTrG82n8EJbBWNJ307/ROiMAIN3ZDd1Xbf3ig=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DEtuaDWdpRRpozSUhuwfD05KDb+IZ9x9eU6B7J8NR7inQJeZ8jIpIsFPAaDsszg9CsLt/ubsmBUQo/Q+e13ZPHsDZxaetY/DFRNZ/1NQaWnkMPUfe4418h8Irdlwo6vn+Qc9qM5djUSIloAN7hLj82PdXH2RfXWqhHroVRn6RGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CgRsHjrX; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CgRsHjrX"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-851c4ee2a37so68766139f.3
        for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741872280; x=1742477080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PLsvEgnbim2yotRJtm3RxSyGerYXasNwsqr+/KVpS4=;
        b=CgRsHjrXXRqq4vaPHAcHpS5QmNOKwPbwPx1qON250R6Zi2OYgAUJ+uhFKQuGASSWQm
         rS7BY/yLPqLiuDxkl1/pXv7VWbJ7vDEGxpDH6GcG6/dLYajQjZHTa8KbZ+qumNySbDVQ
         gz6YNnTe5EHVHnU/j+EU4aBDLYuPhD9jw0fqBgZkqKCCOAEfIOt1oGRotT9X1Ju/lCix
         1bBdnCrP7jcTTY79NVlC35F9pvq8RTo3qnAo1c2m5X5xGbeUAbZETRvWLoKC6dh7aE6e
         gLjgAv/qJFO5MTjp5mpC15RwBUcg8FbdNu6RlZel9/kWcHOY+Vi/o8qQR9Lpa2KJ1yXT
         A59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741872280; x=1742477080;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5PLsvEgnbim2yotRJtm3RxSyGerYXasNwsqr+/KVpS4=;
        b=YTeHwAExHBUqcZxMjlqgchE6viXjz6ZVHa6C6hvqxI0GzUhepHRvZ4YjhoOeOY3b6d
         6YIl54Hm1qwG5Kkylw/jrGlMwJfK+lm65uPmJw1qsG6MZNdj5RC3uUzdiK0HhdJSssuM
         wMiQf15YJ8tiesZjPJot3BkD2JvA0vDpEM5C/1VcLDDIjsdsXdRyxgyBogiBg295nmh4
         hShIbP2dxeNssoKi+2o1XaMV+i3pyxQkHGcKznci/3fS+mFVPbvaE79hPfijpCo4MTTT
         azWZ3+qR2209LhN3SgApypQOyV/kfB9wFoGZ7h1jA3faKUdClcoBfU1rPV0YJY1aS0DF
         o+IQ==
X-Gm-Message-State: AOJu0YwJ7IB2VBzx93AEC0AbRwSVFIbsznCZVwg3QXJZR3QtMi02b4/B
	Ax7VDAprKZSWIkjLHoJBTT4YYVz1WBTg8evlLBCCRDeDOA380boEuPXKK+48KGc=
X-Gm-Gg: ASbGnctdcvQ29UEvx41jq801wC87HwLZs8oy0yjgcbFoV8bqfJw5j/1CIdJbt+PIYzq
	ax7qKJVqa2VDoEJuavyiFRXia/JOEm9hM1C9ibfVeRYQ7c3fYz4Cv/jsmaoFPhA/F04G1aCZL9U
	ns//K0oT+PNhLPuJIR8dAmmlp0VbmJpO8JBf6X34VS6a08Vzg1ihSXfBIy48PkyDziFytFY+hgV
	QoUpZdxV7ijAt9xkvg71aU6vmfk/arA0mBcNQc1/DMMyyQM2LAfSWV2JgGUh8zbR8YS+DMC/ltr
	VBFPHK8zmrDslWWi/aBfqZ4FUzzA1jJ3HVk=
X-Google-Smtp-Source: AGHT+IEer637uehs/daevOydns9iUer0NF8/Lop3Ui7LDoPjH6cMpb131IF3qkXQqxQNFL57dNEHAg==
X-Received: by 2002:a05:6602:380d:b0:85b:5494:5519 with SMTP id ca18e2360f4ac-85b54946d71mr1891701439f.5.1741872279762;
        Thu, 13 Mar 2025 06:24:39 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85db879e512sm31580739f.28.2025.03.13.06.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:24:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Maxim Levitsky <maximlevitsky@gmail.com>, Alex Dubov <oakad@yahoo.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Zhihao Cheng <chengzhihao1@huawei.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Sven Peter <sven@svenpeter.dev>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>, 
 Chaitanya Kulkarni <kch@nvidia.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
 linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, 
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
In-Reply-To: <20250313035322.243239-1-anuj20.g@samsung.com>
References: <CGME20250313040150epcas5p347f94dac34fd2946dea51049559ee1de@epcas5p3.samsung.com>
 <20250313035322.243239-1-anuj20.g@samsung.com>
Subject: Re: [PATCH] block: remove unused parameter
Message-Id: <174187227786.18244.14269218969550436496.b4-ty@kernel.dk>
Date: Thu, 13 Mar 2025 07:24:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 13 Mar 2025 09:23:18 +0530, Anuj Gupta wrote:
> request_queue param is not used by blk_rq_map_sg and __blk_rq_map_sg.
> remove it.
> 
> 

Applied, thanks!

[1/1] block: remove unused parameter
      commit: 61667cb6644f6fb01eb8baa928e381c016b5ed7b

Best regards,
-- 
Jens Axboe



