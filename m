Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ECE33CD1
	for <linux-block@vger.kernel.org>; Fri,  9 Aug 2024 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723185748; cv=none; b=eXOV+e4gkoDFIjTETwPSfZIjLIL8yuFAeZgpexhSLL/SxQ73zocBJdMFK5z2r0ozQeLrK/ziq+8Wjb8R0IxsnYJ2PcFbHa7nKMpf1mZHGUephl8KiglqbeFlccYZa5YtXRxd7dvEJeyVgkx6Ci0Slh8BcG8Mc0GoLv1Kvi7koOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723185748; c=relaxed/simple;
	bh=HholN/+XdyMinrqUfy63uVJsuU7d+wbTPtlTlhrsKx0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gYlGVTWSzfvAUKy0x3QStVoRJP6jhf/v/TUCI86THpgc7frxspTevvN7WEhUuIY8KCbSVvUFWYkAi7wQ+C8wLk1FC/cgavN5n67ywg7NCuTBdUJsljFGvKh9sNe2J2xDTS8pEj412bm/EbDP4fWvb+wOtGTZ10Cql1zxm32VpG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A3Upvgbx; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A3Upvgbx"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4281310bf7aso12182885e9.1
        for <linux-block@vger.kernel.org>; Thu, 08 Aug 2024 23:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723185745; x=1723790545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ycWHxy08yR7R4gUQxQ3NP2HVLqXqLgVRiOf0Wrc6YeE=;
        b=A3UpvgbxTYV3V0V+GQZSf+KZ7h2PKfLbb2Sp+w0tAbK/rz4BOCWJdw++UWXXTpcGpJ
         cQDDaUnpprgBnD251lCs4mD5N0yGKzeqjI9oRNuJXPrFpaDSmupKrcK1d523jR0mWZPj
         YF/qM6N5/qrnCtaev4aQgJpuBQazvf/zeLgNYzL3mc2u28EhAE+F6fL0mkwtUJ8RNB+z
         ceeLta1IpNanxGE8VH0XMe0HCdrBTjtYd+Mxul7ezrHwAxQFMJ59t0+Hi/gwDC119xg3
         uXLsHl7kAgSxCJEkyjAidklGs9EeVUInz1AOgMNjp6OrpzYzsaPQuKUvGyBqZQj4y0CB
         X77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723185745; x=1723790545;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycWHxy08yR7R4gUQxQ3NP2HVLqXqLgVRiOf0Wrc6YeE=;
        b=m3Jj+5S5g4ChYS608VZW9W0GaO4KMQBsDwXiOeB+jYXAi9cfOFuGlOKL669030IGml
         ukBFsKSGUk4S74S7l0m4u59Drsal6+S+EoUZt8/BnYA2keRa1SMQPzPrspgw9UcHUtqp
         QBcfy9eUyHs90rkwvcOX0jC8IgRgufQN3EaJdjjOrveUHSRCQ8gAbmBGGjQ3++Td/hjZ
         ezv47cJnL1sKxGGkajMZlN/izjZO1xYhMIegwoyPnxnnWED5wW4th3cJNXjvKUj+AqJI
         F4ycNGr9WlXNy2I9Q5srVwG8n7QSp6vC36Uk1zcSdrNPCbiI0a+G/DxoaNjOqY2lX9T4
         /sAQ==
X-Gm-Message-State: AOJu0YyYrtCxQ/xoWjvOWgRmyBbya/Dk+xDahWX16dxKzYCCYkjNGkQS
	eJb0ZYBW3xUthOAXkNAQRVKJMua4mREgbjh4BgZz4h6GODvmoZ9UvEutCSdmRsPAM2MS7wIbODz
	lIPGVmM9qAbPvVw==
X-Google-Smtp-Source: AGHT+IFQkj4oMuGjXzErYfkKCkm/h2A8MyaTmrLJIibB0GRREzpqMzzF5KRDGS+wu9dVXLR5StKjDEzve+YWlD8=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:35bd])
 (user=aliceryhl job=sendgmr) by 2002:a05:600c:3c84:b0:426:5c35:ffce with SMTP
 id 5b1f17b1804b1-429c3a5b035mr21605e9.6.1723185745452; Thu, 08 Aug 2024
 23:42:25 -0700 (PDT)
Date: Fri,  9 Aug 2024 06:42:22 +0000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=810; i=aliceryhl@google.com;
 h=from:subject; bh=HholN/+XdyMinrqUfy63uVJsuU7d+wbTPtlTlhrsKx0=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmtbkDvrPOy3Lva2fPoYFKULqo/X6D5Zi3RRhlk
 ry/UBhYXcKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZrW5AwAKCRAEWL7uWMY5
 RiijEACLoqDuh3y8sO80/Q1j8lzQaTjTaa0hPkpGfrfC1YwA/b0BmaXZQmmviaUOOid5VZg3Gqv
 jA/dewKNo8X5UsHZUKWBEeDRLUkgzmx4QKkjSidfP0o6cBH35pNHnA/Mtpyyxz93nYehOkcekY3
 MZcQFnGHTRfA+HYJireDVD5UinWQreqY8ExtsfkWaGUOEVCX4UxljxG7hcageZ63lFtryFnWs9p
 zlLyV2OmnuWWx1DwWQimzXfa4q8v4xufKX5SDHzMQv/08DtRADcw0GXqfQgIlgH89HXbgiT3Nbd
 EWcgw8pH4SwieSNzSHloQtHmpivcB7o9ncAfAZT0BjV73ff3bOnk5dBaxZboOtRr1SKj+2QmDTq
 BDaUJ9Mx0fVj7eIjRStcG/y70vlwkvtf0oJfLodLr08QlCCQFv11bSdD7jQz5YNS/2zqDyE4F+i
 XB3UBjoxJO2DayItBI8jCX0XFrjXTu6Tje+nzHQXV43vxt2PdhImSW+4OrBY4dLwJM3dCetTmTB
 z4fq0N24xb22DnYn9uXE4FrevRXUzB4N0FJUtcq8KbiPGYexOflp98AO86Hy/MD/WSDAGwI9bnP
 G8l1pnhqidmRF7tUtDhIxQ+bvouAvTqrELf0Kq0pKOeXfdmkPmhlmHrmvXD7CUry3bqQCiCk0Yr EP0P/bXtC8W9ISA==
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240809064222.3527881-1-aliceryhl@google.com>
Subject: [PATCH] rust: sort includes in bindings_helper.h
From: Alice Ryhl <aliceryhl@google.com>
To: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Cc: linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"

Dash has ascii value 45 and underscore has ascii value 95, so to
correctly sort the includes, the underscore should be last.

Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module")
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index b940a5777330..ae82e9c941af 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -7,8 +7,8 @@
  */
 
 #include <kunit/test.h>
-#include <linux/blk_types.h>
 #include <linux/blk-mq.h>
+#include <linux/blk_types.h>
 #include <linux/blkdev.h>
 #include <linux/errname.h>
 #include <linux/ethtool.h>
-- 
2.46.0.76.ge559c4bf1a-goog

