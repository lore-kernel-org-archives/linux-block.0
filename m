Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C074DAD27
	for <linux-block@vger.kernel.org>; Mon,  3 Mar 2025 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005823; cv=none; b=HnIdupThNZZsIpVnySWhjBX8R8EDyrik7bM2/uzjuERO6caS5IplaaA3YIdQ01/zXE5DM2oJSXGs5Y+uQ9v3w/KcNc6kzt2ghY8s/qNY5jUIwnjWhlS9rm8W4vjsT5juDHgPOWXdgyW0fYuxYkTX9j+f3qClG03zH84Adzav9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005823; c=relaxed/simple;
	bh=FR8f6OTYzxpbDZfjxI2ncturkIcoZjcEe9JOkVroDsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XLGYzZ5TU/g3/drodad4dnUbv5JOXaRDB4tjAI6FCiKER53Rq2E8yOKEFLmExmi3f19+AQd8ys9MTfiFNcS0n1qoBZ9UufwFum69niUva3hgtRm8li77lCTnAXlBwAjITOWHMXB9CyAwcP1XBf/mlCfvDGMnW8M2QipGYtviOaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXABwOGb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXABwOGb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741005820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=55Yz1Z9WIVSPvjndpkumuunccgMCP6JbGoOXhDzkQHQ=;
	b=GXABwOGbcoPWCJDduZFuyQ1Ay35qRGdAdh+PKCyc/0KveFKDijX5ET3rXor6GQ41qzTo6S
	etEnXfacF/NS1LFHCy5ClFWqvqvZmmqgm93pe4Iby/6cp6gGJH1Un+WjA3JRjjNPS7N4S/
	NHs/fa8WsD+IcgtszjE/p1/EIFgM9F8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-3xCsZy3KMYWE7PIkSWdDkw-1; Mon,
 03 Mar 2025 07:43:39 -0500
X-MC-Unique: 3xCsZy3KMYWE7PIkSWdDkw-1
X-Mimecast-MFC-AGG-ID: 3xCsZy3KMYWE7PIkSWdDkw_1741005818
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D7D41918165;
	Mon,  3 Mar 2025 12:43:38 +0000 (UTC)
Received: from localhost (unknown [10.72.120.23])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D63CE1800367;
	Mon,  3 Mar 2025 12:43:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 00/11] selftests: ublk: bug fixes & consolidation
Date: Mon,  3 Mar 2025 20:43:10 +0800
Message-ID: <20250303124324.3563605-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hello Jens and guys,

This patchset fixes several issues(1, 2, 4) and consolidate & improve
the tests in the following ways:

- support shellcheck and fixes all warning

- misc cleanup

- improve cleanup code path(module load/unload, cleanup temp files)

- help to reuse the same test source code and scripts for other
  projects(liburing[1], blktest, ...)

- add two stress tests for covering IO workloads vs. removing device &
killing ublk server, given buffer lifetime is one big thing for ublk-zc 


[1] https://github.com/ming1/liburing/commits/ublk-zc 

- just need one line change for overriding skip_code, libring uses 77 and
  kselftests takes 4

Ming Lei (11):
  selftests: ublk: make ublk_stop_io_daemon() more reliable
  selftests: ublk: fix build failure
  selftests: ublk: add --foreground command line
  selftests: ublk: fix parsing '-a' argument
  selftests: ublk: support shellcheck and fix all warning
  selftests: ublk: don't pass ${dev_id} to _cleanup_test()
  selftests: ublk: move zero copy feature check into _add_ublk_dev()
  selftests: ublk: load/unload ublk_drv when preparing & cleaning up
    tests
  selftests: ublk: add one stress test for covering IO vs. removing
    device
  selftests: ublk: add stress test for covering IO vs. killing ublk
    server
  selftests: ublk: improve test usability

 tools/testing/selftests/ublk/Makefile         |   6 +
 tools/testing/selftests/ublk/kublk.c          |  43 +++--
 tools/testing/selftests/ublk/kublk.h          |   2 +
 tools/testing/selftests/ublk/test_common.sh   | 167 ++++++++++++++----
 tools/testing/selftests/ublk/test_loop_01.sh  |  13 +-
 tools/testing/selftests/ublk/test_loop_02.sh  |  14 +-
 tools/testing/selftests/ublk/test_loop_03.sh  |  16 +-
 tools/testing/selftests/ublk/test_loop_04.sh  |  14 +-
 tools/testing/selftests/ublk/test_null_01.sh  |   9 +-
 .../testing/selftests/ublk/test_stress_01.sh  |  47 +++++
 .../testing/selftests/ublk/test_stress_02.sh  |  47 +++++
 11 files changed, 300 insertions(+), 78 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_stress_01.sh
 create mode 100755 tools/testing/selftests/ublk/test_stress_02.sh

-- 
2.47.0

