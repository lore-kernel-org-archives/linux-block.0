Received: from mta0.migadu.com (out-213.mta0.migadu.com [91.218.175.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9269545000
	for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786821109; cv=none; b=jU7GSntQXy61rHuk6C1zsOnkGLtF/AeweEBGqJWDo4a2rPDO0uoJUrz2jboMulVCW9pEqCx5By7BmHYijREG9VRxtvzZ3cdaIWfiUX6liF18fGymwUq/FM5jSCjbD3CX99uk7seb74kKRGEZ54DgC6kJlY9M5f/mvRw09cuJHfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786821109; c=relaxed/simple;
	bh=cDUZPm63d7+H8ZYqrNGqRmeOC4yvjNbkL/CUpu6HBWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kw5e2eZ9bZSRwFREw7kdmZh/tZKbZu52rVV1Wa2VViBfDOgCMztuY54EgSTVJ1rWk1OQljqLTj/20qoRKjuNH4brL+ZYz5qv1Wu2Ok8ihug2VfAWecPukLAuEEdkFq+IQ5TH54JBVuOCOv0Rj3Th8q9yufYEdjbivRExiK+V/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u3f6J3rq; arc=none smtp.client-ip=91.218.175.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u3f6J3rq"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cDUZPm63d7+H8ZYqrNGqRmeOC4yvjNbkL/CUpu6HBWg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786821104; v=1; x=1787425904;
 b=u3f6J3rqjBaxZkWDB5vIoJ1DYsI5MNd9/HxopChCLztuC32lwQGoHnP4VBO/2mO0hypWsrjn
 yqHAvxlsKv9euWVPWsAf5CBFHe9wIa80IBSmfqOlyYjoKVh7N4G1sCpTeZ/pq5wuIHIyV7JvcE/
 9C1+8iI9FZAJMR4kJoc7w7u8=
X-Envelope-To: linux-block@vger.kernel.org
Received: from dragon-master.speedport.ip (2003:fc:df23:7a6d:8270:6cd8:72a6:a586)
	by smtp.migadu.com with ESMTPS id 5df5ee4d033f5123;
	Sat, 15 Aug 2026 19:11:34 +0000
X-Migadu-Flow: FLOW_OUT
From: Md Haris Iqbal <haris.iqbal@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@kernel.org>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Haris Iqbal <haris.iqbal@linux.dev>
Subject: [PATCH] Documentation: block: fix the sector 0 error injection example
Date: Sat, 15 Aug 2026 21:11:00 +0200
Message-ID: <20260815191100.43956-1-haris.iqbal@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first error injection example is introduced as failing one in ten
reads of sector 0, but the rule it shows does not set nr_sectors, which
defaults to the remainder of the device.  As written it fails one in ten
reads of the whole device.

Add nr_sectors=1 so that the rule does what the text says.  This also
gives the documentation one example that uses nr_sectors.

Fixes: e8dcf2d142bd ("block: add configurable error injection")
Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
---
 Documentation/block/error-injection.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/block/error-injection.rst b/Documentation/block/error-injection.rst
--- a/Documentation/block/error-injection.rst
+++ b/Documentation/block/error-injection.rst
@@ -48,7 +48,7 @@ Example
 
 Return BLK_STS_IOERR for one in 10 reads of sector 0 of /dev/nvme0n1:
 
-	$ echo 'add,op=READ,start=0,status=IOERR,chance=10' > /sys/kernel/debug/block/nvme0n1/error_injection
+	$ echo 'add,op=READ,start=0,nr_sectors=1,status=IOERR,chance=10' > /sys/kernel/debug/block/nvme0n1/error_injection
 
 Return BLK_STS_MEDIUM for every write to /dev/nvme0n1:
 
--
2.53.0

