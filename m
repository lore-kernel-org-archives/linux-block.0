Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED433E373
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411092; cv=none; b=T1fDEXJ+6vFw+U2e0LIScs6E1rRtIrrt/3NZO3gu/6cVspZ/PqvEBZWH1cs87XsKp4iTg1US3BfKn5ShbFOxLDPcw9nQvTbVAnaiQ0WUAhX/WuSmvJWrH5zUwpPUp6eSjzCMvTUB2K6rlmG8HSQ51vyVRhwSeyWd4qtM9buk1Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411092; c=relaxed/simple;
	bh=2fGDOT3hOlNR6C9el0fpIF0YgndGuBe7jS+ChUB49Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLo3uGyfUtowfypmXmYMnT7Etw/uhtJVpFGKpdQJ52l1xLi8vRC1TFJ+BkqqvlcFuSxBxtaJ9hjAHJt85iZkYsLgGXtb1RSUxLB3zdzzLUgMIinl4s0JtmZciW5HW7S9jn+m2xIgvrpqFf1T+kGwsdKcGF2GDSoXgQCLbNY517E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NenDg1H9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NenDg1H9"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bc59a785697so3687660a12.0
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 12:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1763411084; x=1764015884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=onsK98uoUhT0XwWIqjQPKdP2gqDAphdg/ek+7mT4eqQ=;
        b=NenDg1H9iDrFXoJz3ADI32/lpqAvmI2/mA2GekXEP8plOLIRJ61CQiuZ5tybLAXfsK
         Uz0s31489u/+DybWDsgTgJlYcC+oNem0egFmB5Udg4IqdUHOXgSkjMCeUy1V+4u/Tjbu
         nLkDrtpVbuTkCgrIiOx0hAb++KsssnX/ZU0sgqW7zLSPz+OMuwrVA63s3JWoBWjP/WEG
         Le5wY2cj89rmlfeD1R+tXWYnOUXDTBhMfc3BrYc55xv+D6fZ7eQ4cdQVqxHfxcYnCs49
         GR1eEYUw5qQEi4eNX0/mSa/ryHeG/lxsf+FkGEnRb4aM1RNMe+5O3PWL0DpOglTshV9K
         UUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763411084; x=1764015884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onsK98uoUhT0XwWIqjQPKdP2gqDAphdg/ek+7mT4eqQ=;
        b=RXcdCTbMCPAKyixGPxwC8QCVjbJinf4yJOCMMZkaUVdtFqn72oa2kJkpHpnaQoVY8z
         +yayhfONJKDycMeSD0vjrT93+tZSGy3d7uPTFXheKTdgnV4OybrSbJxRwEOrLO+2q3rv
         ERulxYCqgkDnMAb0z6WzNUANeylWEIKZ8swvlSnrubJgJytNjdkYwXFyjCj/qeaWKwv8
         Ap4nndZxa97vM0IYZAviA+gSHVTzyxj0csHDCN/fYtHOglGjJMoiTGISpfV01q2HT6qA
         98NsdBaFQuWiGH7eB5uFA02N76lErpU+Fo6s4zwjw4PHu+epPh0EzjO+ZXIobjXeq3mv
         wyzg==
X-Forwarded-Encrypted: i=1; AJvYcCUjmBIW8S6iq4yKDdY9rQMiyl5nRr0icm9jJ1YY4xC9KlWT9ctfUiA52pC9G+Y65+OeENZ6FIdSV1SChA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF6E+yPgwSMO4n+wDd+5SpTReqH99FWASx6zs/L7teila0uWvm
	iv0DBgIGgSz+1B8pNXxHbXn50Vt2tfketE2cZuKhTFujWLOQIiGqUKX1+uX/Cmel3nc=
X-Gm-Gg: ASbGnctsQVdlMpegncA8Zbaya0zu+yV5oQMGvWRFtLdCTGZzk7Qbi9bfEYPaRea6jj7
	pSrt5SCcWpexQL43J3+/uaeY0/Zh09RmYTQURTq3qp7EEr9/28EHdQKgHVHL80tXIc8luqxG/Ft
	fIL73NPHMbhnrLrRDNsHR+EgcJs2/O+8JX1wT7vZFhzMYpEKQp0+8/fXpMaZNg9MxhK4ct2T6lf
	c5upB8cCZC2a5cIu306rHlMGfoB5rmdcbGyWiO46mq5uI+czB2tCnAxMZL3U14fOvtCHoJm0Vi2
	SEkk5tFST1rlOgav6qmDw6Bb970Pm7agvUqtDLDE8VDfgbtIa5JiaSNFpBdNNQNOTlR74vjEY1I
	oDZcQwS9hXSVYKcCBNNSmTvjRtWNpXpCDI43SMr1jT7jPBsYB5/B9XbwZyMUQQrIEipDpi8gUOr
	h0yOxwHbt3+eZEFfNv5cuZg0Cgvzn9u760yX78Ax5FNKnx
X-Google-Smtp-Source: AGHT+IEdhFd42XGtdY73xnyG2hr/76Hbk1CjMiITvZ1VDOj8aki8ecB4bkyUXogqVL/y2/Mbq+4Cyw==
X-Received: by 2002:a05:7300:cc83:b0:2a4:3593:9695 with SMTP id 5a478bee46e88-2a4abb32b86mr5625538eec.18.1763411083462;
        Mon, 17 Nov 2025 12:24:43 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm49298281eec.6.2025.11.17.12.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 12:24:43 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Casey Chen <cachen@purestorage.com>,
	Vikas Manocha <vmanocha@purestorage.com>,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2 0/1] nvme: Convert tag_list mutex to rwsemaphore to avoid deadlock
Date: Mon, 17 Nov 2025 12:23:52 -0800
Message-ID: <20251117202414.4071380-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes from v1:

- Keep existing behavior do not freeze newly added "q" when
  transitioning tagset from unshared to shared.
- Delete blk_mq_update_tag_set_shared() and explicitly freeze "firstq"
  and "q" and set their shared status.
- Add comment explaining why we are downgrading the semaphore before
  freezing "firstq".

v1: https://lore.kernel.org/all/20251113202320.2530531-1-mkhalfella@purestorage.com/

Mohamed Khalfella (1):
  nvme: Convert tag_list mutex to rwsemaphore to avoid deadlock

 block/blk-mq-sysfs.c   | 10 ++---
 block/blk-mq.c         | 95 +++++++++++++++++++++++-------------------
 include/linux/blk-mq.h |  4 +-
 3 files changed, 58 insertions(+), 51 deletions(-)

-- 
2.51.0

