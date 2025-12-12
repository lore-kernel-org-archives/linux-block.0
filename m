Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C266D2D593D
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 17:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765559832; cv=none; b=HNf//yipzXk7ezBKKLJEhh3x/Xn+rOoEKLKGS4mdGxEy5jgGfdh+p3PF1Vy+P3HNtYIXxCKanaR2MZ5D3PQSmC5lyrJ8ubZrDx3UbCLnEoYRwRKi4goNuI3CgjgMRXejCRoqRVB4G+O2Fx8lygLL0UGh6OWsmwgHySFpEHqCzno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765559832; c=relaxed/simple;
	bh=hMDvcWZRxsHgEupNzfRaoWl4qKW471diyO0Q/xWeRr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtTVF7vSJrZh4MoV0g8JMljV6Ne2TibTXzw3nsRhFuoxUfUxO6rDwSPK5+K01djFTQ1JNUkP5/q3szWHKZPfyqRbCI737wuRVdvYs7vSPCTdef+P7FC8YmhrJhW8CCqcyo5LbUBZQo5ozNB6XJ2Qqdhcjvo7mukr4MrZOfN+DqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Lz38eRs1; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Lz38eRs1"
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-7baa5787440so140286b3a.0
        for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 09:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765559830; x=1766164630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vaZfyTagTLiPkyNwQyOOZqa8fNIA0b68wD31umuEqc=;
        b=Lz38eRs1KR93kotP7e4HhjeUYRRUJMQ8C5T0VOG8Z8v2OUg3DYyUK/DOSNpXPsja+9
         Gp5AlKKxs0HKjK/9XiqaNLijDpVuqMvvnPfa1/6SmSwlPIJf0vyy7YeEcHZIZi5ApIVl
         CxcmK9JbOR0mzJ0yHgctBSGntLXUbWTSazjx00waQa3ZdBPQMUB9xhmKn3i+gwuUZ3vq
         eBOQaJOdELxID/0ShJZYoRg84TIIQSSBoy3DF3N9ox+RM9WMpVucBiN97YaRWac3sVC8
         8X0GBMAS9+N/hsts9t58GKWeIsVvasGRYzd7BAjMF73B1+mCMl8SRqMufpowzLY2cRsY
         UAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765559830; x=1766164630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5vaZfyTagTLiPkyNwQyOOZqa8fNIA0b68wD31umuEqc=;
        b=OPLYLqz0a73ZgzjpaiK/2XmpSTZkZ2xL3adBfzNdS5Uv2swbsFXulHoOf4XtXb5z0q
         JuaYTs1ncttbtjDB/A+V3NhSNbNce8tj5zaoV7EWBqVIgcLqHA3jJxsNMsD2AO5uD5LY
         J9qa+J1Z2/u19muP89yfoNRKAVqn+NbcvtrSWMpaJHfH3QCTDWQlj4Ffg/eJ/aGRfg7r
         xisYEd+ddr8Y5G/NcDdk8N4+ihGUyCDYRFcKlXw1N+4TDggQVhnWdGXQB1Ohp0bupcvc
         pafJZ5+wHpQbH+z99JI4Z77e5c0kK8mkZDz5+jfpho77Aw9DyX37RfOvkK6jcECfb5Kl
         nr2w==
X-Gm-Message-State: AOJu0YyzOHgft/iu2mdTdpkxG6OIhT98VeSlfgmkvZ+sKo4Q4DbZGa2J
	aYCc3BXVwQK/lkkvG//cChUU0PR99Ew3mVVkFx6BLviGevRzbczHfmQwij6uuyEQM9FvaXXE6dR
	QlPkywZDdVyubxzrF1SfMF3zsb9A4frqSbmW7
X-Gm-Gg: AY/fxX42+O2QLVc7qUPheWuPg5hgXNiRxTtDSOtId6K4YqlN7849ZK0ek0F9k/Qyq7f
	/UfFofTgtrrcxF5d3v22lZJgrV4GfnN2A/yYpyJaP688sU5P6pEEwwPCT3SjnZ71rjhMlbscLoR
	ANswW63UQmMRK8EORwd6piODVfvmPlwpbFsHbrxe+yvxFWskCxkAYdYsn9Go4llxK44I3BMRIUX
	YQu5/DhDfMZSwgKboUjPG9HvHVpgS4kQfxcZPBa+lemyGEldufvXIJyhjISuY2SNnNpe1G/nmWD
	X2BJgO2bGHr2UlffyesWf62YnZk5BKovJe49tj0UEpN4eAqdPFq125uDT8LsQPoVoLyk/0VDVFu
	/xb6u+sKhB2AcfZw/45SaMU3Xd+/KSvZ2l0cueNgM3g==
X-Google-Smtp-Source: AGHT+IH96LAecJgAV0OtPDEdr6lLIdVq3cjMdIk0JNIP2zsFKZMrRSd2mV+qKmbyfAADOWtK6riDrjBkekWW
X-Received: by 2002:a05:6a20:72a8:b0:341:29af:3be7 with SMTP id adf61e73a8af0-369b05be897mr2150111637.7.1765559829956;
        Fri, 12 Dec 2025 09:17:09 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c0c29639704sm672529a12.9.2025.12.12.09.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 09:17:09 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 6151434079F;
	Fri, 12 Dec 2025 10:17:09 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 5F518E4232B; Fri, 12 Dec 2025 10:17:09 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 3/9] selftests: ublk: remove unused ios map in seq_io.bt
Date: Fri, 12 Dec 2025 10:17:01 -0700
Message-ID: <20251212171707.1876250-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212171707.1876250-1-csander@purestorage.com>
References: <20251212171707.1876250-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ios map populated by seq_io.bt is never read, so remove it.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/trace/seq_io.bt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
index 507a3ca05abf..b2f60a92b118 100644
--- a/tools/testing/selftests/ublk/trace/seq_io.bt
+++ b/tools/testing/selftests/ublk/trace/seq_io.bt
@@ -15,11 +15,10 @@ tracepoint:block:block_rq_complete
 			printf("io_out_of_order: exp %llu actual %llu\n",
 				args.sector, $last);
 		}
 		@last_rw[$dev, str($2)] = (args.sector + args.nr_sector);
 	}
-	@ios = count();
 }
 
 END {
 	clear(@last_rw);
 }
-- 
2.45.2

