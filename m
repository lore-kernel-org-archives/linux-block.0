Received: from mail-lj1-f227.google.com (mail-lj1-f227.google.com [209.85.208.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4526ED31
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 05:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516628; cv=none; b=i6NDrTnvUOa1PhACgFgMkcTHZbYPzOywkVajLzpWGV0SqL5N4z00gGQvZd1tkLb4NYgulyWnojFJ/PYYGuG78vz/Yiwp6ctfHkB5c/m9gUKwNg38ZPJw1Mj8vaJi2EWWnN7uH5foxZZMJcHZSA0lB+bErfKZuRGqjgNif5DXZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516628; c=relaxed/simple;
	bh=hMDvcWZRxsHgEupNzfRaoWl4qKW471diyO0Q/xWeRr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUzo3WyRITwP64HQpnuxFjV571GH9D8Y+BKB6i+65mBgIMYBcbh0sIj4w3h8Qe9y6VvD/mXgiEFPXfNhajCOB0L8NQC7NibEBbZ0dlbKdszmtAFM6fqLZ3GIhmYLPU2Yb5MgcnPz+6J6RH2wluRBiOwcqojQellOaks8kol+qCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=beLM2HVI; arc=none smtp.client-ip=209.85.208.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="beLM2HVI"
Received: by mail-lj1-f227.google.com with SMTP id 38308e7fff4ca-37a5a3f6bc2so1040611fa.1
        for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 21:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1765516625; x=1766121425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vaZfyTagTLiPkyNwQyOOZqa8fNIA0b68wD31umuEqc=;
        b=beLM2HVIbumy1pdkLCSkW5I9XqEAI/uVEif3tYe8XA1JiMU69e/kj4fxtlVfLnyRV+
         9GIl0Da34eUqhzmUaaNXr6k2HZkwD9BL9fFodjK6PCf/+rvaNzvBzBbg69SXszH5+aDV
         fXKnFOE6CQubFqJp7YpbCs8wZf+oJzrlhrgAlMh9wTfTM3texYCiHI8UQxpSDK8FsHEV
         jpg96jytf3ScrXcYD2te7ySYmm42AGlCf7j8jZFmgS+MOtIUIsdkppn7VQadgpSWvKlQ
         zqoOYytBA6p8wu8lzWqPq8aK5BWGzewGQbu1HtPJ3fS1puR1LXg5ACujU45gQ/eKp3YH
         VnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516625; x=1766121425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5vaZfyTagTLiPkyNwQyOOZqa8fNIA0b68wD31umuEqc=;
        b=wXduWgnt2O8Sbkkho2AtrSjxJFfYt66Sa6xJP5vv85L5oTi9gLwJ+taKOq5DvUKhGg
         gATpswLc6rvzXXb7K16fr89cjoARtYiFs8JuLrKb27l5GoQwa43zATXsilSSScUlHwWj
         Z3XrT6n2C5anF0eOg/gkjMIP9R1FnQYvNLRv59l6133UnzEuA2V94DZX7tnd8nzdUb2E
         kgh47++udcN/esellv67Bnkia6yuh+UMuRo7pVhePgDyOsLQiKp9bClINLqcPg3FDFWB
         9gF3WHbSFi1mONxBBj2uC45KoqEVVW6E1Qml1AcZ/m0/v5rhA2uka8LPNqk0PDvJJLuF
         Rlag==
X-Gm-Message-State: AOJu0YxCsuhzJip3uGg0l7gsl4raddjGYhb6HPE0392Ny2Cv6tioKhjz
	V6A9Pw8ytv4cTPCSLt5As/JT5Gtq2Cf+Unb5FX91H2DmG7FUAqampSJVP/FzPauKSdESzBh1pPr
	FCxSrpWJJbiE40wsIGuIPfJPlPqn3CD5aU9jm
X-Gm-Gg: AY/fxX7HC3Bbo3ISa1QnbauBs3PTU3TtTCU0gxKc4ZvUzr4tZvb1vjKSiJ+SABy1n3F
	0NOzTrifPsudNMoFoqJytU2DSJH+GVNVBDRl60PHq+sn+mi1gq3n2WoZwYp4+mwZXVbgBOpj5xo
	+PVkFxlJX4YYDM51LHAdgg3XtdmNwC8GcX3KyVl6jhjxaKixp1EhqDzz8IsI9it2N0DRe69Wv5U
	zRrx4d/+bXjZOX07BSPSZxDiBgZ3CAptdqneH1Gxmd7+kROEUJXL6m+ai7ElKO3jWzPCefhKudS
	Rplg/XGWm552nzcTQRIxxaKwvIzlf78/xUihwp3b9BWmTj8pdDfD+q2MnMs5Snwdn26rACTMk25
	aq3U7SlNLWRT0qdpAmLuM2qbTa97qq5x2wNDdI3VsCQ==
X-Google-Smtp-Source: AGHT+IGtF7eyo8lXcOR8WUkH9+guQzHvCZGlU7C+InJFwFhMRt+x3f30HEC/DWoVBssc+TB5k2rM71vsdf3i
X-Received: by 2002:a05:6512:10d1:b0:594:2a33:ac17 with SMTP id 2adb3069b0e04-598faa21734mr115979e87.2.1765516624456;
        Thu, 11 Dec 2025 21:17:04 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-598f2f72a24sm939705e87.40.2025.12.11.21.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 21:17:04 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D2A56341DDC;
	Thu, 11 Dec 2025 22:17:02 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id CE18BE41A2E; Thu, 11 Dec 2025 22:17:02 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 2/8] selftests: ublk: remove unused ios map in seq_io.bt
Date: Thu, 11 Dec 2025 22:16:52 -0700
Message-ID: <20251212051658.1618543-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251212051658.1618543-1-csander@purestorage.com>
References: <20251212051658.1618543-1-csander@purestorage.com>
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

