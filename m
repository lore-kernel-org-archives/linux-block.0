Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C06D23AB81
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160243; cv=none; b=FuH+eaWfS8mtLCKSySOKeXJkMBPhZo0d3EtE6lzYdjtuF20PRk+26SGpJsHbXe0V23G7DgcTuOIItNjPMwWkzX6d6he15KGDQ1e+XLCU6MrwOOBMvvF+ODia61MS4TVj6Uvsw5HP3sRRPujSNCs3mfV48UlCv4QFrY3jtVfVz9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160243; c=relaxed/simple;
	bh=DoQr5ah35Oc1iRvaZs8481Qw1cZ5i039TpGwZ57s7WE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8bzY8uyWctF/OvBNODGOHVmMYcBCTqmoRw0LTHH6yvzAs0t7bF5n0BrH1Ui7YgLI/+elQYze0vY9SY/GE49o0gig+FkPLhj88/XzR1qQdKVubMdaW+bSTPwata2vVuotEKVXbSVhO5aFsj3D2IIVDVhxpC+X954PdFHFNPhc9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=d4HDKZdQ; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="d4HDKZdQ"
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-80e49674d8aso5880385a.0
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160239; x=1758765039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgyIBIfsHXqcLdLsUG8D4gUNHCFZYWoyUaFA0as4wgQ=;
        b=d4HDKZdQYOnQGfGaMtf4r+ECyvstyVPI68HRHgJPdlX6gwQ7bpc1+Dy5QydfEb1bBk
         Yf7/TAL+0hfp1GEvPkkBJUac8H26abGrcGYj2w8zcKpOf/ykIXuQfoVpUj+CLzM5BlI3
         DK4UvsFTH78TOF5ZxFAf7Db6/GLPrqV7JvrT2g5lh7v4dPcxQgLNnKUEK/EnDdyYoFE9
         t/NjInXxYk/m6JFLRXdXMCNF5vV5wXpHvC2K8RmzlRqep65Zijn2lfkRL5ZkbHzyZyte
         gVMnK8OFNqaA9qMTTmjGu1lNTJSGODUe0yo34Yf5Wv5TRxE45nUtZTOxn20vJ2Giaae2
         +06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160239; x=1758765039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgyIBIfsHXqcLdLsUG8D4gUNHCFZYWoyUaFA0as4wgQ=;
        b=Zpqxu5ZDSmBeRCp6Knorct4/w03v3KYrA8Z/U3mehrvSY9a00Hzz7VCn1I9UVxOQW5
         AQ/F68gyIO4JtcItxI5pnX/Y/YIsPnnWukt1BMyj4elfficIPO885IR5eL4qZ/aq903O
         WjwNZN6Hvn0nNGdzAVoT9a5gCr0stTW3TM1mk4ohen1H9OMfZYutt2D3crkS8CRujv/d
         5RCiQHACZgkO//HQh64WKE/dCyec0q/hF0zDehSFE5/0aJ4X85QRrtv8404O//GBxoKe
         vvp/NbCLOB/Qa/fUAu+Ew9ulHNfHN/hfdCIp1zPqdZZgHdMQYVkFQLn1dcOrY07dy+X+
         EZcg==
X-Gm-Message-State: AOJu0Yy5vnwXJRtDdDAUhjRR+7VnEoF3+NF7c9h8cpCwysejpvTUyOOr
	m2BMK9sPImgLt7RscyUSKYigdoCuVidJx94ncVP0+IaqJsNXCZG6ekS5sTjFsKyxM9TFvRFmrk6
	xyKRdtA4PBfA8L95sHxxrV9vXgjxBJd4DqCSbugRJOaztj7tOJMRJ
X-Gm-Gg: ASbGncsFUmpRV+DtgiUHHwuMLG9oiaP5Yt7NeDDhAUm1ZwsETUWyZbq1QfJirQuj1HB
	wIDVQOnHMyswN2AuSZvy1BECZ9ba+Zko1m/xmE4Mx6c9SHd1CDddIv8x9BpG4hhOfA/6z/HoAYz
	qsRSXjR4pQRqxi0aeqOyexP1fdyY/xPIXc2w8DJDJDQGJZ0mFvXCTNiqUhxrblfIM3bip/LpztW
	urSDycx+Z/C9uaQw+51qo1Xkd3uUkn0EtYsPqxhBUpuiRpyNbDWMvtIR/cgGCIjWFi1VEUjnfv0
	MjEBXR0r2M/VjB768pVjvvxQtjFlt08hvxo1l1Aa0U24AVpVRPX7gVq2VA==
X-Google-Smtp-Source: AGHT+IG+kmuiBvnrCyAQ5L5LWbgpGTaf98YifEYA21RL/x9XrazJ0dPYu1qM0uSJk1UB0/SgdjkVu+ofyJM8
X-Received: by 2002:a05:620a:a816:b0:834:bb79:1d71 with SMTP id af79cd13be357-834bb791f84mr194121985a.2.1758160239108;
        Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-8362871be2fsm12164385a.2.2025.09.17.18.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7E94D340325;
	Wed, 17 Sep 2025 19:50:38 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7AAFEE41B42; Wed, 17 Sep 2025 19:50:38 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 12/17] ublk: don't access ublk_queue in ublk_config_io_buf()
Date: Wed, 17 Sep 2025 19:49:48 -0600
Message-ID: <20250918014953.297897-13-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250918014953.297897-1-csander@purestorage.com>
References: <20250918014953.297897-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For ublk servers with many ublk queues, accessing the ublk_queue in
ublk_config_io_buf() is a frequent cache miss. Get the flags
from the ublk_device instead, which is accessed earlier in
ublk_ch_uring_cmd_local().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9c6045e6d03b..9535382f9f8e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2079,15 +2079,15 @@ ublk_fill_io_cmd(struct ublk_io *io, struct io_uring_cmd *cmd)
 
 	return req;
 }
 
 static inline int
-ublk_config_io_buf(const struct ublk_queue *ubq, struct ublk_io *io,
+ublk_config_io_buf(const struct ublk_device *ub, struct ublk_io *io,
 		   struct io_uring_cmd *cmd, unsigned long buf_addr,
 		   u16 *buf_idx)
 {
-	if (ublk_support_auto_buf_reg(ubq))
+	if (ublk_dev_support_auto_buf_reg(ub))
 		return ublk_handle_auto_buf_reg(io, cmd, buf_idx);
 
 	io->addr = buf_addr;
 	return 0;
 }
@@ -2231,11 +2231,11 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_queue *ubq,
 	}
 
 	WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_OWNED_BY_SRV);
 
 	ublk_fill_io_cmd(io, cmd);
-	ret = ublk_config_io_buf(ubq, io, cmd, buf_addr, NULL);
+	ret = ublk_config_io_buf(ub, io, cmd, buf_addr, NULL);
 	if (ret)
 		goto out;
 
 	WRITE_ONCE(io->task, get_task_struct(current));
 	ublk_mark_io_ready(ub);
@@ -2385,11 +2385,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		ret = ublk_check_commit_and_fetch(ubq, io, addr);
 		if (ret)
 			goto out;
 		io->res = result;
 		req = ublk_fill_io_cmd(io, cmd);
-		ret = ublk_config_io_buf(ubq, io, cmd, addr, &buf_idx);
+		ret = ublk_config_io_buf(ub, io, cmd, addr, &buf_idx);
 		compl = ublk_need_complete_req(ubq, io);
 
 		/* can't touch 'ublk_io' any more */
 		if (buf_idx != UBLK_INVALID_BUF_IDX)
 			io_buffer_unregister_bvec(cmd, buf_idx, issue_flags);
@@ -2406,11 +2406,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 		 * ublk_get_data() may fail and fallback to requeue, so keep
 		 * uring_cmd active first and prepare for handling new requeued
 		 * request
 		 */
 		req = ublk_fill_io_cmd(io, cmd);
-		ret = ublk_config_io_buf(ubq, io, cmd, addr, NULL);
+		ret = ublk_config_io_buf(ub, io, cmd, addr, NULL);
 		WARN_ON_ONCE(ret);
 		if (likely(ublk_get_data(ubq, io, req))) {
 			__ublk_prep_compl_io_cmd(io, req);
 			return UBLK_IO_RES_OK;
 		}
-- 
2.45.2

