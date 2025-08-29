Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCA91DFF7;
	Fri, 29 Aug 2025 01:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756432447; cv=none; b=UEAB76SI1dz5LJq6GRX9HbgUNXDn2HEXdgTe+Q4mTRoA+Sp+5S9cup8J3EnjYlu4IKccp2goS7CTEWP5abLiW7bqM62acImMl46+DYTg4Z2jD5BgnyiJt9sfzsoANxkcS8T2e5Q3ermn5i+hKN9DM/ExVUuh2TV95P+dUkA2IG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756432447; c=relaxed/simple;
	bh=OWFmvzsVpeZgMbpE1dW6+FVSeCbwmUNz/xvqxcvj7Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XpaNt4VoVIrrOpmxRCUbTXqU0RIpsG4s6Fz9/MasxTpvddSKp1bckOi4kX9m9s8lsWjlh8rdODdQsQ/MzmB/69RrVwDCNygRpTt3BTrmyNvBpUbGXHF+IBUD3M2z9LS+M5mHKbT92vQrNOi7cAdXxzkdoshmMAz0+0rcy844/6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6dfpG+M; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6dfpG+M"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-32326e5f058so1296222a91.3;
        Thu, 28 Aug 2025 18:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756432445; x=1757037245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M94lH8MA5wNtCfiWKos3XiM3bUM+bzg2Tsiy9Jdi1Yw=;
        b=W6dfpG+M/ESSA2P6i8bSF7OGnyLNorIDJGYVjzOhgy+zjCJvFm4pc8sQ0MGs8s7WyW
         h5nV0O4nlDCUFmdKSeTlQu0d7+tG0hIwtuYbbmGE9Okfp++aefvXCDo7oV8261rDR8AJ
         pgFLjolIQ1+duATdaXv07wezK/PmLt6cCCPbJSEikD28KwhE0MaSHST3JdTuNO9pcVX7
         ehmFcbgk/4/JAtqAUb/d5fJWkBw4OzP4WpEW6/tXdpCxU9I0dKUW5A9YPbdy80G+A7hr
         WJrO4qBzz7HfaQmfRDefUwqmRSYAgB6S+2LMRHCS5EiNDa8M5GjOndFN4oQnk3jNj+ud
         hXEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756432445; x=1757037245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M94lH8MA5wNtCfiWKos3XiM3bUM+bzg2Tsiy9Jdi1Yw=;
        b=MNj9u7/io64kvYJHhb9Y2iqvYUa1yBCk1wCZnNasu9l7mVGUw0V+fDA5Dg9szzB6db
         3mANeP6jlBJM5hld7eQam+pp16Znb3CIJxzvEst9RkNcfeQyYI/v2eWHEW0pyLvVcW7H
         UGXNo0DaCtQxIwfKjmA4GQlN8/hwAATJrgJcGVjhf+cxAFgtquP6XjkbDQ9HtdrhZb4J
         faMBsl9gmY52jjS5gtcoL5q5Pa4aIIgeUuUw5xbmoYPvUNxsQTFj4pA0wvbCqZRAa4JH
         nSS7L6dF+wIuS9lZLnerfP6b5RP33u8GgVxNAKXz98VK9KJU875vdJufYyNWTA0eY1+W
         1J0w==
X-Forwarded-Encrypted: i=1; AJvYcCVtlVQ4b5IFIqwYEUsAGRQ4RaxY0eOKwsK4vWwGgpxWR2jdvD8E0nNxcRQDSEXwb3yloZsmbhgW40lIi7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh6T13JaMUyTmt0w/DC7ZVB+x9U1H/rZ471ENDs4CjG49PXvLE
	ZybWR5a4jDJkcuZRL9X/ZFz4LSpCDyyHeKx5+cZ0pwnCid9CADQotGOr
X-Gm-Gg: ASbGncuV6TlBdlnlDlnfYmAZ6f10RkBxNCwhVmAhgpGNlD95GveSt/9S1f64chbzoIE
	tPbhZiIfA3JPDaMVIG8RFZuPbUNg5L59KpKHskUbRzg2IFTAopHro4fYaLqjehd7N6epoBy3Ngz
	OVnYX6V4fTn6Su3kcGSJ5uLirB4g1iJ1R1pFCE5d2wQ6nw4AR5n08lH0nYEkU0obyywmouWvxuT
	MDbgurOtSYrKyckaSk6U6bMX/lfzyMVIYvAQaGozZUOucaCpu8TU9EUk6I7RxeSAxM2go9IVTBZ
	2RijT83SjWcWhPmMB5Jg3QdY5JjWkpNA93Mp5YwoyAg26DEB6GGxhDSz70Pi5bsl/8JP/BZepOX
	ufJQ6hdz2pyCZvM00FaIAAXXUD4vNd5JcKL8G4wUc2TM4YE5U
X-Google-Smtp-Source: AGHT+IGc7SwzCuuG9wnat3x0V0Nx1Ip2wqCPwtYX+Aa9q6e9Th18a9MxCD78QT+pPcq+h7NbsediBQ==
X-Received: by 2002:a17:90b:3c45:b0:327:b824:2257 with SMTP id 98e67ed59e1d1-327b8242bbemr4748750a91.32.1756432444984;
        Thu, 28 Aug 2025 18:54:04 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd025eac9sm695175a12.6.2025.08.28.18.54.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Aug 2025 18:54:04 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH] block/mq-deadline: Remove the redundant rb_entry_rq in the deadline_from_pos().
Date: Fri, 29 Aug 2025 09:53:41 +0800
Message-Id: <20250829015341.91304-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chengkaitao <chengkaitao@kylinos.cn>

In commit(fde02699c242), the "if (blk_rq_is_seq_zoned_write(rq))" was
removed, but the "rb_entry_rq(node)" was inadvertently left behind.
This patch fixed it.

Signed-off-by: chengkaitao <chengkaitao@kylinos.cn>
---
 block/mq-deadline.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 1a031922c447..0f5d0d5fe837 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -136,7 +136,6 @@ static inline struct request *deadline_from_pos(struct dd_per_prio *per_prio,
 	if (!node)
 		return NULL;
 
-	rq = rb_entry_rq(node);
 	while (node) {
 		rq = rb_entry_rq(node);
 		if (blk_rq_pos(rq) >= pos) {
-- 
2.39.5 (Apple Git-154)

