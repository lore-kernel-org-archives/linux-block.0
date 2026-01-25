Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3FA17DFE7;
	Sun, 25 Jan 2026 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769331488; cv=none; b=SvUFkea8vkGXzImF0mUhhB57kaxhql187NQc21pk3VPwmXGVGq8cJ3fxsUQyVTBt/kKEjmwX5t6mbdfxpVNmX28msI5M4QkCVzWP2vjUPGWRmZ673YUvvMFZfsf4wouMC8LGzZd6Fq4+HXcFOIIom8JO59iYgHcnwkyh3+E77m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769331488; c=relaxed/simple;
	bh=1HaJTy+ipoPfBFt+sG1DshpgFRc8uCED8zzZuVjhY5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ci6ph+t2CTIbjOyfJde5SBYm0rOwYal8gx3DMBCo+TRzzhL3dnaCjjjydClbpRkNukE42xJPf9iaxTA6CQavSrT7F3ULmGFvMHb/PgN2Isv5MqPKgOtv3rkEyTDhQr9+CN8uc+AZsY4vvAdqe+QkuWSOLeoAWz1hLWEApnBCqf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=XBHQJHdV; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="XBHQJHdV"
X-Virus-Scanned: Yes
From: Alexander Atanasov <alex@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1769331476; bh=1HaJTy+ipoPfBFt+sG1DshpgFRc8uCED8zzZuVjhY5M=;
	h=From:To:Cc:Subject;
	b=XBHQJHdVLmsXCpLl0JTrsl03fWFsGnhtn2wucK73lG6ad0FaCnbEmtf24LIjRD0VD
	 zIRub/YHxGBhLKstqMwYtv1M60UekGBsd+gYOpzmzXngKuU2S1biptBRkEAIrUst/L
	 mzCIw+dVtzi1hHwOZn/l4qZ0/nK8wmk7bOrdtMzZT/+wm/Xre8PTXY8RnXi0ViO87+
	 Wc/ZLqhbspx3uiRBvglKcaU+3KGvGX4uJL0QszMJAMEKceqhw0ov2f/spjY4lo0j74
	 WN2mUjk/gnogYM0xgS20n2L4gjvUBJ9RHw4uxtf7TogHrS0VRcy1tt+oP62TknD6d8
	 6+BZ95Olh/0ZaM9K4z4034uAs6b56LfB9/8mUeKFqp8ZJo8e2w8GVc9ipnfmn8GAtv
	 qU26GkG5kONlZpzFOr1IDEBLAbjeFc8kJPaA6mK/kyjSCVTVb2hT24yYx1dDTMTiYU
	 LpHiA37QbN/4Vcv/jwpjyr44U74PDBUYQo8iRLA1lkoYA1KHcnJ3WP8pklOep4uY6f
	 7G7AWYdL+qzFdmoMT2tsc6INW5FedWcYiodapntylB1BRUc/d85rCdYI4zEcOEDavD
	 eKmliBBZ+IS28w1IHWrcXb+N7+IjxIEwDMiCrjAMOyyzx30fSTn4mQLU5LAr86o7tn
	 qCq/6db6yzrvyoTwOLu4TEJg=
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>
Cc: Alexander Atanasov <alex@zazolabs.com>,
	linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: ublk: add missing gitignore for metadata_size binary
Date: Sun, 25 Jan 2026 08:57:46 +0000
Message-ID: <20260125085747.1631424-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A new utility metadata_size was added in
commit 261b67f4e347 ("selftests: ublk: add utility to get block device metadata size")
but it was not added to .gitignore. Fix that by adding it there.

While at it sort all entries alphabetically and add a SPDX license header.

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: 261b67f4e347 ("selftests: ublk: add utility to get block device metadata size")
Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
---
 tools/testing/selftests/ublk/.gitignore | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

v1->v2:
 - add SPDX license header
 - sort alphabetically as suggested by Caleb Sander Mateos

It is also Reviewed-by: Ming Lei <ming.lei@redhat.com> but it needs an Ack from him,
as he is the original author of the file, for the license header.


diff --git a/tools/testing/selftests/ublk/.gitignore b/tools/testing/selftests/ublk/.gitignore
index 8b2871ea7751..e17bd28f27e0 100644
--- a/tools/testing/selftests/ublk/.gitignore
+++ b/tools/testing/selftests/ublk/.gitignore
@@ -1,3 +1,5 @@
-kublk
-/tools
+# SPDX-License-Identifier: GPL-2.0
 *-verify.state
+/tools
+kublk
+metadata_size
-- 
2.43.0

