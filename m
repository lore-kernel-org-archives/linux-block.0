Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.111.35.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794044146;
	b=oCEDmD/cnP425Pm9Q8Ez93vTs91HHWEUwurPPBmXDDxzeiQwVbt78YGXKChBdVvhNeyU
	 QrSK5hgjIpRSyKjNTRLuruq96tTFUOQsclDCCPk/KlDhIySBqjeXmCFta+V/YbgHtrjjJ
	 wRHUE0Jj2O7jQkqoGSPdCmgtMo5GyFicUxjPWVZ2+6jQKpbF4R/M48R/MjJDw+F9j4BEL
	 CO4Pvy2F8BOYvWJsPjaklBpQKqH4vHNY2FmjgoNniug2bd/5UYyW/Pj5Q8nV715MTcj/1
	 mdt/Ojx/9yjAD5OqOSwhzs0S9XDQZ83+isMfuNJUbWbeBz/QSaNJGElfxsq0plPGG7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794044146;
	h=DMARC-Filter:X-Originating-IP:Received:DKIM-Signature:X-Session-ID:
	 X-Originating-IP:X-Works-Send-Opt:X-Works-Smtp-Source:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/3diqcofIQZb45YZZQhvIySlUWGXY8v/QHQXJI4TsZ4=;
	b=RevK6ilsgY5PAdOR5aQUNSQ/CgJ/Tt+HqhbYoyOKg9FYDMnQ5993J1W4ZaRK2+UYvF16
	 RruRLuzOxojuXp4fLDfCHCllQ79K4bYsmJ+ggaCSaMpvcED0TSMuTUbcA0Ql0ar2LgW7A
	 Xm5nyRGazIa8L2eZzWl4V6lDkkWNLkvpQxhWwHcAFu2KRypJwDjnyPaKfZi8+kKJYcium
	 4+Tx8bn+j6ZJsJ6NP1xoT6QUkO+n+7HnNFauYGbcaqt1dJophIGlyWaoKEoohYw/BxoXk
	 5lTMLTO4xOA14mf0yc2ZLq7XH3xCim+CNio9FM0bXsGrEHxkYwvaoLIXitbtbaXi4Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=naver.com;
	spf=pass smtp.mailfrom=naver.com;
	dkim=pass header.d=naver.com header.i=@naver.com header.a=rsa-sha256 header.s=s20171208 header.b=YebCyZYe;
	arc=none smtp.remote-ip=114.111.35.158
Received: from cvsmtppost15.nm.naver.com (cvsmtppost15.nm.naver.com [114.111.35.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AF1606A32F
	for <linux-block@vger.kernel.org>; Sat,  7 Nov 2026 09:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96AF1606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.a=rsa-sha256 header.s=s20171208 header.b=YebCyZYe
Received: from nv1s-hmac-real-15 ([10.180.31.91])
  by cvsmtppost15.nm.naver.com with ESMTP id RGb8X2fCT1ONgt7gjZ6Lcg
  for <linux-block@vger.kernel.org>;
  Sat, 07 Nov 2026 09:35:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1794044137; bh=BZpIDUDSRj/MFpAbjVfD0gcX/NsJd/t1bpVkkbQXaao=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=YebCyZYeT88cijckvgk7CSsObO1xLzQ26wJAZiV0i3dxIa73MU+slyTRA1GXOGJGV
	 gMABRHheDcRJNrv0yNsjGSLBCK8Dju6DSfyHpra4V8KuMx29p2P8p+cmyfIfSf6bb7
	 vgFMx25H9LgUI2a4swiJ7eSzQVIvg8rH8Yi+DFrFrV/SEOXh8mponLVhDSznJ0xjdg
	 xT9lH7xJ7RwE8hxOugFll0ooaaQkJxhebe+SQX4XeZxArlBNTuUgGXiQcu4KRbxSjs
	 k5GNa9nsGwrpYQHU0low7+H8ocSOKRkRWvnTPFRMWMzLvtSbxxJzJa9OLq4E1FreBw
	 MiFCSGcoPtwiA==
X-Session-ID: uxigsGlVTHmaNT4Or5XJPw
X-Works-Send-Opt: OlewpzGdjHmdKHFOMr39Ko3YKHmqjAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: rqnwKAtlFqJZ+HmXKqbw+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by mvnsmtp01.nm.naver.com with ESMTP id uxigsGlVTHmaNT4Or5XJPw
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 07 Nov 2026 09:35:37 -0000
From: Sung Byeongchan <tjdqudcks0424@naver.com>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH] ublk: retain server PID generation across timeout
Date: Sat,  7 Nov 2026 18:35:31 +0900
Message-ID: <20261107093531.619041-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
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


The UBLK char opener is recorded as a bare numeric tgid. A child can
retain the char file after the opener exits, delaying final release while
allowing the numeric PID to be reused.

START currently resolves the supplied number only long enough to compare
it with the stored number. The request timeout later performs another
numeric lookup and can therefore send SIGKILL to an unrelated task that
acquired the opener's PID.

Retain a reference to the opener's struct pid, compare START against that
object, use the same generation in the timeout callback, and drop the
reference after release work drains and resets the device.

On the exact target, a local production-path fixture reproduced SIGKILL
to an independent reused-PID victim in three of three baseline boots. The
fixed kernel rejected the mismatched generation in three of three boots.
Normal I/O, near-negative rejection, cleanup and following-valid recovery
each passed in matched baseline and fixed lanes.

The demonstrated impact is cross-principal process termination after UBLK
delegation. Memory corruption, information disclosure, privilege
escalation, RCE and LPE were not demonstrated.

Fixes: dd7a8507319e ("ublk: look up ublk task via its pid in timeout handler")
Assisted-by: OpenAI Codex

Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
---
 drivers/block/ublk_drv.c |   16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)
diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3d322fa1bc831..deb0a179a88ad 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -11,6 +11,7 @@
  */
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/pid.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/pagemap.h>
@@ -345,6 +346,7 @@ struct ublk_device {
 	 */
 	bool canceling;
 	pid_t 	ublksrv_tgid;
+	struct pid	*ublksrv_pid;
 	struct delayed_work	exit_work;
 	struct work_struct	partition_scan_work;
 
@@ -2130,18 +2132,16 @@ static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;
-	pid_t tgid = ubq->dev->ublksrv_tgid;
+	struct pid *pid = ubq->dev->ublksrv_pid;
 	struct task_struct *p;
-	struct pid *pid;
 
 	if (!(ubq->flags & UBLK_F_UNPRIVILEGED_DEV))
 		return BLK_EH_RESET_TIMER;
 
-	if (unlikely(!tgid))
+	if (unlikely(!pid))
 		return BLK_EH_RESET_TIMER;
 
 	rcu_read_lock();
-	pid = find_vpid(tgid);
 	p = pid_task(pid, PIDTYPE_PID);
 	if (p)
 		send_sig(SIGKILL, p, 0);
@@ -2410,6 +2410,7 @@ static int ublk_ch_open(struct inode *inode, struct file *filp)
 		return -EBUSY;
 	filp->private_data = ub;
 	ub->ublksrv_tgid = current->tgid;
+	ub->ublksrv_pid = get_pid(task_tgid(current));
 	mutex_lock(&ub->cancel_mutex);
 	ub->ch_file = filp;
 	mutex_unlock(&ub->cancel_mutex);
@@ -2633,6 +2634,7 @@ static void ublk_ch_release_work_fn(struct work_struct *work)
 	ublk_reset_ch_dev(ub);
 	mutex_unlock(&ub->mutex);
 	ublk_put_disk(disk);
+	put_pid(xchg(&ub->ublksrv_pid, NULL));
 	clear_bit(UB_STATE_OPEN, &ub->state);
 
 	/* put the reference grabbed in ublk_ch_release() */
@@ -4530,11 +4532,13 @@ static struct ublk_device *ublk_get_device_from_id(int idx)
 
 static bool ublk_validate_user_pid(struct ublk_device *ub, pid_t ublksrv_pid)
 {
+	bool valid;
+
 	rcu_read_lock();
-	ublksrv_pid = pid_nr(find_vpid(ublksrv_pid));
+	valid = find_vpid(ublksrv_pid) == ub->ublksrv_pid;
 	rcu_read_unlock();
 
-	return ub->ublksrv_tgid == ublksrv_pid;
+	return valid;
 }
 
 static bool ublk_dev_ready_or_stopping(const struct ublk_device *ub)

base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
-- 
2.43.0
