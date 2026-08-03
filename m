Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDF3B5304
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791688; cv=none; b=kUhA1439Fp2d222Tfp+doKWaGQDDe+5uBMwUBZdcYJoQHbWumxAR+IWs3Yn56hqGayl7HZ/LLxGCM4TxjqQ3xo4sCHLos7XMetMNJKrix+YMulVz1q2dlbT6TqDnl6pAK/DyKuE4TLUjtQ6TKVDPLzxCdqLLwlPqA58dh9PPNi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791688; c=relaxed/simple;
	bh=Ay8po0D/dJHtAAlv8sLttVFqYoCzGVXCHK3T6K0atNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S483cvh3InbOwqRAqPYcewuTP0Ow58I/XWiSLv3i9QbMa8eVARgOyDT8LFK6Nd/gJ+zO69du/euYEd8rS1mOw1N8CtyAWSQVssKBneVBtI3gBr6boXtiBfNjlGN3PpyeXRhSN/sTdMD+6mRGG2ZaBR77Tg2F+NLax9dCv4M6SK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Jiwybz+F; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Jiwybz+F"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2cf420670bbso3337575ad.1
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 14:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785791685; x=1786396485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z5Tn8GDAuHvEBSiHkYSZKLLT9+XXk8tB1iGEjxC739I=;
        b=Jiwybz+FSeaIf2bntyTV8xi7prosYp13/nYqEYW0eZJtyiDkyN8xnEZt0ApjWdqutQ
         RrcNc8cRdDWEgOh/yX4FjS3xq+8MSBo7JWiYj8cNglat3GyiQX2pbIVgJcUKt7hKLB4w
         KL+TDMCvm/K8hW2KFOJyMUiTZD39oRhmIy4Lr3eg6tz5emshanD3iAH4Fo0Zo4k01PKT
         rMwWLny5pU9ZIDv8ion+ApvCKssogSvfEb2D7jW0T03sW1qgu31oNU03rxM/jBNXPhZt
         wkS2iPnyxOGs5zo0NAgcgima2qz0sJjBVgsZcBWbrXMAfqim0+FiOh5jf56CQ884KaIQ
         AJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785791685; x=1786396485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z5Tn8GDAuHvEBSiHkYSZKLLT9+XXk8tB1iGEjxC739I=;
        b=LadLjdH3VCFbtPL8JizUY6GgdrnS+RN95wpRpccZlJHnLZ+iKqw+HJFRJDCtbE41yE
         nsX7+ONu4mM/SebTi8+Okjw1Jv+zv0ZJEnOub/r0qGqq/wun+Y0nseIek7A8xsfh12+P
         RtIOKs92JkIeAgY14iSiSOAnLAq/S9ucJYJv2Owvj8b5O60NTfc8hNq2mscoVf4qHi0G
         +sP0G6UsLYNf7veuT9ZDT6H2wLUn2Bbxig5vfKUU31bbi5OxFCJpyiTQ0qg8LbpMKXMs
         8pY0hvsNS1NMRRN49etZ9CkyjIC0qPbXBlJzoLO8eGjpDkEmzsumLDa0P5hF8GRnh0qG
         ebcQ==
X-Gm-Message-State: AOJu0Yy4X+mNUpX9iYgRvVB0q+qbswmffSI4wjALdxu1TA8ZQ9uF1MMz
	VAnzHwEHQVibwQSzSi5kld2Gyae9k8WlYbgQgyuNaqGhlY/x52V2ZECSCE/1h7fagwnwkdpehN3
	tarU3DsaVFcoppEYfAqWxgk2vuAqKyoIrSencZVXB7x7Rd2eaXDZw
X-Gm-Gg: AR+sD128YbJm7L03lVJ9g6HX7tfpC9XVVo+h9bBieuYDqn86yC72VUAw2Nt4JWyylbi
	fqJXQr93YvdRpDWDuAG1jyV/WsSz2q7W0qRoHKgUTue2Z4TQx432EmFgL7yWdrVVhaNHUtsPpw/
	bxchF93XDjrflj2m5Np7oTyWndYrk2t3PNjn6Q8Tgisx2SIs45oM2Af4glu6taHIEzty1D4IObW
	dtChRUZ+ou5cOonxiQK4bPg4SOHjtIbpWXKSj5vAMxli51Q6IxxN23GkM/l9O+8CzGrqlT/DYvz
	LRYnjBRJ/kmU8q/Kv98svKAr/G+lwwY3DXny92RO7qwLzo7N3YzDWT5sSYt2BhEzSGO27IdClJv
	Q0XuYLIjdy++IZOXM9A==
X-Received: by 2002:a17:903:2443:b0:2cf:9e90:8be with SMTP id d9443c01a7336-2d0524799d8mr154463345ad.4.1785791685120;
        Mon, 03 Aug 2026 14:14:45 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2d04b136acfsm10910745ad.39.2026.08.03.14.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 14:14:45 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 62F3C402A0;
	Mon,  3 Aug 2026 15:14:44 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 52883E4041D; Mon,  3 Aug 2026 15:14:44 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/8] ublk: io_desc optimizations
Date: Mon,  3 Aug 2026 15:14:32 -0600
Message-ID: <20260803211441.2538144-1-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is based on the "ublk: harden user buffer handling" series.

ublk passes the parameters of incoming I/O in memory shared between the
kernel ublk driver and userspace ublk server in struct ublksrv_io_desc.

The thread submitting the ublk I/O writes to the io_desc, while the ublk
server thread handling the I/O reads the io_desc. This basically
guarantees a cache miss on both threads for each ublk I/O. Avoid the
cache misses by writing the io_desc on the server thread in the kernel
before dispatching the I/O to userspace.

The size of each io_desc is currently fixed to 24 bytes, which has been
an obstacle to extending it with additional fields [1]. Additionally,
with multiple ublk server threads handling I/Os from the same ublk queue
(possible with UBLK_F_PER_IO_DAEMON or UBLK_F_BATCH_IO), false sharing
results from adjacent io_descs sharing the same cache line. Add a
UBLK_F_IO_DESC_SIZE feature allowing the ublk server to increase the
size of the io_descs for its ublk devices.

[1]: https://lore.kernel.org/linux-block/aV8QfvaNO5P6vOs6@fedora/

v2:
- Cap io_desc_size arbitrarily at 256 (Ming)
- Add kublk list support, selftest (Ming)
- Add Reviewed-by tags, Suggested-by tag (Ming)

v1: https://lore.kernel.org/linux-block/20260729012951.3744582-1-csander@purestorage.com/

Caleb Sander Mateos (8):
  ublk: consistently use u16 for queue and tag numbers
  ublk: remove struct ublk_zoned_report_desc's operation field
  ublk: split request validation from io_desc init
  ublk: initialize io_desc on daemon task
  ublk: add UBLK_F_IO_DESC_SIZE
  selftests: ublk: add support for --io_desc_size
  selftests: ublk: add UBLK_F_IO_DESC_SIZE test
  ublk: lift checks out of ublk_{,un}map_io()

 drivers/block/ublk_drv.c                     | 261 ++++++++++---------
 include/uapi/linux/ublk_cmd.h                |   5 +-
 tools/testing/selftests/ublk/Makefile        |   1 +
 tools/testing/selftests/ublk/kublk.c         |  30 ++-
 tools/testing/selftests/ublk/kublk.h         |   6 +-
 tools/testing/selftests/ublk/test_loop_08.sh |  25 ++
 6 files changed, 188 insertions(+), 140 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh

-- 
2.54.0

