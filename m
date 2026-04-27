Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698F53A640F
	for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323704; cv=none; b=pwYCegWdOU52njjP0N6LoTUAEZby/87/MzartowSBFRyfcw/DI4FZGjaDbWg0t61lBX1iHiEatwUgxUEYhG5KoBX2ZpuxHd807lslOHULymLlncDQVAglmw4/we/1xDoTF9eeiu964uMTVBXGUzaVgPJ/O/3tLzoJq2D4SG9Ct4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323704; c=relaxed/simple;
	bh=9PwDTvBqRlsGT1Io6SYj17OthVAMg7LfmFnM2z/+VTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7F58rcUmMM8E5OfAjBaZ6lWVfMAaAiW2AdDEVQx5JGsyWlo1fB3I8DL0TR5Sjuhipj7vWzYjYUrPSrYU/JqluUlSvv4RCGBwsQ/7FdYU+WxWPoRNL0YgmIfrdr9MUgsoaLBURcnbrGFji5o1VCOGFNDazrkZUAOmVHzIRU5fMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b=GJT5I0rO; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20251104.gappssmtp.com header.i=@philpotter-co-uk.20251104.gappssmtp.com header.b="GJT5I0rO"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so98398445e9.0
        for <linux-block@vger.kernel.org>; Mon, 27 Apr 2026 14:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20251104.gappssmtp.com; s=20251104; t=1777323701; x=1777928501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xl1BNL4UvkpMxVlGMpH9AT7kb5f8bNTPVulQaQVwqbw=;
        b=GJT5I0rOB7qkptUnakDeBwjFsMfhrLtxuqVMoS0kP3Ahu2DokaEySimYaiw5sWAGq8
         78wREH/fcXhRbHZ6/l+JivqK98KxwPh9+tx0JGPzF5Onip8loYqjKW3JxS3CZz51EOSM
         tY1Amb4e+jI8/Sfbe4o/LYrLgXTu7/ngVONNlBuQfl24U62eQ6cXGh3fDXW34jcC2xEi
         XSWwXqz+5Mqsz2xH3GrN8KjvX/eG1qfywt7FYMLKRqRlq3yJjBBNrFEzPVfMGKRMIs/v
         H9JuJfuJsIt8nUAM6RRTEz25OOhe5lks6bnggEUu/uyD3GubOdhThh1grIiydsa+0xyU
         I+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777323701; x=1777928501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xl1BNL4UvkpMxVlGMpH9AT7kb5f8bNTPVulQaQVwqbw=;
        b=S/USw+SVqsajZ3SWp9qfBB28Bi6SNdv+zh/mHZSv2WemslwSr5LqDE8cE4xWtVbnKU
         SVwjBq1QIRTSoxneil4gCMlMVpGAym2FxHLikQS+qrFbi01cvu/bEevtGO1Yow59a9yD
         o0jsiAYF4fJHaXNNwMQD8/oDPC8NqKJHw67y+GwBVUXx4P3+H7CTYNQIjM/C80XO2p+1
         Z1rqBJ9T3X7Pv/FiXkN32l8ZQfmsnS7xB24X99p5Y21P7DlFhMb1BeEB7Iz+DiAXogT0
         qtOtspFDw9RGeCnemUvZBx06dlOUNKaCEx7mxanValn7xnz/6+LuNqNUYYSUBMgl+Zor
         3NLw==
X-Gm-Message-State: AOJu0Yx7tmMaEUekcxfmdiXjChoYtD1twd/oozW9mfkbXynR7UKkecim
	igg0X9Q+FaGMgFJqE8v/uxD8+IpFuPRjGh8oP/xIOiib4uOhhG4uey4EwdeX2r6UjY8=
X-Gm-Gg: AeBDiesnZYA+FwOtWk94H9ubqp3lukmsEHS0NGt3/fFm6nkrcEkOYG0P/2ic9Edamin
	VfTNiHEkZYYL7ybLcExGjg5mtoPSU6ADPVY7iUi+L8Ed+HPi+sqRVll8BuOyi+cmtv/EkL7Dq1a
	2cSatxROaAa1cmKNjjC5LbNMU0U0IAHTU/MjjUhyFp4i3fEBYoBdl9L459/xIcKFjgHt03fno+b
	SBaMxNGmtDIB4v6LNwMEApBBbdlA+hMc/DDVmJJpfcgdPf4Hovxaj59UkZAMLWIAWZlC2Ck/hQS
	4opY8DvZaefcVwET6ukw6odBXkIRgZme3Z/6nYBSZZcBpzkM0svrc11I07H9Ya2DlnGRNzx6eLo
	cjA92CJzqxXGJuHJdqeH+sOxrkiTdhilveAhpAQVoVIH7Ih16zG1kk4/VGQFhbb5DiHPSHsvD6o
	jSS1gSdu61qmFxCDJUiMCW2vtxDC73OpNSmJFyxm+vON42IUbmgZyN4VZNkd0Ah5EBCqRnrbA1D
	NMqY8ch14ABDuB9UKjg3Q==
X-Received: by 2002:a05:6000:420e:b0:43e:a638:2507 with SMTP id ffacd0b85a97d-4464761c278mr708078f8f.8.1777323700366;
        Mon, 27 Apr 2026 14:01:40 -0700 (PDT)
Received: from KernelVM (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463cb59e65sm1165027f8f.1.2026.04.27.14.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:01:39 -0700 (PDT)
From: Phillip Potter <phil@philpotter.co.uk>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	daan@amutable.com
Subject: [PATCH 0/1] cdrom, sr: patch for inclusion
Date: Mon, 27 Apr 2026 22:01:38 +0100
Message-ID: <20260427210139.1400-1-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jens,

Please apply the following patch by Daan De Meyer from Amutable, which
reworks some code to correct a longstanding issue with propagation of
writable status to the block layer. This has been reviewed both by
myself and Martin K. Petersen of Oracle, and I have also built and
runtime tested it without issue.

Many thanks in advance.

Regards,
Phil

Daan De Meyer (1):
  cdrom, scsi: sr: propagate read-only status to block layer via
    set_disk_ro()

 drivers/cdrom/cdrom.c | 73 ++++++++++++++++++++++++++++---------------
 drivers/scsi/sr.c     | 11 ++-----
 drivers/scsi/sr.h     |  1 -
 include/linux/cdrom.h |  1 +
 4 files changed, 51 insertions(+), 35 deletions(-)

-- 
2.53.0

