Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68BE198858
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 22:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906995; cv=none; b=JgX7R+mC5zl/CDwsNXmtKv+PI/ACLPhYXeAARAkns9aU+rxncSnoopwKoh2pwqJ+mXu8pYIBh8bfaX4iaxFb+xKLLUgTOFTC7JUNSI6xUuzuXv9GqxruovAd3nGuYhStPTg/9rqfWMOHrPa/1M0VTTwGtYJtpMWWdW1rl+TtqmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906995; c=relaxed/simple;
	bh=45UR2z5wJFRmcL5gk335pr++TR817+wINiqq673xlkg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ovy4595mhB0hsaBqpQS8LU3hLTRapHCMqAWYthX2nrC+Qqm/yUAOXNJbScypAbcpp9AXCt98+9HX59xHI2Q1vzNWTWVEBV8lpaKV4H013WeCxYPP/GJp4u5dr4OVzqxOiWJ/BV9WEDu81ge3JMBIWRT8GbjKjL1JtYAOZ63S0U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BOtRigmJ; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BOtRigmJ"
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-7a99fd4ea26so25650685a.1
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 15:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1727906993; x=1728511793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E6afvH3qs06X8hpCRvtEWaOTzwuCuJbSy0eO5PWmZw4=;
        b=BOtRigmJDoQqnvV36Q5DmVwP7U7KUnwpITa4OmonvZSLUXSXX/j8Ls32T8gFOXquVO
         /ByORQXWA+uvJ3HOwsQiv/VOvZUCLuFtLWn8NXjLiMPyw+/bn94+deiZ/YGAkcn8uhw8
         v8z9Enb72j/IGEAMXKC7nUlQP/qlwpr+9iIwfSut+fsomDKJOw5CNEFPKWJxENpmjhUH
         7esltowfmjGN72p4wSC+y3EXmQ70d3uhTEkj0E0JByLgq8QGShoUk7uYhrl5JF5SKCma
         3mXJPwHpIxh9PZMQ2Z5PP8dzlynd+ezRaVXiByuE1L+pqTcCKD7xEVbX/oHJTDMrDHKC
         LzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727906993; x=1728511793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6afvH3qs06X8hpCRvtEWaOTzwuCuJbSy0eO5PWmZw4=;
        b=smfiXuRZ03OVCSCtL8db9UFCyAFaJSQVzQvh9NPIOuEDn+CenZmt8DydTdqHpG81sW
         7KN1Bgj6I7150TtXdMLmKe0y2MvEj6iu3ct2qDlFaN5y+SyGCqbcnXfXTJTPb1RLLlVz
         lqs8gzOzbaFhmGxhd3DGxY0KAMyktEDkyqpM5/W8WMv6V5HfncD9Yo7zmWYwXDWzHj1d
         C5pZ1LY1AVtWpYl9AmHaHavLUiOS3PchrF32c1XHlXprhT0toyAM96jw6KcU455QmbG9
         ZFRXdaMoXabP8lAgj/g9uYPfZXgge1N6VWLCiC5iRX3TzIKnjlg3VgHIe2XqOeTkPT4d
         SkPA==
X-Forwarded-Encrypted: i=1; AJvYcCWNc6mKESutR3aJJos+dAAkpQJ/NMWddcTR1ihsDy/7+H9LqWtFvou+oOWpMLmeP+nRB280Tmf6XQpwdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyC3d8TAJ+vZJZNbLQEREkUM0GhUgJ6l5dv7vjtzAHKd188ulFX
	fHgwGQBA/9mghXa7Y3S8pAHREFsWkz0vxR3/TjQBl9SHlgPvGHDZl8fdcgRU44tncK0Kxekw748
	wzX32h+LGSyBB5wQnfpjMt0Apa5g/JwBtDRQtA8Vz9tlx6dzJ
X-Google-Smtp-Source: AGHT+IErAuuAS4AEKksBar0VPbp/w8pPakVM0GvxWsDzOW5pG2w6io++eRe/B1AB+2yvwEddJxlqge5cC6VQ
X-Received: by 2002:a05:6214:2f10:b0:6cb:79ce:bdef with SMTP id 6a1803df08f44-6cb819e0b24mr57547526d6.14.1727906992626;
        Wed, 02 Oct 2024 15:09:52 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6cb3b606b95sm4066646d6.8.2024.10.02.15.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:09:52 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5B8AD340357;
	Wed,  2 Oct 2024 16:09:51 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4BC9FE413BF; Wed,  2 Oct 2024 16:09:51 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 0/5] ublk: support device recovery without I/O queueing
Date: Wed,  2 Oct 2024 16:09:44 -0600
Message-Id: <20241002220949.3087902-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ublk currently supports the following behaviors on ublk server exit:

A: outstanding I/Os get errors, subsequently issued I/Os get errors
B: outstanding I/Os get errors, subsequently issued I/Os queue
C: outstanding I/Os get reissued, subsequently issued I/Os queue

and the following behaviors for recovery of preexisting block devices by
a future incarnation of the ublk server:

1: ublk devices stopped on ublk server exit (no recovery possible)
2: ublk devices are recoverable using start/end_recovery commands

The userspace interface allows selection of combinations of these
behaviors using flags specified at device creation time, namely:

default behavior: A + 1
UBLK_F_USER_RECOVERY: B + 2
UBLK_F_USER_RECOVERY|UBLK_F_USER_RECOVERY_REISSUE: C + 2

A + 2 is a currently unsupported behavior. This patch series aims to add
support for it.

Userspace support and testing for this flag are available at:
https://github.com/ublk-org/ublksrv/pull/73

Uday Shankar (5):
  ublk: check recovery flags for validity
  ublk: refactor recovery configuration flag helpers
  ublk: merge stop_work and quiesce_work
  ublk: support device recovery without I/O queueing
  Documentation: ublk: document UBLK_F_USER_RECOVERY_FAIL_IO

 Documentation/block/ublk.rst  |  24 +++--
 drivers/block/ublk_drv.c      | 191 +++++++++++++++++++++++-----------
 include/uapi/linux/ublk_cmd.h |  18 ++++
 3 files changed, 165 insertions(+), 68 deletions(-)


base-commit: 52d980df51c607867e40e11eef125cb51f8769a5
-- 
2.34.1

