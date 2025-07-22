Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB520CCE5
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200160; cv=none; b=WCwITsNngY2CAbCHVuzBR8dde2Gx3avPJDUhk/HqW03dGvIy49Xc/+/zn+fNlOoCDK5aZVC/PYHq9D+tMoqw/BZ9GWjCW0RxDzQASR5L3bcIFghmaNe+92O82L42bjpJXUA+ursINhgSU2inZwTFVVG4zFNBuGZWdEMzI8sRQo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200160; c=relaxed/simple;
	bh=noCp+eXK33xOruhl37s/mqn60tBI6l0AIHoZYe0gMCk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lgA8cdJmDkdVRH6/b6AEelFQfITL1mgF2I6yA1yJAubFThckygcLzdI79HvCFnAgYMNMal/PSCTGj29N9mnvrO4Li3NyFPqSmTR0xdO3z/ZiNGxYlNtsm0diA3akfHUJHSv2Fbhqdk3G/By36Zx56meMA9jbsTvqxzMElHrwMi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xt3xVbJs; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xt3xVbJs"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-879c737bcebso1351339f.0
        for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 09:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753200156; x=1753804956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBDUtHjG8WwK4Nzt7OVo+JKFrKxCJS3/depqRx3MmAo=;
        b=xt3xVbJsXEzkPhPitoRtfx5sqT2K6sM94IayNFRZvpJe538HdUludl83xXLiAiaPbI
         Y+DTlJBMwcLQrv3bHNIiwMNS0qnBgk7Xd4BH81HI3fOlhhkoeNfLRJDBCbljhjedtxi8
         ly6ura0OF04Jsc799gZ8ZEmzRJ6R8akr3Bl3v/czMOyA2Pf9n+NJb/5fzjXnYZ1Ko0Yj
         M/X9hccYU/7e/aJE3bFdYuJTL8E9g1XEAGGpBbl1isaykTzDpSH5ghfBGIv/bzK0QPph
         6+aXJgEOh4erjwbahzyOonudSopGu0r8fuz0ten8Yr/mnYl4pfhEJAGoTjq44+JG74jC
         tNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753200156; x=1753804956;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBDUtHjG8WwK4Nzt7OVo+JKFrKxCJS3/depqRx3MmAo=;
        b=J3XBbwaNkQReSnfHXCawGks/osEKbDCL+ez+Tu8wkwRLssCEf7rXLKElBZrYT6wy2m
         hI1XtnR0egfc1ny7v5E/217Egjct/LR+ZdlyU4xxxQx9R6rKHnZObVUEqg8wkX0mydqE
         ocKS5kzpaIgAyEzYkj069MCxM51ShRd3rXGDS8wnvwUfv7TEDEZAn4ZtzlMfH1ArvY4e
         T9Ffebc9oEX5Vrw09KI2SjU0bPgh1MV25cxCyIDJKouTnugCjz3Rvr+LIIYk69H1GaTF
         CeX/XqrjJSj2/pdipUOJwbwmJoeYdepQ8aOw48qeCNOBSF5YJ87NFnRWbfVG1vRXpU5b
         1ZPw==
X-Forwarded-Encrypted: i=1; AJvYcCVT48r0bnxt16KF5s84eYx2gwYEIsMuFuNyTGt1OyFsBLIjWdWypfDFKcJv/dbmYBUWD/nFAY4XdBqegQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgOS1LqUTvhmA3gD0dQKKepZ9c5Fr/KNx+odrsU0wu7WTxOw98
	jo1Rze3ZUHaMWj4R0wPd6ve3GA9JipmtYMo2iGzt8wlvoNM9c4sV9PpwTP7nECcWpv0=
X-Gm-Gg: ASbGncsAyw6uyZpYvPipG4hiplfMRErCXf3UloiJ9iOd63Kw6oUnqh4RWOfKMAn9hJ2
	813rossW3S+fIXbbtJ+sgZKUF1Ar0jHZjg2FKQFvGDZDg69J2vIiObspoF7Idt2KmJON71b74Uq
	7dT9IUmtGteDQcYYNMaYfxDvsR4Jr6PwXo9Rqc2yQCOi/EFS2Flgx99BpzGSkmkHTxlul1dVhGN
	ApFGWYX+fNyDGYYVk2dFkyX4ys8/c2P0jnqYiu9VSVqyZWwob6Q0O+RRrbk/fQgxCDDsl2u+ecL
	3ytnTGTCg2woIiAYoKn0Owcl7684rKxLLZuRSHE/NG/c3w0MuND0cTXmQgoXLotTkMlGmVcW17g
	0YBv4UjT2lPow
X-Google-Smtp-Source: AGHT+IGwFeinDrd1apvfPiLCe115kkPKtu21yo+ZtYpYX23SlO5YPHk6OgHUI5gPbzer2SUz6HNeAQ==
X-Received: by 2002:a05:6602:7417:b0:873:1e91:210e with SMTP id ca18e2360f4ac-87c538883bcmr676458339f.4.1753200151901;
        Tue, 22 Jul 2025 09:02:31 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084ca62884sm2493638173.123.2025.07.22.09.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 09:02:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Jim.Quigley@oracle.com, davem@davemloft.net, sln@onemain.com, 
 alexandre.chartre@oracle.com, aaron.young@oracle.com, 
 Ma Ke <make24@iscas.ac.cn>
Cc: akpm@linux-foundation.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20250719075856.3447953-1-make24@iscas.ac.cn>
References: <20250719075856.3447953-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v2] sunvdc: Balance device refcount in
 vdc_port_mpgroup_check
Message-Id: <175320015081.186214.5828107139805643955.b4-ty@kernel.dk>
Date: Tue, 22 Jul 2025 10:02:30 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sat, 19 Jul 2025 15:58:56 +0800, Ma Ke wrote:
> Using device_find_child() to locate a probed virtual-device-port node
> causes a device refcount imbalance, as device_find_child() internally
> calls get_device() to increment the device’s reference count before
> returning its pointer. vdc_port_mpgroup_check() directly returns true
> upon finding a matching device without releasing the reference via
> put_device(). We should call put_device() to decrement refcount.
> 
> [...]

Applied, thanks!

[1/1] sunvdc: Balance device refcount in vdc_port_mpgroup_check
      commit: 63ce53724637e2e7ba51fe3a4f78351715049905

Best regards,
-- 
Jens Axboe



