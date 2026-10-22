Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792674578;
	b=TbaJRC7C7iVL6hvtlAA8Dxi2r+0xK2CoSHPQ8NKiUPeff8ltqdW4IVx3kKbJZc+3M6Zv
	 jOsbBsZIYUZxoQ4auo7pIBSUs4aeqLc4Sy3CtmkRxa+0e1f+gs79pDcy0iVcYwD3AA6Qf
	 5XD0rZqz9ZvbxCF1JCwKYmkByJS9yFCmD+3WpXionUd+fSh8i8ED4xTAb0x+q18Y2stPF
	 6dUqh4NlzWI+9XTMohw2B1j6rH3oP1uvVkwvCEaMxGPyy0XmLIE2QQ246cFswwOHkfL4d
	 EGrOUXOyDc2JRbzqqDo8GBF9uKA7l/KFvvO73rJdjc9y3kVPTX0guaM07EBgKEvXNbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792674578;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2aB4n5jrJ+eDnutbPVSuTN4FJGF30ZBUQ83WroDaOXk=;
	b=4LjhOjouN4fYFrPK8/cJ5fFCIgZBdFvWJAS4UOlVwKQCc5qWRT4flLliDFrpSq/HSxgg
	 mIXcz6qI5Z+OM7WPTnPIlZhAGUMizBF2zjk9NlJNfguVu5RjnPoyEgeOfcyR9SOY5fPlM
	 Vf8aK9+cmeQGlT+vPYbcP0E3iguQsdrCDnYelh38nroJ50eeQ0FE4dUsf1lH7cFFfn7pQ
	 m4r9pNjms1ks4us9aukRmU0yY7tPbuOtrhLmst9yOj+EQygesLU5PU2JHW6+QkyGzRDRl
	 VpukW0uv7uvCFTY4jMtAoO54RfVsDzfTQn1YzWLOzWAYYwlgX4pnclnWr50YctuOHlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eX0UnUP4;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B40A606A31A
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 13:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B40A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eX0UnUP4
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a208d93758so6770905e9.3
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 06:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792674577; x=1793279377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2aB4n5jrJ+eDnutbPVSuTN4FJGF30ZBUQ83WroDaOXk=;
        b=eX0UnUP4RzYdCYWZ5YStmugmN6r5vIcGyiU+0s+mx/gl8C9lqFi4e4fM3T6Bi9ZfKi
         JyqkkMvR61kbeRXaaAlo5hyUf2tyf7rYe++EjQ0fan8HF8xcLl5MA41t+LWaSnnr9tSA
         lkAG/gDl6EviheiiTP//aah+hc+xcHlZYAu5KlL3wY2+kidZJ0DlF+Lng4FxxtVFKynt
         NSsdAek5i43z1F3Uct3IDWpnSqp+5Br3DhB0jLYlVByW9EYsQ14rA5wS5ZzM286bnchH
         TYRJfg5k1awF6jmXsPXWNYKbKcVhAUOFp0RSAG3Z4CHqvj8l6/3yt4XEungcFiahXql0
         DP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792674577; x=1793279377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2aB4n5jrJ+eDnutbPVSuTN4FJGF30ZBUQ83WroDaOXk=;
        b=TOtbJ95osy/4RFcTmhFCZAfWsOlKXOIEe4AMdAKnv+V9sjCP3jKxzTCX4I70Vcd/0r
         Bzqc0KuQZzktKSsjyqcykcqtHMKaux6Cz9GhSip0fRfS8XHAx7ghS1NqhwAPUmeAo2ly
         sBJNHK52HPuOt8M+r462tfPB9zbUDD52ev5B3/Lo0cM9wSLItq0At8Ni2WZ0VcCSHb/k
         RJVU61rFjhV2lU9LQy83tvFQysqwPMR0p6Ec15n/6N/liQQi8exTx2vhoZ86g5USVAK2
         9c+/dtFVEHdBuvIHc5/NNGvj8BRfC3eL65wIZj+QT/T/V74qzv0PyYm8Ndno53t/sjG4
         vrpg==
X-Forwarded-Encrypted: i=1; AKwUvBw1euX2AtWBpANI/S4rAT9K8WB3Wt+PDnKxegUEbuQ7MCXZOlso2Ot2qFmyHdeGg7iEdkc4FkSwLuVUAA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJSQqeTEcAkSHJbux763M1esvVBKgI0C9OApLn/NaSd1N3ttKc0
	wUAwvMNGSNC9abN9m66/VoEfGkO8hdFuXRb0XLdVGyxtOmFpF3+M9ouH
X-Gm-Gg: AYBFou3bLx7YYNV6Mvyg+/S6tlQe8xCqSVyLHnw4EXADKtof8OztC7R8GxCrl2jE/BM
	bXvQiBuIKGUMYep/+oAV7UijOn56HbZlrw3FsqY+vOLYbVNirBzX3e3AjUJT4+3BfjWWIepei9n
	3+wDP25mNMRLZI6V97/2WEnbGHnzQ2FHviDFaKz+waEuTjaoI5IoLF6oIxfiPoWG6NCbxhwQYY5
	43QdsLigOucSVqs/C/fssdyI+1Yy6asbgLdi8mFA6dGxuTjFVa/aYzL95PLQiMGYuY1h7JXsMuO
	Joibe6SRu5WOHUqdMARKGVJc54EtDZHYqxvh10HFF2ov/0TA/eUtjiOBuZVE63KpDuh8rZ4UHsH
	m62kPHfYTM7k5JU1LXSVF7VOs9IuPN9ri2t2be2PbLe2/7fpSbgYyEB3CYRUDBP5S5bqt6907pk
	Nlw6XJRSU4UJFuEH2/HS6SZRy1dle/84YuxaiLgBxxzalgb/aZ38tCUj4qIAnBCTWsesvhQDHpP
	xwLcIZdEqlMcZfP8OhYXLlc6att6zkZOKWq05VUohkcI52H4BKOy1QmOK8CxJ2aeHSLf35gKIcF
	Qg5lI5YAIvOpD+97DnWowbBs
X-Received: by 2002:a05:600c:3e14:b0:4a0:174:579e with SMTP id 5b1f17b1804b1-4a1fdd517f2mr102306365e9.28.1792674576373;
        Thu, 22 Oct 2026 06:09:36 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.51.95])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fcd2eff9sm119664695e9.4.2026.10.22.06.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:09:35 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests v2 0/4] nvme: add nvmet zone report and FC regression tests
Date: Thu, 22 Oct 2026 15:09:20 +0200
Message-ID: <20261022130927.3583166-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add regression tests for three nvmet bugs fixed by the kernel series [1]:

  nvme/072  "nvmet-fc: only send read data for successful commands"
  nvme/073  "nvmet: zns: don't leak stale memory in zone management receive"
  nvme/074  "nvmet: zns: reject a NUMD whose byte count wraps"

The nvme/073 fix is already applied to nvme-7.4; the other two are still
under review.

Patch 1 adds the zoned null_blk target setup, cleanup and zone report
status check that nvme/073 and nvme/074 share.  Patches 2-4 add one test
each, with a small C helper for nvme/072 and nvme/073 where nvme-cli
cannot express the check.

All three tests run on every configured transport.  On a kernel without
the fixes, nvme/073 and nvme/074 fail over loop, tcp, rdma and fc, and
nvme/072 fails over fc, the only affected transport.  All three pass
with the fixes applied.

Tested in virtme-ng VMs over loop, tcp, rdma (rdma_rxe) and fc (fcloop),
on v7.3-rc4-108-g551c722f4080 without the fixes and on nvme-7.4 with the
v2 kernel series applied:

                   loop  tcp   rdma  fc
  unpatched  072   pass  pass  pass  FAIL  failed Identify transferred
                                           4096 bytes
             073   FAIL  FAIL  FAIL  FAIL  stale report bytes, and an
                                           8192-byte transfer for NUMD
                                           1023 not rejected
             074   FAIL  FAIL  FAIL  FAIL  NUMD 0x4000000f not rejected
  patched    all   pass  pass  pass  pass

Changes since v1:
- Renumbered nvme/071-073 to nvme/072-074, since nvme/071 is now taken.
- Patch 1: configure nullb1 instead of nullb0, and drop the
  _init_null_blk() call, so that the helpers also work with a built-in
  null_blk (Shin'ichiro).
- Patch 2: rename _identify() to issue_identify(), and drop the
  namespace read, which only served as a control, together with the
  file backing it needed (Shin'ichiro).
- Patches 3 and 4: use _have_null_blk instead of _have_module null_blk,
  and read the nullb1 attributes in patch 3 (Shin'ichiro).
- Rebased on current master.

v1: https://lore.kernel.org/r/20261014170046.2516-1-parri.andrea@gmail.com

[1] https://lore.kernel.org/r/20261012141239.156408-1-parri.andrea@gmail.com

Andrea Parri (4):
  nvme/rc: add zoned null_blk target helpers
  nvme/072: test that nvmet sends no data for a failed read
  nvme/073: test nvmet zone report initialization and length
  nvme/074: test that nvmet rejects a zone report NUMD that wraps

 src/.gitignore           |   2 +
 src/Makefile             |   2 +
 src/nvme-sentinel-read.c |  89 +++++++++++++++++++++
 src/nvme-zone-report.c   | 165 +++++++++++++++++++++++++++++++++++++++
 tests/nvme/072           |  72 +++++++++++++++++
 tests/nvme/072.out       |   2 +
 tests/nvme/073           |  68 ++++++++++++++++
 tests/nvme/073.out       |   2 +
 tests/nvme/074           |  46 +++++++++++
 tests/nvme/074.out       |   2 +
 tests/nvme/rc            |  58 ++++++++++++++
 11 files changed, 508 insertions(+)
 create mode 100644 src/nvme-sentinel-read.c
 create mode 100644 src/nvme-zone-report.c
 create mode 100755 tests/nvme/072
 create mode 100644 tests/nvme/072.out
 create mode 100755 tests/nvme/073
 create mode 100644 tests/nvme/073.out
 create mode 100755 tests/nvme/074
 create mode 100644 tests/nvme/074.out


base-commit: 9ad5a10fa8ed56f74c23fea2c35f4594a110b8b9
-- 
2.53.0

