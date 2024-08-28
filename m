Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015561A0B04
	for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724856686; cv=none; b=mluzNHCWSokEciOYzAgAhnGjujZ85LEwqyi7y7x6KJO1fXPYq0N1We1gUUMaA23nTyyq83h6KoUAFFg29P4mivmgqLRyBjPb9Pu2YHia6Opg79palgzq2RJMhI6xdrgN9AoMcb91YrGx+IzNqeMkT83eHVDDgL2a6JVr7cwFXH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724856686; c=relaxed/simple;
	bh=fvisZexUf4VvnutqYhdxmRerwQon/w2cB6Zl0MbQYlU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WujP83+g5RDVhBEyL98XxDHUZbGH2kAvlmKQNaCE5VYyozHYat1U3Tum/dMZdOwUWt3XUSYT5ZyvsHtqt7uDuLPvgp1RdfWoScQ/72qu+I27yTjKjHs6MAOsqt50+au1RrFmNMqsQHqNfenufqx82+uCVvDcbEtpPYp2+RNSSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WpXbLGgv; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WpXbLGgv"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-81fb419f77bso373692239f.2
        for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 07:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724856684; x=1725461484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyEUV1xYu+pXzys5LhYG+utdaA9ZxHIg1uBDsn9tZgM=;
        b=WpXbLGgvQi269Oj5tE2+z7T+aYzuL+oh9bXXjw6NumQhwVkvZsZG1K4/3NCwSMboEh
         qWZY+z/M6MDIfzk4W62DsAFcrw0Cg6UskFvOOA1FDqcav5xjo123DYZoAi/PMIsJZQDe
         Lt3ktUkHSafDaTEclctm0ojTGLrEPIEhZpb5DNIcCwten98iBFmsgbZTPZIJLrCuOMmQ
         PmggzrKSU2sJRsTgG5eYBOzdNCm9sTxpcld5g10XmPk3Ig6v01Z4pDkABrgTcUvVmhCy
         GUHjgCyWcKW7D4bcqqGFWeW/oFoqd00j50wF/ZDKzC+g/RizRCCbsfqB5J6JI2dg30Do
         GkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724856684; x=1725461484;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WyEUV1xYu+pXzys5LhYG+utdaA9ZxHIg1uBDsn9tZgM=;
        b=XKl9S0eP//pgiJFjrs3Vs3Ie39mcN2s+km+uRhZRSpdM0LCCVh9Ct/vpuwpjTKk2bg
         H5FGSfNLuR5BuVVM9GSeHqlijzrhJQilDiYHWQP/7iSwtchgbcwWCJsQQ8EQTTAbmC+z
         nJGxVKWBtcLzMH9BsUR97/ovq85FBE8F/yNumkVy6KEtnZ5OisSY7oFkpG10F1luUUJu
         h0eDZbhg1q0RDwA1nKl0mpR4jZcoyP9eqrBWQrBija2svvxVzZW1/TDeTOCY+bhvw3K+
         M4dBUwQpVhufVBpzOdGZoYeYJzTXuo5e+7yn75wA+/LY7OnysR0Yp4D3hpHnbH0W5A8F
         6a7w==
X-Gm-Message-State: AOJu0YyUmlNhb8FaLkezitfSEpKgDhv9yemr1V7FKVRVAsKJVhpnUb7V
	cf5Ge8KsWdXY1SvdrMF4+i9zdOLndhKUzO3Ala32Y5vCk8YHuteRjmGorTl9+Z8j6GPkHPez2CY
	3
X-Google-Smtp-Source: AGHT+IEGZ5Vp5T+rPisQ66cmsf0Xa/De3sGPs/AT0I32TE+m8OHmQkLyWghpBozFV++zVfxon2ONcQ==
X-Received: by 2002:a05:6602:148d:b0:825:2d48:91c7 with SMTP id ca18e2360f4ac-82787311582mr2215340139f.4.1724856683619;
        Wed, 28 Aug 2024 07:51:23 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f84e20sm3092887173.84.2024.08.28.07.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 07:51:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Md Haris Iqbal <haris.iqbal@ionos.com>
Cc: hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org, 
 jinpu.wang@ionos.com, Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
In-Reply-To: <20240809135346.978320-1-haris.iqbal@ionos.com>
References: <20240809135346.978320-1-haris.iqbal@ionos.com>
Subject: Re: [PATCH for-next] block/rnbd-srv: Add sanity check and remove
 redundant assignment
Message-Id: <172485668231.410120.2205193926439632652.b4-ty@kernel.dk>
Date: Wed, 28 Aug 2024 08:51:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 09 Aug 2024 15:53:46 +0200, Md Haris Iqbal wrote:
> The bio->bi_iter.bi_size is updated when bio_add_page() is called. So we
> do not need to assign msg->bi_size again to it, since its redudant and
> can also be harmful. Instead we can use it to add a sanity check, which
> checks the locally calculated bi_size, with the one sent in msg.
> 
> 

Applied, thanks!

[1/1] block/rnbd-srv: Add sanity check and remove redundant assignment
      commit: f6f84be089c9d6f5e3e1228c389e51c7ae7bad1a

Best regards,
-- 
Jens Axboe



