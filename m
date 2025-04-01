Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BE1213230
	for <linux-block@vger.kernel.org>; Tue,  1 Apr 2025 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540559; cv=none; b=Qm54Eg5U9wbEhHbmZ6aGnCYlouzR/H4RCe4Thk9tThSs62tg3/DDbnA6JW/kCENvV/5GmOVRPfyYkB48Mff9TsjEJyPWBNEMj4NWrJlav6WFqN9SvyMwWR6RywsiojdBzNtD9VX3csBipIpUGNvuEtiDhC2mOBup/gfRhcUmXFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540559; c=relaxed/simple;
	bh=7f358SFWcNF01KixZAOdk7JW7C28LBiBgCh8D1STrA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ft3GxPUbnRntT98pbqp5vmF4AluosU+oNXMAvTiJMAWjXZPoIBm1tFkMVDMv9DLtYguV086fjKgzeWuumWBo+t8GSw633WrjOPuPUgqjHxuwu/mLvHkohG9DRR1mCuYMqriWFubvUKKPNu13pVj7RzyTft3QRBTGpRw0HPrbo2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VrE5U6Q3; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VrE5U6Q3"
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-2b8e2606a58so3102845fac.0
        for <linux-block@vger.kernel.org>; Tue, 01 Apr 2025 13:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743540557; x=1744145357; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mGgBmKURFrUHto8RQWqSBytYldTDlTLz4TpMdWnsHRk=;
        b=VrE5U6Q3jvN+w3UQAiz4r405izZrJbr09mmkkSjtT61ljyZh8H4pIf02vTXg9EgF8P
         6WhR2gd/S8rG2OamIX2SXBjPFGInmXW5E7o8UMs/zsyO8rpV6lQSAAJlvapVmFTogMaD
         4kZpycgDU2u++PblsadWLSY7WehCx3V0Px4l6KvQ9BZ8ANoUKZ7hlVFyhqffUUtUXMjA
         zMfe4pCe5iQGlOzbLcMLNvIzUDgmM/ZviLXuSXAmlhOH2S5R/9KfJaSSknJg9GkQAJMZ
         q9HfMoJjQCfEjdBiXw1aDSJWmOAPgAi4fQkWGhoCDOfWG35wUwtP1WnlEt0V+CrWl3Au
         s50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540557; x=1744145357;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGgBmKURFrUHto8RQWqSBytYldTDlTLz4TpMdWnsHRk=;
        b=Zh0llauirvrwl4E/wS4uqFB5kyOSorRHZMsuJPcGOPeLmzfNkgUB7kwBy2Uf7aan3E
         98qkhCfumVaz2cENk5AAEl+r59mfWJwEqrBO/EYXbruOhEZdUYFZz0ZKmu/JU60cvNBx
         4VvWeIMnxDV8h5cmF5ycMHUt+gawN4eZ8i9UOc3nZt1OXghzq1EA20Aq0iIj9nM2cX6F
         YEJmbqvz5A3VFKagirbeUcv7fVd5ZORhvweaQBmhGVVZNb8if1eKPJn2DR6P1mRrm/Hr
         OoT0X20U3hRkNSEvf7vXFJknf8AvSN7L9a1c8GTSthDNMjsJ3qw1yqhY1jYnRPAUH+96
         F8Bg==
X-Gm-Message-State: AOJu0Yy40MMkb+/PRRwaAicYlLp6DUZcij3xTkT4vUQR8we72lNW6NMz
	3BHqUyPOiH0NeDZ7YtCL/+ZRqhNaiSND6bDGPowSlGS4B9NtLqFoX+jZBiLpMCs8XID9kBtlkFJ
	mp8A0G7Kfk4w98uqb+S5TeysT1z5WhJP2
X-Gm-Gg: ASbGnctKJN8r6zjendR7d5je1M94TTYSZpRsiHnB/aniYZv4lcisg5SM73WAEeBerfS
	QFSRBd+TmVyFloQqmkcwn434w4BaFtpSP9fXDEULGngN44FtJG+rVFbOqU4cjBQ1OTUVqQqWRDV
	s6x2gqHWQoPhOhgtuuI8Eldb7BoFwzrm4uA5+2GCHHHVU3C66oex+c0WmIOMpIPwKFhVqTT018d
	ouqGHpNzygFifDozuU3qwba4tVjQFpQr6fHXYXCy6zgrBEp74ztRzKhvhpMdlZXIDk/7Do3nsxg
	nCSQ5XP1mkvRh4cfhC05uwDhEzFZ/fUo6cWzvmGs7phSOGihrg==
X-Google-Smtp-Source: AGHT+IHT7tuEyz+8ZJfFEve9qQLewq55VRij2JfH0oFJeVdDPpIS9H4oxcQmw8lVwKWstaifysOw9lQ/JNUK
X-Received: by 2002:a05:6871:a583:b0:2c3:f8e3:bdb9 with SMTP id 586e51a60fabf-2cc38230b64mr2788695fac.28.1743540556932;
        Tue, 01 Apr 2025 13:49:16 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2c86a3d3c80sm566879fac.5.2025.04.01.13.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 13:49:16 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 18B8F340351;
	Tue,  1 Apr 2025 14:49:16 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 0EC2EE4161D; Tue,  1 Apr 2025 14:49:16 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 01 Apr 2025 14:49:09 -0600
Subject: [PATCH 2/2] selftests: ublk: kublk: fix an error log line
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-ublk_selftests-v1-2-98129c9bc8bb@purestorage.com>
References: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
In-Reply-To: <20250401-ublk_selftests-v1-0-98129c9bc8bb@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

When doing io_uring operations using liburing, errno is not used to
indicate errors, so the %m format specifier does not provide any
relevant information for failed io_uring commands. Fix a log line
emitted on get_params failure to translate the error code returned in
the cqe->res field instead.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index d39f166c9dc31721381184fb27d68347ecab81b6..91c282bc767449a418cce7fc816dc8e9fc732d6a 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -215,7 +215,7 @@ static void ublk_ctrl_dump(struct ublk_dev *dev)
 
 	ret = ublk_ctrl_get_params(dev, &p);
 	if (ret < 0) {
-		ublk_err("failed to get params %m\n");
+		ublk_err("failed to get params %d %s\n", ret, strerror(-ret));
 		return;
 	}
 

-- 
2.34.1

