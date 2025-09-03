Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733692ED143
	for <linux-block@vger.kernel.org>; Wed,  3 Sep 2025 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756942581; cv=none; b=KxaFeLx9A5xMP7/MXxxUjCIpxTbVJ9vee9u0qJ9AqlQM6HOyOC6gqqGOUvPN8eJ14FCXF/Dc6EdPiEZLc94ZIhcv0Bk767GXrFj3JVFcT7oJ7LIyjHVVYNl8fVsqpHYUJ/d9+vrArbgiBYSfT7eH1OxbvpJuxjGIRx6hLjnVmxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756942581; c=relaxed/simple;
	bh=hTsUf+7pIdM/lXCqAe9D86CNr2C3O5JzzF0WNrYSDIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a/PH3J021WOieEaVDtrSlv2K8zY8W/KoSQ8KIt5+Pdt3EASZEaYuND4wx+a0EnLdT4YZZtzhx00jPC5cHsER2sDUMRnK3Z9deLdom7IxuTOqaB2PKOCQylVrEWvGFJI45HDuUgRuiALHylIGrMkChIf/N5wBZVrNiJk7C89n/RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DrXH5bNF; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DrXH5bNF"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3f660084016so3428805ab.3
        for <linux-block@vger.kernel.org>; Wed, 03 Sep 2025 16:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756942579; x=1757547379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpgLGMWO0awdNrt/VLr9OxSO9rXyxL66JQE1TwfW2uw=;
        b=DrXH5bNFOFDGGBA7a5ba+H5TbdMgdKJAPsxeN4Wj+n6XUT19vlRnPmbEcboKP2x9/q
         vKe72MjpspPHgJO1O6V/2Z0OmngQ34mgRZjowDqlobqLsQgo6zn1pR5GP86rJwsQheDO
         0YyMvNhINfsQnp+ik5KdD04ddXO5arfXG3oW0d+iXpmBsqxAFHw8hjVRlxbBh06l1ZHj
         PfUlnJkIbXrsX0JivnIvFsdtN3dCxkdjB0db3X/lUY/+cZ73q7yRKm6RYe89yMQmObkH
         wv5XzJqZ1DhvieyJr2PM6cfSnQlM9kqTD6VtDUBXvcPQyc3266cRyS+K+jfbB667qKb1
         dCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756942579; x=1757547379;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpgLGMWO0awdNrt/VLr9OxSO9rXyxL66JQE1TwfW2uw=;
        b=bDSub4M1l+Fj5C6Cs5GMxVUY3puwPv3BPf00SiW3uwb2OVurvCezJFei0kjS/QKDGz
         8UZbi08hfWOUvvwZZQ6Iar3/NiHCg/98U5OpbMu4lgVKuJAOx/I7++ZhFLxrV10h5u7N
         TbSeEt0hOZi0yqFlg823BALTRmfg0LlaliDFsEBMRJ2QeRVnUKw/47tnRdjgcR902H6B
         2bByMxYX6oH13KZTfvHlcJH3DIrat8oEl2L4D7mewoDND16SkGPmkg6iUDrBLep2wxoU
         b7uRqhgbXYimj3Xg+yXgtRrr/qEbj/jBm496trH//NjwP/n1Op8hdPIQFof9JaL/AvUy
         LIjw==
X-Gm-Message-State: AOJu0YzHGIDxpbihMSILnUrbsyZs49NtsmNdd4UQ7lKO8mp6X8SRhT58
	RFmYLWGQBh4bz77+5YDan8gHiOtJlIIg7XcOKK0xyZBmLRxSMgYZK5XbtROU/Bdtbig=
X-Gm-Gg: ASbGncscgvNt4ud+JjMDq4yHuDP3KTKvjntRSxSD4aCganAwcOIQHUzJ9MKhMfCNOXl
	B4TpRSZdvkd6HpP7JAxa/aApqmBjXIdtE9+3Qb7E2mwiRU8Bx03fJv9EehkILNyGIVX8TDpqeUF
	mB7COd+Khj0/n4EIiPdjOI9ypiOIqWxGrxCLvskbAXmhPfy3JvtYH+gLJXcBRPuIRhgmVh9DD1r
	kbT6/hIvSSAY5UtK94PE4Duw219hPpJ24xWYeIwMD67OFNszaZXxJEnQGoLAuvnX6rMvzt5BU5A
	QcgXe3M5wf3H29ZD4RhrqXFxuOlBs+LtDKGomZExbVWsgDjTKLBX8xnTeZA+/acijmAugOdhi6y
	PjwvSLCP2Q5PySCFkz5j28QmiHvz3TSTrWX/G
X-Google-Smtp-Source: AGHT+IHnXqc+QrXXfnvVjSXU+Urf58cLLyfm4Xz21aO3AQHu4oJHxvNC61ADrYGkuPGDXqoCBDPmSw==
X-Received: by 2002:a92:cda5:0:b0:3f6:6228:33d3 with SMTP id e9e14a558f8ab-3f662283597mr46635955ab.19.1756942579489;
        Wed, 03 Sep 2025 16:36:19 -0700 (PDT)
Received: from [127.0.0.1] ([70.88.81.106])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f65d1ef2c7sm18736855ab.5.2025.09.03.16.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 16:36:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250808153251.282107-1-csander@purestorage.com>
References: <20250808153251.282107-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: inline __ublk_ch_uring_cmd()
Message-Id: <175694257775.217330.8898056117894470803.b4-ty@kernel.dk>
Date: Wed, 03 Sep 2025 17:36:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 08 Aug 2025 09:32:50 -0600, Caleb Sander Mateos wrote:
> ublk_ch_uring_cmd_local() is a thin wrapper around __ublk_ch_uring_cmd()
> that copies the ublksrv_io_cmd from user-mapped memory to the stack
> using READ_ONCE(). This ublksrv_io_cmd is passed by pointer to
> __ublk_ch_uring_cmd() and __ublk_ch_uring_cmd() is a large function
> unlikely to be inlined, so __ublk_ch_uring_cmd() will have to load the
> ublksrv_io_cmd fields back from the stack. Inline __ublk_ch_uring_cmd()
> into ublk_ch_uring_cmd_local() and load the ublksrv_io_cmd fields into
> local variables with READ_ONCE(). This allows the compiler to delay
> loading the fields until they are needed and choose whether to store
> them in registers or on the stack.
> 
> [...]

Applied, thanks!

[1/1] ublk: inline __ublk_ch_uring_cmd()
      commit: 225dc96f35afce6ffe3d798ffc0064445847a63b

Best regards,
-- 
Jens Axboe



