Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C688346FB7
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374517; cv=none; b=OD9X75JDau7DItUbYa2AbcmXTnK5xlmYxeXeO8kKa773df135poumljWekUq0uurD2SokYoFoEmJMAIo6pD7mJdENYYLO7HqzGcd+4wpHhRKv/uxlQ1+pnkyCDhgAWiveBJlfdWkoYak0KWysIxezGYGue6rP4HLG8E31MNLzr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374517; c=relaxed/simple;
	bh=vbqZgxt+ddV/gMkFndwkKli1Qq2AmUr3CIWnYw0YR+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MgzpdPoG7KK0NN8zgt+PQWO34YrOVHGUc8V4RVObKyp7xIxu7sEMlQ1yH2dkDUIIFlAn56ZgBIbjsr3cZBqxKFwzWBtTutMk6NCZMt8vSy5NQjwwKlIPQ0JGkWR4i8/U4hpVFQdX7N8B/m1fMU75IVMMd9REftWjqBcjZbrP6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=O6mjjhaF; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="O6mjjhaF"
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-59425b1f713so29194e87.0
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 12:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762374514; x=1762979314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hqzNF//smCH/wXecy4K5ISa7DPzn6oehsCzEe3RVrHk=;
        b=O6mjjhaFAPe2uNPTMK4gmVhTqCVG2biPQDaboBual9Ul5aD5Umf7XGxueXtHSvq/tp
         t4RkEZ3sxNuzB1eAEkik+hqJ9ihTSyVArUI2nhOPh/JXu9qSTBHbzkpiRwsvBl50JM7K
         PMp92jnXkkoMVDBosrW5CGiHQ8U/P/s0PsdN9Y1RAeFx35SFdbOaeem1UZgPUMMvKbvp
         E+DmTQPEGjyCHZH/BpuezZsTeLg5WobmToLaz+scYzFPzNxp5VVGKoPocFK0JgCu+82B
         groMf+YartE60TX1enKVrNu74dWplA+/i40qEc3JT//gfh8x7vSBBse2OwDNPFllEnON
         hhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374514; x=1762979314;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hqzNF//smCH/wXecy4K5ISa7DPzn6oehsCzEe3RVrHk=;
        b=Z1bkWDrQmRTGoWzFULhZPiGSGddzmUWN4hgEYk4RWJUU5WeHB0JPbVnyChZOiS2eHK
         MzFTHN+i6S6jnq55UjRktYa3uXVLiPy221m1Tt2I9mx6fItHPajXMLN4/bfqA7xyKBjk
         KJ6d1AwyxD2LGIiSmB9pp2CViarumN8kOa9FIPAYZihwXWChn/b7CDuRG1vT4CW8tFnO
         LizneJShwxyFH4Uw08H+DTnnTUYMYw6M5CoFiCDZxu5cMFJnGNzKcEwPgyrnhxyQY97k
         DeSiZsR5LElXLX5y5FoQmtATr4UP2K38EBfuFRavStGJwRmNdht111PvuRcCe9vFLASY
         ZDkQ==
X-Gm-Message-State: AOJu0YyW38+J3ISr/dxe4/8+GUnHv8IqsmeY/LUF2GksYJZWESKBJL/q
	8HpVIedQTkJ1UaKrMEOHEf1oT4VyFfvvgqv5IC8zYS0o75I1FR70hBXYe8xHmO6S8Smf/YOR9fr
	bbwncc52Y+hwQrbIWoGSpmeg6fF0+xQk5M8Zx
X-Gm-Gg: ASbGncsP/CbjxtgPRSXkmJ1i5WLga8OlsAf/mwOn47MmheOQ2sE1iAmz9Xlyc4abeWH
	K07p0cEtm5uW3qC0icIG6dHQ57U0S9C71K48libyCf14DlsUSOfjYIK1zQGrvty0nA4dKp2kFXG
	2Zn32wo8uI41xJ/ckXHFOvG45oDt/FO3InmHYBRGbiIm5G2in99tcgxzFFPcXPsvUQ6XjMwhhNg
	pTj5MX6IoAif7bWcaDJKAkntBsz8AIk//DMMNWh3baQ2APdmGGKFJhLML/jH2HEoKZaPDTMd5Gi
	cBBoJ9wqy6nsmy8vgik5WVNEAsH0PSKQUzvRYBs7AleulxbvSwaxyw48/dobNfHe9Rn3wggCMkS
	dMbVUSvNbzYsHZ98evQre9SAO4EtlsfY=
X-Google-Smtp-Source: AGHT+IF1qzknNMPR4sXhFbfjCjDnaAvrB84RmIyS+GxY4Bwmj8KbhDyluGDBr1gzppGHTLZrqh0wn4FE9H8y
X-Received: by 2002:a05:6512:3b86:b0:594:2d0d:a3dc with SMTP id 2adb3069b0e04-5943d7c97c2mr786137e87.6.1762374513403;
        Wed, 05 Nov 2025 12:28:33 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5944a0b9327sm15740e87.41.2025.11.05.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:28:33 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id E5147340355;
	Wed,  5 Nov 2025 13:28:29 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 036ADE413BB; Wed,  5 Nov 2025 13:28:30 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/2] ublk: simplify user copy
Date: Wed,  5 Nov 2025 13:28:21 -0700
Message-ID: <20251105202823.2198194-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use copy_page_{to,from}_user() and rq_for_each_bvec() to simplify the
implementation of ublk_copy_user_pages(). Avoiding the page pinning and
unpinning saves expensive atomic increments and decrements of the page
reference counts. And copying via user virtual addresses avoids needing
to split the copy at user page boundaries. Ming reports a 40% throughput
improvement when issuing I/O to the selftests null ublk server with
zero-copy disabled.

v2:
- Use rq_for_each_bvec() to further simplify the code (Ming)
- Add performance measurements from Ming

Caleb Sander Mateos (2):
  ublk: use copy_{to,from}_iter() for user copy
  ublk: use rq_for_each_bvec() for user copy

 drivers/block/ublk_drv.c | 113 ++++++++-------------------------------
 1 file changed, 23 insertions(+), 90 deletions(-)

-- 
2.45.2

