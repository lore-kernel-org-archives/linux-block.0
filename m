Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AFA476078
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 11:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521474; cv=none; b=Qh6rGOJahVjhPqY+fp5BVt2W1C6EmLOYa6h4L2gBZ+R4TvA6VgztS76Su+YVCmibeYzBLbPLhaJKtX1k6G/6um1OvVjN3yDIJdOfL+h3/uXXvzkrS+kztlh1t8uu7qoLoapIc2QaYlCRvMRXbSF8VGmjA69nUAYhVNyDZj5w+eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521474; c=relaxed/simple;
	bh=Q9VNhfOJpV0f6GAYSCL1Z6cTQvWb7SN7DQFyzoIQGiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPNgJ1Bj9mR2pKZJG0AQH6uQ9lDwNzUgH62qOptMnhvk4pAGCDCUxXI+QAY6kR/LF5KWjsvBAVTmO2u11744usSjAzE9etRAK1tJw985KS5Y0vyiZP/3pu2fmWkkZ8fDMNA0hxkzJSk/ffuw+OmcVEVxu9zHzIbnfx0d5Zni9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QmAuFasl; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmAuFasl"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6aa9606ddadso632163eaf.0
        for <linux-block@vger.kernel.org>; Fri, 04 Sep 2026 04:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788521471; x=1789126271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dH+xoxlA23TxNw4X4P0nYpbdDmv6zzTVoV0RNrE+c+Y=;
        b=QmAuFaslXRjhXV/arEwrNjXMFfKItaVgeOsL/jGPkGcrjmuq1ecAAtbHx7wKmGomV7
         bNjMyqrR3GiwGMe93TQBNyXoJelRMFJ5RFNMOINc82NfExoHxsY4Y7t5JJYgu4TN/E99
         Kg8K6eg+z2GMczbQ/5ZDVN+y5SM1U+ZZutx3Nhr70aQ0vtem9LlnxtEi6TlLqbjJXqJi
         xDGG0yaAgWY0ZYaYnrZ7wwHfYgQIGfkvK5e/R+EzN6epgrBRg5lOjNU1BwVDi4k7vFbO
         ow1AQzlGxJ/vfYuPhG1zFFzaLio7nR8m+bjE8Yb0KHvACGwqDKMJkHzXXWbMaFNwMYMA
         93Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788521471; x=1789126271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dH+xoxlA23TxNw4X4P0nYpbdDmv6zzTVoV0RNrE+c+Y=;
        b=kEGc0+601LTnuC43Ns4ArDL6GJsO9hmVWrQ19KM1K3oay7MkJvhqcyr6V6I9y1Z2AF
         bZGTzEjpENriIxbpSY4V0z5t5Sz4RHQgmWjqKOcvQAH/fcqDvcfb6sA30dRJ+idEBWrj
         A4Ix5XOu8sF3jBFIPJc5/j4CQMKZ1Svsn4FgIeWzmbqPVrN4RCgHYds7JQfKp9gEYla3
         lY6k9gWMrIc3EJ6Q9p7Wpozb8RLTRXcc8FuBFIhOsQRqTWMcKXgjxOV77QHu2zZ2/7P1
         2eeEuy0SHwBDejFZP71F3ivfVo5xBRUAwjumoBSleFgIdYw2xZ3WBm1hHHx0X2d5a2Y9
         sUNw==
X-Forwarded-Encrypted: i=1; AKwUvBz4n1Za5JofuN/WDkkbXEpCTjHSxrOb6hFaCDvM7sc7uhCl4mKhJvi3unjeTapN1veReiCxjyOXdZ+2Jw==@vger.kernel.org
X-Gm-Message-State: AFuF++l7/ocuw3PTXQYTyxpbrlGrW53haseRubJxxf/+MwkSXlmfD/Di
	i0i9exBWDzgLTh/fyH9XOxl5G9vvB/hvXyRfJB08S8WH+k3q0DayEM62
X-Gm-Gg: AYBFou3i68PTGCq0gUDf9gLMnYwFI2Y5OrnwRl+VeCk5NihhMP3IUUtFg6DAp3xGJAt
	pRAGjX2+nbTsZgm8PJqnt85KbEMA0+q+3F9AIe24Q2VVqgrX/oUrk56VcdLxhh/CdBZVLmXcF+q
	NO5ax0c43IIN/ldXfg+j0P6X9y64rGK3oFdcV4zho7h7fYakI6ovdm6pTNfnzCL6Tz8LBXuiOiN
	md5D8wIK2cH6M5w+h5BHrPbWy9sUBoVyfJNRJOscDeqLbnf3M79vsVjFlZI6koCHNglmQGpMyFf
	XtqipS4/yf3uV4urF2zPhIvJl6DSls+dVKejhKJwUJuAzc2T2eUcOz3FlUz3sqk8XFJ0ARQ0+dV
	0w4K0jBa8iORTuFXndH+R7iEG19ssIRXwXlFVqYTDjVunqEjMt1YLZ6dWwxS0/2z8Pl39EAdWFd
	M8+x3kSavtGO1IV+YJFgMLjlfgPUDs+RTDpy7GcCXYgHFTa7xToMsgsc4MJFnf7rwqFism+GINn
	2OPTuwxKy/X9zfaCcWDyYnLcA==
X-Received: by 2002:a05:6820:81c9:b0:6b1:7251:4210 with SMTP id 006d021491bc7-6b6fc7d3e3emr4024717eaf.22.1788521470789;
        Fri, 04 Sep 2026 04:31:10 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm6039922c88.13.2026.09.04.04.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:31:10 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: drbd: fix typos in comments
Date: Fri,  4 Sep 2026 17:00:59 +0530
Message-ID: <20260904113103.10805-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904113103.10805-1-hemanth.selam@gmail.com>
References: <20260904113103.10805-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/block/drbd/drbd_nl.c    | 2 +-
 drivers/block/drbd/drbd_req.c   | 4 ++--
 drivers/block/drbd/drbd_state.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index b77f901fc3ef..f180c2eb996c 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -605,7 +605,7 @@ bool conn_try_outdate_peer(struct drbd_connection *connection)
 	spin_lock_irq(&resource->req_lock);
 	if (connection->cstate < C_WF_REPORT_PARAMS && !test_bit(STATE_SENT, &connection->flags)) {
 		if (connection->connect_cnt != connect_cnt)
-			/* In case the connection was established and droped
+			/* In case the connection was established and dropped
 			   while the fence-peer handler was running, ignore it */
 			drbd_info(connection, "Ignoring fence-peer exit code\n");
 		else
diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 70f75ef07945..6709c45cbd5f 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -1576,7 +1576,7 @@ void do_submit(struct work_struct *ws)
 		 * Be strictly non-blocking here,
 		 * we already have something to commit.
 		 *
-		 * Commit if we don't make any more progres.
+		 * Commit if we don't make any more progress.
 		 */
 
 		while (list_empty(&incoming)) {
@@ -1747,7 +1747,7 @@ void request_timer_fn(struct timer_list *t)
 	 * but which is still waiting for an ACK. */
 	req_peer = connection->req_ack_pending;
 
-	/* if we don't have such request (e.g. protocoll A)
+	/* if we don't have such request (e.g. protocol A)
 	 * check the oldest requests which is still waiting on its epoch
 	 * closing barrier ack. */
 	if (!req_peer)
diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
index adcba7f1d8ea..98abd2351d6d 100644
--- a/drivers/block/drbd/drbd_state.c
+++ b/drivers/block/drbd/drbd_state.c
@@ -1339,7 +1339,7 @@ _drbd_set_state(struct drbd_device *device, union drbd_state ns,
 
 	remember_new_state(state_change);
 
-	/* put replicated vs not-replicated requests in seperate epochs */
+	/* put replicated vs not-replicated requests in separate epochs */
 	if (drbd_should_do_remote((union drbd_dev_state)os.i) !=
 	    drbd_should_do_remote((union drbd_dev_state)ns.i))
 		start_new_tl_epoch(connection);
-- 
2.48.1

