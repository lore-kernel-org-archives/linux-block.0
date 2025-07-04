Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8471C2080C0
	for <linux-block@vger.kernel.org>; Fri,  4 Jul 2025 05:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751607678; cv=none; b=fJFJNflUtUh3yJmFD143jXe0xJzP3PwBKKxC3LASAtiR9tjKYXSr0vDic11yl968SwjRljRrDufq+y6L2znt66wCws8qaHp9wVLcYPTPNA3pjlBh/NseGYvvU12YkZuMQ4kEWsfPlOfNIEVZcrGIeZOU17yIZAB/2+kzRy7/Z9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751607678; c=relaxed/simple;
	bh=ZpEbESBZW8O2O6g0jyprqru9JBixE7wWH9Tk+pSe9uc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K1IQqz9cJ4iNdCjIbrFrv9L9y0ZCY+eZgJFiEUoI/q/TpvwFIJmMXod3GHtSIYNXJ+AQaZBhIfryhamurRXhTdwT2hkmGggB8i5+J+045LBII95saJk48nJ74QQw6Fd3f1A21e2I456pBm3X9p/+paqxO6qsyo6UOAgMAqtQ3V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Igvla8t8; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Igvla8t8"
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-86d00ae076dso58576839f.0
        for <linux-block@vger.kernel.org>; Thu, 03 Jul 2025 22:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751607675; x=1752212475; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6CSObR2E21Qmkv7k2/pRD0kdbXiykqAPJCSZl0967hU=;
        b=Igvla8t8seNLMzFGBeOHNpfHcgV0XnwbZWi8+xEdIzDCf3Ty2iiRygp40cNVklSEp3
         MPk4K8S2WVNuFuI874ER9XEcP8fV9lskZqHbBs9qUBJSV02itfadBMjc0D2riXhOSt2f
         JukAgid3EVhjr0ciCtZbkSyhlhK357yFNi7IOJz1dTdOPJY3RzRniEa+8a0ebCUZERSf
         9wdNusNcCdmJAmsfeG9WmSwI4+2eeCqh4nuKIdwIYI8Jc0XKvuvyzJSNvtMmuW+5Finq
         CO6JpDEvPs1LZq4h5lMMv4fHmxKAGK1sMd2bD9h0yZS9OT2SH2khzYc7S2qHb+Euh9vr
         cpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751607675; x=1752212475;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CSObR2E21Qmkv7k2/pRD0kdbXiykqAPJCSZl0967hU=;
        b=VkeYAtco3Jbqo3NrCCk1AQI7gr2Ks5tton0rLZGO7luWgU7iQECHrDtuLHXayI0xxn
         vKRTWStgYoO7cw+Q0yOGJUEo5J4BYxbOw1EkHxKsYFkA5sGAu/9Nv4DFdACPWC5as+h1
         MOx5NL7tJFi1izcyW4lVnA3TCe58K4cd2He4xeLxMnTAioA3V6b9+vieG74oZFGFTzKW
         THJ+tME1EJSwwTbw7wOJmvFqe1Zj3DxuRZgBlHqnK7yCWEsDObR7zWpYgW3FfLSc7x2q
         Iv9llE6IJ/h8Mlu1JFlTbO5okLtP3LQplC/5nnjRBsMaaenxfeAO3SIVsYZcWrMc49AJ
         6HgA==
X-Gm-Message-State: AOJu0YwOMeZFm7iEjvm7oaQvCOBvT+6bKIP0ZRt0LIpfod6kNK1Bzuc4
	xQqT2YfkmqoMOyrvDnz1e5yJ6r0CRDnZkPU6fkz26ymXeTL/Ao4rqwNzmtegUMYATIh1QT0cqVR
	0lkN6YLWMUmI0dBrNeXskqRWJI2belCHCQuPzVOUJGVVhyVmHo1cx
X-Gm-Gg: ASbGncuj0zQL9FyrDVAcDlglc+qXB9GEwpiKxEIDWMJCTsfif7N9Pyci5Oqg8Q6RatY
	+FW9F0rrqyYpY0cZLjSlGFNPFiP26WzEWEx6DF1tI9SoJzDr/OsnIOpIqnMtIMf/wXRGMV9S95S
	q1EzUkSS1WWbXnHlTZcb+EBBAjA2+x9u0WzpJk0tJaIVhmzxOSLlwHs1Xv+wUwfiyoHx3DG30tz
	onJC806MFlxl+5hmnb+M+PardrXmTbrkPj9WmwlZm/etzBPCrZN2gcn3SZUJCoIvnWxlTdj+LDb
	cgyw6DnhACMOFP0UNrYj2c6XLKGchpiO1cftvQ7Pcg==
X-Google-Smtp-Source: AGHT+IHBR4027FaJ3flrlnIhAyFQVaOQYfC7kVdfOzhrPSSkaEnv+I+L6AW+RwMd8jbTTl6OaOITpm5JmUTi
X-Received: by 2002:a05:6e02:460b:b0:3dd:a0fc:1990 with SMTP id e9e14a558f8ab-3e133be1ebemr18863035ab.3.1751607675543;
        Thu, 03 Jul 2025 22:41:15 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3e0f9c295b4sm841125ab.39.2025.07.03.22.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 22:41:15 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E5CAE340355;
	Thu,  3 Jul 2025 23:41:13 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 7B599E41627; Thu,  3 Jul 2025 23:41:13 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH v2 0/2] ublk: speed up ublk server exit handling
Date: Thu, 03 Jul 2025 23:41:06 -0600
Message-Id: <20250703-ublk_too_many_quiesce-v2-0-3527b5339eeb@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJpZ2gC/4WNQQ6DIBQFr2L+ujSKFWtXvUdjCMWPklawIKbGc
 PeiF+hyXjLzNvDoNHq4ZRs4XLTX1iSgpwzkIEyPRHeJgea0yhmtSXi+X3y2lo/CrPwTkiyRNGX
 dMVkyiRcGyZ0cKv09uo828aD9bN163CzFvv4rLgUpSFWharprLphQ9yk43Cuix7O0I7Qxxh9dO
 mj5wAAAAA==
X-Change-ID: 20250627-ublk_too_many_quiesce-937d6c36ce46
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
 Caleb Sander Mateos <csander@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Recently, we've observed a few cases where a ublk server is able to
complete restart more quickly than the driver can process the exit of
the previous ublk server. The new ublk server comes up, attempts
recovery of the preexisting ublk devices, and observes them still in
state UBLK_S_DEV_LIVE. While this is possible due to the asynchronous
nature of io_uring cleanup and should therefore be handled properly in
the ublk server, it is still preferable to make ublk server exit
handling faster if possible, as we should strive for it to not be a
limiting factor in how fast a ublk server can restart and provide
service again.

The first patch contains the functional change that speeds up the exit
handling, and the second factors out a repeating and error-prone pattern
into a helper.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Changes in v2:
- Added back ublk_queue::canceling to minimize number of cache lines
  accessed by hot path (Ming Lei)
- Added a ublk_set_canceling helper
- Link to v1: https://lore.kernel.org/r/20250627-ublk_too_many_quiesce-v1-1-55ef9d80a6af@purestorage.com

---
Uday Shankar (2):
      ublk: speed up ublk server exit handling
      ublk: introduce and use ublk_set_canceling helper

 drivers/block/ublk_drv.c | 76 ++++++++++++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 28 deletions(-)
---
base-commit: e74a1c6a8e8af2422fce125c29b14f1d3fab5b5c
change-id: 20250627-ublk_too_many_quiesce-937d6c36ce46

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

