Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D6306481
	for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112135; cv=none; b=AvTVwXhrTQmMtrFETv/XPpf/QHFE9RBYNIMvOrD7k39Giqd8qU9auFbgIIQEgv1J312iiQBGSt7qSaKiBfrtCDFb5e448qkJbJkmsQ/0cToavpLcSapww/v5hwl6FafIAnF3IWWwsj6n1J7Zq8mDKEiF++oPlU2e/Ff5vV5AhN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112135; c=relaxed/simple;
	bh=3yKmCrbAdSfO2k3GcxeDVFzxOqz5BImDvVOtgCC29lQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gwoUfuCTf6vBikQDC+FUTqgOU7W8w/b7acebOS2C5aUl794t5jDXmFdMRC/TQNaf1+9zu0Sc6mNFCXCCDhOAlXFUHjYyHcUzOybtzg1HW9BisYeBgsM88pnoLxlIpkwICBsFLJJESYwewJTOraLmo9jjHteGhBSBtEBtvpy5raY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AMh70ouL; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AMh70ouL"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2980d9b7df5so16576155ad.3
        for <linux-block@vger.kernel.org>; Fri, 14 Nov 2025 01:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1763112133; x=1763716933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VOUcl1KTNJ6yNbLI1Tyvpph5ES1zSXb7oj0QZ81RI5c=;
        b=AMh70ouLRszzEBY6WQZeYRCj1O4XxwjqQOj8XGUCFBNcIVfE9P+bAcsy2QMKVHj7K9
         zKbMYwESq3+4J54eIW4h3ofW7+19+oCd/fLKVhgapYb+uhhHLzelhDc4IgjX9UVvF6P1
         V9Y56unZ1bsHJVw+XjvEo/DE7yFD5oj2sj/MTlGWq8XeFuAK6QMQa4tAi+t/HJbyBa6t
         6kM/PBY8BZjkSugTDlP9ywabgXtJY1Vic7CpMnYC9gxbx8IlwrK8GbmFE5MDXQd/IzzQ
         rU04v3dxv9BW+RpD1IXTckglzGgKNaLSxTCH+7AIBe5CGPQVZagLUUr3zgE1vzn4bzdR
         r9Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112133; x=1763716933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOUcl1KTNJ6yNbLI1Tyvpph5ES1zSXb7oj0QZ81RI5c=;
        b=VxyvKLLn7+YBpLVJui04ng7h6d6J99XmNflmxhoaF8BW5kspN8BcbNRJayCwv9+6Iu
         Iq62zrT9+n8iWaaIB+qNo1SVLyeqNeEtbmyOjYIlrxvj3LPMkDP9S2XNqLNbcysivlEk
         3t8spqEXS6nH0Zg0fXFbKcPBdemfcx1yRK0LlS0LKeUBoh37w9QNcbPGjfaa7Wx8jMCj
         T/JOHfp9Nv3TU8Ki9ll4uqleFnfAV9XUbW/QEEeGYqJ1N8TAzR6jbnmJmgf6apvfL3D0
         eP3+IX2Jq44oQHDmPpZNx5s3k5qzO1PuXEPQGuJTTk62Gg/Mu6k77HaC3FTXaSdsBe1Z
         gomQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDnhqgEIP+JOZi+5C5nRXFSZyW3fXcRT25XWgAXHSP5GYU/E2P7OOhxxVeJK6J/tJiQB7k0dFKApDEtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtsyKOxKGufw57uQLaUOuQnTQAQVvdXbIQyS2E00xHHGCR0vkj
	3nfCghJ+oWn1eVQt0RCS58nAd2/K5kD37sG0dVMrXnYJhGsH62WUgeqh0xWUyiOA850=
X-Gm-Gg: ASbGncv0qAu1vrKlBxczY/Y3/mQdmECEt5jrYVXZxgPNzu+drMY4kLekehXLvL+esjC
	IifcVmY87WWfpuUjIZQo4K0T6QvJzqwgJ5iCFrzTt5/2fsjScKmdt+xOHVbocd+RsImn5EXr8vL
	YSDiwTa+ekn+NzhcU+Hi2bzaBV64iOb/RAvJk9ieso58RGgwZYKt29UZbJDDfwDbqxBoXtBrRME
	8PLqxAnYF1+BM84dOUSP+j/1w4Pg/ERp4VFXirCmlWF9a9LWRIK90uBJYvbXdusl80Cibd/SoXJ
	/ijbYQgHT1awhGBwnyGm5JKsAyvA/EADHtAvo5lDC5vSM+8/SVd2OlTGEcAUQHZUxeDb83zsDB6
	OoGXHYrxzZMdrijgTqWOTL0AP2oKf2tl6MVjRZDbIPqa79didOmBsmv1XabHifW2h364NMkEviw
	aV1A5AnXrhltaQ58bGKDwBNP2q7qShpZ+TEg==
X-Google-Smtp-Source: AGHT+IF+L62VoDL311ziY3WGmIGqOUF1aAOhbYoj7EpJUNyw6PsD2tlvnXHX5j5jjprmk+4XNcS2IQ==
X-Received: by 2002:a17:903:198b:b0:267:a95d:7164 with SMTP id d9443c01a7336-2986a76b6c5mr23867635ad.60.1763112133120;
        Fri, 14 Nov 2025 01:22:13 -0800 (PST)
Received: from localhost.localdomain ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b0fe9sm48725735ad.65.2025.11.14.01.22.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Nov 2025 01:22:12 -0800 (PST)
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
Subject: [PATCH v3 0/2] block: enable per-cpu bio cache by default
Date: Fri, 14 Nov 2025 17:21:47 +0800
Message-Id: <20251114092149.40116-1-changfengnan@bytedance.com>
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

v3:
fix some build warnings.

v2:
enable per-cpu bio cache for passthru IO by default.

v1:
https://lore.kernel.org/linux-fsdevel/CAPFOzZs5mJ9Ts+TYkhioO8aAYfzevcgw7O3hjexFNb_tM+kEZA@mail.gmail.com/

[1] https://lore.kernel.org/linux-fsdevel/c4bc7c33-b1e1-47d1-9d22-b189c86c6c7d@gmail.com/


Fengnan Chang (2):
  block: use bio_alloc_bioset for passthru IO by default
  block: enable per-cpu bio cache by default

 block/bio.c               | 26 ++++++-----
 block/blk-map.c           | 90 ++++++++++++++++-----------------------
 block/fops.c              |  4 --
 drivers/nvme/host/ioctl.c |  2 +-
 include/linux/fs.h        |  3 --
 io_uring/rw.c             |  1 -
 6 files changed, 49 insertions(+), 77 deletions(-)


base-commit: 4a0c9b3391999818e2c5b93719699b255be1f682
-- 
2.39.5 (Apple Git-154)

