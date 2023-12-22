Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FB433CED
	for <linux-block@vger.kernel.org>; Fri, 22 Dec 2023 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KcWfQuVl"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d42ec6c6fdso1125715ad.1
        for <linux-block@vger.kernel.org>; Fri, 22 Dec 2023 15:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703287210; x=1703892010; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYhDbVX47z2N+8t5R8HG4Gpbw6ebWyYX6QtbtLEUEFg=;
        b=KcWfQuVliE0cUChB0PBFpVt4UhnKy9J3LN0SMTGSIrowtqGxFBOwTT8rSMMuVKA+9o
         rfKWE2LVTE61P/zOOMwsUF1IHWHs2TJE+k68YbLAKOMxmVmyTwBihPBDNwTjkjOHZw7u
         WpH0n0r+2fHe29ADZXchx2gqBVpjpiQK6Q3WzfY+huNgYDOZD2KvO2kw3eGx1WrEtfcH
         KN2hjC8ekPN8F2/fJuA96/tDkA2CzfPkKyngE3BxEgmV3gtSCX675HCl9MZgn9PsVj/T
         h35WAebgaXG0yXCZp1xzj5AjZd4T3WWEW2Lu/H9BXZspN+bTIYRJic/XaENWBYSgzuUM
         LP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703287210; x=1703892010;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OYhDbVX47z2N+8t5R8HG4Gpbw6ebWyYX6QtbtLEUEFg=;
        b=tuDbAhVN1feswJn8SBhxh4x6i0sp/6+pF4ya1SsrNEk2DFbpnioq8ZrRvsdF7F52B2
         OE1OspUTJo2HdWAgSlorOJ6rbyYUR8Jn6LrctMW00J8P/su2+iX9Hv/oxGyspB/L9Xt1
         ao0WEFkYjYjQHh4/eoirUBgGuOQ+DLwZQ8IdsXo9L75JqdlNX4Wc5RvdctGg9CVZn5jY
         6bZ2J3HierFPDwujS+1UaOA63mqEyhydbSEsLddyk/vF9Sb+uAPGWWO1CQ6ZWgGEcqyq
         EP0oo5PsRRIE6435sjDPHf75dHllnXjbhVM3d96FHyhWJJGWnZiN7nglOWxiXvv2AquV
         EP2g==
X-Gm-Message-State: AOJu0YxsKwQF1ZALiVwSKMT1BxfQxetVY0DXMXkmt5nvvyNtzQ1vnpuo
	gFaxa4wXNqB4lyayiOFy4vCK+zQAhmpHtSS+Bcdt/ScdZ4lpiQ==
X-Google-Smtp-Source: AGHT+IFRp+6A+l5SB4WG2KrDv7Ko5QCxKrOx5CR61UYWss2dMgMqgPmJFtWpy4wTTEKUTb+Vjclozw==
X-Received: by 2002:a17:90b:4c09:b0:286:dfae:32f6 with SMTP id na9-20020a17090b4c0900b00286dfae32f6mr3615006pjb.1.1703287210311;
        Fri, 22 Dec 2023 15:20:10 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id co9-20020a17090afe8900b0028bebf9624esm3898611pjb.23.2023.12.22.15.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Dec 2023 15:20:08 -0800 (PST)
Message-ID: <075bc8fd-e296-4b0e-bb4a-d69bcf7d4ba0@kernel.dk>
Date: Fri, 22 Dec 2023 16:20:05 -0700
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
Subject: [GIT PULL] Block fixes for 6.7-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Just an NVMe pull request this time, with a fix for bad sleeping
context, and a revert of a patch that caused some trouble.

Please pull!


The following changes since commit c6d3ab9e76dc01011392cf8309f7e684b94ec464:

  Merge tag 'md-fixes-20231207-1' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.7 (2023-12-07 12:15:18 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.7-2023-12-22

for you to fetch changes up to 13d822bf1cba78612b22a65b91cd6d4d443b6254:

  Merge tag 'nvme-6.7-2023-12-21' of git://git.infradead.org/nvme into block-6.7 (2023-12-21 14:32:35 -0700)

----------------------------------------------------------------
block-6.7-2023-12-22

----------------------------------------------------------------
Jens Axboe (1):
      Merge tag 'nvme-6.7-2023-12-21' of git://git.infradead.org/nvme into block-6.7

Keith Busch (1):
      Revert "nvme-fc: fix race between error recovery and creating association"

Maurizio Lombardi (1):
      nvme-pci: fix sleeping function called from interrupt context

 drivers/nvme/host/core.c |  3 ++-
 drivers/nvme/host/fc.c   | 21 +++++----------------
 2 files changed, 7 insertions(+), 17 deletions(-)

-- 
Jens Axboe

