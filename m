Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.213
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452469;
	b=OrX9ueXT6h9bge4v0Xd7Z5NcXG8qqBpoV9a51n11uQou/A01mY30Ow7c6r67WN7hEjow
	 iTqfDF0iX67DvTjhqFE7uB2q9ho98OHOJ0yuVfiUPQyEpmnyzx+E8Z2vUrdWYTXRaBELo
	 h0T6EG8HneXlrVZSvOJAOo8BujF4tszHobFU6ONdtu0ZPMIem9T7YXGEPlLuH1uj4n5q0
	 QGUGQOZtgcQ66QvS14kakZve2LxZJrovF3DHB5B+6JgsIKW34n3vQ50SJK/dgfwHqDE7R
	 pzvdznQ29f9M804dvd1zAlQ+QeXtmnJGe43UyKcSTwgdKxS8FLTz1jdVq3v5+xfDdnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452469;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer;
	bh=O5nA+1q2Ly7KhI+4W5hR1wKCh5D14tqesJy35vJZ96Q=;
	b=rCPzS0GubKST8BMKXZI/qRh1aftRHspil0CzEwJQPvwHxRPHNB3W3EDHqMTEZ8ecpJwm
	 Dfr7nGzXBIUCWc6x+chuVGf8jz3u7X9QeFrElK0WZT69BLf5lG7iSOGkDoEXK5YpkerM6
	 k2y0recnPWEoESNRZH2+In4I/zq46cP7HPo8xUR7COucTeKrg2UY/e9VZQNMf1K6zpoNm
	 N0QMQ9+0KzzeuWQxvMLhPjW7WE6T/WxWHMIkm9EhhJz9u/55hULCeN4xGOISSwLZY7J4J
	 W7YnIy8Wo36BGZsczs+D53RR1Z3WPggZRFDobrwIDxezEwL8KWXWr/V1A8IHf1RNu4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=n3+AZmDG;
	arc=none smtp.remote-ip=91.218.175.213
Received: from mta0.migadu.com (out-213.mta0.migadu.com [91.218.175.213])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84265606A31C
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 03:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84265606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=n3+AZmDG
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xQOp8E3Q1twQQOr51+f1UmfFBIcTlFk6WwjvK1VznqY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794452466; v=1; x=1795057266;
 b=n3+AZmDGrPe9wqCDjY2sfFAF8k4F15byuD2zxgVOoRDjUEYA17IrTLrSqFQ8ihwwtCQ5IN8l
 CMurPCIVadZWv7NcSy7CW1g9gtA5q3fVEP07dKjClWxt4qnmFAyzEERapYYjiJviY69hUOS/9X1
 ql80AXKd2vFTPbfYlHn9nldY=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c51555cf0ba76343;
	Thu, 12 Nov 2026 03:01:06 +0000
X-Mizu-Trace-ID: c51555cf0ba76343
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Subject: [PATCH 0/2] block: make rewriting the current I/O scheduler cheap
 again
Date: Wed, 11 Nov 2026 22:00:57 -0500
Message-Id: <20261111-bug-block-elevator-unchanged-v1-0-583198bd4e21@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOkr9WoC/yWMQQqEMAwAvyI5b8BWqOJXxENtogallVZFEP9uc
 ec2MMwNiaNwgra4IfIpSYLPon4FuNn6iVEoO+hSG5XB4ZhwWINbkFc+7R4iHv6fElrjSFNtFFU
 N5MUWeZTr23f987xKlWWZbgAAAA==
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, 
 Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>
X-Mailer: b4 0.13.0

Writing the scheduler a queue already uses to queue/scheduler takes
about 10 ms and freezes the queue, which stalls I/O on live disks every
time a udev rule or tuning tool sets the scheduler unconditionally.

Patch 1 stops requesting a "none-iosched" module on every write of
"none". Patch 2 returns before freezing the queue when the elevator
wouldn't change.

On a null_blk disk (median of 20 writes, all kernels measured in the
same run):

  operation                   base (ms)  patch 1 (ms)  patch 1+2 (ms)
  none -> none                    13.09          9.06            0.08
  mq-deadline -> mq-deadline       9.19          9.14            0.08
  mq-deadline -> none             12.00          7.96            7.97

Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
---
Qiliang Yuan (2):
      block: don't request a module for the none elevator
      block: return early when the elevator doesn't change

 block/elevator.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)
---
base-commit: 79eb6679ef6a0d5ea68da53a8321fb1dc72299b9
change-id: 20261111-bug-block-elevator-unchanged-a6cd2d761d38

Best regards,
-- 
Qiliang Yuan <qiliang.yuan@linux.dev>

