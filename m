Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA83C7FBA3
	for <linux-block@vger.kernel.org>; Thu,  8 Feb 2024 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412747; cv=none; b=O3/lt84pVfeN99DZHW6WmBzasZM5XVrJUobKTnOOKwiKNEuKtJ8VK96vGEIRCT3yjs8xMKLsssmevVmQuujLYDKq/5cXje6K2086Gzok2RJ4n2AkiTfQybOpCnRicyVaL/wBz6tCwjNh2PG/ke+JLK2qo/dYFG8W+DVkrJvf9xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412747; c=relaxed/simple;
	bh=OYdekK2Em/cYF0miUMzoflzw3gSJoqWAFVuQcaQLOxc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rKzdVO4SITVFxjd3F7eWWQ3MG0FEt3toRRmsStL9F+Lv0rtfmtHc0dUJVl1n1aMm9V+oFTXadX/I1dGE5eVJY63BHx9xoApKgDWAjY27jcE22k8Vq8q+JVcsdAfJqNvqTNtCmUtQudv4urVMc7XNOdhvHGGWfGPFTmXv7FWQenk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=iLS+o+tu; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iLS+o+tu"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-363e7d542f4so110825ab.0
        for <linux-block@vger.kernel.org>; Thu, 08 Feb 2024 09:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707412745; x=1708017545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfxuFvECaBraf1c5hZUbS2f+Y45DtoHwXuGRaiKkoVk=;
        b=iLS+o+tucgIhttByBCMpl3xGXPvwjkg6DdMPyMGMtcdp+uQMOXTL0PYiBHfg86ewQ1
         3Kuv9cM8+O9Uyj06heea9yHGNh4m3sgP4uj5R1yT3Hrrc04sc0vDZfjJ4woyUcrycXKS
         gkEt8njqRLLxo20Ke30zuFRxHGJn9ZLlz9w/oqaU6AzM9dS81CFXPOJBpnSwT8UACHFR
         OW6kY3CC2moCnp36IeMgrDY64l1wI7PeVy3r9BuMUkuoduewumlTUlOm9/KnK8zVrGm1
         C+4bZ26t5PfG2cbyQK67Iq+XP+extvvDjrPlUjjrmtw0wdYStEyprZfOWcgSm9IJ0WQp
         47RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707412745; x=1708017545;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfxuFvECaBraf1c5hZUbS2f+Y45DtoHwXuGRaiKkoVk=;
        b=pmjDeis5oLdxojCBXcj99HbeseOUJBHK5xiXaBNnSkbv6BLl/ryWdLz0MYU5jI013P
         lcT4sXOa1Z39hMdFFySW2tGPn8964yO6+e62vQNBLFwEFDb3Ci8R0tiBiWEvTsDjmSjH
         ERMRYUmJ02arsYkUKb1cw+DCB/fPIbVAZyGXsQM+8pyMl6pK2d2MdADymXFLAX2tKJV3
         noOEVGdU5JeW+yG3yW52XlCjqyUu7pdsWNEnhnzdwIlmKi8o0vfn5QSbsYeMGJs/YB/4
         hOio366LQ0JuUnr4e2vIbmJxFD7XVAR0xRTgHnJg3jeIqSBKn1rUQycWTcbjk+F5MQql
         7jCQ==
X-Gm-Message-State: AOJu0Yy4dpQ74Ho0QE68HrvftTukGElu6KXF9sicu7j7tmZj6bt19MqF
	xX32v+jn3FfEfX89Htf4gACUTIv1An7APRjskzP9mcNUHmJIOPTRdIN2EkLx6RE=
X-Google-Smtp-Source: AGHT+IGrtYjmUqatNjmm0WDMnOH631o+OAhntraBWoO6vS2EuInD6t2Wtz+AIyo5SFX2jXSn0HOhZA==
X-Received: by 2002:a05:6e02:1aaa:b0:363:c82e:57d9 with SMTP id l10-20020a056e021aaa00b00363c82e57d9mr173121ilv.3.1707412744752;
        Thu, 08 Feb 2024 09:19:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWyP1mWH+SizUOH8w4DG/ms6mSkE/1o3h+BvU2XT8Krrfb437Z0nMu8Ls/JGtny4zrcgdt20bXMk+1jm737hY3K5Yo5wsXx
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bm9-20020a056e02330900b00363c664cfeasm1143599ilb.61.2024.02.08.09.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:19:04 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
Cc: hch@lst.de
In-Reply-To: <cover.1707314970.git.asml.silence@gmail.com>
References: <cover.1707314970.git.asml.silence@gmail.com>
Subject: Re: [PATCH v2 0/2] bio put in-IRQ caching optimisation
Message-Id: <170741274409.1369019.5049430143936300007.b4-ty@kernel.dk>
Date: Thu, 08 Feb 2024 10:19:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 07 Feb 2024 14:14:27 +0000, Pavel Begunkov wrote:
> Patch 1 is a preparation patch, which enables caching of !IOPOLL bios
> for the task context execution.
> 
> Patch 2 optimise out local_irq_{save,restore}() from bio_put_percpu_cache()
> for in-IRQ completions.
> 
> v2: Extend caching to the task context
> 
> [...]

Applied, thanks!

[1/2] block: extend bio caching to task context
      commit: c9f5f3aa19c617fe85085b19abbf7a9a077336d0
[2/2] block: optimise in irq bio put caching
      commit: e516c3fc6c182736aec5418a73f15199640491e2

Best regards,
-- 
Jens Axboe



