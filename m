Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7D33093CB
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971148; cv=none; b=E3mjwthiVigMmEnd24alrdacV4tgsGFgr0dsaNC1bPW2ksMgSmvDpmUhJXhTrYlLS+OwiNOvv7R/SLpiGCeBB/g+KMaysxjL+BjocaKoG/rqt/FrbVoRmf58XIid3JL094oNDi/nvAlDyRuaZ5eC7b4Ke3CEEuMlPjmzCWoVn+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971148; c=relaxed/simple;
	bh=eV5BMpfDpDFwCA1zAnP7HFUdcxsV/o/kPbTe4A5tXzo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XMfdRKRgIloPMnjfIrM3gl2KxLGipTKL0GxrwxM6O72p4Q3rTFceUtFQdWPuWxyFVfcVJwLWqcOJs2sMSrS+w5JtPGaA4j3/7FUrWIx9asXY1l+pSFX8Pg2JQLRH3x+HEQYLZ5/otP0l0oJFFGs9wzGCw2A7OzxIybh3tyJaL2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KtII02Iw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtII02Iw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774971137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gY8pFWmDdku7ffP9u8tEQC3+mU+qhw083DDwvgUHjW0=;
	b=KtII02IwjG1iN5N5d8WuedsCKcbf4YAb4Zvgnn8kxiIN4okvpC0KQVtJFFNoRfip854fZf
	+Ir0+XX3cG3VJsAz4f7PTg+m7QznaKFeMyfT+ZH2UOSe/pnGMyf54RhYOlQNwRUN+juQEu
	14EKDx339X29F5Nwc6+K0VbVz+sfzDs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-ikJ6Rnf5P4-QEWEhIAMUJA-1; Tue,
 31 Mar 2026 11:32:16 -0400
X-MC-Unique: ikJ6Rnf5P4-QEWEhIAMUJA-1
X-Mimecast-MFC-AGG-ID: ikJ6Rnf5P4-QEWEhIAMUJA_1774971135
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ECAD51944DC9;
	Tue, 31 Mar 2026 15:32:14 +0000 (UTC)
Received: from localhost (unknown [10.72.116.55])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DE39180035F;
	Tue, 31 Mar 2026 15:32:13 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 00/10] ublk: add shared memory zero-copy support
Date: Tue, 31 Mar 2026 23:31:51 +0800
Message-ID: <20260331153207.3635125-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hello,

Add shared memory based zero-copy (UBLK_F_SHMEM_ZC) support for ublk.

The ublk server and its client share a memory region (e.g. memfd or
hugetlbfs file) via MAP_SHARED mmap. The server registers this region
with the kernel via UBLK_U_CMD_REG_BUF, which pins the pages and
builds a PFN maple tree. When I/O arrives, the driver looks up bio
pages in the maple tree — if they match registered buffer pages, the
data is used directly without copying.

Please see details on document added in patch 3.

Patches 1-4 implement the kernel side:
 - buffer register/unregister control commands with PFN coalescing,
   including read-only buffer support (UBLK_SHMEM_BUF_READ_ONLY)
 - PFN-based matching in the I/O path, with enforcement that read-only
   buffers reject non-WRITE requests
 - UBLK_F_SHMEM_ZC feature flag
 - eliminate permanent pages[] array from struct ublk_buf; the maple
   tree already stores PFN ranges, so pages[] becomes temporary

Patches 5-10 add kublk (selftest server) support and tests:
 - hugetlbfs buffer sharing (both kublk and fio mmap the same file)
 - null target and loop target tests with fio verify
 - filesystem-level test (ext4 on ublk, fio verify on a file)
 - read-only buffer registration test (--rdonly_shmem_buf)

Changes since V1:
 - rename struct ublk_buf_reg to struct ublk_shmem_buf_reg, add __u32
   flags field for extensibility, narrow __u64 len to __u32 (max 4GB
   per UBLK_SHMEM_ZC_OFF_MASK), remove __u32 reserved (patch 1)
 - add UBLK_SHMEM_BUF_READ_ONLY flag: pin pages without FOLL_WRITE,
   enabling registration of write-sealed memfd buffers (patch 1)
 - use backward-compatible struct reading: memset zero + copy
   min(header->len, sizeof(struct)) (patch 1)
 - reorder struct ublk_buf_range fields for better packing (16 bytes
   vs 24 bytes), change buf_index to unsigned short, add unsigned short
   flags to store per-range read-only state (patch 1)
 - enforce read-only buffer semantics in ublk_try_buf_match(): reject
   non-WRITE requests on read-only buffers since READ I/O needs to
   write data into the buffer (patch 2)
 - narrow struct ublk_buf::nr_pages to unsigned int, narrow struct
   ublk_buf_range::base_offset to unsigned int (patch 1)
 - add new patch 4: eliminate permanent pages[] array from struct
   ublk_buf — recover struct page pointers via pfn_to_page() from the
   maple tree during unregistration, saving 2MB per 1GB buffer
 - add UBLK_F_SHMEM_ZC to feat_map in kublk (patch 5)
 - add new patch 10: read-only buffer registration selftest with
   --rdonly_shmem_buf option on null target + hugetlbfs

Ming Lei (10):
  ublk: add UBLK_U_CMD_REG_BUF/UNREG_BUF control commands
  ublk: add PFN-based buffer matching in I/O path
  ublk: enable UBLK_F_SHMEM_ZC feature flag
  ublk: eliminate permanent pages[] array from struct ublk_buf
  selftests/ublk: add shared memory zero-copy support in kublk
  selftests/ublk: add UBLK_F_SHMEM_ZC support for loop target
  selftests/ublk: add shared memory zero-copy test
  selftests/ublk: add hugetlbfs shmem_zc test for loop target
  selftests/ublk: add filesystem fio verify test for shmem_zc
  selftests/ublk: add read-only buffer registration test

 Documentation/block/ublk.rst                  | 117 +++++
 drivers/block/ublk_drv.c                      | 403 +++++++++++++++++-
 include/uapi/linux/ublk_cmd.h                 |  79 ++++
 tools/testing/selftests/ublk/Makefile         |   5 +
 tools/testing/selftests/ublk/file_backed.c    |  38 ++
 tools/testing/selftests/ublk/kublk.c          | 347 ++++++++++++++-
 tools/testing/selftests/ublk/kublk.h          |  15 +
 tools/testing/selftests/ublk/test_common.sh   |  15 +-
 .../testing/selftests/ublk/test_shmemzc_01.sh |  72 ++++
 .../testing/selftests/ublk/test_shmemzc_02.sh |  68 +++
 .../testing/selftests/ublk/test_shmemzc_03.sh |  69 +++
 .../testing/selftests/ublk/test_shmemzc_04.sh |  72 ++++
 12 files changed, 1292 insertions(+), 8 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_02.sh
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_03.sh
 create mode 100755 tools/testing/selftests/ublk/test_shmemzc_04.sh

--
2.53.0

