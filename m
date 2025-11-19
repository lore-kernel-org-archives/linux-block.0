Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10A3702F2
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 03:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763521586; cv=none; b=Dg1ddjC3ys1rT9OHC2KDSlhaibxfegTfKnH2NacMw8TbWHBLl3y8a4JSDgGYG6nC1F+wAUwqhCE4etW7t0gMZ46Q/+ZtQiC+i9lPq6K8BMElOk6c5In25Iie3PAFXcb0zgT6C9djpHCa9RWV52obQMcsuNOqRm2YJUOPdmM3tkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763521586; c=relaxed/simple;
	bh=xU4EusndYfZ8RCUUwyuBU3jKmuD8Ymexo/R9AClsFrc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMG4575YxeChB6ew4Nka6TZq4vNWGIFPqa9vXA3Iei9nG7i7sQokpCyQ+palaAkWKiOyMIH3GnlVEpFu2w45eEwU5sCQVovEAWfiIGxh5QKKoPOeL0mSu2FmBYqVucG9YyVKRQVsNnWrdKy8mRJwFF1SOQH0ww+6TOxy5jrrWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+GIZXsD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+GIZXsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194A1C19421;
	Wed, 19 Nov 2025 03:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763521585;
	bh=xU4EusndYfZ8RCUUwyuBU3jKmuD8Ymexo/R9AClsFrc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=A+GIZXsDvioaI4hLWt+v7FXDHfiHw/FVk+eGYIUb3C3ybc6OA33b2XPB15bqUSbxC
	 fqrVZeMQsN0ZA3cPR+tioq8GJhMTFtztZXfTOpaNiDu4weJdYKIvNRj/rN5QtKcvzo
	 ak1URk5d8qEzYhLDSzHn17sujKOYmXPLBuR3PXT8E906Ql97WOE9U1tX2PU1c0cqHI
	 ZjivZ6NL232MZgad7iy1q17a4VKUaXKRegtYd/M6AdTw/UEmyZyQPhzvBHQXTz9UjH
	 By2D+P9wAkT94iPMOYrQrvV7wY1xgyNeixu83+SRkEUYYJFaK0P+2b5gWZPfdiUl7a
	 0ykj4GoThHtfw==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 1/2] MAINTAINERS: add missing block layer user API header files
Date: Wed, 19 Nov 2025 12:02:19 +0900
Message-ID: <20251119030220.1611413-2-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251119030220.1611413-1-dlemoal@kernel.org>
References: <20251119030220.1611413-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing user API header files related to the block layer to the
list of matching file patterns for Jen's block layer entry.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64b94e6b5a9..037275e53cc5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4406,6 +4406,8 @@ F:	block/
 F:	drivers/block/
 F:	include/linux/bio.h
 F:	include/linux/blk*
+F:	include/uapi/linux/blk*
+F:	include/uapi/linux/ioprio.h
 F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
 
-- 
2.51.1

