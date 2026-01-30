Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340D320A24
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793273; cv=none; b=o59D3cVMjT3HZXZxW9L4t1MAkQlc0ZxuOS/6+i1QCTN+bDIn/JGcXy3NaozMDVQ6aTu2UubjUgbdvvm7HLHqaYGWyhGuEFgnGDx8E4mU68NIVqbsxac3kUCGmANG7HRnmvVmN2YJ3egr/WOyUIo7357Qy7f9fCELMohr8MhGzwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793273; c=relaxed/simple;
	bh=wCkT+0Fo7ip1VAXveKM+pIVE+TBXQ2MYyUCKXghWGUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hR2r4XOj11bPqxCHfsKq6U9FfKEQ5c7NNt0+XbICyNLcFlyaQZJlhNaVG+bdPNLSD3JBaNn+2UaQytmF9ByvbUtLXluywFp6yWQ7E/9I0NOf05ZIIfQCrMn8coDvgORQbBQZs6fvAcz7NQBArRYR5cL+hMawtX8AiPjEYm6tYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=d0IE/pIA; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="d0IE/pIA"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2a08cb5e30eso1126205ad.1
        for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 09:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769793271; x=1770398071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pYvyvztBv1OPHWCa1BTrjMg7Bnkkyf2mkorsSdzRqM=;
        b=d0IE/pIA7Bkt9TI8aV6P4pbUhC9xy0MzHVQSH+kaY/cPj8PjP/hj8rlEdm8OTSTkmy
         cAkTq+4aSLTwePCjIteUozWQZQSE9MQAZIu+zcOmUj2MZxGI0eX7MzVdpJoFcl5HsBOh
         Zz9JaczA0L2rmb1eFqb0fU3IQkre13+Aqen0V3ubULFZRVhrTpcnwIHN8eORVyBVv2xU
         mm2MWkbPMP7ieI6pTmmdhEUNxUfJy0OPX9RVp0Ofv/I2axax/1Na4WkApIrN1Hq4v7jq
         1eRqWrz9YspFPuNGhQMkr8NNGKIqNXTVJpBwc+4o4ov8h65lWy5k+f1YERN7YkH9aZsj
         ApOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769793271; x=1770398071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8pYvyvztBv1OPHWCa1BTrjMg7Bnkkyf2mkorsSdzRqM=;
        b=R524cdZjT1J5gphaxoyU8BmY3ojdrE48ExIw45HaHwnLhUuoWz3EiA8R5MQeDTRhNb
         azL0pYDl9xN+GO9qP0l2tM2UaFPDkaEXNlKg4fCdNA9tslTN+Rpg97ofOJdxZ32p2h2d
         m7BbHmrr0dsjMggo9hKd9lcZtKkOhRJoSJnYMAATsURHWW4WyOECd1iFv63B/AjjhXsS
         YunuRtTf7DuhBlsV5pejrG0H/e6N15GH4WxwcGQOsfMZFMpe1VnJwsCfWT3KOJnmz1MP
         zz3734PjDRFChtUPVjBWl2r0k3xviW/A+1zrHsTtVvfIYIcnQLGQ4WN7aMuymk+GbyNC
         PFaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeoTTjN+J2uCr8REzU0Ej33EsxbWtsxGZo+snvhfaLpyVBT4WJ0G6RQvgviJ5/3drP2GXyKqTq38MuYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5ZaZ3gdTS9EI5mGiT44kzpmpDsTv4mFmCrzU9aM/TAViVT7ML
	at5kddGhFjn8cBmZuwrl5g2SSLYO+uCVd1UdISTJPGRkIyshO5DkKcz2GK2a/ViWAio9LjDE+TI
	jLBNmV0IaRu5yp4a87BPNtSUo9m9vIUguP3u3OBu7pIMgrXF+EXAL
X-Gm-Gg: AZuq6aI1JxO17jVJA5Ym2IkGtqKVEN09P1FC8cqmTypnIfdM3nTKXjHeHjUyQlMYL2B
	mWVzxf4IFyOXCE1S6w+pH14jTZNKAE5aWo9z5apUPlK2kyjea/m4AK3hiqETQzJ+zXSZoKxiUJw
	bk1fOnw3m7EI+IQtzwfn3oKxNQNMEVoFcnKXz3K3Zjzc/G1wsYEAvTB5I4m1oW2p85i2IwYrvW0
	rTk9GMEMvDivki8eWOfSniLgZjU2J1bLenxLk24ZM8rjqCG8NeTGbzqwO42ToS7F0E3uj9kBMiL
	3l29gNjKhFhbJvScCy5oR1Xy1ee+K/n9KXfYReFltUiSHMMQ5J6+Ao9MhJJqnUYrewK4v8Mt/dI
	vbHc2S/H7Rp6z/A6YkJ+eChDCo+8=
X-Received: by 2002:a17:903:2c07:b0:2a7:87c0:d1d7 with SMTP id d9443c01a7336-2a8d9a7f66emr27658905ad.9.1769793270768;
        Fri, 30 Jan 2026 09:14:30 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b3eeec9sm11140785ad.12.2026.01.30.09.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 09:14:30 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D75B634058D;
	Fri, 30 Jan 2026 10:14:29 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id D18B7E40249; Fri, 30 Jan 2026 10:14:29 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Govindarajulu Varadarajan <govind.varadar@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 1/3] ublk: Validate SQE128 flag before accessing the cmd
Date: Fri, 30 Jan 2026 10:14:12 -0700
Message-ID: <20260130171414.1376543-2-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260130171414.1376543-1-csander@purestorage.com>
References: <20260130171414.1376543-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Govindarajulu Varadarajan <govind.varadar@gmail.com>

ublk_ctrl_cmd_dump() accesses (header *)sqe->cmd before
IO_URING_F_SQE128 flag check. This could cause out of boundary memory
access.

Move the SQE128 flag check earlier in ublk_ctrl_uring_cmd() to return
-EINVAL immediately if the flag is not set.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Govindarajulu Varadarajan <govind.varadar@gmail.com>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5efaf53261ce..01088194c8d3 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -5219,14 +5219,14 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 
 	if (ublk_ctrl_uring_cmd_may_sleep(cmd_op) &&
 	    issue_flags & IO_URING_F_NONBLOCK)
 		return -EAGAIN;
 
-	ublk_ctrl_cmd_dump(cmd);
-
 	if (!(issue_flags & IO_URING_F_SQE128))
-		goto out;
+		return -EINVAL;
+
+	ublk_ctrl_cmd_dump(cmd);
 
 	ret = ublk_check_cmd_op(cmd_op);
 	if (ret)
 		goto out;
 
-- 
2.45.2

