Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22C18E025
	for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 01:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745630259; cv=none; b=K+aGSKwKnubZGNthzGBupxeUIwUamIqcHOYv6vr4KqN3rdlAKMDYnyUrhoVXsFTwqLsp3ZkDv869UwMBQbedulpskFfqDlx96sEW4oa04IIe6ibzsHraQLTb5TvJ6+H8SXV/Mvvd2+Ic13ijNiVTAjJ5+oI418GPjLrbp7p6jHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745630259; c=relaxed/simple;
	bh=3SdRMZedVNsGhoUkRDA0ELdVBKWAQIbe+N/5UZyBhJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YXvWVUG+8jTc8tA95QE8zt8T6dKXNNDptdHpYL52AzvEWYfjxMSk8bfJ2ReHHNtv8M+t5cOcvxGbwr1eHGnWsO2qHBF+bcgGXq8yE9cI2N0hZI1k27neSmGuvLyYmobVoBJnsr2qvYG1YS0dMh7EnMOim9CSStbPTjoZkBL/b24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=CRKq6wUd; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="CRKq6wUd"
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-6ef0537741dso4136996d6.2
        for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 18:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745630256; x=1746235056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sWoTSB4woNticZtUd9FUCqOsuMx2ByEG0kxwm3khTAw=;
        b=CRKq6wUdni9Qufz8JWcpx+oqWwdfu1gLN/rimX4RX62/QWslIHvisI9aADz//p9xUO
         w3z1if0k9hSiB7Fz6MmPLS9oluk6vFuhx6YnbaXXMmzGpWE0yGQsVnYpUaahnFF+jrdQ
         hNLfoz+cRJqzjrZL1zynv9sGHopENq7zIPNqH5Y5Y4PEtpwmnO9GJVUansPK6lQ78e3V
         BQeLfPPhyXyhak2mrDchBEghTzVW/hRWD+MRL3f+8stmgX4kXImQOuUIAyMusLWoPDAt
         HvmDdhiIA4SkqIXijmd/a+27xKPAUCpuT8+rNzL7fgNtXMAscyOlfnt7qFCS4DyMgG+A
         0fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745630256; x=1746235056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWoTSB4woNticZtUd9FUCqOsuMx2ByEG0kxwm3khTAw=;
        b=OyIO+zHuP5gOu8KVe4QQaZhBx3V/7dOxeNzhCg8jNagtEb8Q0omnocWj9tcM8ZkgRI
         FGL1Yg3n9BQHqNxRn+K9M/6coJYrzeZhjsev7O0TpZK4ADWTpYtc0AdqkvoGaO/qpXR8
         nkw4gq5EMqBkOOEzJrhb3fzOhavAJ/XQHK2aaQ6cYxWcmyU0hKNLuw/aAN8ikWkaA2b6
         WNB9MSrsueAgyk2VCDz2jtKYb4BR5Qcjw/gMmxmY1LMRMQbT3NMgi0PUqKUQ0pRtm/qd
         28YTHe/6RZBBaVzkev7DSrDEGrrIP1bHVh2Y8nwzulUEibiD5DbVE3HONlLqYMA5Yvaf
         6IeA==
X-Forwarded-Encrypted: i=1; AJvYcCX6w5g1eCu/Yu9VKOIGEzx+aFto27EQoJ0jAZstIAOP1hxA6vhC1cUw5CcwKf+iHE5/K7Tc6mU9p95/4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOQ59bWoTaDZ1+MziWCEPX5TUq8ufTALXLqA1CTgkriW2ld8dE
	wRANl5SGE2TmiKnTmRR4WZacQnGZicXS9BRVKZ9TQuE1n5+DecMcdrLdXcowPdH1Pg6xu158rrX
	KPX9/Si9EnSY6VL13OM0qo8wuO915Ovys
X-Gm-Gg: ASbGncvfyVauscZm5M8YEg3g2W861tpvWv6cw4N5LB14ZHV50npKwamBewJfQMz2M7v
	3WBQU1mQYbR+4TQI5oT24PnYBBQeGYeIFM85or8qdV3s7vk0gyYz5d3scDSDwV1pdYZg/S8/ahn
	G5GTvy5TxXyObQMgcRFoS3HG+jK8wHVAQ4htZZ/SEw/+lItHD2magWxnCcB/+mjZhNU3vVc7d77
	laxYy+HofLjFX9hbEXKerYAj2kYnWvWsHR99liueNFkICwdjGju2iklt7TUwtQMHQ4ksev9yt7b
	ms4ffcAuTZ4vAocLP8U3ip/5KjraCE+zBEqTlaAMDa/R
X-Google-Smtp-Source: AGHT+IGKOnOAGNaR2172G+3uzVJGtJ0TwGdbe9ifds15Yrh4dQ+LSR97ANlr718s3pllfYeAXRU6CtDhyvT7
X-Received: by 2002:ad4:5dc2:0:b0:6e4:449c:ab1d with SMTP id 6a1803df08f44-6f4cb9b43edmr27466936d6.2.1745630256282;
        Fri, 25 Apr 2025 18:17:36 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6f4c602821dsm1903696d6.41.2025.04.25.18.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 18:17:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (unknown [IPv6:2620:125:9007:640:ffff::418a])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 476823402A4;
	Fri, 25 Apr 2025 19:17:35 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 40BEDE41BE9; Fri, 25 Apr 2025 19:17:35 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/3] block: avoid hctx spinlock for plug with multiple queues
Date: Fri, 25 Apr 2025 19:17:25 -0600
Message-ID: <20250426011728.4189119-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blk_mq_flush_plug_list() has a fast path if all requests in the plug
are destined for the same request_queue. It calls ->queue_rqs() with the
whole batch of requests, falling back on ->queue_rq() for any requests
not handled by ->queue_rqs(). However, if the requests are destined for
multiple queues, blk_mq_flush_plug_list() has a slow path that calls
blk_mq_dispatch_list() repeatedly to filter the requests by ctx/hctx.
Each queue's requests are inserted into the hctx's dispatch list under a
spinlock, then __blk_mq_sched_dispatch_requests() takes them out of the
dispatch list (taking the spinlock again), and finally
blk_mq_dispatch_rq_list() calls ->queue_rq() on each request.

Acquiring the hctx spinlock twice and calling ->queue_rq() instead of
->queue_rqs() makes the slow path significantly more expensive. Thus,
batching more requests into a single plug (e.g. io_uring_enter syscall)
can counterintuitively hurt performance by causing the plug to span
multiple queues. We have observed 2-3% of CPU time spent acquiring the
hctx spinlock alone on workloads issuing requests to multiple NVMe
devices in the same io_uring SQE batches.

Add a medium path in blk_mq_flush_plug_list() for plugs that don't have
elevators or come from a schedule, but do span multiple queues. Filter
the requests by queue and call ->queue_rqs()/->queue_rq() on the list of
requests destined to each request_queue.

With this change, we no longer see any CPU time spent in _raw_spin_lock
from blk_mq_flush_plug_list and throughput increases accordingly.

Caleb Sander Mateos (3):
  block: take rq_list instead of plug in dispatch functions
  block: factor out blk_mq_dispatch_queue_requests() helper
  block: avoid hctx spinlock for plug with multiple queues

 block/blk-mq.c      | 110 +++++++++++++++++++++++++++++++-------------
 block/mq-deadline.c |   2 +-
 2 files changed, 79 insertions(+), 33 deletions(-)

v2:
- Leave unmatched requests in plug list instead of building a new list
- Add Reviewed-by tags

-- 
2.45.2

