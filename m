Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B92322129B
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758160243; cv=none; b=QYNcz8bo7JJp9T2HRNjNqono5MfdS+wah73sLRklcxuW3OnUIfAEtctgDSRubozqFX51/bjBIxnNZNFN2rjtMDD3P5+LxRVDJI3QYWnFlUQNoI2GxroZLmTpZRbx4BA2ulX3taE7+K8y+1f7bYMM2sDtmDMrviSjIxPPotjAbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758160243; c=relaxed/simple;
	bh=KVEBWh1k3zqgptqwYjWnc7dJxRsoATwKrSK9Z6mzXAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j7Ib8WkYVcSvIAGYSM69W+fYX4FbqHEmS6zZvq1QJNz3nN96/6dB7gPe/XPOXzp5HY2Nept+onLDfCZYveGXEf4p3INOFLZuB2pOkcOpZNMLJOSmg69a0czagSPRHTvs7KxbSPt2IHz8A7yO2T3NJNLtczdERy7L0J4UDgR9Zl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Kr+//N4m; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Kr+//N4m"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2630354dd1aso803645ad.0
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 18:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758160240; x=1758765040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RQtQL6k+NU0z+7kBXeWsorzi1G5ZdNWyfKDcftnhrU=;
        b=Kr+//N4mIO+HDwLtTHxQd/uI5TYxsgHGyS94pJ/3JHNVM5/jJSogfc4yIr4KZeL9Lx
         JZTCnDS/BlvSK3FTxFxDCfEo791kj8UEQTPR4OTpe9V8K+O/XxgNX5AQ4p+/h4YK3LRV
         Sflkd3H0pWlC0XJUEEuN4WqHVeJ9A0QjXTAZ+D6nQVzqA9PBuwU/G7wPuPwCRcr8MXl+
         ao0BdrSb42aOAfUmkNNQR5KjcFOdwcz91IWZbDgEgNn+56oD2vg0Dkmck70N/tMnixis
         doyWoYZtCqTE10oZ9rgRqc1vrC/Wddn7fjN0Rz2pJDkxUpfANLnEmJTfF1bhbyH/1uGR
         9BgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758160240; x=1758765040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RQtQL6k+NU0z+7kBXeWsorzi1G5ZdNWyfKDcftnhrU=;
        b=ILvqDINuQsysK5KWmdccfM52h2we31Ag/Hxp1WBIuL+Qk8KqF9EuwQZVTT0Nw4nmZv
         kMX17dDegJHiRtX7nQki0kcpKKJvhxOYe6RSaUd/LKD1YnPrI7GiEuAYi1jhOms3FzEC
         Iq2VghLoh9CCZXDDzWR3Kwpbxtjlfk1pXAyhEy+3hrtx0g1Iuwe6x+RAaqKfld2Qwg3c
         2/YlvK1zOklcEowAxTikxgYY24Ei1LXOwYWZTYvSBt5INhtj7LPAiyJI9nTIVKeJKukL
         Rmt/pTDRnOiS4BdXMtoUUcEGbHOR65MeLRNTvnzeZxgTyovk4xyzev1AXULh144YZoa5
         HCzg==
X-Gm-Message-State: AOJu0YyZHM98N9Zbxgcj4hVdD/D2V0TnWOKNZDhtxlJ52GL29UqbO28D
	LEM5bu3v7tHAzcm8wucXXzKjBLePiwBUEepNGjLz5hXr5I85c5smF5/oh2xGhagb/ythRSYow2Y
	HuSvq/kEyWNkesdXJxJe5UaqeClGkarhiW7w3
X-Gm-Gg: ASbGncuv3Of+xHIyjygpSoeWtf1H7+vpyJuvM8/ajKzG6DQe4C1gBJkbJM+XUMZvpUT
	7BZNdah0mwo1FI4VOOdms7HFalQ73Gdhxtym7o0Q/mP3l2+YqhnDDFjxIpvbV/gZNSzCRz4C4vP
	8tBAF4OECWo0Q5yMW6MdXFJlCRT4VzwM5iUIilXUKaw24DMwRlbu4UscWhUTkmLIv6r35zaBGCF
	iBquX0jdOZ4v5SQ1fSuJHWD7Qn1Ca4sGgkvoCkrpZ18vFYYHbN2lIuVFZpoDFL/nepJ7Wm6s4sM
	2DEXy278HbWP6N5vMg28EuiMT6i2CJ25hjnTjmNS0lGw0agRFlFK21ySbZqZ4zdNetGF45Zs
X-Google-Smtp-Source: AGHT+IHkb8RXhzbuJ3XKkdNpezbAOWNNYIBATOvlV66JaHRzlItWF2QE0jLxB1hwPQNp7yRVtm5JheJT7b2q
X-Received: by 2002:a17:902:db04:b0:269:8d1b:40cf with SMTP id d9443c01a7336-2698d1b44bcmr3530315ad.8.1758160239846;
        Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-269802bbe62sm940265ad.66.2025.09.17.18.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 18:50:39 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 324F3340508;
	Wed, 17 Sep 2025 19:50:39 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2E16EE41B42; Wed, 17 Sep 2025 19:50:39 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 14/17] ublk: don't access ublk_queue in ublk_check_commit_and_fetch()
Date: Wed, 17 Sep 2025 19:49:50 -0600
Message-ID: <20250918014953.297897-15-csander@purestorage.com>
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
ublk_check_commit_and_fetch() is a frequent cache miss. Get the flags
from the ublk_device instead, which is accessed earlier in
ublk_ch_uring_cmd_local().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 9a726d048703..b92b7823005d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2241,21 +2241,21 @@ static int ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *ub,
 out:
 	mutex_unlock(&ub->mutex);
 	return ret;
 }
 
-static int ublk_check_commit_and_fetch(const struct ublk_queue *ubq,
+static int ublk_check_commit_and_fetch(const struct ublk_device *ub,
 				       struct ublk_io *io, __u64 buf_addr)
 {
 	struct request *req = io->req;
 
-	if (ublk_need_map_io(ubq)) {
+	if (ublk_dev_need_map_io(ub)) {
 		/*
 		 * COMMIT_AND_FETCH_REQ has to provide IO buffer if
 		 * NEED GET DATA is not enabled or it is Read IO.
 		 */
-		if (!buf_addr && (!ublk_need_get_data(ubq) ||
+		if (!buf_addr && (!ublk_dev_need_get_data(ub) ||
 					req_op(req) == REQ_OP_READ))
 			return -EINVAL;
 	} else if (req_op(req) != REQ_OP_ZONE_APPEND && buf_addr) {
 		/*
 		 * User copy requires addr to be unset when command is
@@ -2379,11 +2379,11 @@ static int ublk_ch_uring_cmd_local(struct io_uring_cmd *cmd,
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_REGISTER_IO_BUF:
 		return ublk_daemon_register_io_buf(cmd, ub, q_id, tag, io, addr,
 						   issue_flags);
 	case UBLK_IO_COMMIT_AND_FETCH_REQ:
-		ret = ublk_check_commit_and_fetch(ubq, io, addr);
+		ret = ublk_check_commit_and_fetch(ub, io, addr);
 		if (ret)
 			goto out;
 		io->res = result;
 		req = ublk_fill_io_cmd(io, cmd);
 		ret = ublk_config_io_buf(ub, io, cmd, addr, &buf_idx);
-- 
2.45.2

