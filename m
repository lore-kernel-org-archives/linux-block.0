Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439AD22A7E6
	for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920914; cv=none; b=Yp99v3sB0blrmjp5gc7zjC31suoNdWQ8MxB1BMwm9vAVun8c6/Q2scFjtIWoOVdEh6xogxNTqUB43TbwlownvzJB9Tys+uCEsvyEPtVvmU5hpGnRTZmBcZLVKOfWpS8iRbY2/z3QJDHORP8WWL5m5zS0Tdz6P7qzWTwbPcSP/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920914; c=relaxed/simple;
	bh=GubqMgiX4ooo3bzumQQGvJZHe1W3sY603ZYnm0heyNA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r74oRQ7DhwNMcRkPN1PHRwuaVsp6i45o6dPHIOAZKQV39jvMxtLt8egJbIGXgQ+d8MFOJzsYr25plvVsPtdwAKldUZKudFCqXh/lysGqfLg6jd5LC7Jg+xFW/o9VFATgprpJF1it+QxgtC6Ce0tMzH17r+sJF9Ng9jIGnIQj95M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TbFmKEry; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TbFmKEry"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-321a2faf29dso901321a91.3
        for <linux-block@vger.kernel.org>; Mon, 11 Aug 2025 07:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1754920912; x=1755525712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pytqrPdqiE/DDlNNA2hijqy4loXEQIRQQTm8Sur8Efw=;
        b=TbFmKEry4Dh+P3Q+YCEbJDE50VL3oSDVoSYpwx9JNi9tAYFgt8aMdUTp03/NCZXoBy
         CmzutA0WgGXz8cB8B+ONn3WcCg1BMcZXsRCt+6rAM/slyOghKnXsFp9HIcNGbMBfhsKQ
         /ayJtDSMtLFUQCNiIbuGhn/7qGIofoGkolSYovUrPf+3huqTAgRG6HaB5JHwMv1Di2sF
         7m/fDZJbg/vjHLDSdWzI9qOONzl94D2c/QVDXqTFJTVQ3oxktQMNtAGYAUrYJgcxRBBk
         dJLcQIB6zL1xGtIvDnsLrX1d41oryGKEilgAIzhZm5fgymoz9Lokqpc+vduCCvDByAFB
         1+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754920912; x=1755525712;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pytqrPdqiE/DDlNNA2hijqy4loXEQIRQQTm8Sur8Efw=;
        b=Aoy62wvD6wfM69pEmh1/7iq/KKyA8+YenP+IMzXK8G1ppndJTh9jKv2nLMBtNLA0zK
         myxLkV40lIF+p3YUJO1mo7a0g7cZu0xCmVGMiHyLVShRsgUVgsxdOyCBR82rhzf+/rc7
         o41Tgd2jN2tP1OpVMAbLFOVwMNLmkke3ALqnB7NaHzE+HkhH4aWz3J0YG8vPeCZyMltn
         jjARGlG9cF+hmgfp5u7mUnGlrmsqr4J8MHHyIW/qJtPNM80No1gZadrxSJxNaA4zOsOC
         OyxiWb1G/plW+6CFdqo8nAMJs8N6DTVTYYVNx/E4lyvWhwX8On5VoqUsEBaaLwI5DmJQ
         QlWw==
X-Gm-Message-State: AOJu0Yw0/DeDM9KE2lGTrYLayueyDT4ulz6nJorT7tnhHHPg7KQycaM4
	sop5YB3R+4rhO7Lmru6mrTSiI9A6QVhj7uBVF8UhhK3QGv317Vei7xTWhSJwqojqedeyBBirHL8
	JxVAG
X-Gm-Gg: ASbGnctvCjmWKyJ+LuWl8tcLRfPmHxkwBayaiidoweeNcQPoVUGXeej/+F0TaQKU6b3
	oIjOtDRjKvGYd2A42SGmYQ9j9UOGmxvTK9CeH12B8AGkLdU8fpnw7JkCwx0EPdoPiAeP3Yi0kK7
	h5K785Gd2JR3afJ8pj4svFlpyIb8+G6zxLD3ScPz3uG6RhNC/S7eVlLLJa3Kneu9Fxmb+9DILed
	gVxJaGEw8/yg7ENEeCeh3Vgp/bsrrfzEs9J+rfiQrROJFTXLdJSRKdGFRSEj6HFnJbRPZCU0+Ij
	6zmJt8eI8B0bnU3m0n/oTiMvcZ7x6ryR9HpDRETocIRK0OLUPm8XWbb0m+8L5Z+aOZW1etNyZVi
	v4I9a5e1QW/JEAG0=
X-Google-Smtp-Source: AGHT+IENlkeiAPcHAcA+87B/RRXGblT9xTDrIHRKxm4Y7guv11yoxs8qU4OCwMNXyYFXMBIOsT6igQ==
X-Received: by 2002:a17:90b:3a85:b0:311:ea13:2e63 with SMTP id 98e67ed59e1d1-32183a045c9mr17238321a91.13.1754920906362;
        Mon, 11 Aug 2025 07:01:46 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161259a48sm14821216a91.18.2025.08.11.07.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:01:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Uday Shankar <ushankar@purestorage.com>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250808155216.296170-1-csander@purestorage.com>
References: <20250808155216.296170-1-csander@purestorage.com>
Subject: Re: [PATCH] ublk: check for unprivileged daemon on each I/O fetch
Message-Id: <175492090530.697940.18050903274660070529.b4-ty@kernel.dk>
Date: Mon, 11 Aug 2025 08:01:45 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Fri, 08 Aug 2025 09:52:15 -0600, Caleb Sander Mateos wrote:
> Commit ab03a61c6614 ("ublk: have a per-io daemon instead of a per-queue
> daemon") allowed each ublk I/O to have an independent daemon task.
> However, nr_privileged_daemon is only computed based on whether the last
> I/O fetched in each ublk queue has an unprivileged daemon task.
> Fix this by checking whether every fetched I/O's daemon is privileged.
> Change nr_privileged_daemon from a count of queues to a boolean
> indicating whether any I/Os have an unprivileged daemon.
> 
> [...]

Applied, thanks!

[1/1] ublk: check for unprivileged daemon on each I/O fetch
      commit: 5058a62875e1916e5133a1639f0207ea2148c0bc

Best regards,
-- 
Jens Axboe



