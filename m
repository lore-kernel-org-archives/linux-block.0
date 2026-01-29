Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3E77478
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 03:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769656520; cv=none; b=PI5XkAn1wLz/gq4k7bp0EhniZX8WPxUlatLGEliTDBWlZd+X8D8bQPCoFBC6uAdjhOe8Cu3ovYM6O1oXUFp7fqEhl6zej560kpxNq3TWzdJ6dp8aIla+u2oxFt4UiX0MbZa/M4szFZf3/VvkytuJHDiNc3Jda0AhMB86oO6nTH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769656520; c=relaxed/simple;
	bh=BerUuHV3Nn8ojYI2+i0RdyDGZsXHuwa2eBuT6DHo6n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhbVwsDR/1YNoUMloAj8Ghu7Maw5elIwCmDGPLZI5mitHUgexN2BCSVKl0FTN7LWp4vgRdLEzNUhKojiUVBP9gBIn2b0VFYV9IOLZP02YbLfe5EzChn9EDiew9C7oTj1j2T+Yp3M3JPw1iYTOBCV30g94A62ruoF5sI17AfIodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiVQkPMH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiVQkPMH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769656517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VDWNh/hqVl5bmijfc5DObX4mMxC2c2CEGHIdKzAGEQg=;
	b=OiVQkPMHwjhbp5UJuraEMNY3zzCEz02bo4J3lnAEN6yLEiT5XXlv+TadpoUWO7FMHtUBxd
	IaARib9t0aamiAnhlqwuJqKOSfd0Ib58ZZt3Zb2fSSu19LXaH4hguvRV+3y8F80S6G5TS6
	vWRKv9E9HXcirjio4vsHQiTAx4ZhxOU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-_r_e6xr2Mpa0-AjhReWYNA-1; Wed,
 28 Jan 2026 22:15:14 -0500
X-MC-Unique: _r_e6xr2Mpa0-AjhReWYNA-1
X-Mimecast-MFC-AGG-ID: _r_e6xr2Mpa0-AjhReWYNA_1769656513
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1377519560AA;
	Thu, 29 Jan 2026 03:15:13 +0000 (UTC)
Received: from localhost (unknown [10.72.116.182])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8E11E1958DC0;
	Thu, 29 Jan 2026 03:15:10 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/5] ublk: misc improvement in driver and selftests
Date: Thu, 29 Jan 2026 11:14:54 +0800
Message-ID: <20260129031501.3403688-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Hi Jens,

The 1st patch improves fetch command removal and canceling, which is
reported as risk from AI.

The 2nd patch adds UBLK_F_NO_AUTO_PART_SCAN for disabling partition
scanning during adding disk.

The 3rd patch cleans up selftests by deriving TID automatically.

The 4th patch marks each test start and end in dmesg.

The last patch adds test case for UBLK_F_NO_AUTO_PART_SCAN.

Thanks,


Alexander Atanasov (1):
  selftests: ublk: mark each test start and end time in dmesg

Ming Lei (4):
  ublk: check list membership before cancelling batch fetch command
  ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
  selftests: ublk: derive TID automatically from script name
  selftests: ublk: add selftest for UBLK_F_NO_AUTO_PART_SCAN

 drivers/block/ublk_drv.c                      |  23 +++-
 include/uapi/linux/ublk_cmd.h                 |   3 +
 tools/testing/selftests/ublk/Makefile         |   2 +
 tools/testing/selftests/ublk/kublk.c          |   6 +-
 tools/testing/selftests/ublk/kublk.h          |   3 +-
 tools/testing/selftests/ublk/test_batch_01.sh |   1 -
 tools/testing/selftests/ublk/test_batch_02.sh |   1 -
 tools/testing/selftests/ublk/test_batch_03.sh |   1 -
 tools/testing/selftests/ublk/test_common.sh   |   6 +
 .../testing/selftests/ublk/test_generic_01.sh |   1 -
 .../testing/selftests/ublk/test_generic_02.sh |   1 -
 .../testing/selftests/ublk/test_generic_03.sh |   1 -
 .../testing/selftests/ublk/test_generic_04.sh |   1 -
 .../testing/selftests/ublk/test_generic_05.sh |   1 -
 .../testing/selftests/ublk/test_generic_06.sh |   1 -
 .../testing/selftests/ublk/test_generic_07.sh |   1 -
 .../testing/selftests/ublk/test_generic_08.sh |   1 -
 .../testing/selftests/ublk/test_generic_09.sh |   1 -
 .../testing/selftests/ublk/test_generic_10.sh |   1 -
 .../testing/selftests/ublk/test_generic_11.sh |   1 -
 .../testing/selftests/ublk/test_generic_12.sh |   1 -
 .../testing/selftests/ublk/test_generic_13.sh |   1 -
 .../testing/selftests/ublk/test_generic_14.sh |   1 -
 .../testing/selftests/ublk/test_generic_15.sh |   1 -
 .../testing/selftests/ublk/test_generic_16.sh |   1 -
 tools/testing/selftests/ublk/test_loop_01.sh  |   1 -
 tools/testing/selftests/ublk/test_loop_02.sh  |   1 -
 tools/testing/selftests/ublk/test_loop_03.sh  |   1 -
 tools/testing/selftests/ublk/test_loop_04.sh  |   1 -
 tools/testing/selftests/ublk/test_loop_05.sh  |   1 -
 tools/testing/selftests/ublk/test_loop_06.sh  |   1 -
 tools/testing/selftests/ublk/test_loop_07.sh  |   1 -
 tools/testing/selftests/ublk/test_loop_08.sh  |   1 -
 tools/testing/selftests/ublk/test_null_01.sh  |   1 -
 tools/testing/selftests/ublk/test_null_02.sh  |   1 -
 tools/testing/selftests/ublk/test_null_03.sh  |   1 -
 tools/testing/selftests/ublk/test_null_04.sh  |   1 -
 tools/testing/selftests/ublk/test_part_01.sh  | 104 ++++++++++++++++++
 .../testing/selftests/ublk/test_stress_01.sh  |   1 -
 .../testing/selftests/ublk/test_stress_02.sh  |   1 -
 .../testing/selftests/ublk/test_stress_03.sh  |   1 -
 .../testing/selftests/ublk/test_stress_04.sh  |   1 -
 .../testing/selftests/ublk/test_stress_05.sh  |   1 -
 .../testing/selftests/ublk/test_stress_06.sh  |   1 -
 .../testing/selftests/ublk/test_stress_07.sh  |   1 -
 .../testing/selftests/ublk/test_stress_08.sh  |   1 -
 .../testing/selftests/ublk/test_stress_09.sh  |   1 -
 .../testing/selftests/ublk/test_stripe_01.sh  |   1 -
 .../testing/selftests/ublk/test_stripe_02.sh  |   1 -
 .../testing/selftests/ublk/test_stripe_03.sh  |   1 -
 .../testing/selftests/ublk/test_stripe_04.sh  |   1 -
 .../testing/selftests/ublk/test_stripe_05.sh  |   1 -
 .../testing/selftests/ublk/test_stripe_06.sh  |   1 -
 53 files changed, 141 insertions(+), 52 deletions(-)
 create mode 100755 tools/testing/selftests/ublk/test_part_01.sh

-- 
2.47.0

