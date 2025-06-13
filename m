Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5281E5219
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749828369; cv=none; b=dDyFV76uz+QFUfSg26a/bKEOuDmivhH/ZCsj6X/0WASI4sp5WVNMzoU/NYUZJAJBPgSAoOlxhkruy5IFbRfevNKFTCKLXPeQZItjeOlc0PEpIpqy2KauzUR/4k2F21OkOSpwPewpoGqgx8bhBMeZCY/ZMcrEiSAErz4wSMPPql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749828369; c=relaxed/simple;
	bh=4e0gp9uIV7MyzxlvTTu7qZW9G/t1tf1C48sZL1Ybazo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lUmlikJAzolxXPvT9mJ0YLSoLUljPd4qF0HRgbqR0/1chycCLSpZuiJYWkfylS0JrbnEOSvtP/9PpHL6bNkHtHeLH6M/E4OtL8UfhOTNObdk+cfkcFrTDZZm7rqnHm02MuZjGpP0YXnbb5VnZBJl+cTsEjWzWNMakXiYDn9wdJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=IT+zgK9t; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="IT+zgK9t"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-875ce3c8e24so47322639f.1
        for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749828366; x=1750433166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJyEx9SEtMoT9W574jcNh5RLLtb5eK5nBGN8Lv2U/V8=;
        b=IT+zgK9tshirZFdcjv95do9YnxYi+asmrxVUqSX9K3SiLvuXrg/csjG2Lz2iD4WDrD
         KGpO+RL09zdoGwAA7pn2wTseKl563bEVBiO5D6DWo+1E3LcdmIewF5rFEuaW3bC1hFXh
         fu9l0iN/iKGsoGvuvAGr3/imrSfjAdbj8Yn9ov37jukVDRVnrSIL7p1HxhIFIizE+Agn
         XBHgbrENP9pWBPGEMK+AKSzl59y9akCH0JyXU0pOJmcTp4G4wdyFZY5KIx9aTeYGx8rK
         VfI+6GIEjBh9H5fPc2FPvCWdYLGV5Q/o+OqO+DBldp270/TiWNGbLGPnWcwp9zCVKiub
         vIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749828366; x=1750433166;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJyEx9SEtMoT9W574jcNh5RLLtb5eK5nBGN8Lv2U/V8=;
        b=SKocH/JeDH6DSp5C7V/0GZJu532GjU7NMi0C3/7MjtPV0n8p7cqF0Df4sB0o5AKUf/
         zGJEYQHaenSXjBdvP5G27cpXoN6hHuChGX3Zy4C6a+nsi8eZg3xMShd+9xS1XWPlvJh2
         +hklxcKe/mR2BW/3N8h2ZrJmlzKvpYrlCUrPgvaN8FJaJGKUq+6f7zWXJOunkNYH0Use
         fxmJa4IhbDdsV9JRME1xmn4v1jXVqbu2mo0/CsRfj6GONbMNAm9TXG6uo1ChE/F84Zgo
         ENQ+QpphK5COnDfNX1nFI9X4q85KxhVnfWb8tt9U11TOKBLnvhN6LhXGwUIDpEsxT+f/
         3TLw==
X-Forwarded-Encrypted: i=1; AJvYcCU01zQCGjf3pej1VytmGuVWeEANOSqEYRcGHKIMZozh86ZHYXSzwZ1osC45twqUOo5GLAW9WNCpeeFjiw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc4wXndo2dSzhkqdn3HT2FFXuw2tM8PIUB5AcfevstuzkOlpMl
	h7PFPECYqbri1sMwyvF4AnyqXQYkf77q9KRt7XdTEAcISlojbOIAcEODHZ2jYOFZFe2d7tBOpPZ
	Vd2Kf
X-Gm-Gg: ASbGncuMgIJP6PUgyI/hAInpLk7V/JEgrlwg8ihZqQ1Mz4Ft0nNw0zhjQKlQqTbfyjw
	NzmAreHeEaA9/DxhwLR0+AkBSU+RpC5KTz7GR9OvCZJeugeJ0d2v5KR3Mcc7j/AlWTgDO0I6gQT
	AJcjn2XubaatXStGKm4VdhDhUg733u8qMILSs64QbuRf/FBgPhTwu5Z8jt8Gpbc7mOjE1oC5t72
	iOC5v3+Y6ZW5GWs96BOG/3nCr2RaMM0PakqQXqUCEc+csBTTQRyVM29HetDHujalIsQEjm+0a2z
	kbknmbgL7A0NYsgVy+rZ0zKNPqp7VLOTbuLneCn4L9rdA5Wolgnj
X-Google-Smtp-Source: AGHT+IGYvJK3/OvP02MLHyARtWzj0lGmzWqmFxziBjJCVW+F8NXt7Xn4uM0PaH6+Trrm9TNdqvfACg==
X-Received: by 2002:a05:6602:7504:b0:866:217f:80a with SMTP id ca18e2360f4ac-875d3c88149mr444305339f.7.1749828366385;
        Fri, 13 Jun 2025 08:26:06 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875d570f54fsm32817239f.10.2025.06.13.08.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:26:05 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 Linux Documentation <linux-doc@vger.kernel.org>, 
 Linux Block Devices <linux-block@vger.kernel.org>, 
 Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Ming Lei <ming.lei@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20250613023857.15971-1-bagasdotme@gmail.com>
References: <20250613023857.15971-1-bagasdotme@gmail.com>
Subject: Re: [PATCH] Documentation: ublk: Separate UBLK_F_AUTO_BUF_REG
 fallback behavior sublists
Message-Id: <174982836505.723307.4689076506739660480.b4-ty@kernel.dk>
Date: Fri, 13 Jun 2025 09:26:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 13 Jun 2025 09:38:57 +0700, Bagas Sanjaya wrote:
> Stephen Rothwell reports htmldocs warning on ublk docs:
> 
> Documentation/block/ublk.rst:414: ERROR: Unexpected indentation. [docutils]
> 
> Fix the warning by separating sublists of auto buffer registration
> fallback behavior from their appropriate parent list item.
> 
> [...]

Applied, thanks!

[1/1] Documentation: ublk: Separate UBLK_F_AUTO_BUF_REG fallback behavior sublists
      commit: db3dfae1a2f662e69d535827703bcdbb04b8d72b

Best regards,
-- 
Jens Axboe



