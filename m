Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779E51C2DCD
	for <linux-block@vger.kernel.org>; Thu, 12 Sep 2024 22:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726181065; cv=none; b=FaZhH0qeUKpTR7bJzJAa5Jgyu8b/aATL6m37A2zUi++gdNzwTEJUXtSqnwL1mcFEy6gM+CXpYAicO+3V8eTQFdeWasyTZzC5oKucziqWQ66EznMHWxtoxkqcrlZNbcTh42gWZC23WJ6eQEU3VQk9dt3wJxqCUwbuR9M4cPnNP1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726181065; c=relaxed/simple;
	bh=J0iR2etiKGhY3+wZ2OYugimOzkoweMRjPToQFcQqhU8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WXRyd9L1GeACaOkKS2KaBxuRXwlo0u0DR6u9Am6FWeqSC0we68u+hQ2Im27NYDxNSn63+JC0vnfyqZmwasdbujtQYkzhBxxNBEFzj8qwd45zD/1c7a1Mo/NrrsYzWhaOgf50GI5WsimGaIPcxAANtSCHyxSYeGACWJneCraMPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=MfDwTYa1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="MfDwTYa1"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2059112f0a7so2492525ad.3
        for <linux-block@vger.kernel.org>; Thu, 12 Sep 2024 15:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726181063; x=1726785863; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEczFHX+4D0Nkx5plDp6GsddH+KnlP5tmzPkaURbGdk=;
        b=MfDwTYa1zqbWhwoz3wt5f6m9UF+L6tPKNUe2PDW/jepK0hQIWJ7+rS0WhIhJ4+fdg1
         pYm/DwnEYrLaT6i297VV0rKrj85t1w2NWIMVBOP60oC5GcuhydOr2ZhYdR4qdW0A+TO6
         xSaC23rkED/ibagFh/K1GiTVrZaFsUik85uBUHs5n4iRir/PWv0S8W2b73b+ftB4OHhB
         rAWhNbuGrxbuuueqzpabcih4a73urprzyNF0drMVX6vd8jcMctz93sF7MVPhHXXuvnVZ
         oqwnLRzLRO6Gu7aSFcqmQKsngo5xi6KsLwiyF8HYubUa6LoLQAVYwJfC30DNQhLBW+Zd
         UUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726181063; x=1726785863;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AEczFHX+4D0Nkx5plDp6GsddH+KnlP5tmzPkaURbGdk=;
        b=sqMTOQguFD0+x0BT1g3ZgtIRFojo9P/EQb3wsGC8QBxNGvvTpknwWeGiSP/3pajX/n
         311BKJAWD7qCPBho6IX2zoeEeC9sHO38JVCGvwPh7R2vhcdOo9A4aTWOgxFVNYug2vkj
         oP0uZoqavQBvUDgFW7gMzmeAAjf54m/hy7KeDpFXs4Wql/UKkN683zqtvRt5R4HQEhwi
         bYHEZmuNm+U5BYq3qJtyqqgkX8lWlzW0tDansPQzYrpgcpoRyc9M0aIRCf5zuSHFwv0k
         4pmVVXq0nHNcGEPeJRFnYLOXn2optIRpRtfeXNOgowk1MEJBJF7KJOIQlEeSPOt74dgi
         5R0w==
X-Gm-Message-State: AOJu0YwgaraLhgsE47rAuCNdxGCMZmajMSN+bA/y/fmEzvfJPV4w8jSw
	xlicQmtInzWHIMUFJuZQnPeGFK2kDub4ee4KBlSe86oW6zEZoilB6gGODs3DhlvViqlGDJuHOAQ
	I
X-Google-Smtp-Source: AGHT+IE752g5qDf/yZ9Rzm2azKLpXQpJWJKAU5vA5k0+g/2ANsRuRcXdMNcqi+pqER8mb3QIVL9PqA==
X-Received: by 2002:a17:902:f643:b0:206:a935:2f8 with SMTP id d9443c01a7336-2078262cc4amr12247775ad.2.1726181062624;
        Thu, 12 Sep 2024 15:44:22 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fbc3cb5sm2256778a12.52.2024.09.12.15.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 15:44:22 -0700 (PDT)
Message-ID: <c8f3fba4-9cc1-4e7c-baf3-afb10ab7605d@kernel.dk>
Date: Thu, 12 Sep 2024 16:44:21 -0600
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
Subject: [GIT PULL] Block fix for 6.11-final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Just a single fix for a deadlock issue that can happen if someone
attempts to change the root disk IO scheduler with a module that
requires loading from disk. Changing the scheduler freezes the queue
while that operation is happening, hence causing a deadlock.

Please pull!


The following changes since commit 4ba032bc71dad8d604d308afffaa16b81816c751:

  Merge tag 'nvme-6.11-2024-09-05' of git://git.infradead.org/nvme into block-6.11 (2024-09-05 08:45:54 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.11-20240912

for you to fetch changes up to 734e1a8603128ac31526c477a39456be5f4092b6:

  block: Prevent deadlocks when switching elevators (2024-09-10 13:43:42 -0600)

----------------------------------------------------------------
block-6.11-20240912

----------------------------------------------------------------
Damien Le Moal (1):
      block: Prevent deadlocks when switching elevators

 block/blk-sysfs.c | 22 +++++++++++++++++++++-
 block/elevator.c  | 21 +++++++++++++++------
 block/elevator.h  |  2 ++
 3 files changed, 38 insertions(+), 7 deletions(-)

-- 
Jens Axboe

