Received: from mail-oi1-f227.google.com (mail-oi1-f227.google.com [209.85.167.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C9C233136
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765949716; cv=none; b=aUp3OE53f9iKObA9Nbsl3deNoSN0/08BbX0qGXQV3jRik0Qtz4ODZpOcq32cY8rxXAATgyPBr/BCbqEJxWd7Rg2fr0ykt/DcURw78SZGY2k/ReOeHVUjUrrMfoc1Nqp8R35vK/KORdxHInaN35I5blyGFlmCncgbEW2fJc60Ci8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765949716; c=relaxed/simple;
	bh=ucGc+TSUhYwDQoc6ixsQQruv8iiJb+kc2UPEiXGTkNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C+hKyjjx2LWuXzkQDsn/pasgJbQCnP5xNAk3Ig63J7EGUaVC2HVRlXcXCu07H7G0FgC3XE0pgckMfshpoymZBRVqZIUZft+R+vZ5auR9WX7VjFHYb6RLTYh/zqf5isPZJc6zoEfkgOjboiiNnAWCXzSPGk9W2sE1HYFXq05XDtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=QFCLjIjM; arc=none smtp.client-ip=209.85.167.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="QFCLjIjM"
Received: by mail-oi1-f227.google.com with SMTP id 5614622812f47-450b7ee2d4bso1342820b6e.2
        for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 21:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765949712; x=1766554512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0kYX7fMn9cIPzKPm0RApyGOG3Uig+HeoLvmYZn5VOao=;
        b=QFCLjIjMHAEmGNaa2/JpmUKDwUAGOln7JFY643iw14Vfg/VodX40ExsPW+ldBRXdac
         OPijxuHX9wSUFNUXB7xaVPO60bJB76fQWIyojg04cfExQ2Qrc5V5MkAqQXmZS0lE0OUN
         oLnCi0k2fyoUj6OyfKAwPQOL4oAhQL64+uoyAuXz82L7tvlXM+O+u9J8qx3VbZzRUywA
         w9TuXLam7vIuC3QXw5jqUUutYH8Mso3I9DL7ZsdMknMET77Ol1kVW1VCyhq/vkd6A2tQ
         AvCp1jytQB6dL1u0BJkBcxZJUGZQ1iLYVmHV0ueukFUsy/cbcIDszm5uVYKA4o4f1yt0
         GN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765949712; x=1766554512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kYX7fMn9cIPzKPm0RApyGOG3Uig+HeoLvmYZn5VOao=;
        b=hwB1o/DHddcJjtR9BYlKuvNU9W0FeQR8CW2jt3/afA4PwRViBwl2s7r/DNjvwmJMCL
         7wXaYoZmCgNf+eT4ksGCt4ie+ataLiUNoOvl3I9HpchJmGcdk+RU0Rh7QDc2Or6M+riv
         F292mWE2+FVmqvvyWJdEsrIRH7xTrvv5qZnFVL2KCH7nMU60Of4bntnT/33LgnlKkEM7
         6IXFg0Sb9okG9rEZbpw9euLF0Dh5MuM0hBhygLPi7nAlC6vznllCNp3+NS5uPi/in3IX
         QkByA8rQS2KcP7WUApzlqY05dtlUpxEzdj8vV3OmXfC6JrvEomE6V/otgvRCa798otia
         44Zw==
X-Gm-Message-State: AOJu0YytlLySzG5ZlX/S9ynyvMMZFR5c+fx4G0IXQHiwRdps5YXGRyB9
	A+okY6JtRbYSPPL+RrW8Yj58tdt2htFIGg3G5pDNzR9o/SJup1C5pZ4EPc9pCh8HZcl09b/V6W+
	qSUlYcsEIxF7JfjddEUj1Am9SCYzrPT6chEZK
X-Gm-Gg: AY/fxX6B6zqVuQKULTzP52+I/JH78ZupC6KHPpR7g5T4/WAp/yLzEtKtdsz34tbJWrN
	4U2YV+DZ+gL4ynN7z+r2UojXRzBTixA7qu+NorSDKaPRgagSWELCbOFpQt1Ax3I/oezj4W3XW/Z
	yJE/8lq07PR7357NUEzEFBlGIgtb2BsNGKG4tk14RHnvYCDwk+Eo5yAVrG6EuEBppcqKnmsuX9G
	+kIGM+Lfvu0mz9WN6Oe9nymwh9CHzwtLjE6UE67lvuGVGnKAwB3SFiyDnzY53NxJiiuf7ndgX1t
	QkoT+tdwWdxGCGhI0LK5eYfZszNelRp3fNqJE6EyQRpZKzs2Ms6go0bOjGq50ToJBDkkLsS8lLD
	rukeMKEImmZCtFPQ16P99rgGaJ95P5IvFZyui1jn3CA==
X-Google-Smtp-Source: AGHT+IG1pNtGJfvVY9V6xHjDD1plNrOgWrKS0l5UH8P7p8sfNn2pWC8Cix6HvcE4sAJQZVA7PfrFFWXPVAX9
X-Received: by 2002:a05:6871:a606:b0:3f5:b461:e811 with SMTP id 586e51a60fabf-3f5f88e90demr7048611fac.5.1765949711983;
        Tue, 16 Dec 2025 21:35:11 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3f614e7e074sm1486621fac.17.2025.12.16.21.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 21:35:11 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::1199])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5C1713401D2;
	Tue, 16 Dec 2025 22:35:11 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 54EB0E41A08; Tue, 16 Dec 2025 22:35:11 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 00/20] ublk: add support for integrity data
Date: Tue, 16 Dec 2025 22:34:34 -0700
Message-ID: <20251217053455.281509-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Much work has recently gone into supporting block device integrity data
(sometimes called "metadata") in Linux. Many NVMe devices these days
support metadata transfers and/or automatic protection information
generation and verification. However, ublk devices can't yet advertise
integrity data capabilities. This patch series wires up support for
integrity data in ublk. The ublk feature is referred to as "integrity"
rather than "metadata" to match the block layer's name for it and to
avoid confusion with the existing and unrelated UBLK_IO_F_META.

To advertise support for integrity data, a ublk server fills out the
struct ublk_params's integrity field and sets UBLK_PARAM_TYPE_INTEGRITY.
The struct ublk_param_integrity flags and csum_type fields use the
existing LBMD_PI_* constants from the linux/fs.h UAPI header. The ublk
driver fills out a corresponding struct blk_integrity.

When a request with integrity data is issued to the ublk device, the
ublk driver sets UBLK_IO_F_INTEGRITY in struct ublksrv_io_desc's
op_flags field. This is necessary for a ublk server for which
bi_offload_capable() returns true to distinguish requests with integrity
data from those without.

Integrity data transfers can currently only be performed via the ublk
user copy mechanism. The overhead of zero-copy buffer registration makes
it less appealing for the small transfers typical of integrity data.
Additionally, neither io_uring NVMe passthru nor IORING_RW_ATTR_FLAG_PI
currently allow an io_uring registered buffer for the integrity data.
The ki_pos field of the struct kiocb passed to the user copy
->{read,write}_iter() callback gains a bit UBLKSRV_IO_INTEGRITY_FLAG for
a ublk server to indicate whether to access the request's data or
integrity data.

Not yet supported is an analogue for the IO_INTEGRITY_CHK_*/BIP_CHECK_*
flags to ask the ublk server to verify the guard, reftag, and/or apptag
of a request's protection information. The user copy mechanism currently
forbids a ublk server from reading the data/integrity buffer of a
read-direction request. We could potentially relax this restriction for
integrity data on reads. Alternatively, the ublk driver could verify the
requested fields as part of the user copy operation.

The first 2 commits harden blk_validate_integrity_limits() to reject
nonsensical pi_offset and interval_exp integrity limits.

Caleb Sander Mateos (17):
  block: validate pi_offset integrity limit
  block: validate interval_exp integrity limit
  blk-integrity: take const pointer in blk_integrity_rq()
  ublk: move ublk flag check functions earlier
  ublk: set UBLK_IO_F_INTEGRITY in ublksrv_io_desc
  ublk: add ublk_copy_user_bvec() helper
  ublk: split out ublk_user_copy() helper
  ublk: inline ublk_check_and_get_req() into ublk_user_copy()
  ublk: move offset check out of __ublk_check_and_get_req()
  ublk: optimize ublk_user_copy() on daemon task
  selftests: ublk: add utility to get block device metadata size
  selftests: ublk: add kublk support for integrity params
  selftests: ublk: implement integrity user copy in kublk
  selftests: ublk: support non-O_DIRECT backing files
  selftests: ublk: add integrity data support to loop target
  selftests: ublk: add integrity params test
  selftests: ublk: add end-to-end integrity test

Stanley Zhang (3):
  ublk: add integrity UAPI
  ublk: support UBLK_PARAM_TYPE_INTEGRITY in device creation
  ublk: implement integrity user copy

 block/blk-settings.c                         |  14 +-
 drivers/block/ublk_drv.c                     | 336 +++++++++++++------
 include/linux/blk-integrity.h                |   6 +-
 include/uapi/linux/ublk_cmd.h                |  20 +-
 tools/testing/selftests/ublk/Makefile        |   6 +-
 tools/testing/selftests/ublk/common.c        |   4 +-
 tools/testing/selftests/ublk/fault_inject.c  |   1 +
 tools/testing/selftests/ublk/file_backed.c   |  61 +++-
 tools/testing/selftests/ublk/kublk.c         |  85 ++++-
 tools/testing/selftests/ublk/kublk.h         |  37 +-
 tools/testing/selftests/ublk/metadata_size.c |  37 ++
 tools/testing/selftests/ublk/null.c          |   1 +
 tools/testing/selftests/ublk/stripe.c        |   6 +-
 tools/testing/selftests/ublk/test_common.sh  |  10 +
 tools/testing/selftests/ublk/test_loop_08.sh | 111 ++++++
 tools/testing/selftests/ublk/test_null_04.sh | 166 +++++++++
 16 files changed, 765 insertions(+), 136 deletions(-)
 create mode 100644 tools/testing/selftests/ublk/metadata_size.c
 create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh
 create mode 100755 tools/testing/selftests/ublk/test_null_04.sh

-- 
2.45.2

