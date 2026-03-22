Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF23F1F4181
	for <linux-block@vger.kernel.org>; Sun, 22 Mar 2026 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774189843; cv=none; b=DBV067pL/g8efwwRNeTbIQShF+nv8uj/zNNw/jZS5qTWaMY1OAsH4ky+j75ByMbpSDkHIqVITXWSHu5I7ESRde0Ua0N+D1MQvFArzSs1nAAHjnrzVM6Ak5fYHsbFh8jA3Df67flyCx7PkZOOPtTCmtu6TeldC7ZPyey++Q3rYv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774189843; c=relaxed/simple;
	bh=V+YRdvkTSoa/d+GYqQRAYGQCkJMJpcL8Htec9eIAdgY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=afxEUe15qVg3NbItNlivWm66ZrF/uiG9C/qrjpzc/UjP1f1x8iCDHS12WzDoKG95QPQgp4uUjQZ8eeeFsrj9JBpJV/L5Qp8/jZyWkFo7URiQ9b5NT//EQeJLk5FfflEhH6iUjMd5lxU3l7tUyka81kRNRdyGPPHAjLasnWPbGVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=q0Hl8Vt2; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="q0Hl8Vt2"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4673790ab85so1192477b6e.3
        for <linux-block@vger.kernel.org>; Sun, 22 Mar 2026 07:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774189841; x=1774794641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHK1YAHhATX+BOrgvNcOMGXM1iLk+EcLOH7Ra7adyWU=;
        b=q0Hl8Vt2E/hKdFWOG7lJfkpSPyMe40OS9nVR99NMW0WPhu1wXp59/kL/vMe9Dm7E1D
         ihM4MhftzEtJXRYwvF0JHF+reFf2ql4ayZGTYVbe5gwXDRHigKK23lhHLn3x/Xj1Eqjd
         Zf0aRu30Ls8lZHY1kEFAJlfA2pJUfsXwqfNqYXse/bzGjEWFN69juAyldy97thzN1jeP
         q2QyGI4EG1BuD63gJCV61xlvHlmhKJFsgOQ43YUzDMQJpTwNiiPyLjsITayF5Csh6wWX
         /UZ4YXaZRLg2NSbdscuY1g1vxmKTudr7C5jO0Fu7PGhTxvNoAEztyYpSm2ohz500lmkq
         rrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774189841; x=1774794641;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HHK1YAHhATX+BOrgvNcOMGXM1iLk+EcLOH7Ra7adyWU=;
        b=VpFwgvBXSMCiz6+r40Xl1SYwVU9kOqxz2OsBjaqCLSaR06i8yYJiwkA2TpEro+6SQS
         S7dpa12NxmItDHHrSTL8Kd70f7Gf3WeBzOhKk+Rzc1sInlDgqiamhCC9fjJ6mFRbfrEm
         IuMsyx2xn33ONqkgT45DNJewDd4nnidkhCaGZc2UPqF8Xqy54Ua1aOgf6HBeBrlaRcQd
         JxdBjCo3sxbiqALh09oMAr/mdhOwfnsJjX8HqjgUucXo4lH4rL/L1rSsQ0QxuJ1k3ExH
         5xJHGBDNZclytTmYJPCHE1kpU77dI4AQvtypu0C6V2NIgTq/3+SmhiYWBPjcXU4wzTIx
         dT3g==
X-Forwarded-Encrypted: i=1; AJvYcCW53zUim1fsIU6xeu2gMyetnyiHKLMaTaRs0vg/I6h2jRvd/BQo6OvxOa79u3rGEqh38ikQt9puPMP/5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzes7j9SlJnROY31pyA7bShlMNv7yjaNb/mTEpkRsX0yLcRltxf
	biNsgwGrKRDLPPbF2sZKyfONPPh+6q/nTbfTJ9irqe2Zm3By5Jr4bVRMg0gXl5f0fPU=
X-Gm-Gg: ATEYQzzbjZui1lUd6ifepJ9qlUh0DzjWeoixfYDqdIInidLkba9E+Xj2NgWKloZiT+P
	ZKn/FJMpzUbBQ6BLotnX4EzXvi2Z47W7DNqqdwxjdAnwmN85THB9kZ9/sx2Fok0NOkkbKhG8AQ/
	zKbAn2BYfMZiG1hwszmtEd9HkLeuQ8tsfa/Eo44BqkEWeFrav+DkCugdKpRmFvHdSVwpCb98/Re
	Cl/BLXFXJ1/CMMWSiw8IbsqVdmsp7FM+DdAgbcalex6dqQ59Bjajsp/+ACerG7Miw3XO6BQKGph
	m+dIw8mBGtqW4t8Bb14ml5/ygD07E8UtvcfZHD0jr5LJ2jLAPRf0ltwcw5A6fuXxjAVZ7jdyFHo
	jkxtEq3iXx855kTl849AWBFpTO0DNVfig70YSstHmoCIrSyl9rbIlnWXh6UtaFacwxibCypFMb9
	ry+0ur+b/T9/bvRdFovG3IuDnTRD61AOIXwa3TGr5tcXzo/xtcr9BRs0OJZaU3h4Oyrw6tmVXfP
	vPI
X-Received: by 2002:a05:6808:c1b2:b0:467:4939:967f with SMTP id 5614622812f47-467e5fcc1fdmr5356813b6e.48.1774189840902;
        Sun, 22 Mar 2026 07:30:40 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c14d64fbbsm6629011fac.9.2026.03.22.07.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 07:30:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: axboe@kernel.org, colyli@fnnas.com
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 Mingzhe Zou <mingzhe.zou@easystack.cn>, stable@vger.kernel.org
In-Reply-To: <20260322134102.480107-1-colyli@fnnas.com>
References: <20260322134102.480107-1-colyli@fnnas.com>
Subject: Re: [PATCH v2] bcache: fix cached_dev.sb_bio use-after-free and
 crash
Message-Id: <177418983975.306181.7832678653109865447.b4-ty@b4>
Date: Sun, 22 Mar 2026 08:30:39 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.0


On Sun, 22 Mar 2026 21:41:02 +0800, colyli@fnnas.com wrote:
> In our production environment, we have received multiple crash reports
> regarding libceph, which have caught our attention:
> 
> ```
> [6888366.280350] Call Trace:
> [6888366.280452]  blk_update_request+0x14e/0x370
> [6888366.280561]  blk_mq_end_request+0x1a/0x130
> [6888366.280671]  rbd_img_handle_request+0x1a0/0x1b0 [rbd]
> [6888366.280792]  rbd_obj_handle_request+0x32/0x40 [rbd]
> [6888366.280903]  __complete_request+0x22/0x70 [libceph]
> [6888366.281032]  osd_dispatch+0x15e/0xb40 [libceph]
> [6888366.281164]  ? inet_recvmsg+0x5b/0xd0
> [6888366.281272]  ? ceph_tcp_recvmsg+0x6f/0xa0 [libceph]
> [6888366.281405]  ceph_con_process_message+0x79/0x140 [libceph]
> [6888366.281534]  ceph_con_v1_try_read+0x5d7/0xf30 [libceph]
> [6888366.281661]  ceph_con_workfn+0x329/0x680 [libceph]
> ```
> 
> [...]

Applied, thanks!

[1/1] bcache: fix cached_dev.sb_bio use-after-free and crash
      commit: b36478a1fece72b5d4540141fd31024dcba1d241

Best regards,
-- 
Jens Axboe



