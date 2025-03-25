Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600E8269D17
	for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941211; cv=none; b=VoCl1L6rfgrWPFBUCqawy7zMOXJRlvXll6B9hVgZhmSZznRiB+M8iIuEW+Wj1aipN/tIqKPsnMGOSLhGtw2V9bPvAtCc99PKKUXnVPHJCzl7+09rH7IkJnq0r64+nxDNG4+AzGh759TIgQxfDXAE9Hv6fJNSDUti8rngID7FRFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941211; c=relaxed/simple;
	bh=nAQdS0kYPrlB0PxMAzJ/qiXcso8pLJA0WH4ER3qHVdM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cfaX1mFJO4zvmtnKvqjlma/gZoivkBIcW3WfisDLegmfata5PgZBvRor+EFzAhAi1ZH+ko86P3/YCWuZWovoubWez6XnoHNvT/MuJhouynLKpOnWl8AwY3b+NPvKsDWDXN3QXBlUq9azIw8FY9YBRMDkyC8h+sQ7fUkNmWq2/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GO+KRb7o; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GO+KRb7o"
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-3d45503af24so56283595ab.2
        for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742941208; x=1743546008; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EiF0TiGkTFNi7Db5MBCoZMxJpvKlB7Oq6RSbWRlclPc=;
        b=GO+KRb7o9uvfGlkG0dJl8zfE7T5grSS261BWMyG9+29f96VK9Gp7VmjB9oPXGyg/mj
         98Xm2OIO/Sy22aEM7s5Cpo6ZcOv4JSuLO6lLzwnKQGaq4Q+wnlHAuTnLAigbcCTFogRp
         7bHeEBu7qQg49IniTxR43ipzXRrj7Gnfgb++wgREWO6DJHLbdCp019hlxzsengwGCRSx
         JmU5dZTuKoyTqidUxnYX4RZ/j4f+xJ8ATV+Sw0yEYYOs11Nv+DvO9Nfn8Rd4unDhtWiW
         E7AjcYyWKBXNeiodWcNJ0iGczggaIZ1cC+AWrztKf9l77uSszVjjqMvLtR1irvH/GEOE
         v0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941208; x=1743546008;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EiF0TiGkTFNi7Db5MBCoZMxJpvKlB7Oq6RSbWRlclPc=;
        b=SmmRWVl+F0VWI9N9g98zFM2WugTydWWRoq4Dm3yFuqmqLAmbzmIFkYFbvfFT2cVT6I
         DFI5CKSzLkoek/FyPMdZtK1HmP1jUSUsgi/bbkxlex91YTagnrZPuNnaR06kHsVjgpQi
         a8TgpfAPoXjd/WCk9+LSPjKNto16CP0akg8gNifn2PQBnl6XsZzebbSyquW0FKrCvA+O
         WvYMfrdeJQfO0KPz7D+uYqjIaM5MVM65lHyubG5g5hDhTdA2ooDnnWFd+cokOOjkZVQn
         yibdtH6yG7M2NrzgNfxm/4Br9xqMi2Y8oXgl6g5N1J4ALeeYBIXeFH14xusJEG5fsT/k
         V/Uw==
X-Gm-Message-State: AOJu0YyZK8lx3jB3iZHNKThACPEgRMi0OVzCZwpRgPPEgsasw0w3VuO7
	I8COWkc+uZk0E8tKWMxAl+0WycW6SUDu7dI6U15BfjAVdnH0mmdsA+4TZF+Shj/CJQMv1hiLedy
	LcoIxzHfscHilGAqVFgBJkq4tbuGEi73p
X-Gm-Gg: ASbGnctarLLZuOGHXBhJjV6b/RkFAKaJ0IwlQXB6GL7bwOzknLMrJbOiZTU0BDaMOrf
	MNnDQyqAKl9wg4NRtgfVEog6eUvwfUywVxcg+WcjbdYKd/paXaQUFkKs2nN5AUkAggOSQR11eah
	z55DDA4OB4HMelfF7LyjN8kWvgv2zkU1mvfqgVnzml5ShpdLBdonE+rGiPlqt3WBYEg4EQBxmj9
	DuZBo61y27yVnHun/g1k6fURKAdEU+zr8X6EjKtJtP7Zv2WscKiAXRAKznLyrY1SaAwqKjiTvKf
	dF9xyK9iEfRwR012tCL5Z9F4ifcLaEAYRBKK2trUIwjbd/+sUA==
X-Google-Smtp-Source: AGHT+IECGuSjUNmFI1yEx79hdLBJWrV2d4PdV+RHCZjyZnEqNWuhCc1Y70X4uB74VGhHc6q3AvLuDGD9FuBX
X-Received: by 2002:a05:6e02:3303:b0:3d2:b72d:a507 with SMTP id e9e14a558f8ab-3d596192691mr215382215ab.19.1742941208306;
        Tue, 25 Mar 2025 15:20:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d59606ff78sm5505215ab.9.2025.03.25.15.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 15:20:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 51D5634041F;
	Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 3CCBCE415C8; Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH 0/4] ublk: improve handling of saturated queues when ublk
 server exits
Date: Tue, 25 Mar 2025 16:19:30 -0600
Message-Id: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPIr42cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyNT3dKknOz4kszc1PzSEt0kA7MkyyRTw2RTS0MloJaCotS0zAqwcdG
 xtbUAk2Sfs14AAAA=
X-Change-ID: 20250325-ublk_timeout-b06b9b51c591
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

This set aims to reduce the long delay in applications reacting to ublk
server exit in the case of a "fully saturated" queue, i.e. one for which
all I/Os are outstanding to the ublk server. The first few patches fix
some minor issues in the ublk selftests, and the last patch contains the
main work and a test to validate it.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Uday Shankar (4):
      selftests: ublk: kublk: use ioctl-encoded opcodes
      selftests: ublk: kublk: fix an error log line
      selftests: ublk: kublk: ignore SIGCHLD
      ublk: improve handling of saturated queues when ublk server exits

 drivers/block/ublk_drv.c                        | 40 +++++++++++------------
 tools/testing/selftests/ublk/Makefile           |  1 +
 tools/testing/selftests/ublk/kublk.c            | 10 ++++--
 tools/testing/selftests/ublk/kublk.h            |  3 ++
 tools/testing/selftests/ublk/null.c             |  4 +++
 tools/testing/selftests/ublk/test_generic_02.sh | 43 +++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 25 deletions(-)
---
base-commit: 648154b1c78c9e00b6934082cae48bb38714de20
change-id: 20250325-ublk_timeout-b06b9b51c591

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

