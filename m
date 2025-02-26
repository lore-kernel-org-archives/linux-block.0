Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4222C25D537
	for <linux-block@vger.kernel.org>; Wed, 26 Feb 2025 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740550825; cv=none; b=LdceSQpLiThypZ69zhbkWzduW+BdDQbefGCEo3XkTc7+fC8VAV17G6On4BxBLW/DsmGuIpIQClkPuSF0VfbSRcOQ/1NW+4/G8tMvSxqjNAayS/p0cC2T7fCXI9pbXuP50zuDNwqwp2fY84yD6XBlCUdq77YVzUsfXsQqs00S1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740550825; c=relaxed/simple;
	bh=s9PEzissdmP5tjxcso79iidbFGJX3Pyz9B8vKM+8ulg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nmepVCBZ+HsDDtrvFN3vzFiPwiqMWh0pCEsmTBnIy83lDglK5e1Suw5iQsKy25bmd7lWUG6ySi/pjFZzS+Yyg/j7VKVtKO/ciOSXt+UU5hJIUtv3JFgcYhFP3bzWiewZimhf9xdYY9O6UFBvw6i1Llw/fi2DX+FT06QHrCxZWYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fg+MMG6b; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fg+MMG6b"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1740550823; x=1772086823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=s9PEzissdmP5tjxcso79iidbFGJX3Pyz9B8vKM+8ulg=;
  b=fg+MMG6bIOSRfkoNjY62GytQcxMLeZFwnfREnBkZFSKhQn7RPNctpqK9
   8gTxczT0QOvmOZmfQmpNCuYh4EB6fPKTdmpcOBpGSM4JhGPuRbrCSmt/S
   YuPSqaTSdtGHpzW+uFr1MTBh3WdC7Bkwllz+BmQU8qK6aT/5wI3+KshIo
   VX2SuDX/YFBVADn4YaRw5iQ+TA8b9PpancxO4GwxnKoRojOvKqu7wqvAu
   kz7rBSGyyL+ZLYlVyIATIRA8yTccOD7f1i+NEHsNlnOilUYnPLC5J27kM
   8EBzynkLp0IDGw1vK6Bg6wIA5kkjlODmiYCnTM4BID8QedTmSfBThR3wz
   A==;
X-CSE-ConnectionGUID: x5ftM4I4TjSb+br7YyBYgQ==
X-CSE-MsgGUID: hV9sl8x/TqqFxZAXsJPaAA==
X-IronPort-AV: E=Sophos;i="6.13,316,1732550400"; 
   d="scan'208";a="39464584"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2025 14:20:16 +0800
IronPort-SDR: 67bea4dc_Nf2y/rbAELAkgijSbP7AkW4AzFECYNxSjgdrQ3fk7tO4iuj
 D9AzfyhdrIyY31D81N5UxOnPpMreTQpJdfitR4Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Feb 2025 21:21:33 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Feb 2025 22:20:16 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] zbd/012: avoid fio stop by I/O scheduler set failure
Date: Wed, 26 Feb 2025 15:20:15 +0900
Message-ID: <20250226062015.1620612-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test case zbd/012 fails occasionally due to a sudden fio stop. At
the fio stop, fio outputs the following error message:

 fio: unable to set io scheduler to none
 fio: pid=119786, err=22/file:backend.c:1485, func=iosched_switch, error=Invalid argument

The test case specifies --scheduler=none option to the fio command. At
the workload start, fio sets I/O scheduler of the test target device to
"none" by writing to the sysfs "queue/scheduler" attribute. Subsequently,
fio verifies this action by reading the attribute, expecting to find the
string "[none]". However, it instead finds "[mq-deadline]", leading to
the error.

The test case runs another process to switch the I/O scheduler of the
test target device between "none" and "mq-deadline" every 0.1 seconds.
When the switch to "mq-deadline" occurs in the interim between the sysfs
attribute write and read by fio, fio encounters the "[mq-deadline]"
value, resulting in the error.

To avoid the failure, drop the --scheduler=none option from the fio
command in the test case zbd/012. I confirmed that the test case still
can recreate the hang with this fix, using the kernel v6.12.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/zbd/012 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/zbd/012 b/tests/zbd/012
index 42ca351..2a93d59 100755
--- a/tests/zbd/012
+++ b/tests/zbd/012
@@ -59,7 +59,6 @@ test() {
 				--filename="${zdev}"
 				--iodepth="${qd}"
 				--ioengine="${ioengine}"
-				--ioscheduler=none
 				--name="requeuing-and-queue-freezing-${qd}"
 				--runtime=$((${TIMEOUT:-30}/5))
 				--rw=randwrite
-- 
2.47.0

