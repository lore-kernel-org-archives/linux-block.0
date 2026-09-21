Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CDB3AB272
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021255; cv=none; b=ZVYu7Ty/7q4wwZBtWoA4O/20Obpf5kPFAg1fJ0BoNVeTxh7bf3qY7DFG06cVGdyeKlvN9SuY9Q9WT5H3tL1BwAzPTSemHaoonWrRP9QTskbBKt7HcfVJVAKUdGsGROG2PpzvZBoQwbVMGlBvnuJY3YkC0QdChgvGEJ8RP/GbxbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021255; c=relaxed/simple;
	bh=GebsKRDHt3UQhaWaTAl53f/Sh/f8qeGCKjN+sx5S42A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/nAY7yf/GhWyVBosAJDZ89N64lXkbHfzg9QtZKBIUr+FBXuEywlTq+YfH8ZZKoQPgJxavnA7pl5C09ucYnbJVne3whTMZr4w2LcSou9Xjgcx6TGM7+01ThGWZ9ZV5x9mT+MOOPOnKqUVom/MDDwjc/Xunqcdl3GbNP6BLyuPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=B00vAzGp; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="B00vAzGp"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39d654f02baso2871731a91.3
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790021253; x=1790626053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6cpRmN69U5lCxBcGPQGzsX/kkdZBkTNEMnGFB5cbb5o=;
        b=B00vAzGp78XYuGLYqOz2Vq9anLXJzpwREE9AXmGxLez3d+Y0XAqGcXuD9ExyPHmAUB
         TuZEk3CFW6CkHeK27es8PcyRDIIuyKnLBX1A8mhmTpE1Td2cd5M6QgNCZjUvpyjHL2sv
         YRlH3zTW/nXq2VCVnbWpoE0mzvLdyfIb2SN7SEj6hTtv3XIw5olN7CjhqiucHAbEdjAx
         rbVTUg25voKXZbIaCM0h19MFRc/j+uuubdHU3j+Z0VShiHneaN5N90PfI86ZyDAgXtjf
         HXzB1IG+kKXNbXevS0vCvJCxbG6A1nHZa1CDsLkgZpp69q8ALpelkr/+QZ0wDM/6StRE
         nuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790021253; x=1790626053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cpRmN69U5lCxBcGPQGzsX/kkdZBkTNEMnGFB5cbb5o=;
        b=AR0pct/A5/NXdp8X//kn3FENcK56q7xnJFAE6CBIBBZOxY5NReOwcbJm3YKj/nq/Wn
         29ZN8VbapupiSTMKATYjj06sswN5+Rsl5T0JKvQLxOJV3n18fo916vMxXZhHHMF+keZC
         73cvq5um21e7gMWJR/CH0oI63QwVNPiu0DfMH6PFQ6vtEAeryt3COXjIXbM964VxE3w9
         KCq2InAN93AnhNaCW4+RHk8r4UemG/XTUxxy9VLyzEIJIGb1Bk5GJEhwic9wu8aomwck
         3fruVLz8RO3y0/yeu45Dk4lUtKOlwIZeRp8nO6HcJNDOUYKR1uvFurufp+wtz2MvkuSu
         b8cw==
X-Forwarded-Encrypted: i=1; AKwUvBwcnhDB+ttTPF54L/xFJ6Q4f5XDtzUr/MkGAviunxlH6cXbsZDhBCQwOEGRF/M0ScIsFkWH64h0DXCZyw==@vger.kernel.org
X-Gm-Message-State: AFuF++mdbirWe+0R9+FUp06z/7PMsIsFwHXzRBI2cH6BxTG05mjHFml3
	bPqh/rxAZbOZa1LqZ9NZeMnGwXzQru1Mc7Qhep2X2zOzEM0cXhy3F939BzMZMgt56Rs=
X-Gm-Gg: AYBFou1Y+YIg8R4zYdaFnHWL0EfjDZ3DlgIgIEUkHbrR1lp3TBbKftpi2K9u255VnPy
	RPpXE5TRv3g0ysrGWh9EoMf9BXgRp4f1ockUkPOTXnulWjsqntKJPBIk2pjk95S6OYxIBvxqYlJ
	GT2zTfU3sOsjI88jFbjWdGb3kFPodRpjGTFsmI3h/Pkd6D22yIglKiOHlBcaVQklfDODPPIjDs1
	CVt4Fw/DNNDYN5H/iCWgctPMYkL0ZLjnW5oM+bI+lX4IxSYJr4nbu2bPxw+ue5aCKLVNqxUrO0y
	I2kAJOrCoF3pM938VDttiJ24LDRozJauzIZUl2oEnCQ4W0dIOcRiIvqnLURDL+B8SU4khbIBhI+
	7I7i/CbAJEaxNMBSmsNQOmZOeuaPAvNMUgPRrQxitoMr2wHHJj5oymDdWHhQ0J7SAwM0aBFmCyR
	WcWKWkF8fD5PAtag7G37C1/zRXdeqieyZngSVlsM6ulHO56sFpHvEB2lojhNWasURPQorJD8N48
	+WUKxkmLTl0u0hhOPtWOcom/nRpfnfAbLv2wr1CGEMRcMSNq98nzIlVNY1qGCOfdPoQr8o=
X-Received: by 2002:a17:90b:1c83:b0:39e:6c69:34dd with SMTP id 98e67ed59e1d1-3a06b0caf64mr39927a91.65.1790021252643;
        Mon, 21 Sep 2026 13:07:32 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:289a:f600:f11e:a45c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e5ebcdbe8sm501164eec.15.2026.09.21.13.07.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Sep 2026 13:07:32 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Ming Lei <ming.lei@redhat.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6.1.y 0/2] blk-mq: backport CVE-2023-54227 to 6.1.y
Date: Mon, 21 Sep 2026 16:07:24 -0400
Message-ID: <20260921200728.84114-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg, Sasha, and block maintainers,

I am continuing with the smaller CVE backports still missing from
6.1.y. This series handles CVE-2023-54227. The first patch frees excess tag
sets after a queue-count reduction. Its immediate upstream follow-up moves
that free past hctx resizing so the repair itself cannot race into a UAF;
they need to travel together.

Both changes are already inherited by v6.6 and every later mainline
release.

Could you please queue the pair for 6.1.y?

Thanks,
Artem Dinaburg

AI assistance: An LLM helped find the missing CVE fix, adapt
it, and prepare the draft; I reviewed the code and build output.

Chengming Zhou (2):
  blk-mq: fix tags leak when shrink nr_hw_queues
  blk-mq: fix tags UAF when shrinking q->nr_hw_queues

 block/blk-mq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.39.5

