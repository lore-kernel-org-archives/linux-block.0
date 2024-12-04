Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C35720ADDD;
	Wed,  4 Dec 2024 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324697; cv=none; b=aZD3wx89aMiyPRfS6gCQSYoEyfe2VsOSaw+2b+LHcrv5EjBpvcVGrNk4zwC9RyMDjfL5leb1lbxelimRyxy5hCMP8PpVZucMONXbgOamhT/dsuT8EnrzJYPK1on5+SrnSZaRzpNbTUbh5K8U/wXUppQhrMq2u4uPi0lSZ3g8SC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324697; c=relaxed/simple;
	bh=hewadqbWLJKRts95eOYXdwWNooML3XA7/3FBG/3C6lg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZttceMr9Cl5J6yp7vOkA17PHUubHvIzaIpZWgOyKM1plmd0JPCmsZRcftx2zP/UrIwC6Av2ucg2OTySGsuWiSZ+9qu5dBnfCPCjCVCIXyv68E0cgqDCQDZTWmy0s8Ty55wtm0JYS3xQrsRQFQNN5nT6cEpZ2a4wWt2BVtVngGjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7pvPyRr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7pvPyRr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434a1833367so6400285e9.1;
        Wed, 04 Dec 2024 07:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733324694; x=1733929494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EA+h0saep05HaBgoBiILoVwh5Jsa3eA0cCo7gYVbZ2A=;
        b=R7pvPyRrIUbSB/5kgooy2b5aBCjVY0DwgUSJCvVTDU6K8jATal5gN6ul9V4OdaPVrd
         vLxTq2ZuYUI0SL8Qe5YsAuVwVPvesSQ6/tM+dOBV02v8k8fCiZFNrxkJCXpEgWHXb9v+
         nue2kuFm0kLc9bhgDuWnY0FILN22JU1l4/53IFRAPNSltdmCMb6I0PAhmaOzpmkP03Fg
         D/QXISpTPdPMMD/keri/h6q9rzwKFBGJtEHCcantVX/0xQf7MnQeFnSZ1OePnLGvqmte
         xWmyLU+8pbcmBEKeY6a2k+72BkvFz0BFYnOk+Yh4+8IYZ2nir33nhuH89NtTmF7qJzlz
         966A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733324694; x=1733929494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EA+h0saep05HaBgoBiILoVwh5Jsa3eA0cCo7gYVbZ2A=;
        b=uSLajtFj7BgsT0TkwoIhWsvUv43H36od8Hvd2FrYpuYqiF6b76gW4KX/6oQ2RqkEiI
         NZNu8/LWeUUwzhMVgD14UXNS2q65DcrGP1u2ln+VkfJG89RoXIOq/yvlPO/bvizXbUkw
         qXkBo7Xaezxf8xBOJUj2V+2nmhC8fC16eUcJuwEBJKtuenBNPIKprEK8GHNL5OLE1ed+
         meA016dyvc2w8PbwZMnkklZbWgQj+WnJg4rQbLOX34fAkIkCE4vuiAjw0pLedzDL0MLK
         OHRKbKof+TrXaapFPNTt7zGo18Lt7u2+0tmg4DWsR9xxzdqlohDRLcVOpxYnLieIb5h1
         bi2w==
X-Forwarded-Encrypted: i=1; AJvYcCUhSbMpqzO7hmrJ2NIkolyc7mMGR+ILeQ7g4g/YpoC4qPYl9qzDPzjItJGlI/b0BVVDlJIdXd7Au7FXVg==@vger.kernel.org, AJvYcCVJ6koNaLoPv9TbHeu9OQ5g7TZILGDaPTtTMMEZ4hE61L59Mh6ZaVPyzFBzj7NEXQ5ryC77x4pfVfSbxlqkTBY0mJJ2@vger.kernel.org, AJvYcCWocS+p/HBu6vy39TmRsqqzb0McPgorJkJSz0oA0MLnUxDPfBerKUonbabmdwSJNAF2wgmjjbUF4gEF9ElN@vger.kernel.org
X-Gm-Message-State: AOJu0YwQi8ffZ5U67Iyat/4HFBp1mn0DUr/35lVzqMS4xWOh0ba7wZ8P
	9J80fd/068TtPx9RqxKKc/dd6+tLtJCeSOQ3xQSSdMwDiG0gQJGs
X-Gm-Gg: ASbGnctzC6Is0Q/j1u5ZR/pD7ZMDWqf+hsshFElQHa2+zkm6HN2oEJCuN9QtC0wPdQA
	CKQXVcfGU7Epzv4x7xhU0hlAFvJMbTJrB7KhTYfIcc78qR9zGVSbNjs9Z89HZ4yjvfbyLgFUmF3
	ry9oWFsecsDKrT8zc6HIRLRC7lJ0K7PtkX7csmOQRUWoqCClcmdvE4VEIvj7YtTSStyi2MOhYD7
	8OlXRfH39A+JyV1ie4iRjx4iXLMumGVgQWfV2XdxH+cy7nDae4=
X-Google-Smtp-Source: AGHT+IG9QX67ZxBd606G3QR1uTGV5YwZCnPF29rocVK9K7/R3gYKV4ItXJrojh7qMPNmn18OgiE1Zg==
X-Received: by 2002:a05:600c:458e:b0:431:4a82:97f2 with SMTP id 5b1f17b1804b1-434afb944bbmr222608275e9.6.1733324691930;
        Wed, 04 Dec 2024 07:04:51 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5273b1dsm27157315e9.15.2024.12.04.07.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 07:04:51 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ming Lei <ming.lei@redhat.com>,
	linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] blktrace: remove redundant return at end of function
Date: Wed,  4 Dec 2024 15:04:50 +0000
Message-Id: <20241204150450.399005-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

A recent change added return 0 before an existing return statement
at the end of function blk_trace_setup. The final return is now
redundant, so remove it.

Fixes: 64d124798244 ("blktrace: move copy_[to|from]_user() out of ->debugfs_lock")

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 kernel/trace/blktrace.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 18c81e6aa496..3679a6d18934 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -639,8 +639,6 @@ int blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 		return -EFAULT;
 	}
 	return 0;
-
-	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_trace_setup);
 
-- 
2.39.5

