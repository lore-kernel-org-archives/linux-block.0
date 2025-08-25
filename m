Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB64B275AFC
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 20:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154905; cv=none; b=tPOZSOo40gFlNlJO/jRojMNQ5pt25lsJmyljwSwEd4LrDMRqknp8BbIcMmM5mLztvFqlsDX/BoDuiJfTu2sTiTotQSmab0K/PnzKoNpAmrDlRIQliRlvUf0UmVECW/mAN27CeUK1US98jX1Y6FChDo9/JxJmocMWhA9FXFXrR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154905; c=relaxed/simple;
	bh=ws0OH/LPbfD0uWhZ3//ck7/pwntfVUXedOFJRthyTE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fBYHY5k1T3kp8yZmaWFXjONiuhdqrGtyfMwyY1r6Jvvjx2VQABzhGA69bdc4xwJOwDReUWGElNjF/bJf5JbUJ3c5mQ8sBwLPYdmBCdPsVvNN98yvY36Zzp8fOIcqkRzlJV181N/wuh9l9GgY1vP69BJCUTuY4ZyE9GvyDzBjoyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jZH9/6ae; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jZH9/6ae"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3eb6da24859so14330835ab.3
        for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 13:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756154903; x=1756759703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/dnllQLN8cDpaKVqJzQZtSLrZ7j3LLHfYLifC1ogCM=;
        b=jZH9/6aeiq6scjXh74JMeDRknBu0YK1nVmdvthVMAlC1uKD6/6YiXbcN0d9uOFhQ8y
         n5VOI0KFRdom7vcCh2mFTkp2sEjBeLtvrpwmjhGTwmMURUIf+hINw3wtrwFg0VAZvVFJ
         DnogJpcDUJSSM4JQ5eeutJ85KJnu2jhLgUnKiMuACh3rtdaPxU6Hb5AmPv7aHB4l8mNu
         IvEzWzVGgskyavxiDt7E+Sqw275JD1aC7EtvEnGuIrA5LEDxWYauZo36SBhv+aKCCKmh
         qp7eK8YXq5krcHBKgokh3yv5r2zCwcezlUnx5OFFgipygHxemWQ6ZEwnTtwt5qxHNkMl
         BZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154903; x=1756759703;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/dnllQLN8cDpaKVqJzQZtSLrZ7j3LLHfYLifC1ogCM=;
        b=gk0X5BB7XFBnl1gpiuTNQk0wjkapLfEWH8WnfJeuTuEjtg+dMXWmUABbANQWOAWZvi
         e26KBM7B9BeBrIcfHTuGIbNf4hpw7/omNUmyt+QnLGXPboqiQUrmGXsMTl3FMwcbxSb7
         1FK8zldHpBUrfCFZrUNhFb4ZDRvB8lffcnUbmg1GV1GlY1D8/s+eRP/sj4cyUZ87iAKY
         E0GYxNOJ9yjK5pwJLdtXlK6YDhjnJoEfX26OBSotu6ZFCfgEp9gADY4yTsnh8KN3qUEE
         nL7NNZ7Fw9CwHa5n+NqJbFl3yjqwofFu+HfhXbGNBniIbcWiEV+mdaybGv60MHQ1bya1
         n9LA==
X-Forwarded-Encrypted: i=1; AJvYcCURO2Gk49qCYffr3+iVuHW8U/y7AqoamUAyG5lVmDditWsn4mrYHJ+GobfM8ciYlmJFGyCjZ98f2X3SfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwOT67BejoFpDkUTpDCY5Lr/m6DdQyHjwTEJ0v29NYfgu8nlT52
	8WlHjXLmEKbxksg6N8OyCSPX1pjxy3Yts2b1tGQAP23nkZ3fiYzH50EPVl8f9E4sdTw=
X-Gm-Gg: ASbGncv9UQ0XMshVTPFtS3r9L1POO6YiNiO7BTwduuOa89uPg/9ydrmwHPajl37jjaJ
	f0unRSTGwwHPXbONJl20ENXEYJsA5eWro0kpYmXA5YJnM521M5mbRYMCmFiMIhTywcWyk/rRRrK
	fhZU/Wg8F5ql+gh/vqU+5hNH17dqyhmAYOhX91jxh4YWEfdIH0zNtHQ+2faP5310l0bNSue4f6Y
	HxOQBTjkJ5iSZwe97bVejlc3AjfBcO+MdbgRqrVDv1UzAkClQ3PI2kWKtRyImBIJw7IBnxwqGNu
	8YOwQpBoMKoNJzhol2YPx81O1ywRHL0so6J8fES2YbqpPtHrFSZvc7q7cUISWCEQxYH0psDW32h
	u9ouE7DrUh/SbsA==
X-Google-Smtp-Source: AGHT+IGz/OLusjKqnvYuytsepj0QasUaFhQNGeebbI4cWxx4cpCIdsaTdG9b8SEzhdQW1utDLqTgxw==
X-Received: by 2002:a05:6e02:1582:b0:3eb:cca5:5586 with SMTP id e9e14a558f8ab-3ebcca5874cmr83676445ab.17.1756154902655;
        Mon, 25 Aug 2025 13:48:22 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3ea4effe70csm53084775ab.51.2025.08.25.13.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 13:48:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Thomas Fourier <fourier.thomas@gmail.com>, linux-alpha@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-block@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>, Ian Molton <spyro@f2s.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Denis Efremov <efremov@linux.com>, 
 Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20250825163545.39303-1-andriy.shevchenko@linux.intel.com>
References: <20250825163545.39303-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/3] floppy: A couple of cleanups
Message-Id: <175615490112.25116.3742797696959119744.b4-ty@kernel.dk>
Date: Mon, 25 Aug 2025 14:48:21 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 25 Aug 2025 18:32:54 +0200, Andy Shevchenko wrote:
> There are a few places in architecture code for the floppy driver
> that may be cleaned up. Do it so.
> 
> Assumed to route via Andrew Morton's tree as floppy is basically orphaned.
> 
> Changelog v2:
> - combined separate patches sent earlier into a series
> - added tags (Helge, Geert)
> - fixed typo in the commit message (Geert)
> 
> [...]

Applied, thanks!

[1/3] floppy: Remove unused CROSS_64KB() macro from arch/ code
      commit: d74968780bf287958e2815be5f088dd6c7b7aa19
[2/3] floppy: Replace custom SZ_64K constant
      commit: 8e7ee0f6fa33934373c1c37e8cfb71cff2acea09
[3/3] floppy: Sort headers alphabetically
      commit: d4399e6eb27a803b73d17fe984448a823b4d3a30

Best regards,
-- 
Jens Axboe



