Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60461E1C17;
	Tue,  3 Dec 2024 10:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222978; cv=none; b=WhG0ZemLaquuMmg6UBxckTplfFKsuKO4DJoTthXKl2dS8cvDlaE+fNqfHxsY1RLfipIqkihY4kpzrRrKH84jbY3EhaIga0E1xNzgzNUoK8hM+h8Fwom2dFXeIp+JoL2cXvx/0SphbMF44Ntaj4Cs5QC+5pp9cQMcvrqOFLwE4kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222978; c=relaxed/simple;
	bh=bo3wuC9HkNuSSw1/QJ3UULXCCAlfDT+4agAwJLumpGc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=iQc0mbMQ/Q8Gvgdwgt57KLrCpMzouyh59Ady8Xv0XlLKpS1AJQCl2ZQfiTm2DB4D3NJnzKAW8+1b8L/5I4GFni+Te7y5jVFYEEZESWuzVhSx+j2t4xf5aDm9y2VMTrT0uh1kVlVMLnDM2ljrtL+mkV9RoAcVs7le1o3T2ETHRYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=eOxnbF+d; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="eOxnbF+d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1733222664; bh=WKIY4LrlVHMQ3OOsHWYNK8Ode//U/Xxt59UxPG8cG04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eOxnbF+dpkNTrbzWUplkTzkDGg5x9WALaLIHOrz/OLtElYJMvgoYJYSXMeJyxboy4
	 9ubrpptHI5DEgakUYd8JKu3nYxIvXk/J3GSpucsl7fI4vhB5dag5LSHnWQEBGELkfo
	 KuNPilsO5v8PTvB3sscUww95t8YEUEsOTr8q0QjI=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 57B8EAD9; Tue, 03 Dec 2024 18:21:59 +0800
X-QQ-mid: xmsmtpt1733221319tp3gynv1o
Message-ID: <tencent_F56949906EED6EC90C8027D0C6DFD2F84606@qq.com>
X-QQ-XMAILINFO: OWvGpOnEMXUNOP+3RrufT5kZdR54MKp3zE8TTlC+yFZzoakx5HZGv5BDvAjVCS
	 IjEZaIq9pUBwZxR6tE3t6tu7cimfsWiJa42SqX+LDJGaNLE50+rt36iHdPYT3qnRmO0y1iil1lDa
	 PzOlma1bnaMvfGgo4hiSpHsze4+NrEL9JX3X+1BxrSU2/CaxjRd0pxfL2d84m3OpHMsByWCgult7
	 V5Uz3KDryyfTfPFUe2q1L4PJc0cHZ5rnMs7qJFST/IjQkqg26x2RhsM85AQeqZS5ohPowgc5zNeG
	 FSoxNUeHACXGGzETWkKMBsbKp50wfZR+RuyOfrDR+66L1+nunxU/evxLGX7qAKm4JGM3GYtI8Rfx
	 O4MqzXUnxQJb1HQdLsoHJGfLusY0XqPV/19/1OpvQWc6MvgeOFKP6yTEm5keEcEXpeBqM91lAfEI
	 NNX4ANkn0maBLMiPpvcmDJjg7Cs8SKDDc79JT1v9x0XYLBXV9n4w5FdBo2b3VdFh3mBYAscSpV+u
	 Tcclpme/GDbktsaxbfqGUzlSkZUmBqdPb/n6WIgwYg0dz9q8rdJ90qiGv+4dAIO5cE/w+u1LhBTm
	 dO8uD17bUWgTvf8eFxTuxtsVTLdEpnd21XgFuHbq1723UTxYrnHR7RwH8w5x2XrRCgaNlmq7j5/2
	 UmkLHIz0qHgxl8sL5JJQ6ngPC4SUZczyE9DJyD8gMc1lewjeMA9M3uHh2H3WWklcRXxmsVa2p+/C
	 rffw6AuJie26rcZ4v4FGX4spmwQPLeYeVm7buQdiC9Hi5U5/r1eXoLpu+BYb6xKGB5RTtDZiDwvj
	 5LC78LqgCRINm2gpGlT644e3Zag90519zewFhii3YFWVOxWZ7kUDYWqKQ0x7QdYv9NW54yFLXRXe
	 T2YYuhlOAjhND3QrqpK444x2DFsd7v6Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
Cc: axboe@kernel.dk,
	jfs-discussion@lists.sourceforge.net,
	kristian@klausen.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] jfs: check agwidth before calculating the control page level
Date: Tue,  3 Dec 2024 18:22:00 +0800
X-OQ-MSGID: <20241203102159.599532-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <674e82ce.050a0220.17bd51.0040.GAE@google.com>
References: <674e82ce.050a0220.17bd51.0040.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The width in dmapctl of the AG is zero, it trigger a divide error when
calculating the control page level in dbAllocAG.

To avoid this issue, add a check for agwidth in dbAllocAG.

Reported-and-tested-by: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7c808908291a569281a9
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/jfs/jfs_dmap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index f9009e4f9ffd..2377102d9c4c 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -1373,6 +1373,11 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
 		return (rc);
 	}
 
+	if (!bmp->db_agwidth) {
+		jfs_error(bmp->db_ipbmap->i_sb, "width in dmapctl of the AG is zero\n");
+		return -EIO;
+	}
+
 	/* the buffer for the dmap control page that fully describes the
 	 * allocation group.
 	 */
-- 
2.47.0

