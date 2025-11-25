Received: from ssh247.corpemail.net (ssh247.corpemail.net [210.51.61.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804092AF1D;
	Tue, 25 Nov 2025 02:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.61.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764036402; cv=none; b=A+/CY7Wc6ty34Femd35rAB6xKD9jNof9EGw9sgY1hJdrdKtiyD1893siovT7cmxFmTcRNNi6gMPNl76q8MnkgTC3qT8Eq5uWHfGroDMfp6I3quLvNzcvriMKOuBFxjoX6aiEQzWrCmqp69UPKLPVhroWoXjAtPqxI+uFGl+utcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764036402; c=relaxed/simple;
	bh=KBu7rRr8atx8bgLucQ91XSj1f2cMLAjFtxdMuyTM510=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ruVimq7USYjyRooheAMkZP0TnstT+G4rW5kSQLWZYMI6WHdW1NzVmsgEUhEApmwjXzBpiiY6P7R+Zz2NQVmG57qwvqizogk0aJOyLSr2MJ5TIvv19BUo411cMlM3fw8PJNIziUWUfaRr6bJ+Txls6Hip3k8sKMrPKzwkIgKqmSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.61.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201613.home.langchao.com
        by ssh247.corpemail.net ((D)) with ASMTP (SSL) id 202511251005254397;
        Tue, 25 Nov 2025 10:05:25 +0800
Received: from jtjnmailAR02.home.langchao.com (10.100.2.43) by
 Jtjnmail201613.home.langchao.com (10.100.2.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 25 Nov 2025 10:05:24 +0800
Received: from inspur.com (10.100.2.96) by jtjnmailAR02.home.langchao.com
 (10.100.2.43) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 25 Nov 2025 10:05:24 +0800
Received: from localhost.localdomain.com (unknown [10.94.14.191])
	by app1 (Coremail) with SMTP id YAJkCsDwOTXjDiVpmxAFAA--.147S4;
	Tue, 25 Nov 2025 10:05:24 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <minchan@kernel.org>, <senozhatsky@chromium.org>, <axboe@kernel.dk>
CC: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: [PATCH] zram: Fix a spelling mistake
Date: Tue, 25 Nov 2025 10:05:22 +0800
Message-ID: <20251125020522.1913-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: YAJkCsDwOTXjDiVpmxAFAA--.147S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JFWrAFWktF4rCrWkJF47Jwb_yoW3KFX_ur
	17JFs7Xr4vvrn8AF1jva95ArZFvw40qrn5GrnaqF93WrW7Xa12vFyqqryvyF98XFW29FZ0
	k3sIv3y5Zr15WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbckFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUG0PhUUUUU=
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?LXWOBZRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+Ke+3GUkL1WZCCfrCib6oOz1cbS5HqyPZ5NbUv4I72y9QH43tVWUA6ryIviUw8O1rVrU3
	BZKyqykVd8YqD7PS8E4=
Content-Type: text/plain
tUid: 202511251005257164644d14604f72aec6f9f785b9e103
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The spelling of the word "relases" is incorrect; it should be "releases".

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1a1159a70fb4..5759823d6314 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1043,7 +1043,7 @@ static int zram_writeback_slots(struct zram *zram,
 		index = pps->index;
 		zram_slot_lock(zram, index);
 		/*
-		 * scan_slots() sets ZRAM_PP_SLOT and relases slot lock, so
+		 * scan_slots() sets ZRAM_PP_SLOT and releases slot lock, so
 		 * slots can change in the meantime. If slots are accessed or
 		 * freed they lose ZRAM_PP_SLOT flag and hence we don't
 		 * post-process them.
-- 
2.43.7

