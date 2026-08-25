Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4011F3B9930;
	Tue, 25 Aug 2026 06:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787638627; cv=none; b=U0hFtnme++0XP8m1rIO1DDGRZRAITKhXOct8WpSfjMeulzXNB2X9+h2JKHuUg/aQ46AbETNpY89esIgo8mx3aAdNVxwleIuL+2ZSCUeVPWTAqTs5TFaOIhaPzWx6FTjvXzf3kJPZRdL0CKftUg2llSAnEFR2zKyvyhaXLMHUl8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787638627; c=relaxed/simple;
	bh=OJLM4l6+hozQ5oHOMZ5YxUkzIQ+K0520eEH6NFBEFGk=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=idnez63ULu7Upn2/7bwSdYtvO668P8KrjzYrdXoV3LiOG9swoieSNXQ91hGPkD27hD10K7khiTwrziX5IXC0Q6xvr07YkEnXv+6n3M8JjTNbHc4EUmowTHxiipqKaEb3X/aeOedBGDWRiy7IWBI7/AxgI/TMQVobE6y6KBQYy5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=O8FsCRyx; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="O8FsCRyx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1787638614;
	bh=Um3j+eB0TXF6immw/nDRX3ZN34pDkYVubwwHXy3PFWM=;
	h=From:Date:Subject:To:Cc;
	b=O8FsCRyxB9YkL1tbJE7Mb82HGs8HinGbVCw2scA21WKwsV5Q0giIat6W6WB71PbGM
	 qZGNdUEFhLpR9t60bGXI8oJ+970JPRj5Hr3urVn5T20lyFnC3qVorj5xa0oltq898x
	 hb5/IxUMj8eic9PRiKXqoaV9JM9fpV80w+8rFB5Q=
Received: from [127.0.1.1] ([2001:da8:283:e049::9:8de6])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 4343F855; Tue, 25 Aug 2026 14:16:52 +0800
X-QQ-mid: xmsmtpt1787638612t9y1hurak
Message-ID: <tencent_F7A3786EE31A7EC420F9C05E74BA446FB109@qq.com>
X-QQ-XMAILINFO: NYtOCndYWoWXYmBTC+qmMhAIEdH3dYPY0KWji0NdjBo9NwQceoGxpuOriVcoOt
	 WUE74n66k0UhFp46AbHiRIkSIfTw8fqg1UUc1VDBk7Wifydc8NxbeCSvyGqVTvmWo0HdvSQhKIwQ
	 JUP1PcY1t53WpqYGtkFrMCon/qlrl7KGI6hht9eNzyCmUSPbTp8yR2ZTO52OvUZvnPhSS7Tvgynm
	 jvCoMD/z0U7c6C59UtlTliXpttoE2MIJoiXAu5ZC/UphOyj0RJI3yLsa+NDcpwenEwT1EACj/JHp
	 wYfrEL39/P1vSh8RGmmz6Tt9HR+MzjNSn7if8tlcDdH1CUt5e3D+czIgfZaoWWHXyGUIODN15YCk
	 uyyxeW5j+97A0RNMOtQf8MePAMQp2N5t7rSH5WRO1Mdhj41O90Drdh6qW6eEZXQqv8INZO0FA1aP
	 IGtTT6YpDFesGW9YFAEdSGLLhARisAiZq5Lssfjz/JjEBTtUs8L6VhJ+fcmDMMPlyfeMrjTwrt0L
	 6BxufxY8zltOsekONvmwSK1irXLsJbCNFJinyivhVJ/84Y4sou5uPPcfB83N06xArwnhf/tq+BMb
	 Yz4j6T0TKhyNubbQXx4w1SJwuNCvX6X09BL9zUA0kBq+FkiSPJlRyA9PL7yMNBXyUuqVEy4Pr0fe
	 BwG7TN5Bswhqk4cs6N1uQDYCVY0FTstMjLbKFrukk+gQQbiWHB4nHZ6xiYBG7ZmdzxyHf9aZ3wLy
	 WdT6IpXsIZWWZRb5cqQIZQvyvkQCq9GdYCpBn9ISd+nSiwqdw+e3KrRqjA0/x8ta92pGcJQsYnO+
	 Nqj9kRdz5kYqgHR3kV42q4slNMREHigUUXt9a3M0FwzvcMcNKBD/tOU51B/BQfGMMJolPF65O94B
	 iL8Pv9mRYjQIskAcOE00x4qcMhjUILelE+y5EYeIjXXQ4Ca0ps0Dr0npRAWpyJA5R6/VvyZxDyrG
	 KG5sn9xIz5Wu0ch+8zpLKuwnSbclioe5X8J9adxcco8fI5IXkHjFjHtGbw8UckQ43/beEGBxmGhQ
	 bwVn+34j+vWjyEXX0plXZ2tjrfowNlfm3rweL7jh56F2cAz/dxfefneiGis6QmsY8BLDjqmM7Ppp
	 mURcYJwIvpWeYG148HaN0MtPCn8VmWHKuswU3IVSCzabNZHfPOhBAFwkywAPBQY5hSJHv1rFRyFV
	 Arq2Iw7RzKSDVqQ9x9RtDEOyCpTc5FbNAgPxcF5nhgpdAhxw==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Cheng Lingfei <chenglingfei@foxmail.com>
Date: Tue, 25 Aug 2026 14:16:51 +0800
Subject: [PATCH] null_blk: fix sleeping in atomic context with shared_tags
 and memory_backed
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260825-b4-null-blk-sleep-fix-v1-1-053aab809622@foxmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM2w6CMBCE4Vche+0mULAeXsVw0eKAq00lXSEmh
 He3wuU3yfwLKZJA6VoslDCLyjtmVIeCuoeLA1ju2WRKY8uzObJvOE4hsA8v1gCM3MuXbeMqZ2t
 T43Ki/B0T8rx1b+1unfwT3ecfo3X9ASCzUWp5AAAA
X-Change-ID: 20260825-b4-null-blk-sleep-fix-64a1a6323e97
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+b6fd00508cc05a5c003c@syzkaller.appspotmail.com, 
 Cheng Lingfei <chenglingfei@foxmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787638612; l=2513;
 i=chenglingfei@foxmail.com; s=20260824; h=from:subject:message-id;
 bh=OJLM4l6+hozQ5oHOMZ5YxUkzIQ+K0520eEH6NFBEFGk=;
 b=rkXM3Y+lX9Ubdxu/bij97fMHKSZ5TsD3ZgkijTjXxirTL+L3PjpKNYRINVajnd7Q3j2XzbaCG
 FM0iGMDeXPMAmF5M4XX+WJ4Zz9bY3YyUYMrhZCthLXOdtv7eXtN0e9Z
X-Developer-Key: i=chenglingfei@foxmail.com; a=ed25519;
 pk=jJFtzwUiUOhTRJNlFx9WjsWHIYGk49Br17a7AD8MH2I=

When a null_blk device is configured with both shared_tags and
memory_backed (or blocking), the zone lock uses a mutex which may sleep.
However, the global shared tag_set only checks the g_blocking module
parameter to decide whether to set BLK_MQ_F_BLOCKING, ignoring the
per-device dev->blocking flag. Without BLK_MQ_F_BLOCKING, blk-mq uses
rcu_read_lock() instead of srcu_read_lock() to protect the dispatch
path, making it illegal to sleep.

This leads to a "sleeping function called from invalid context" BUG when
I/O is submitted during add_disk() partition scanning, as the call chain
enters null_lock_zone() -> mutex_lock() inside an RCU read-side critical
section.

Fix this by disabling shared_tags in null_validate_conf() when the
device needs blocking but the global tag_set was not initialized with
BLK_MQ_F_BLOCKING (i.e., g_blocking is false). The device falls back to
a per-device tag_set which correctly propagates dev->blocking to
BLK_MQ_F_BLOCKING, allowing blk-mq to use SRCU and permit sleeping in
the dispatch path.

Users who need both shared_tags and memory_backed simultaneously should
load the module with the blocking=1 parameter so the global tag_set is
initialized with BLK_MQ_F_BLOCKING from the start.

Reported-by: syzbot+b6fd00508cc05a5c003c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b6fd00508cc05a5c003c
Tested-by: syzbot+b6fd00508cc05a5c003c@syzkaller.appspotmail.com
Signed-off-by: Cheng Lingfei <chenglingfei@foxmail.com>
---
 drivers/block/null_blk/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f8c0fd57e041..0dc7fd106db8 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1912,6 +1912,12 @@ static int null_validate_conf(struct nullb_device *dev)
 		dev->blocking = true;
 	else /* cache is meaningless */
 		dev->cache_size = 0;
+
+	if (dev->shared_tags && dev->blocking && !g_blocking) {
+		pr_info("shared_tags disabled: memory_backed/blocking device requires per-device tag set for BLK_MQ_F_BLOCKING\n");
+		dev->shared_tags = false;
+	}
+
 	dev->cache_size = min_t(unsigned long, ULONG_MAX / 1024 / 1024,
 						dev->cache_size);
 	dev->mbps = min_t(unsigned int, 1024 * 40, dev->mbps);

---
base-commit: 2f1baf1fc8929e6c48370be543ad028ac7ad4131
change-id: 20260825-b4-null-blk-sleep-fix-64a1a6323e97

Best regards,
--  
Cheng Lingfei <chenglingfei@foxmail.com>

