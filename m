Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52122139C9;
	Fri,  4 Oct 2024 14:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051048; cv=none; b=t/p+TAvAVJ+05kphIH2qiBv4TyitVs6KV+fN67A6InKuthsPW+vpeu52/n8bjAscALURcGP36jHL6CCxX/uQpOlWXUJI5sK4TaRHBqBhbljl0dH1tP7Qc1LLXQFKQd/0plbl8BinzWqOPIBNxLH7EjFm3nECRFle4/XR+I6ovfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051048; c=relaxed/simple;
	bh=JcoAozjGe6KJwo8JlLKfy7dzBgqW2BEBvSTA/VAxTfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/nAilbIGqjDRneNtlu+EGZ+cG21ZlG+6t8NJE6LGLVYVImt2BqmjOt9VIjSrQUEmjWzHhceHeR6j0OFvErmEqZH9P6JrOL/1iO6JG06G9b6Mr4UFu5fKzs4OAZqTsSSVNIOa5MoU/AF2a+zss+roqeAH8Qrl+snj1hUczEUcsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRQhRwdB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRQhRwdB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20aff65aa37so18681845ad.1;
        Fri, 04 Oct 2024 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728051044; x=1728655844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sfd0dihu7gfegBqVS9/NP6tMEUAcyFXZ5iJaoj+m2kw=;
        b=FRQhRwdBAPr+1DR6VheuSOxfMQmi0PDbg4/odiyghl+4k/BxmEL0i+U0qd8Z1wCx6Y
         8sUxN8VZef8yaWMW/clve1/6budN7YnCUHl8WR/KFsWzVucogxXKJw57psTpdFmXMjdW
         8LMfdXClFwevZjjkF3hics5swOYZ0LAZt5YMBWwyWWlL3lLS29Sk/mbWcRUuNlQPiHaM
         pCFWMEi1BvMRcflqwP5SeXGVXi15dZ8Sgb/hHUWBOw6mOYWzZxAeRDTqLubsgmMWawTx
         GGp8oS3nXfX49rn+PEPIpNcO7tjf0fPjX83dD/SPyDJzfec8iVgQXX9Zjo06kA9qkRKp
         IGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728051044; x=1728655844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sfd0dihu7gfegBqVS9/NP6tMEUAcyFXZ5iJaoj+m2kw=;
        b=c0sJnvKJV5osiHFZcwktyJk2SetLAz1cwatIW6G+tEOi3I1MyqtPk3ZBY96xXhkisT
         Bu+DtpRbwZtR+JDGUaMm0xCzk2UJ1t16U/COHBW5dBGcl6V6FTWNs5b+wndlIK6lYSlC
         UKLnhWmVDZWS2rBQKY4BVA6RoxKtJS2FohzGj9/tKsgRPkewLFhrnVgZA80dv8j+ZBjj
         qoWnZc9obsbQ8F0sWXb0qqzLoDPcivGxGWgo4uAAK25VFkznKBGHo4lTeQBUux/GO7Lw
         VfT/T2JGtQHCzuB/eakjSq1eh8sQCvDu7adlWo3wezeB9ethBSSs+U/cmxl5yPQnrfZJ
         4o9w==
X-Forwarded-Encrypted: i=1; AJvYcCW5XWFDDisJ8PBrFL2wBQCROhfB0a53hTlyZYIdbgKljDilyzar/Xjuy7vddFgAzE51pVhGWDLQx9E8BQ==@vger.kernel.org, AJvYcCXciPvyKfe7vCbIsb0ChaHcR2QouPwBDqNP6uWkSrBVn3BElgWfv0cqpqSbWe3IqAL2iIS+wwI3zq57Vdtk@vger.kernel.org
X-Gm-Message-State: AOJu0YwDMhdqBQoyCE31K0pU03eZHFCk0fWyQSv3nXw0K1dR92bIX10m
	m7Qz+1iXpEOsD+qLXNcW2GyKoVo6LcD3dGg7c0A5e6V+Vpe+yXBP
X-Google-Smtp-Source: AGHT+IEC6qnaS9VbQbPqrtFDm5c4hbnrAi1LBKJRSfHwE5682SXEXs7jSskoTR2Yjzx112qTn+aKyg==
X-Received: by 2002:a17:902:db0d:b0:20b:8642:9863 with SMTP id d9443c01a7336-20bfdfc268dmr44096215ad.18.1728051043743;
        Fri, 04 Oct 2024 07:10:43 -0700 (PDT)
Received: from purva-IdeaPad-Gaming-3-15IHU6.. ([2405:204:20:6275:2654:2317:92c7:7b80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeca00a5sm24580825ad.113.2024.10.04.07.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 07:10:43 -0700 (PDT)
From: SurajSonawane2415 <surajsonawane0215@gmail.com>
To: hch@infradead.org
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	surajsonawane0215@gmail.com
Subject: Explanation on Uninitialized Variable bio in blk_rq_prep_clone
Date: Fri,  4 Oct 2024 19:40:37 +0530
Message-Id: <20241004141037.43277-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Zv_eFIjstVns-ebG@infradead.org>
References: <Zv_eFIjstVns-ebG@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explaination of how bio could be used uninitialized in this function:

In the function blk_rq_prep_clone, the variable bio is declared but can remain uninitialized 
if the allocation with bio_alloc_clone fails. This can lead to undefined behavior when the 
function attempts to free bio in the error handling section using bio_put(bio). 
By initializing bio to NULL at declaration, we ensure that the cleanup code will only 
interact with bio if it has been successfully allocated.

Best regards,
Suraj Sonawane
