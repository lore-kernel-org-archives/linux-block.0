Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BFD2F12AC
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741460; cv=none; b=mJ0geXy3axmMj3b4wsMiQTV1CaandKqokBDZIbW+jiG1zKkkFHCscokOjWnTAmo44YtjQdSpfCPzXeCgknSOR7dmGQigCyhV0oZK9+l3RwLxMky07aNNGLfzdKxLtgsk4hQ2k/OnzuXCbemWN2MThX6FhRUN2JFkaiureKPN/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741460; c=relaxed/simple;
	bh=O6JJX4hvnffxMoqUB/tCn/MEd2BblIZYuRhMwzJneok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O04l5D2G97VxlHfn1+kn/TozaGZ6Bl9Obkxwqjy4aWGb+qPYSdya9HAJDfziLavkcLih9WdaIHQ+xAcM7lPz7CDR1rudQN6ftU86BQVB4aJFFQhHBptnATP/+B3+icXeXTJFl5nzq4CDjozI0HQBQdQCZSDHYgpQy2c8Hb5u6Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/XsaXaO; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/XsaXaO"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76af79f029so376610a12.3
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 06:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775741458; x=1776346258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pb5Ap7y08egZx0u2vj4Be51whl4yIrGQ4HJpVJF8EBg=;
        b=O/XsaXaOlmpkhHP9EWH9o1d6BPH3I3J0f8+1R2EP0Pq59Qy8YaG+hx0Ab3fdH1oyiZ
         g98nd5vv+7vC7mdR4jZCsdS/wAk1hJyY6RWYX7a7JolWIySrNY+o9izS6a5qls8NdXtw
         qWo7Ddemro7FEEfARmLJNo4c/IHypYTTvjfzCcZtlm4R3a7UTgOOGvP83rp+rh4vPa9a
         BayMGX578xjJrGRWo9zaJWx1fPvnJGnbmmCDNiccXxdDvd5FTpRh1zFiMRV4OzGo9dk+
         LowFiGVnRJ6g7Y3AKZW84f/VL6XgJK4uStBykdiB9cX/E/jKuU2bZNEFCaKYZXpOO1Ss
         BMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741458; x=1776346258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pb5Ap7y08egZx0u2vj4Be51whl4yIrGQ4HJpVJF8EBg=;
        b=mww87XtMCf4w+t63WuNRP67tWjQ8aakHnK59E+o9PBtm7ORqGUU751gLE8Q8qbrbCK
         kFXww0ONj9GLIpKIE23jDhwTjeLx4xA888KecuV/GoA4uFsb1DkIztvQXzDOP8ejPmkx
         Z9jd56ZeIvpwfzYA/lihIZRgOerKKC32pDYPy8rx6YncVfMjbcsELG/vmJaDEuwq3ZeC
         /+xt5y/nwoj7sqEx6yng/2y/03N+2HDw/D968igovCgxq0PXn3zhk0BZiOMC2ZxFw3Gd
         9knxuMEfc6t6u9UpGEMA+tq77AhjxkbAjgmSEt1HctJfIprL2G91BsR8iNIZkB7ng2KJ
         qk/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXet5GRnF+/LQAJCL9nfSLaDQZEvkMyCBLytnELdN/fpy4amcb2uK+6kCa+tpVahRnSR3S3pck9cdxv8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzATFn/E/ol4DBTRHHn2aVROL8Fezu3+iBdTbmATDXB/PrvOdQs
	3PeyUeNEklbCWY8319ix/GjXBFtROS7KMAVktfJEbTiY8kEoldGL8QI4MrkLur1VD2kq8A==
X-Gm-Gg: AeBDietKkcz9+I3ifXufMwK5yGqegDgAPhdZLtXtgF3oyDQhoq+G65Li8Ba6qOCekI0
	hf0c4g5pqpgfcJzK3TjGMVYtDLCyHVZHaG0hkwio/SPW34FwF89KiZOYFjZ7PXKCG7wJwjOY+kC
	Ga5BFYl1+wVt8DcQbrGf616CIgQOUDavcIanc1L+pGkI4PKWh/eJx6jqkWOu1Bx3nvzZbELWM+t
	tZ0k86rd2QnKXiMdytsfDRUeZqXh00+/hLRsP6/LQN4ZVbr+oW1qYXr4zzvflxjL35DxK95mnup
	Xr1P6c3ylw3lavpgH6+2YJZ+FLOt63l57zQ8MExFzDFlvCEK4F+OOZCcuW8ocs6D9bQelNb0evY
	IWbERZ5U4eANUMfGcF/QV99Weizascyf7EKh+pfJkKI3NkXmnHIDir2KP/reWRqQO6pxKJI3YZ9
	NMLqlGdYEALYh51n7JBN4FKZv0vqu/JPFfRWzGk1sH9M8pF9NmDzXKJuv6jFNqdS9aPw==
X-Received: by 2002:a05:6a20:2591:b0:39c:cdb:5d78 with SMTP id adf61e73a8af0-39f2f00f0e8mr26960336637.36.1775741458334;
        Thu, 09 Apr 2026 06:30:58 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm21021166a12.24.2026.04.09.06.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:30:57 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 7/7] MAINTAINERS: update ublk driver maintainer email
Date: Thu,  9 Apr 2026 21:30:19 +0800
Message-ID: <20260409133020.3780098-8-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409133020.3780098-1-tom.leiming@gmail.com>
References: <20260409133020.3780098-1-tom.leiming@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the ublk userspace block driver maintainer email address
from ming.lei@redhat.com to tom.leiming@gmail.com as the original
email will become invalid.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 77fdfcb55f06..4abb3345bc4e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26992,7 +26992,7 @@ F:	Documentation/filesystems/ubifs.rst
 F:	fs/ubifs/
 
 UBLK USERSPACE BLOCK DRIVER
-M:	Ming Lei <ming.lei@redhat.com>
+M:	Ming Lei <tom.leiming@gmail.com>
 L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	Documentation/block/ublk.rst
-- 
2.53.0

