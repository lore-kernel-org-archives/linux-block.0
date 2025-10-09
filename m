Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB081E47A3
	for <linux-block@vger.kernel.org>; Thu,  9 Oct 2025 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760017551; cv=none; b=gmfQdRm7rk2V9/44zMhaAar6ZK6Vfp/asbvHUoJ+Gb9Kt+pJuQbNCzsGfechz81747elhG+6xMQrSof/I+JgAhGCLgNF74ybzypeL4UHBsEX79JPqy3rH7OpBB51DBotXnMuE/VyXyL8jnjzOvimTshjK4yktDWjFYT3mUfRB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760017551; c=relaxed/simple;
	bh=Fw6HmamUNQVj03SSnFZ0JjwwpW2Unuuyy0L9OvC5+Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ey6paUnTOH6G98JlXb/BSacscJNNf0IiTrlxwWUXlmnn97PbZmrbQjQL30U2pUMU2WIgpDhmicHKz5QulppKQRA2awvaBS4YPRaGDewKKoADuGXaKH5XED8BpJIJk8nCdoXxL3cm0eAsl/uPzViGabuJtQjdXMFFJ9bhzJr5OcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1vTMRXU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1vTMRXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760017548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LuKvTV/ZvxsZcI+HNaWfxeETY2vb8WWG5aZ1soizNHk=;
	b=A1vTMRXUt7ewQ1l2HvGSAi3JzsfHn6KuMcBMyRqvln+JanBMOVmeH5+/s3m8ybpZFCF473
	XKS0uIq2/G3m5JfhhUC23RnmbgP9YmqjSLx0F5gGcYl2vaUD84L0dclYzPjJ6WwflKc3Da
	bYj3J6dbf0vwKxwTO/Xf/N5vxrVl2hk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-TPFCb6CKP1-HftRCss5PEQ-1; Thu, 09 Oct 2025 09:45:46 -0400
X-MC-Unique: TPFCb6CKP1-HftRCss5PEQ-1
X-Mimecast-MFC-AGG-ID: TPFCb6CKP1-HftRCss5PEQ_1760017545
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e3e177893so5798205e9.2
        for <linux-block@vger.kernel.org>; Thu, 09 Oct 2025 06:45:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760017544; x=1760622344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LuKvTV/ZvxsZcI+HNaWfxeETY2vb8WWG5aZ1soizNHk=;
        b=qXg2lx1qJqqGEpMUL0p+meT4MFBIrX9WNY8cq/E1LND+LLShpHFIq9/Z/ccrtled1d
         xnGPPlX0rhpVNj8YHA0FQrg5KhFn9MPW3kx8SZG1ieFZWo4xe8droHfbBu8PDFHgHYJz
         ysk0VVbnqLah2twS59Ers2uL2iVHpNTJDtxWjmwhuBm6Vt0at0gUBYMuZSWTcxPXRpy3
         iGSu6syYZS4XHIHhbD0XUBFuysCVONinZVxig57ZkUmRDgIi+BgQyxYGMf6wy/DtOYcI
         Y128/5nD8/XRxcyVvk9+X28+MIKHX+9h1lzCN9E5wxB4+OvY9aAEUnVeSs9ELMnnh2vl
         zV5w==
X-Gm-Message-State: AOJu0Yyc+qiPmFJP6YYflzziQucJ87RzxcYeR2wgodba6nfLodsACtk7
	c6hHmZGwUWgGzHv9I+DMfukUzOe/VSLdLOJnkfeMkekTz9tCBSD6HA3/wpSH92PtnvBzsuRuT1T
	DF21I8SSPDCfw1kthhHQfuRDeerz0otgqyYHxs0NufeBmCIONhCj3kgRo76Y8gNF2B6MDqNbg8j
	c=
X-Gm-Gg: ASbGncs0VpZIWnB3AbCn61DjqzcRj8FyaB+uMwV9XybB3DSPCTAhjeCAAyGH4Q2Mnzn
	2ToLCQd+52Cw5CoBB7YxqB6wDOVdV8HQAcDB5USzQmLFQwzxlxMyC6aeDX73fppX5jbntQVEkey
	Hy21gMzqDA9nn5NuVbMvkJqFtWBaKJpI3Ez6kV0dFQ2HcEFrDj5YQ+oU2y28SgCsg6GPeZE0z/7
	4z67YyZzMacu1KgGc2yj7H46iIdIzHmKDMAHk8Od4mcOZKgpUYM1VI814TpKuZ5sYKLNuHhoV+s
	v+caWbLh57qjg4JygaFk49EWCjOpl9sQst63
X-Received: by 2002:a05:600c:8288:b0:46e:448a:1235 with SMTP id 5b1f17b1804b1-46fa9aadeedmr76517295e9.16.1760017544444;
        Thu, 09 Oct 2025 06:45:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfgpeOYz8rB6dmj0SJ47sQixPMa8U/4+cKkDJEI0Y54hBFNm63lOaoILSZN0gkfmu+whVYIg==
X-Received: by 2002:a05:600c:8288:b0:46e:448a:1235 with SMTP id 5b1f17b1804b1-46fa9aadeedmr76517105e9.16.1760017544025;
        Thu, 09 Oct 2025 06:45:44 -0700 (PDT)
Received: from fedora ([85.93.96.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46faf16ac01sm50840625e9.11.2025.10.09.06.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 06:45:43 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] nbd: override creds to kernel when calling sock_{send,recv}msg()
Date: Thu,  9 Oct 2025 15:45:42 +0200
Message-ID: <20251009134542.1529148-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sock_{send,recv}msg() internally calls security_socket_{send,recv}msg(),
which does security checks (e.g. SELinux) for socket access against the
current task. However, _sock_xmit() in drivers/block/nbd.c may be called
indirectly from a userspace syscall, where the NBD socket access would
be incorrectly checked against the calling userspace task (which simply
tries to read/write a file that happens to reside on an NBD device).

To fix this, temporarily override creds to kernel ones before calling
the sock_*() functions. This allows the security modules to recognize
this as internal access by the kernel, which will normally be allowed.

A way to trigger the issue is to do the following (on a system with
SELinux set to enforcing):

    ### Create nbd device:
    truncate -s 256M /tmp/testfile
    nbd-server localhost:10809 /tmp/testfile

    ### Connect to the nbd server:
    nbd-client localhost

    ### Create mdraid array
    mdadm --create -l 1 -n 2 /dev/md/testarray /dev/nbd0 missing

    ### Stop the array
    mdadm --stop /dev/md/testarray

    ### Disconnect the nbd device
    nbd-client -d /dev/nbd0

    ### Reconnect to nbd devices:
    nbd-client localhost

After these steps, assuming the SELinux policy doesn't allow the
unexpected access pattern, errors will be visible on the kernel console:

[   93.997980] nbd2: detected capacity change from 0 to 524288
[  100.314271] md/raid1:md126: active with 1 out of 2 mirrors
[  100.314301] md126: detected capacity change from 0 to 522240
[  100.317288] block nbd2: Send control failed (result -13)           <-----
[  100.317306] block nbd2: Request send failed, requeueing            <-----
[  100.318765] block nbd2: Receive control failed (result -32)        <-----
[  100.318783] block nbd2: Dead connection, failed to find a fallback
[  100.318794] block nbd2: shutting down sockets
[  100.318802] I/O error, dev nbd2, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.318817] Buffer I/O error on dev md126, logical block 0, async page read
[  100.322000] I/O error, dev nbd2, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.322016] Buffer I/O error on dev md126, logical block 0, async page read
[  100.323244] I/O error, dev nbd2, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.323253] Buffer I/O error on dev md126, logical block 0, async page read
[  100.324436] I/O error, dev nbd2, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.324444] Buffer I/O error on dev md126, logical block 0, async page read
[  100.325621] I/O error, dev nbd2, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.325630] Buffer I/O error on dev md126, logical block 0, async page read
[  100.326813] I/O error, dev nbd2, sector 2048 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.326822] Buffer I/O error on dev md126, logical block 0, async page read
[  100.326834]  md126: unable to read partition table
[  100.329872] I/O error, dev nbd2, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.329889] Buffer I/O error on dev nbd2, logical block 0, async page read
[  100.331186] I/O error, dev nbd2, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.331195] Buffer I/O error on dev nbd2, logical block 0, async page read
[  100.332371] I/O error, dev nbd2, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.332379] Buffer I/O error on dev nbd2, logical block 0, async page read
[  100.333550] I/O error, dev nbd2, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[  100.333559] Buffer I/O error on dev nbd2, logical block 0, async page read
[  100.334721]  nbd2: unable to read partition table
[  100.350993]  nbd2: unable to read partition table

The corresponding SELinux denial on Fedora/RHEL will look like this
(assuming it's not silenced):
type=AVC msg=audit(1758104872.510:116): avc:  denied  { write } for  pid=1908 comm="mdadm" laddr=::1 lport=32772 faddr=::1 fport=10809 scontext=system_u:system_r:mdadm_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 tclass=tcp_socket permissive=0

Cc: Ming Lei <ming.lei@redhat.com>
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2348878
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 drivers/block/nbd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 6463d0e8d0cef..d50055c974a6b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -52,6 +52,7 @@
 static DEFINE_IDR(nbd_index_idr);
 static DEFINE_MUTEX(nbd_index_mutex);
 static struct workqueue_struct *nbd_del_wq;
+static struct cred *nbd_cred;
 static int nbd_total_devices = 0;
 
 struct nbd_sock {
@@ -554,6 +555,7 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 	int result;
 	struct msghdr msg = {} ;
 	unsigned int noreclaim_flag;
+	const struct cred *old_cred;
 
 	if (unlikely(!sock)) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
@@ -562,6 +564,8 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 		return -EINVAL;
 	}
 
+	old_cred = override_creds(nbd_cred);
+
 	msg.msg_iter = *iter;
 
 	noreclaim_flag = memalloc_noreclaim_save();
@@ -586,6 +590,8 @@ static int __sock_xmit(struct nbd_device *nbd, struct socket *sock, int send,
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 
+	revert_creds(old_cred);
+
 	return result;
 }
 
@@ -2669,7 +2675,15 @@ static int __init nbd_init(void)
 		return -ENOMEM;
 	}
 
+	nbd_cred = prepare_kernel_cred(&init_task);
+	if (!nbd_cred) {
+		destroy_workqueue(nbd_del_wq);
+		unregister_blkdev(NBD_MAJOR, "nbd");
+		return -ENOMEM;
+	}
+
 	if (genl_register_family(&nbd_genl_family)) {
+		put_cred(nbd_cred);
 		destroy_workqueue(nbd_del_wq);
 		unregister_blkdev(NBD_MAJOR, "nbd");
 		return -EINVAL;
@@ -2706,6 +2720,8 @@ static void __exit nbd_cleanup(void)
 
 	nbd_dbg_close();
 
+	put_cred(nbd_cred);
+
 	mutex_lock(&nbd_index_mutex);
 	idr_for_each(&nbd_index_idr, &nbd_exit_cb, &del_list);
 	mutex_unlock(&nbd_index_mutex);
-- 
2.51.0

