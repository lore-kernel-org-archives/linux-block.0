Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE03D271
	for <linux-block@vger.kernel.org>; Tue, 28 Oct 2025 04:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761625974; cv=none; b=VHGuqzx2b0he2sV2Gml49fW8sTBFbA6UUpoAwkH1svl6Lw7rY3VzZ4t9N30LL6yLta7r5Prw2oW5P7YEKMZZOb7aNlzyTNIZdyY/sEfK0J2uP+6YKEKp1BwvZN12Zk2n9HPdUZIVvgZxn/w2pwIhS/5ioIvXxFc2lW01HUyuy+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761625974; c=relaxed/simple;
	bh=S/lne8wybyE1gO5htDFPkrjiiUfBJTJUUGjSUp3mgWA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q13BVs6HrfnPsN7+L7RT8isdMLIWDQT9Ulyd2Fm1bcG8iLvT+vIzzeIu1LbTrZShNZomQW7x8Mzk30RsqoNzqG/5mfjzikYYOD/ZswF2LkiFiY+xDjx2J4cZm+SM94Z7tJItiSNJirzfOuFhp007mzzjXnRKhtTKvpyOFS1ol8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMHnOLzP; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMHnOLzP"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b62e7221351so4836245a12.1
        for <linux-block@vger.kernel.org>; Mon, 27 Oct 2025 21:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761625972; x=1762230772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5TXKHptYyH+Ht2HxkkCZQsOl8z28P1fxyA0/H0EwTQI=;
        b=LMHnOLzPeBtSvYILtN2gzRx1+T6YLxZTdP2FKIocIhpWpeMmKraoRkpZq8ooLt3ozn
         L+aCRVKnOM439xw+UojizqwEAKT5C9gUORI7CbsHWcnYuR5s1YDe8jHR4GSqJSoBtxQp
         gaD2pbZqTxxhVng0zaLPyqCuaIL8GsuD+/mCXbkksTviFN/ztTDW3dRVmdMVt23bmZai
         X0kPEFow516jCTu8OSRhKcaeAtLoUVYo0V9on8ombka2St/Bj6WbhsZ/2jMp6uCYM0IC
         7NDFoJF8fPJsO2TZ6d/063FI/PrXSPWMDH7RVKSCfxBsvjEFrmJCA4xNeI925JsB3c0U
         Rlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761625972; x=1762230772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TXKHptYyH+Ht2HxkkCZQsOl8z28P1fxyA0/H0EwTQI=;
        b=O2TC3TsUta6+B0PzknBWpynWCqrlf60uPJyCnUQceu6hjclSybATjRF7u8yFcgMvKt
         58jToNcQym02Z+f65eLV5LM8dkF6b70jpGa6YV6XA4vsdjpjIUFCJAD9J8S6dOj/2bBs
         aXcjjXK1hf9EtxJwMp2XHtR3KbEQYgO86QQt1bdgtVvT4qOUvdsyOX1+oxIEim9gF9uT
         IZkONqLW01kJ3MuT+Lr1594daWPpjs3EPczcwCUFCn8/yAITHp1OyiiyYshYlj/pW9lj
         vs1X99fztdQLEpC/ft0D1p94+4dqJa8xCzrjNLOWBS8h7pIi0BvEFmt/tqyvi7z/npld
         M0Jw==
X-Gm-Message-State: AOJu0YxpFiaC60jda3zFH+B4CN4WYPRAX0PdqiJ5L4Yb+5JZ7zD9XBX8
	H0DImem1RBn/wOvP9VJOk0Li80SXhpxO2MnjPYddOJEZ6IQ7ViS9+O+RjMzVlg==
X-Gm-Gg: ASbGncvKxxtu8d1G8fqqvTqDRPxK4BJzYJ++dVxJEtgir6hU2CbCdLDEZr6doZI/Ieo
	Ri8McezlSYEC1N59zJQJYbD/YuWVqLR2hDoW93mJaJq5pQqVXzJwppCzDLok/+sT+GI3GcN0FOA
	gkDRpGmbXGl37BPuP/h7DOQddcEfI/QsdDyMpAyBYMuMSfW7Gbrfbify5pUt/Y71Sx2l3SetuId
	+dEid/Lkj/5ThL+uiNfXnWrOG+Kyv4MAqmSei6XzpH1xo+iwP/WVNhV664WnrEQqJCqsuom0amn
	jCsjFEKdbsbJ9ETufLJQNh+40oncmvbWr+P4n5mPhNw+CbGOXQSMkDpvlB8fIc4fFjeq3ZgrqtT
	1hk7m7S5xPLF3gHOpdGPwrF6Wwp774NlSoCq8IqCfR3xbeE+87yEuI/lkc+YAd2Rw
X-Google-Smtp-Source: AGHT+IHO6nGqRH+A9osLM89yQ2mH2wz/2VUNsGYa2/Nw7fF8/pMHkXQuIu1wg0vyQuBPzr8zUy6OJw==
X-Received: by 2002:a17:903:38c5:b0:24c:da3b:7376 with SMTP id d9443c01a7336-294cb3a11dfmr27045135ad.26.1761625971756;
        Mon, 27 Oct 2025 21:32:51 -0700 (PDT)
Received: from localhost ([2600:8802:b00:9ce0::f9da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4349fsm99416565ad.107.2025.10.27.21.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 21:32:51 -0700 (PDT)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: Johannes.Thumshirn@wdc.com
Cc: linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.petersen@oracle.com,
	dlemoal@kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	axboe@kernel.dk,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: [PATCH] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
Date: Mon, 27 Oct 2025 21:32:48 -0700
Message-Id: <20251028043248.2873-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add informational messages during blktrace setup when version 1 tools
are used on kernels with CONFIG_BLK_DEV_ZONED enabled. This alerts users
that REQ_OP_ZONE_* events will be dropped and suggests upgrading to
blktrace tools version 2 or later.

The warning is printed once during trace setup to inform users about
the limitation without spamming the logs during tracing operations.
Version 2 blktrace tools properly handle zone management operations
(zone reset, zone open, zone close, zone finish, zone append) that
were added for zoned block devices.

Example output:
blktests (master) # ./check blktrace
blktrace/001 (blktrace zone management command tracing)      [passed]
    runtime  3.882s  ...  3.866s
blktests (master) # dmesg -c
[   95.874361] blktrace: nullb0:blktrace events for REQ_OP_ZONE_XXX will be dropped
[   95.874372] blktrace: use blktrace tools version >= 2 to track REQ_OP_ZONE_XXX
blktests (master) # 

This helps users understand why zone operation traces may be missing
when using older blktrace tool versions with modern kernels that
support REQ_OP_ZONE_XXX in blktrace.

Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 kernel/trace/blktrace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 776ae4190f36..200d0deb6c90 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -690,6 +690,12 @@ static void blk_trace_setup_finalize(struct request_queue *q,
 	 */
 	strreplace(buts->name, '/', '_');
 
+	if (version == 1 && (IS_ENABLED(CONFIG_BLK_DEV_ZONED))) {
+		pr_info("%s:blktrace events for REQ_OP_ZONE_XXX will be dropped\n",
+				name);
+		pr_info("use blktrace tools version >= 2 to track REQ_OP_ZONE_XXX\n");
+	}
+
 	bt->version = version;
 	bt->act_mask = buts->act_mask;
 	if (!bt->act_mask)
-- 
2.40.0

