Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B620726281
	for <linux-block@vger.kernel.org>; Sat,  9 Nov 2024 02:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731119103; cv=none; b=fgrfJDhHJbjBh6FfDeILqvv032hkGDPlROFSLhYv8wd3fP9kbK7SCwlYGHiEDPn6QH7W/Jegxr1iFUxUH4bKTJKfckHubr39TnDYf3IhvvkqEE/73sLrrvx5jjvD1FwBQiW8onay9weCtETg+nXNyPdtroKrisRoNND8aWo2rEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731119103; c=relaxed/simple;
	bh=fZ0/smuwsbYLNpyeD5r4VwBPZwD9amTMgle2MFXazmk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=nKroH1M/VXYmtxSjURp8FarVZCyM8pij9eg+7iyIxbp6Ktfoq/RUTBhE45scMtX50QFZW1jjU9Jos56Ttd8SDIg2Wjuk67uoIklAe2IGRrUdnVi6h2s41pcUDHPWncOc6h+7e3nl4FWRhdcpDVZ/YdlzLC48pnOM7MdTsjFckuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lmCxHcsn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lmCxHcsn"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e681bc315so2105559b3a.0
        for <linux-block@vger.kernel.org>; Fri, 08 Nov 2024 18:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731119098; x=1731723898; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuoFJmTt1hgN33UXL368GDLh19kX9dWZ+eFKeRLTNNM=;
        b=lmCxHcsnRZWcBcLWw57ws2NQ624P0t8guEsA+nC60JOkeQsRHmIy7BOV9PuaXW0US6
         l3oooywNnjLHvJSledih07Qd4bur+66z8KqnkR+Vx29yaGrhdXUsuY868cp0uMieMSSf
         hfrQpsw9cvVDjAhJPfM2aus9eudcnfYS8GfTaRUFXf5y2uMhOh0BY9IfVHpi/Nxd818u
         xwxp+844hMIaCn3OcUq+SEdBb5+JtJ46Z7mCKLwfgSGhKUqpLplCts54NUQowReuWFVn
         XtW+CZn7bfPgJ1ih4ds1uFhsj/Pn39pydW2cx8bHxAgIHDk2eNHiedKP8CP5jlh29XmH
         aMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731119098; x=1731723898;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tuoFJmTt1hgN33UXL368GDLh19kX9dWZ+eFKeRLTNNM=;
        b=AL7BsILJY1Tw4RHaOW0teqWPuZRPOLUCpj4ZdaLxjm/d6AmXHsER/AVs2WyvnRut3d
         dy19S3hVXArSBc9MtDqURikm27neO0AIAfnANmhRddKWQfjK4tDTXcb3ad6EfDUdlr+3
         ewfmBE3K8KHpSAjURfes8V9TmxlxKTNngQz5xQQshA9Sl+tvVC7t6u9yeBiTLJTMXjUi
         OKW+JA/JgPjhHKm2vnIIHcz2O/lB6se3kktVakGMSsTWajIWhV73MW5kG4I2WVfTvEiw
         u8LHjZHLKLxAdUM+cZKvqDhq+LFisIKarsQ+dFBsKIhMMx4/dgoJlNh2MDoeEPBBi7LK
         sDQw==
X-Gm-Message-State: AOJu0Yzrdku5vHXHdyZV3mk2SNhLDiemPEkBehZ4PGcmHvUzfot0giul
	Tjqir1t9GpGB8ASio2qK3biUKGwBHHp42iiGDT5lcUcBjYQEMdgt8ONJDv9zyWsCdlnRoLCBRKk
	fuig=
X-Google-Smtp-Source: AGHT+IG9yJ9ixl1j6BZAq4TEsE2DdcSl94UnYx+xQmftgA/JJip4uP6aR92uMSbOTmdvE5zA9PHZog==
X-Received: by 2002:a05:6a00:140f:b0:71e:6fcb:7693 with SMTP id d2e1a72fcca58-724140a4ddfmr8233826b3a.12.1731119098357;
        Fri, 08 Nov 2024 18:24:58 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa8efsm4674348b3a.124.2024.11.08.18.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 18:24:57 -0800 (PST)
Message-ID: <1178b3b9-6b42-4577-9cad-60fd899f391a@kernel.dk>
Date: Fri, 8 Nov 2024 19:24:56 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 6.12-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Single fix for an issue triggered with PROVE_RCU=y, with nvme using the
wrong iterators for an SRCU protected list.

Please pull!


The following changes since commit d0c6cc6c6a6164a853e86206309b5a5bc5e3e72b:

  Merge tag 'nvme-6.12-2024-10-31' of git://git.infradead.org/nvme into block-6.12 (2024-10-31 09:10:07 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.12-20241108

for you to fetch changes up to 52ff8e91f916fa05dd47b5c30afa3286c30db444:

  Merge tag 'nvme-6.12-2024-11-07' of git://git.infradead.org/nvme into block-6.12 (2024-11-07 13:57:12 -0700)

----------------------------------------------------------------
block-6.12-20241108

----------------------------------------------------------------
Breno Leitao (1):
      nvme/host: Fix RCU list traversal to use SRCU primitive

Jens Axboe (1):
      Merge tag 'nvme-6.12-2024-11-07' of git://git.infradead.org/nvme into block-6.12

 drivers/nvme/host/core.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

-- 
Jens Axboe

