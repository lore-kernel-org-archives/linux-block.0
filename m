Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5097115884B
	for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719587335; cv=none; b=nzml6HAEx6lH2ic/mGajJv07mNgAEAmsT1TV1edAgGgfomPFatBuWZcedKUrhEB+ABqssoEPNGLChGB53b6ldEAYJd5+VcsClcgV5kcl5Ew/OZoJW+dzSKYC4QKS8419n9YvW3xqr/YNz3WK51m4mOzKxPHtSX7+iWYvAIqBOZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719587335; c=relaxed/simple;
	bh=uguMuXu6eD6GQB5wr9l14vpfpYEItRi1lJPBJaWhyjg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=k/j1kl6cdIoQ5voUWc+I7SPGiEDlfUMUz1RvSiHlLZuXSJcIqRdLCHU5JuL6CAMGfIajQM0DUg5MRuLN/qIpBvyEgWpAFFrK1RwH/b3MQMRaiOZZpWlDl3HZLAP9vf59L03hGAb0xWLH9UDFYJH3uVFawA6sNOsdSdzdGP8KRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nmtxL4SV; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nmtxL4SV"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c5ec50da1so112773fac.3
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2024 08:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1719587330; x=1720192130; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIhsE3emM9nJbihGn4biwnhHfsfbPa84VtlGPwTPpAQ=;
        b=nmtxL4SVIbeDQlKee2WAYZvawieb0F2PJjl9IGRHogka1+yYWWM2j7gr9wftDlaRD6
         qb6IeAwLFwKP9l9H9eS3RmQXwPsTI+Z+499CKwgSl2auAz0+rQA03U/b8Zi5EYmnFQBx
         zqd9qPZ5XlEsM5NPcXFbGYVsaxyzWuQkxk/XFKNpUHzSTrdArl03ZX+1yOFtyOBMrdp6
         mtEIHdsXNu4Vhm4I/dtAvP3ighJ7BWKKLWyGsQrwGDyaifgAC5mfhJpROLmHpDpF1zTQ
         VnXNNWBstDH80/QpFWlSPL8ji+HE9VCEC7LP4DFc7SqeTfJwW5hxcvMZovdw9kkydSgA
         qrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719587330; x=1720192130;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KIhsE3emM9nJbihGn4biwnhHfsfbPa84VtlGPwTPpAQ=;
        b=ZOK9J/V3/7bw335CQBIkMyNVaQKPxOS/JmhHqtozXvxaO7P/3b+XpBGzZmmy5axvUN
         vlAhPct7QlQl18hud0ty8MvC1n7fBmxvYExKi9mIQkmzS8XJPaQa/SrWkOk1ydY1Ybe2
         ARmr1+TYL0/iIWrNszflER30s5raIRLhILVimWtxy7s3T3F3QzAlzC4NTaWl9PW0aNAH
         155XUJPpYe9dn78WWMurawl9cWCGwWQXBXbsfwotv1G3v5p5lp/P4y1id1Tl8+g/V81W
         zXA4MkI9XUHBIsAbfT+iK32fPm14Wmq/m3PiRWlO7SKReE9bQSJxSA29/lBZ7CME3eDw
         CD1A==
X-Gm-Message-State: AOJu0Ywec7lb3zD4Tchbv1k/7q4zw1jDEpt3TZq67p+gkzVtEUF9uHLR
	u7MA8XNYy6p9r4VTpRKeKEhS7TSlpErlbPLHTf979fp5+2kQrPYugb1OYk8YmnMBk962pmAe4Qh
	kle0=
X-Google-Smtp-Source: AGHT+IF0J/NK6l3i4nYn689C9riBCJuFg4DNfLvs6UC+NeIVidGzfQPEx2mfGxB5LNWdoVK+Jd657w==
X-Received: by 2002:a05:6830:a96:b0:701:f366:71d7 with SMTP id 46e09a7af769-701f3667298mr4445580a34.1.1719587329915;
        Fri, 28 Jun 2024 08:08:49 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-701f7b387b6sm337355a34.77.2024.06.28.08.08.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jun 2024 08:08:49 -0700 (PDT)
Message-ID: <57af218d-4c23-41b2-bc1a-401eaf393888@kernel.dk>
Date: Fri, 28 Jun 2024 09:08:48 -0600
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
Subject: [GIT PULL] Block fixes for 6.10-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

NVMe fixes that should go into the 6.10 kernel release:

- NVMe pull request via Keith
	- Fabrics fixes (Hannes)
	- Missing module description (Jeff)
	- Clang warning fix (Nathan)

Please pull!


The following changes since commit 5f75e081ab5cbfbe7aca2112a802e69576ee9778:

  loop: Disable fallocate() zero and discard if not supported (2024-06-14 06:21:25 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.10-20240628

for you to fetch changes up to cab598bcef0971f11679b048cc9f502cc8143c88:

  Merge tag 'nvme-6.10-2024-06-27' of git://git.infradead.org/nvme into block-6.10 (2024-06-27 12:15:16 -0600)

----------------------------------------------------------------
block-6.10-20240628

----------------------------------------------------------------
Boyang Yu (1):
      nvme: fix NVME_NS_DEAC may incorrectly identifying the disk as EXT_LBA.

Hannes Reinecke (3):
      nvmet: do not return 'reserved' for empty TSAS values
      nvme: fixup comment for nvme RDMA Provider Type
      nvmet: make 'tsas' attribute idempotent for RDMA

Jeff Johnson (1):
      nvme-apple: add missing MODULE_DESCRIPTION()

Jens Axboe (1):
      Merge tag 'nvme-6.10-2024-06-27' of git://git.infradead.org/nvme into block-6.10

Nathan Chancellor (1):
      nvmet-fc: Remove __counted_by from nvmet_fc_tgt_queue.fod[]

 drivers/nvme/host/apple.c      |  1 +
 drivers/nvme/host/nvme.h       |  2 +-
 drivers/nvme/target/configfs.c | 41 +++++++++++++++++++++++++++++++----------
 drivers/nvme/target/fc.c       |  2 +-
 include/linux/nvme.h           |  6 ++++--
 5 files changed, 38 insertions(+), 14 deletions(-)

-- 
Jens Axboe

