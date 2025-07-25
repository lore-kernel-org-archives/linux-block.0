Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04E61C6BE
	for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753445746; cv=none; b=YrfnMN3LS4VFQILQdhKPJ+yVx/ycEysWsFtbNAB2VbtyFwOUjKrXGrzmq9QH47JiSguG1AL2tJYakLEdUoE/57Vp2zsbenBsNrliOeXor6Hx6W8CUECvHWieUipigdWMCYnGGq4sYkw+9ulJSPVdKQRsvabWDV5BF99gMVN4ulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753445746; c=relaxed/simple;
	bh=pkrmcYP5beaWXfSnlzeFe8szIbHljUrcs1E0f5bx0FA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=WNiz80dS5X4z7bVyA4VEaK8iVSspD5flHcsAHe2VTN7NIilLx0EQ/pLCYTbAZ508ZtKX+1jA0rALkqDjBICU0F7iZ8TvkYjlC8JJtUCPllVlZ6DU5Zgj6me1wK2/TcS7LNUK6ZgLKsRL3FCBv8OWixD7TqYRmxyKfwh0QyGASXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ANgPUTHX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ANgPUTHX"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-236377f00a1so17950825ad.3
        for <linux-block@vger.kernel.org>; Fri, 25 Jul 2025 05:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753445744; x=1754050544; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u50KxGSm/dJ8vk23OWj94nl3J/HKsjQPInCB6cEucew=;
        b=ANgPUTHXl80ZGjhq6iW43sifw65nJMzfL98LY6svKj/bJ3phtAIW+9OaYY56NQI+e/
         3/24CdzjblaBS7Hk+XbAFmhdYjCI58iWhC6OZpxahDweuxZY7rtugDeMrQkaPBvTcH7p
         xkZEm7Uj/yNB8aUf4//HEtwpq0eOavbsrMG0mkR5/B2iWG+z+ho2UOoIdb94mdiB0TGd
         brzvx6+VyaIpnzmhAJ8+OB7N6nepjd5Fdxk862V90LnQSqh0RuW5MVM7pHvyg4gMHUox
         IPNhK2LLYXu8JzG0pT9pSTFZ7rbDdeadpl1+n2qNDSP+LD/uqKjsBMmZOkYRdqRF8F/n
         Ph5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753445744; x=1754050544;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u50KxGSm/dJ8vk23OWj94nl3J/HKsjQPInCB6cEucew=;
        b=Rfo4MSMxbZmuWRGTrsP1izY2jupJI6lAUhP2cY/6sF/IcaQzhC4PTtiba7bp7QQNzA
         Lul82evQiLphwM55/iQNs/agp2s43pTpMewJmSG+LyG4Xijnm+6Qfo12baELpNVdCOrA
         s5BOrt7DerdQnVeUKxrHNj2NFJOFnKsTtY9EbIyjk0lIvX+1q3/jl3RMIdvcQ0PQ7UT7
         CgTPokJHZGhsHAIdL6yJP8Hom7gd+QnFtfJt4xdFjrBcRl54YgMMJCJVdHocteZNKOCg
         kQD1hj0q72sKr3ttN7oc3Wy5TVCl9end/dwkWjFmLSt2Vb4lBJ0JgQCwrSOCkX5qPUo4
         jIBg==
X-Gm-Message-State: AOJu0YxctKy/ep6p/Sx8uOq2Ws+ZsSvbT9gtP5wYHLjFMwCL2qHYdWac
	SJgXFRHwACwLusRDLCQPOwDp67x4oamy+x9V6hUT39I9fBpnNVIBurAMHIq5+IzWHnA9RV8e5A9
	ktNPB
X-Gm-Gg: ASbGncutp0uYcMSbXPzeqNdY/lTDsR/PrmXah4wW7kJgwYMAfelunQoDI7R6wOV+yqe
	gthTIrTfuOlG1fid7/1a4wTJ+uvKpL+WQGM7/+cvPR/btGqoMcgA1Iqxk7t/gIQ3FesPtEjBlS9
	vvqYHpT+7cCU7Pugq1W6+yReOc0f53MA0SS4PUgPwoMHtANYfJmgZzSy3i9xohmOaiyxkp8Ok97
	whxxUNjGlTi0EzK8GqGTgBKM+9hvuiAfiYpsVlJGbGNjeXX2aPtOXhxr1MNQ1sNHcfx9YNdOh59
	LrbpA/r3JbE3hTYquP2O2ZpMhvDkcl/8gvQxXeIL2rxwUwB58a9XC8CjZUI5I9zKuULpGCLjR3t
	g06KqYRFzTHh2ATlQYn0=
X-Google-Smtp-Source: AGHT+IHpVwNaSmCUhScaAni2YHIiHp1n4TKMEgkqizyljUxGGUXDXvjMRj6ACLIx6q40DgMY8Fu/zw==
X-Received: by 2002:a17:902:ebc3:b0:235:f298:cbbe with SMTP id d9443c01a7336-23fb301c29amr29083915ad.12.1753445744035;
        Fri, 25 Jul 2025 05:15:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbb27ddc5sm2505765ad.21.2025.07.25.05.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:15:43 -0700 (PDT)
Message-ID: <a0ffa959-d8e5-4ac6-95cd-620aef122a23@kernel.dk>
Date: Fri, 25 Jul 2025 06:15:42 -0600
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
Subject: [GIT PULL] Block fix for 6.16-final
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Just a single fix for regression in this release, where a module
reference could be leaked. Please pull!


The following changes since commit 2680efde75ccdd745da7ae6f5e30026f70439588:

  Merge tag 'nvme-6.16-2025-07-17' of git://git.infradead.org/nvme into block-6.16 (2025-07-17 05:56:12 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.16-20250725

for you to fetch changes up to 1966554b2e82b89d4f6490f430ce76a379e23f1f:

  block: fix module reference leak in mq-deadline I/O scheduler (2025-07-20 13:18:13 -0600)

----------------------------------------------------------------
block-6.16-20250725

----------------------------------------------------------------
Nilay Shroff (1):
      block: fix module reference leak in mq-deadline I/O scheduler

 block/elevator.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

-- 
Jens Axboe

