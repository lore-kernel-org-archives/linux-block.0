Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53017A30A
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814797; cv=none; b=GbUDpVPjk9458U8NxnsRSgvQRygFFQy9XYjDkD6kW8V5AwADSW9R1QLm67QuZQxBhRpiymBMXddePuabgI0j3WrXOy5FaU8R02ojdISCIF5sTeFPWXwoUF0XIIBhLEqU7ieldKczFmAzOhedCKQKNyfpFM5HWtyE+GPuexyFXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814797; c=relaxed/simple;
	bh=Wfd5eO/clHgvcN4ga6QMEADLLo3rIDWzI9svwRTj0TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PjMhS+CMTOe2GzjadnBEssRrNRpYzstCOC+1lrrKFpo0VHFzqWopbBL6Be7JMf0bhWbOQhWuNh0MJxRbkT9bDl8gXsIiEpGz3CHXMRi+bd/8duG+bMigL7tDcCFvoQiCrbyMN56mIk7rJsBfuMNTKvGaN+7SV30ASDU9OBAuQdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=g3n0+0Nt; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="g3n0+0Nt"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id A09E1240101
	for <linux-block@vger.kernel.org>; Tue, 30 Jun 2026 12:19:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1782814787; bh=vmTIDbtuDiE70k7LfWm4n8mwiwaSDROKAJdmkwrIwY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=g3n0+0NtFVx9K+YbuKIBGWuVtmtfn+quGZqpKlWgyKSz/BMTtxyWDRivKeZX0zdEb
	 JSqk+Am8ODj+lzS18Psb4HoBH5Kase23TBwbpKLE/bugB47+aLSjsgti2pyIRbqVGf
	 1MsuSQ3DmTUttsk1KPrAeYaPRoYUA0qDrMGeSVPOJHwKWoOHM0OUa7YKix/O9p15tp
	 w7OYzsPxzTfDyrjdHt9tie4XwTJVmHKPFWGuaUNrEtSUxrqUdRGT0kv9bSfz+vFvOR
	 Bw2pzted3j8sPqQtw5sgWqM0cuxKXKKAa9UPfjPvOwbR98xqbpFjJ3EKej98o6HM2p
	 ppo1DnHP4Nh9w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gqJzk6Hp9z9rxG;
	Tue, 30 Jun 2026 12:19:46 +0200 (CEST)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	Mateusz Nowicki <Mateusz.Nowicki@posteo.net>
Subject: [PATCH blktests] nvme/039: drain udev events before passthru error injection
Date: Tue, 30 Jun 2026 10:19:47 +0000
Message-ID: <20260630101936.2371-1-mateusz.nowicki@posteo.net>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mateusz Nowicki <Mateusz.Nowicki@posteo.net>

When run repeatedly, nvme/039 fails intermittently with a regular block
read error instead of the expected passthru line, e.g.:

  nvme0n1: Read(0x2) @ LBA 0, 8 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR

inject_write_fault_on_write() writes LBA 0 of the whole-disk device,
whose release emits a change uevent that makes udev run blkid, reading
LBA 0 asynchronously. The following passthru injection arms a one-shot
fault (times=1); if the stray blkid read races in first it consumes the
fault and is logged via nvme_log_error() (no cdw fields), so the expected
passthru line is never emitted and the test fails.

Drain the pending uevent with udevadm settle before the passthru section.

Signed-off-by: Mateusz Nowicki <Mateusz.Nowicki@posteo.net>
---
 tests/nvme/039 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/nvme/039 b/tests/nvme/039
index 7ca48ec..8c70c5c 100755
--- a/tests/nvme/039
+++ b/tests/nvme/039
@@ -206,6 +206,8 @@ test_device() {
 	inject_invalid_status_on_read "${ns_dev}"
 	inject_write_fault_on_write "${ns_dev}"
 
+	udevadm settle
+
 	if [ -e "$TEST_DEV_SYSFS/passthru_err_log_enabled" ]; then
 		_nvme_passthru_logging_setup "${ns_dev}" "${ctrl_dev}"
 
-- 
2.53.0

