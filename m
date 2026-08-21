Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE5D3E3C7A;
	Fri, 21 Aug 2026 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308284; cv=none; b=pd8l20esphn4nUQlu4789r5IvqQKu4chTGX7PDW8VuGCpZ04Y3oi3Z6JFoPJ212KrHwYe2nFOfi5G3NFSlOje4OoJ7CxVzpqByiuWqBbVOACthc1UVmowUcraB1M4kGxLV6N+Hlf5ti0NHsz0SUEe5JYduo8JnjMecUMSnLVS54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308284; c=relaxed/simple;
	bh=OIA9nhewQ1FPFVmum6HMJchOU5KNExV3hAIZ9YGn0xU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Nq07Y2BAG9gEsAAPPwoJZP6qtGTWcaSlhRC7jOcj3kwJfNhs6QX4fbYOZJTw66V4mMpWuSDktecRC1MRSGFaRqJN01P4pb0OLZ8RsEgjBQ3GDxooDYR6oAYlzSd6ThgdTsaftXIkicV8Ug7FHeFd4kr1494md7qevrwbsBxAMWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Fw9GB7KG; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Fw9GB7KG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=jE
	XB12EAlFZqg5ftbxCibHihlVo9lbWriMvpusDgkcY=; b=Fw9GB7KGy4pBM6gC5T
	aZZxGpJdLXiWmzpqSbM7HW41nJzWRxvJ2UM1MgfQmTwPLchZBj4GFO2qSWPDS8C+
	4Mba/0bsMsgro+mkCL0VFEPMGUdRnZnq+PbAmY6WIKCUJNn7oQ8brRfm/tUnaX3n
	xbn4p/r2cqSB/4hN5g6gvCMsY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnZ5fZKIhq2WaORA--.42749S4;
	Fri, 21 Aug 2026 18:30:53 +0800 (CST)
From: Yang Xiuwei <yangxiuwei@kylinos.cn>
To: tom.leiming@gmail.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Yang Xiuwei <yangxiuwei@kylinos.cn>
Subject: [PATCH 2/2] selftests: ublk: add batch IO cases to recover_03
Date: Fri, 21 Aug 2026 18:30:47 +0800
Message-Id: <20260821103047.369522-3-yangxiuwei@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260821103047.369522-1-yangxiuwei@kylinos.cn>
References: <20260821103047.369522-1-yangxiuwei@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnZ5fZKIhq2WaORA--.42749S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKr4xAFWxWrWrZw17AF47Arb_yoWDZwc_tw
	4ftwn7A3yDAF90yr4fuF13Zry8Aw4UGFWSqry5XFW5tryqqanxXF4Fyrn8u3WfurZ8WFy3
	ta17ZFW5ArWxGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0trc3UUUUU==
Sender: yangxiuwei2025@163.com
X-CM-SenderInfo: p1dqw55lxzvxisqskqqrwthudrp/xtbCwh39jmqIKN1fTwAA3r

Add -b coverage for quiesce recover.

Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>
---
 tools/testing/selftests/ublk/test_recover_03.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/ublk/test_recover_03.sh b/tools/testing/selftests/ublk/test_recover_03.sh
index 2554805e5b02..92f4012178f0 100755
--- a/tools/testing/selftests/ublk/test_recover_03.sh
+++ b/tools/testing/selftests/ublk/test_recover_03.sh
@@ -29,6 +29,11 @@ _create_backfile 0 256M
 _create_backfile 1 128M
 _create_backfile 2 128M
 
+ublk_run_quiesce_recover -t null -q 2 -r 1 -b &
+ublk_run_quiesce_recover -t loop -q 2 -r 1 -b "${UBLK_BACKFILES[0]}" &
+ublk_run_quiesce_recover -t stripe -q 2 -r 1 -b "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
+wait
+
 ublk_run_quiesce_recover -t null -q 2 -r 1 &
 ublk_run_quiesce_recover -t loop -q 2 -r 1 "${UBLK_BACKFILES[0]}" &
 ublk_run_quiesce_recover -t stripe -q 2 -r 1 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
-- 
2.25.1

