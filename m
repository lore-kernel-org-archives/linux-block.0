Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB95DEADC
	for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634837; cv=none; b=WG7FHUim9kIH5cZvLaMMi0MN3x6uYzR7sHu8BEZK0N7hC4Apo1DJRdqBqQhRCepvHHwhaO6cVv/cn3UgIab6Vnn0bKv3SxAIDbC13CJxx2Lx4RzEPtOQHmmpYxp0GKFUskYWK2Ki2wpqruv0HkZUgHwSS3rFHJ0eUa268Mu23pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634837; c=relaxed/simple;
	bh=M9yVNk5VPH+nJY2mgtSbO7qIg2TP4lSJLOthOIJsw+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R3rUaDkzHYxAz2aSoxwzQ8Wj9APXphFZhg83Qb8L4HHoctc4XCYWXLWXa5BdukbSQeZudi/YDyJLhhaXxD3piGKEryqEb5Ay2IanK8K7OoeG1dSiz5JPErpO+Wj+rycpA48FNRrOK7RjR7089+MDVg5Fk/i7S4S7C0Ea7aW+d80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Qbj2kGuo; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Qbj2kGuo"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74264d1832eso4097588b3a.0
        for <linux-block@vger.kernel.org>; Sun, 27 Jul 2025 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753634835; x=1754239635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BXCicH177Dmjz8c5JGGpzyWjrgYU+8Yecl6WQU8pDFk=;
        b=Qbj2kGuoRGLvdzyu8aC2pU5sy16Lr9AJdS8iHElB8kG2e5TkbBUolA8NBB53xfXqOa
         HDgd3V5VzjZHK/B4U3oQYVm5W+s7fasY6lbtsDGxs7vhkOum1w9DkmXIJJT4oxR6zOTm
         voq+bRYPW6useXKR4+ND3tEs8CqoFmqhAelC1n2vqOxCjI5QjKzviIyr7oD6kGSUyJ9f
         gmuGNlLCNzH1Pu+y3PfF5jVvFe3cxjlXKhrH6qszYMRJdqnxBlAtOmCk4DM1Ng0wXUTJ
         3BDNdDFr0V3Qj2inI217BawbZlhYgC9pkzpvn1ZHzcvF03nDScjke+sWGRwg0T0T7Kor
         wFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753634835; x=1754239635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXCicH177Dmjz8c5JGGpzyWjrgYU+8Yecl6WQU8pDFk=;
        b=AeLMY9v6iAzRnq2QAnUzAAgdA6abseBAN1W8sh3Cj4/9gkC7gbWwmB+b2tAietAr2D
         aMoOZPCWLGYN1wC8KiO5RLOBe/KA8cv6NtSUXGw/RMUQdp4LjvQ+QE+qYx2SCLFVR6TU
         tPOumLFxDpN1wFkDtIjFfyuaev3xcFOzJ5mC7Rc8WRYJmtyBh1365ev4RJvHk9hcXyeW
         xIXhQjt7mAzo5vyV1C2UHAa4sf83sN6Bc6Mk/wXWtbIEOFotcUFZMmDgo1Cge8aONKUo
         0yA6VCilJ1UvZM6byRhbC9kGreEkwjc4L73JDkyftzkDWLLYPpAmLaDEvcf5fxWPEmpz
         RVXA==
X-Gm-Message-State: AOJu0YwjseMX74jF/YaylbXQJyLZ99Td8fO7epyPl+D9KK7OcBYI4Oby
	a2US2BrAPUo3f6qslBg+3NFCGmtyqAzl5uJGGq8yMbg8OonNS8Lc3WEGIM5gtFpU1xY=
X-Gm-Gg: ASbGncuXt3b/BclyqgKyeJKbnBkfJMkEXy1iSoOy3XYPOltdKNTkuRYKOzFcBM5ezFf
	BOC6wzfeRf4qIXzdD1jUMZchgAomaBVJQthitSVG2iBV11eOi9Cvr7YErs6q2J6N2wd3GPRnjgK
	9lXuDMuVkPVoHLSuI+0TB5kXD7u8cVxA3Xx0Y6O1HYdaQrQwGh5u+4vIpsVWSF4thjjAWQF3Zcp
	vOZ7TRFJqYrL3nY1vnDsOfyg/8YrpFXR1H0TdOuxWHPvQLpdlX3LVYFdGsXG6WCBr9Psd86CGbP
	o1dVZWcksI2/vkPrBy5EfW2Ci9WBXaVwuMzJ2EkOhoqt84vWBKJHUBKB3ss+sQLL6HEmykddETE
	ScV+GAco=
X-Google-Smtp-Source: AGHT+IGkCU3DHyt9I8/j3dpgBoULEMbtlNBnRe4ybvw/TCAOP0+IrPEGmmuhB3u8w23Zud28XJ3YHA==
X-Received: by 2002:a05:6a00:2d1d:b0:73e:970:731 with SMTP id d2e1a72fcca58-7633740769amr12440290b3a.16.1753634834876;
        Sun, 27 Jul 2025 09:47:14 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640baa00a9sm3402878b3a.140.2025.07.27.09.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:47:13 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 0/3] Optimize wbt and update its comments and doc
Date: Mon, 28 Jul 2025 00:47:06 +0800
Message-Id: <20250727164709.96477-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

Some minor optimizations and updates of comments and doc for wbt.

v2:
Patch #1: Pick up Jan and Kuai's Reviewed-by tag.
Patch #2: Pick up Jan's Reviewed-by tag.
Patch #3: Take Jan and Kuai's advice. Change the name to
'curr_win_nsec'.

Tang Yizhou (3):
  blk-wbt: Optimize wbt_done() for non-throttled writes
  blk-wbt: Eliminate ambiguity in the comments of struct rq_wb
  blk-wbt: doc: Update the doc of the wbt_lat_usec interface

 Documentation/ABI/stable/sysfs-block |  2 +-
 block/blk-wbt.c                      | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.25.1

