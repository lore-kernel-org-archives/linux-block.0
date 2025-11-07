Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D22D0631
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 02:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762481220; cv=none; b=rWgwuw4THV5v2iLbaMdoyWuKsy1tMcL+xzb93hcuvlCez82u76Lpuo43r6yw/6LdCNYUYIPF/rAMEf02o1j71Dekpg1h3orOS6MTxAaMmEVa6mJm35enNJ+Q4nkQjY05fOQjk7nlbUg0uRUYE8HZhOuLObhi8QqMVHMe8Hli1Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762481220; c=relaxed/simple;
	bh=5/T0SIm0UdNO/IdzRZZKEiu//zm3DFK1QFan+BlZfc8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=htmvbqmDV66n2nRcUOKMHcYXqV5rha404J6Y3iE6K4grdXY4lh7dD70JOnCG83jkJ6MEy0Z669XiMJjJ2D+bv/7quDL5syXf4ZVuT4uwKlfPxfypJnenm+mCJBXixeLc4zBSuKsO51SEjJbXlk0KShPy4G4lMXTylWkeln0YmLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OYp4ubuT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OYp4ubuT"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29633fdb2bcso2636945ad.3
        for <linux-block@vger.kernel.org>; Thu, 06 Nov 2025 18:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762481219; x=1763086019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oWHtEzv8Rq5cRO8AqC7Ez/zeQln1yPOIQJdYebnSBzQ=;
        b=OYp4ubuT3gFc60iNpOyqfZR5wKv5fjTWfjquldjj3yOmqwOqHhb+gL5tBGy1h6g19a
         mE9JKBplmSkVKkEn3gsbnssVeL3P2OnVme1LfIGDUWl5uwketcnYSSPYd40ovl+AAtli
         qK20UzYrZWuzXHfZvM8pZD6J1OS8frr4sUeuoh+AKkoH53mA0fbtfwSUkKSjloevMJ8H
         BKbPC7Ggm5NBb6iCHtS/VLhpM2bxPrrfQKV92pW54zrGq7nwYO5NHJQ/ZCweBAVuV4JQ
         X8QjrT3Jou7mvj0bxG/giBOc833ri2zbOH18PTI/qb3Ld1KMUxR3ET8eZjBe147luRUB
         lIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762481219; x=1763086019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oWHtEzv8Rq5cRO8AqC7Ez/zeQln1yPOIQJdYebnSBzQ=;
        b=b605yy/EAYEOw9MlHmmoEHIQqjCXdsW1if7w9XCailEcfjoi2kGD8C2Wu59tE1Cpp7
         3Fk9YvrYf7hKTR+9e4u1mKIKCYnPfctkOeX4aPXODEr9KyN+CBZ/ke972l42SCkk+Mif
         URFle/eiMF+MGoKH9RBK5V3XUPOkVN1tHrcyGF9hNStd2kVoOKpb7Qb3w6TGNPX+RS9P
         GYTp3XKahAM32ubKM1hbnsCk8q2GoxcYiuR5BTAESgU7RAGggDp2oXXbFB/x5+cqENug
         6ZN4ipZKu5QsaUiKYE2DmgE9Dav+Aer5NGWS2GqfMDsJs2S0Rob27pe2w2zY0mLNPpIx
         2bkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9zHa8+uyxzU+x62j33VIMdmS10r7T9iZ5ANN9s22La8pCqNg7E+ZYAa0/9G/A45cX2BWdX58xSeFtmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXf9Ix3kQqO/8tgvuwTa4/TQw2wkMv59I90AVup+31gbC7DY1
	bqOUO5+hjLX2FGcqu5sBaK7HKNjeyTIyix2cM7lj/lMTe3R3c97U35/WXji5E3NO2fU=
X-Gm-Gg: ASbGncsAcO1ux9WWiUDA3o1iQOHr86BW50Y55LtpxpBIb0Hv/gYHNxD4RPFWFS8cAmU
	ajLfC5+c6MFBAAwdXafcLZJ48GzPN3nEUAoHjjeFZu3w7DmrEUvhHAYIp6hzV/MWG492wYezdzY
	tAJNmVphhOAKY1Uu0KDhVaaackkW0UWth79QWF1cBdDC+EoqUHB4tIqpRVNo3fnmpBsqseOYOvs
	dvT3NguUYZguvOSHnWHhXEY1RJkcqYXJm2wDXB1DrxWDEvRT1/cEvuHvNqvgU+QphUMJfNEu7bH
	kZNw/3B/7TCbWIeqfzBkQ0oNec0+CoLXFNWPEjj9strcjwiiTCMQGx9y+uGTky6P1X20m4oTEsJ
	X97yqejuvsR0kDstN91J7SWWCOcdEAhZSsmBcVuelAHrk0Hn60MhFkXGnezxUfpT8Q4EHDn4Rkj
	qvocYGdsZbT0KV4Tqh
X-Google-Smtp-Source: AGHT+IEQ1r7AsblEW15F6NrWnCgQgZkngBPtkNTOIEI5NyInjWIPCo6YMVNtFNrYGdMqGrYdOjvVJw==
X-Received: by 2002:a17:903:1ca:b0:296:1beb:6776 with SMTP id d9443c01a7336-297c04aa6abmr21929025ad.58.1762481218563;
        Thu, 06 Nov 2025 18:06:58 -0800 (PST)
Received: from localhost.localdomain ([2408:8740:c4ff:1::4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096825esm43129885ad.3.2025.11.06.18.06.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Nov 2025 18:06:58 -0800 (PST)
From: Fengnan Chang <changfengnan@bytedance.com>
To: axboe@kernel.dk,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	asml.silence@gmail.com,
	willy@infradead.org,
	djwong@kernel.org,
	hch@infradead.org,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	ming.lei@redhat.com,
	linux-nvme@lists.infradead.org
Cc: Fengnan Chang <changfengnan@bytedance.com>
Subject: [PATCH v2 0/2] block: enable per-cpu bio cache by default
Date: Fri,  7 Nov 2025 10:05:55 +0800
Message-Id: <20251107020557.10097-1-changfengnan@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, per-cpu bio cache was only used in the io_uring + raw block
device, filesystem also can use this to improve performance.
After discussion in [1], we think it's better to enable per-cpu bio cache
by default.

v2:
enable per-cpu bio cache for passthru IO by default.

v1:
https://lore.kernel.org/linux-fsdevel/CAPFOzZs5mJ9Ts+TYkhioO8aAYfzevcgw7O3hjexFNb_tM+kEZA@mail.gmail.com/

[1] https://lore.kernel.org/linux-fsdevel/c4bc7c33-b1e1-47d1-9d22-b189c86c6c7d@gmail.com/



Fengnan Chang (2):
  block: use bio_alloc_bioset for passthru IO by default
  block: enable per-cpu bio cache by default

 block/bio.c               | 26 ++++++------
 block/blk-map.c           | 89 +++++++++++++++------------------------
 block/fops.c              |  4 --
 drivers/nvme/host/ioctl.c |  2 +-
 include/linux/fs.h        |  3 --
 io_uring/rw.c             |  1 -
 6 files changed, 48 insertions(+), 77 deletions(-)


base-commit: 4a0c9b3391999818e2c5b93719699b255be1f682
-- 
2.39.5 (Apple Git-154)

