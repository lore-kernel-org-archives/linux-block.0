Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.108.3.167
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793615649;
	b=ANUk5klW0PqwPZ1MFkUw2ZpxgAZTRInm7afbricie4YsrFzNgntAQRDU+nrxc3HnWB/U
	 we/5WNEd9Z5TwJ+ow1+qCQ4vuh0ifpdwnb4Jw/m3mOk2sTf/SEGboj9sgqK5Pj4WIWsOQ
	 Mdh4x+lK+NetuzOfmiyIV6RMojY0XE1TNQN+zeIKgfhzzpv0F0AoSMtKNf9fgB8VudIKB
	 a/N4YLnzqOYH7wFL9Tnz58tMNs6vsy2AWxhopkuFhqwFDbUeVMrBXdiQa/bOnFZJMGXeS
	 Ts2SzUh1biomrLHL/qk8Ncm2hrOU5GuLBL5IhYsYYhiLKwHwOMUJR+BH5y3JU9F7BxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615649;
	h=DMARC-Filter:DKIM-Signature:X-SMAIL-HELO:Received:X-Sender:X-Auth-ID:
	 X-SMAIL-MID:X-SMAIL-UIID:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zOuEJl576VYtRf0K3AP7aY3pIr+oXdhrrj9wOG3kLFg=;
	b=xFreljyVBjlEZTjkRhVjq64cePkLfd18+kQ7KVNe9I6XJuhGz9zBgluRbrJwgjWqfV7O
	 hukbDT43ikaMs10TzaQL4MggSsUuS2v3eJUfDdrkjoxnKwILasGV+ar2niChr1tytsRjq
	 q6zd2X+Pc1h6PGVq/51ZgNsT0ZAlgd0LZlqzfrD+4YTMeom/p4NJ5j8agPK6byARS0IcE
	 8fOwO/FCteesnNNABIWVZ20PyoHF8OA5iUbau/3LcL2T5OQCA5YesLbDprPfn2z4J3+Ws
	 yYLM+KCjAzwwzyI/vTJbDskxFstevyolh0k9NbYIQT0Awr8VqmefNfIgLoHkihQ4iYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sina.com;
	spf=pass smtp.mailfrom=sina.com;
	dkim=pass header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=JJ5IA83c;
	arc=none smtp.remote-ip=202.108.3.167
Received: from mail3-167.sinamail.sina.com.cn (mail3-167.sinamail.sina.com.cn [202.108.3.167])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF943606A32E
	for <linux-block@vger.kernel.org>; Mon,  2 Nov 2026 10:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF943606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sina.com header.i=@sina.com header.a=rsa-sha256 header.s=201208 header.b=JJ5IA83c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1793615648;
	bh=zOuEJl576VYtRf0K3AP7aY3pIr+oXdhrrj9wOG3kLFg=;
	h=From:Subject:Date:Message-ID;
	b=JJ5IA83cTROc0pPKRihvVJqEBCtHWkJA823NC5032K4MQ+9v9gIyXBloucBbe0Hg9
	 CNoqxFdNofr7qa07wXoUo2gsFPRlOWV8mH2q7gCTTg3IZ6dovI+f2Qb7jc6jOkeMQp
	 ztGvqErn+1823hyAK6OdUHVGSFT2TOZshpJ3Srj8=
X-SMAIL-HELO: lxu-ped-host..
Received: from unknown (HELO lxu-ped-host..)([111.198.231.89])
	by sina.com (10.54.253.33) with ESMTP
	id 6AE86712000031A4; Mon, 2 Nov 2026 18:33:57 +0800 (CST)
X-Sender: eadavis@sina.com
X-Auth-ID: eadavis@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=eadavis@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=eadavis@sina.com
X-SMAIL-MID: 4421456685334
X-SMAIL-UIID: AA9BDDEC5C4B40D699DF352E469666A8-20261102-183357-1
From: Edward Adam Davis <eadavis@sina.com>
To: syzbot+a31cda410a4ccd419712@syzkaller.appspotmail.com
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] loop: prohibit the use of sysfs as a backing file
Date: Mon,  2 Nov 2026 18:33:54 +0800
Message-ID: <20261102103354.427722-1-eadavis@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6ae807da.c8ffc79a.e3697.002b.GAE@google.com>
References: <6ae807da.c8ffc79a.e3697.002b.GAE@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The loop driver's backing file validation in loop_validate_file() and
loop_check_backing_file() only checks for the presence of read_iter/
write_iter operations, S_ISREG/S_ISBLK inode mode, and direct loop-to-loop
device recursion. Because sysfs/kernfs attribute files are regular files
(S_IFREG) and implement read_iter/write_iter, a loop device can be configured
with its own sysfs queue attribute (such as /sys/block/loop0/queue/scheduler)
as its backing file. When an I/O request is submitted to the loop device,
loop_workfn processes the request while holding a reference on the queue's
q->q_usage_counter and writes to the sysfs file via lo_rw_aio(). The sysfs
write handler (elv_iosched_store -> elevator_change -> blk_mq_freeze_queue)
then attempts to freeze the loop device's own queue, waiting indefinitely
in blk_mq_freeze_queue_wait() for q->q_usage_counter to reach zero, causing
an unresolvable self-deadlock, potentially hitting:

INFO: task kworker/u8:1:13 blocked for more than 143 seconds.
Call trace:
 blk_mq_freeze_queue_wait+0xe0/0x160 block/blk-mq.c:191
 blk_mq_freeze_queue_nomemsave+0x28/0x38 block/blk-mq.c:207
 blk_mq_freeze_queue include/linux/blk-mq.h:956 [inline]
 elevator_change+0x174/0x35c block/elevator.c:668
 elv_iosched_store+0x2a8/0x3bc block/elevator.c:826
 queue_attr_store+0x1c0/0x24c block/blk-sysfs.c:906
 sysfs_kf_write+0xe0/0x108 fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x260/0x3b8 fs/kernfs/file.c:345
 lo_rw_aio+0xaa0/0xd04 include/linux/percpu-rwsem.h:-1
 do_req_filebacked drivers/block/loop.c:-1 [inline]
 loop_handle_cmd drivers/block/loop.c:1949 [inline]

Add a sysfs file check to prevent loop devices from using such files
as backing files.

Reported-by: syzbot+a31cda410a4ccd419712@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a31cda410a4ccd419712
Signed-off-by: Edward Adam Davis <eadavis@sina.com>
---
 drivers/block/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a3325ceab484..71647793a717 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -534,6 +534,9 @@ static int loop_check_backing_file(struct file *file)
 	if ((file->f_mode & FMODE_WRITE) && !file->f_op->write_iter)
 		return -EINVAL;
 
+	if (file_inode(file)->i_sb->s_magic == SYSFS_MAGIC)
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.43.0

