Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39ED91F7579
	for <linux-block@vger.kernel.org>; Tue,  3 Dec 2024 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733233334; cv=none; b=EomHwkSTTbhnKrQfQkKpQ1eC+vbOLjFZS05VUBKJOh8aQN6P5EjRQ465BSitg2sNQtfTPuU5Y2Mo9GQAOXIo7JaZPCqf2l6m9Sl50bOaAou+l4Y99XIMICvjBr1N+BtFlWUVS6BjTa98NHlWr/DA/95n8/UNGBRbYviuh7Ft2Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733233334; c=relaxed/simple;
	bh=swAdhm2eapOPHzUUlpD6v5igVWTBbj4YrPwfSTMXPjE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EWCk0hL1HgJmafaC2g5VJ9sM0IkS8gaqDLOY5ZPq9WSsCyZ2ZyQYvZG5/NXDHjW4uWjbZmoWNI0PgLjSlpdStXQA1SoB59aJW1SfbRGqTc6mb16cnfO5h0rmsMeH+YpS7N90aYFHPsMB5xmxKPyIefne+6ELzSFIeSMq78Suf1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pbubcHWY; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pbubcHWY"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5f25da4f999so267526eaf.3
        for <linux-block@vger.kernel.org>; Tue, 03 Dec 2024 05:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733233331; x=1733838131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OC808OH4fso6bInT9VuepjDrgNBDvQNxVS3LcD0axiE=;
        b=pbubcHWYfsTdwHTRs66yTuNa4iXGgrc/XFdHnPvMQ40zYwLONntpGo12bVLni6w9Yc
         wdBo3n3Uz2u2JXdVXkDpeptJHUcj+M0GJ2f4V+6bToKfMOyo/zhoaQceu0urmgL3PAB5
         CwPsjkvRlpD5/tv0iBGal2d9wiNgaSB60BuSewN7IBtGB3jvw7qvcFqEEveaQ1w/ye5d
         plsYly6TLxWPrahgvOqmAOWHpFZY2qPOTSH83yEezVWK5AKk/BnONFi4nxB9mWLK52Ex
         JzMPTRzchYpDaPB0a+v8z2K0wRH5YN8YyNEt9LvsW66uZnnFa8LTyI7+c0BC8UrhYnq9
         iAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733233331; x=1733838131;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OC808OH4fso6bInT9VuepjDrgNBDvQNxVS3LcD0axiE=;
        b=D7tRC+cafa71SaJNmAmMllTbL8CwCCsfVOPw8u1xf2CKMAVS6Ysi2NPc8YeS/50668
         m6BcoVwcRGLF7YwVWLxm5xf9SP18PgtQ1vckHbD9ulNxhVIujqAT/X28Luv60SyfJ4u/
         F30SWlXyQ9tzTiAciZxPpjiKWR+2UJwi+ePy5OtKEytul4UaspvBzYx0Yy+pJ2pwIVoZ
         ugCFr8dSr2WyZeERgW4qtNMupg+3jiGsXK4BOucK/c48DbRcnJgmw9o/+ANp3D02wbUR
         sYlhLHeEreKQ6yXuf/1qPVxvLjqJagX3cPBr0QYkHEnTHtYgmmuzTG3Kgb7CKjLKQ6FX
         aVtQ==
X-Gm-Message-State: AOJu0YyPRxK2L096NYP1dw8SUfywl41C9WUhpPVe0SVL/LMFBZ7512+f
	O7c5Kiz6rj7TwTG4AK2H2Nc0m4E6wG6X9CKRJH72bUTvC6QpUS32x9cbeGFHPGE=
X-Gm-Gg: ASbGncs+xC8xtGHpNhMenPaS7+jtGXWDtM6c46zeGn2FESadmzkyjvd5yaYtBMnje3m
	tYBecG0kd//frAeGx5ZhuNrp2ucNts8Zm8scXuHXBqJ5MafZ6wydST+v/inQh7XYyutagdr2Jpw
	lZYP3Okxs7M6C3tUJty72EKmsLtexcRQ2TvFJhNv1rKIho9x+1OelX5aPbsN2QpsJ+dP5HHZ7A7
	KiGMDeT3/L+5aP+n6Z4GMHerSF+0+uN0nzvYuaTA0qNfQ==
X-Google-Smtp-Source: AGHT+IG9pT2mrXevy6o0bm52Erkrf+w3fU0scfAFMj0oTw55yoG0N65LlD1tXQIzU6UaLc+dmzgsgA==
X-Received: by 2002:a4a:e918:0:b0:5f1:e905:bc93 with SMTP id 006d021491bc7-5f25ae0e5c4mr2010026eaf.5.1733233331308;
        Tue, 03 Dec 2024 05:42:11 -0800 (PST)
Received: from [127.0.0.1] ([130.250.255.163])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5f21a4cd86bsm2782124eaf.29.2024.12.03.05.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 05:42:09 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: a.hindborg@kernel.org, boqun.feng@gmail.com, 
 rust-for-linux@vger.kernel.org
In-Reply-To: <20241130094521.193924-1-fujita.tomonori@gmail.com>
References: <20241130094521.193924-1-fujita.tomonori@gmail.com>
Subject: Re: [PATCH] block: rnull: add missing MODULE_DESCRIPTION
Message-Id: <173323332913.59116.9985316859123945765.b4-ty@kernel.dk>
Date: Tue, 03 Dec 2024 06:42:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Sat, 30 Nov 2024 18:45:21 +0900, FUJITA Tomonori wrote:
> Add the missing description to fix the following warning:
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/rnull_mod.o
> 
> 

Applied, thanks!

[1/1] block: rnull: add missing MODULE_DESCRIPTION
      (no commit info)

Best regards,
-- 
Jens Axboe



