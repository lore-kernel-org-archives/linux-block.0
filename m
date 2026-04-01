Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C037267D
	for <linux-block@vger.kernel.org>; Wed,  1 Apr 2026 07:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027310; cv=none; b=M18zLKWsbTVHrpq9ufbJEYQ7ee+FyYFaDfbGkziQHNsu4shekF4QfU27Sxzn0EQQJ3lH8I19LfJxNQXi71a6UbrMFhHV5GfzCZQKxlQKhvVqZcOJKoLFWwOu+7PFq4Ji7KN9SsnKe2jOarxMEu3NBRP5lWOXgRtL8lAeZDlikYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027310; c=relaxed/simple;
	bh=QEN8lQbdI/uItw0gbHklfLLuY1eeLRHuUX0e6enQplw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3g8i/0C4O2iXWUcXa1AlnAVW+PiCzzMISvbHlSFfIMJkkxqB1eqFMm9Dm/DkZNABS0cDfWPpaoqKCfl3By7dZS/HJfE2dMyGH8h33nEQHCfJ9zDWUgun4JRhjRwfDGIURxcNTSOnWXiJ0UA0yp3SjOunGZjIbKrph2sOSFCkBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oMQlf2X3; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oMQlf2X3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775027305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nr1n9v/ZqKwCH/0pJM4LXsn1wB/oYe7BcDbH2Y3zEeQ=;
	b=oMQlf2X3aqLjn2a2SGDA7xOoni3IOHswQThhysVqOr1rE6gtshl117JIxWEtL+kT+VYICW
	cVTBRoynpJPlADGjj8iaBERqN9bPnzqIT8RkAmir2imcXpt8lqFmJpXxAYrNnI9eJIHNmZ
	N5nxD+5BfSf4v/htWug1Pi1wmJNqXko=
From: Jackie Liu <liu.yun@linux.dev>
To: axboe@kernel.dk,
	yukuai@fnnas.com
Cc: linux-block@vger.kernel.org
Subject: [PATCH 08/10] block: use kstrtol() instead of sscanf() in disk_events_poll_msecs_store()
Date: Wed,  1 Apr 2026 15:07:14 +0800
Message-ID: <20260401070716.991-9-liu.yun@linux.dev>
In-Reply-To: <20260401070716.991-1-liu.yun@linux.dev>
References: <20260401070716.991-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

kstrtol() is the preferred way to parse a single integer from sysfs
input. It also makes the !count check unnecessary since kstrtol()
returns -EINVAL on empty or malformed strings.

Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 block/disk-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/disk-events.c b/block/disk-events.c
index b1680d6a1027..b6233b0d5575 100644
--- a/block/disk-events.c
+++ b/block/disk-events.c
@@ -372,7 +372,7 @@ static ssize_t disk_events_poll_msecs_store(struct device *dev,
 	struct gendisk *disk = dev_to_disk(dev);
 	long intv;
 
-	if (!count || !sscanf(buf, "%ld", &intv))
+	if (kstrtol(buf, 10, &intv))
 		return -EINVAL;
 
 	if (intv < 0 && intv != -1)
-- 
2.51.1

