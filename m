Received: from mail-yw1-f225.google.com (mail-yw1-f225.google.com [209.85.128.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF6F269D1D
	for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941212; cv=none; b=qeo27MhpLrf6C9LLypIK2tOfD7us0FClWJOTg4j0LccLIUhhvujdGeMpDU5pRX06Oe9sS/FM7gAblBt7DcN9aRcH5x+NSA0ect+cBrdtPlFQXGDNe5UTsTDDT42wgOnAA8dRl2s+b0lCdUrOU1BJFA6E9XRe5P4ePrpM9StVKD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941212; c=relaxed/simple;
	bh=NeRkZlcvaCBRIUNhcAknsxh2pPI89exFKSolPCOwHZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OrdVYWZrTObsOjtS+M9I1li2xJ7nobbYJmzG8rsukgpoCTStDGnwXVZXmLfb346aNUP/wMiUCabbsR13BGhELoHsGAfnLU1uu07DzlDNNdpy0vJFhwj3nxvb6EdUy18v+cbs34NWOwGKP1HmqrTgxgQA/rHYsiW/Wv3oJqU64pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=dpLTqJz7; arc=none smtp.client-ip=209.85.128.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="dpLTqJz7"
Received: by mail-yw1-f225.google.com with SMTP id 00721157ae682-6f666c94285so59194137b3.3
        for <linux-block@vger.kernel.org>; Tue, 25 Mar 2025 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742941208; x=1743546008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8dONTFM6RC8uRNfo7doEMwcZfV7041orR9CUS1WNic=;
        b=dpLTqJz77dNB2PodaHyDQmKAThY6hSgYyHc1wGnQhVzNj4cRGZ1fSiocj/tpNOb4VE
         ohxLDKa0NYyYGiXyqRxd8ltvM7nNq3FsXXfpdWrU2qnpuwv2x93r90B222FN5s7UGYj4
         jiwItdje7ozCLsXKGb+NqfqnWyuBNYO2xCDAu0oH1mOGc2NE8v8TcXvGJsLABJq6wzZO
         Fq3cZxJFatqh+FBdw5xlTabbCXpFWACN/YpeErCq0nJpbEPbu/1yCjC3ks6XkYqTbPO4
         QsHeb3R9DamnkkR9X6AlMoVOtlqsVJeXNlp+KFuPLpy1hCF2dB5tFGYJA6ISgNNL4qW4
         ArPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742941208; x=1743546008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8dONTFM6RC8uRNfo7doEMwcZfV7041orR9CUS1WNic=;
        b=V7naSZaklU2pVwh1x/cZyU40lv6EjZih4L7ZjgL72hlq2yAPZVCcUq/x/aOaKrJeQM
         p0w/piaPRQu/gMqoC3AwmQn3+0MU2Md5eZ4I5mjPK9DUvHNBYGK7TTpgJSHX7BBibT8C
         oduE7l5rFtloiiNF9YdPKvstoAwZ6SdEZU35V2HTi2P5DUFrzFkSqi9ykmRXPsgWSR5i
         2F4az1NWORoZF4Qk9U6ek3JzNlPFF+pYsqzROmtkdatwiI2yuago2kQrmLMrxnmSt/Vq
         MrksEUA7cBb0gdvPtmSUMa8aChx8SOuaSz44VixNWJpdEKMa9B0vnJ7PNveZVtkEUDVA
         Qs2w==
X-Gm-Message-State: AOJu0Yz9YWMR6ZS4g28ELyMGYIHjfv89Tdzz027R/Oq4uuoDczrlco6p
	dlewllkJcJUSRC0F6PK+7lTJV7bCX2F3xrU4my9ONMMJxEMTDVaIjFDdh58LJCR0Zil/vDfuRJk
	MZ80zZt1r7iLxRc1r0GJ9k/Vqw8jr4OOroaAJplrdbOuWjl7u
X-Gm-Gg: ASbGncv7xUHzic+htq9A7n3PqVc9L0DyibNQJ/e1OhYy7p204kGff6FvLhqPXkvbzKN
	TyInwMJof3VKpCXzti2376O0wwqrNacM4WuO+wtC21NI9Qo/BvxRCUk6CwKkpHl+2LbQD3O+mag
	eZf+sDO/dNTYFyRCFsASHB48DVAVQZbmY+bTuA0u25/EfGCJbeh0mcZr1Cbyym+bgUrBCJNaryQ
	cHXSf6USJ5T8xKiPQzqK+1QbpZnrs+jsm5wh79Yv7MrlrdSj5ci4HvvhWjXi6Jy0DkFlSs1KqQg
	1GEbD1KFmH1Vv/tl3bxD73Y3rcxytaehVls=
X-Google-Smtp-Source: AGHT+IGkV8dFuwx5r2yLmkio5J6J8fr4hQ3tR+zgbUM8xz8jKTp4WzA8Bx5pOB3XzpAT281kk+7kSZkfNhRd
X-Received: by 2002:a05:690c:a8b:b0:6fe:e76a:4d38 with SMTP id 00721157ae682-700bac5e14emr258757897b3.21.1742941208289;
        Tue, 25 Mar 2025 15:20:08 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-700ba82d5a9sm3786797b3.46.2025.03.25.15.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 15:20:08 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5B1ED3404E1;
	Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 4E772E415C9; Tue, 25 Mar 2025 16:20:06 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Date: Tue, 25 Mar 2025 16:19:33 -0600
Subject: [PATCH 3/4] selftests: ublk: kublk: ignore SIGCHLD
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-ublk_timeout-v1-3-262f0121a7bd@purestorage.com>
References: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
In-Reply-To: <20250325-ublk_timeout-v1-0-262f0121a7bd@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

SIGCHLD from exiting children can arrive during io_uring_wait_cqe and
cause it to return early with -EINTR. Since we don't have a handler for
SIGCHLD, avoid this issue by ignoring SIGCHLD.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index ded1b93e7913011499ae5dae7b40f0e425982ee4..064a5bb6f12f35892065b8dfacb6f57f6fc16aee 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -890,6 +890,7 @@ static int cmd_dev_add(struct dev_ctx *ctx)
 		exit(-1);
 	}
 
+	signal(SIGCHLD, SIG_IGN);
 	setsid();
 	res = fork();
 	if (res == 0) {

-- 
2.34.1

