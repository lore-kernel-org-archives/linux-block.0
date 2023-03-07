Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E84C6FD1A
	for <linux-block@archiver.kernel.org>; Tue,  7 Mar 2023 15:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCGPUH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Mar 2023 10:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjCGPTk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Mar 2023 10:19:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3155A3C16
        for <linux-block@vger.kernel.org>; Tue,  7 Mar 2023 07:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678202206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=99qSzzKU2KdFXld+Lq6WBJNO5mX1Yf91cqdsuF+XSsA=;
        b=XfulSSHIGc5cx8OldLpmbZGJ8DInjLWsVgdftpRJJXqC0Lh2RWDGVRxUsD8DZyxV+LPt4s
        xHekElMJXtx8l9FswMFnbxjCDenj4pOzN2IXaOim2RGA9iZBHdQD76RoYKc5u8qFAXJuDJ
        c41ih5eeDYx7zutxycHDOVmhUmaq5dw=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-PVLoRONjPDKO1KdR8KPysg-1; Tue, 07 Mar 2023 10:16:36 -0500
X-MC-Unique: PVLoRONjPDKO1KdR8KPysg-1
Received: by mail-pf1-f199.google.com with SMTP id i7-20020a626d07000000b005d29737db06so7388392pfc.15
        for <linux-block@vger.kernel.org>; Tue, 07 Mar 2023 07:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=99qSzzKU2KdFXld+Lq6WBJNO5mX1Yf91cqdsuF+XSsA=;
        b=yIGQ6LU/RnaYunLc5joY3LeV8Ya5lr/JNAu2tJ0Xt+GaMJZ/NKTVwFNxXPLpmHLm94
         BzcRaJfDtA0Ovsr4Sxzu4qeBSfAV2ozAacI8+uxIF3yQoEce+oI7IMfaJzvLqOhlu5Y5
         cE4vojgz9wSuKFWqKlc5B1v/SpnDSWB8c/FAL5ndAUBMmda6NLFwwjwmQnFTKOmtZpMc
         g/F38sZwof/1X+5LZnHmJrynSgaElf91s1wLgGdPUqUEf4zaBx8rI04mq3wOmKxPH/DP
         NLnGciat56+bRdyg0quqL3GCcecdudVo8/7zlqVlBvRYd0/bciM0qH8p1ZB0en1YZhbH
         tK9A==
X-Gm-Message-State: AO0yUKW2nzL8TzQFXxLMGQoSu0vnefnqJviYepR4FNSSmGwrEjVVCSFk
        InCHb32O3zhv3bwiHkJQoYv0NzoYpEahxvOI4CSNvRcs8r8DyzUM6I1K/vzaYejzxiu5Ap5UMVn
        o9/cFys082+BfKMcwOjhERxo=
X-Received: by 2002:a05:6a20:8ba2:b0:bc:f0d2:e268 with SMTP id m34-20020a056a208ba200b000bcf0d2e268mr13657292pzh.29.1678202185558;
        Tue, 07 Mar 2023 07:16:25 -0800 (PST)
X-Google-Smtp-Source: AK7set8rScMeHoPkW1lRtZRzrsVYRuLkfQLlDEt+6ifGK29z6JHlPj7m4fmPdiB9OP5KE3rYS0a4ww==
X-Received: by 2002:a05:6a20:8ba2:b0:bc:f0d2:e268 with SMTP id m34-20020a056a208ba200b000bcf0d2e268mr13657266pzh.29.1678202185180;
        Tue, 07 Mar 2023 07:16:25 -0800 (PST)
Received: from localhost.localdomain ([240d:1a:c0d:9f00:ca6:1aff:fead:cef4])
        by smtp.gmail.com with ESMTPSA id k9-20020a6568c9000000b005038291e5cbsm904648pgt.35.2023.03.07.07.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 07:16:24 -0800 (PST)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     yukuai3@huawei.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>,
        syzbot+6229476844294775319e@syzkaller.appspotmail.com
Subject: [PATCH] nbd: Fix hang when connection reset by peer
Date:   Wed,  8 Mar 2023 00:15:28 +0900
Message-Id: <20230307151528.2532986-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

syzbot reported hang task [1].  The following program is a simplified
version of the reproducer:

static int fd;

static void *do_ioctl(void *arg)
{
	ioctl(fd, (int)arg);
	return NULL;
}

int main(void)
{
	int sv[2];
	pthread_t th[2];

	if ((fd = open("/dev/nbd0", 0)) < 0)
		return 1;
	if (socketpair(AF_UNIX, SOCK_STREAM, 0, sv) < 0)
		return 1;
	if (ioctl(fd, NBD_SET_SIZE_BLOCKS, 0x1) < 0)
		return 1;
	if (ioctl(fd, NBD_SET_SOCK, sv[0]) < 0)
		return 1;
	if (pthread_create(&th[0], NULL, do_ioctl, (void *)NBD_DO_IT) < 0)
		return 1;
	sleep(1);
	if (pthread_create(&th[1], NULL, do_ioctl, (void *)BLKRRPART) < 0)
		return 1;
	sleep(1);
	close(sv[1]);
	sleep(1);
	return 0;
}

When the connection reset by peer, nbd_read_reply() in recv_work()
returns -EOCNNRESET and wakes up the task blocking in
nbd_start_device_ioctl().  wait_event_interruptible() returns 0 in
this case, so inflight IOs in the queue are not cleared.  This causes
hang task.

This patch introduces new runtime flag NBD_RT_CONNECTION_RESET to
notify connection reset by peer.  nbd_start_device_ioctl() checks this
and clears inflight IOs accordingly.

Fixes: 3fe1db626a56 ("nbd: partition nbd_read_stat() into nbd_read_reply() and nbd_handle_reply()")
Cc: Yu Kuai <yukuai3@huawei.com>
Link: https://syzkaller.appspot.com/bug?id=f55039d9ac10967440ca01ff24c38ccfa597efe1 [1]
Reported-by: syzbot+6229476844294775319e@syzkaller.appspotmail.com
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 drivers/block/nbd.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 592cfa8b765a..fe861a2b063b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -83,6 +83,7 @@ struct link_dead_args {
 #define NBD_RT_BOUND			5
 #define NBD_RT_DISCONNECT_ON_CLOSE	6
 #define NBD_RT_HAS_BACKEND_FILE		7
+#define NBD_RT_CONNECTION_RESET		8
 
 #define NBD_DESTROY_ON_DISCONNECT	0
 #define NBD_DISCONNECT_REQUESTED	1
@@ -833,9 +834,13 @@ static void recv_work(struct work_struct *work)
 
 	while (1) {
 		struct nbd_reply reply;
+		int err = nbd_read_reply(nbd, args->index, &reply);
 
-		if (nbd_read_reply(nbd, args->index, &reply))
+		if (err) {
+			if (err == -ECONNRESET)
+				set_bit(NBD_RT_CONNECTION_RESET, &config->runtime_flags);
 			break;
+		}
 
 		/*
 		 * Grab .q_usage_counter so request pool won't go away, then no
@@ -1412,7 +1417,7 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd)
 	mutex_unlock(&nbd->config_lock);
 	ret = wait_event_interruptible(config->recv_wq,
 					 atomic_read(&config->recv_threads) == 0);
-	if (ret) {
+	if (ret || test_bit(NBD_RT_CONNECTION_RESET, &config->runtime_flags)) {
 		sock_shutdown(nbd);
 		nbd_clear_que(nbd);
 	}
-- 
2.39.0

