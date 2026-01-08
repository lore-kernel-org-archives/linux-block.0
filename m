Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com [74.125.224.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40762DC774
	for <linux-block@vger.kernel.org>; Thu,  8 Jan 2026 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892953; cv=none; b=U7lpUo+ZD0afxOrIkMQiIqownvlHj4rOn9g8usxqVu5WRgYLtk1MjnF5Q9KeBWCvnCter3jHylyP0xopsE/jrYNkkaPXFUUahdW0z9dkGduOrHvUM9fHY4mOJ8hXWRT0BRAs5r564cBeSCECcBp1O46WpdWc/85wQOToO88Dhy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892953; c=relaxed/simple;
	bh=/IU4BJFN9HahxQd5czjHe0YGZ+qC925mCNOzrq+k6yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r89pr6NbDVFpl8CoFGquNA+l4SGe5I4AcqwX0Oso7ySNTNr6HZhB9qd0a40h6gmxmBseC6A3Sa4RuxHhSU+kCxeAvycDrWevI6vkmGIqZ9v4SyDwXJWPwiBATk45+p/AJGMzD3NYQYqVbkO7AO8DVXcjOJEMZEjXckPNWZCwaIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bogGKBbH; arc=none smtp.client-ip=74.125.224.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bogGKBbH"
Received: by mail-yx1-f98.google.com with SMTP id 956f58d0204a3-6446c7c5178so457136d50.1
        for <linux-block@vger.kernel.org>; Thu, 08 Jan 2026 09:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767892951; x=1768497751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FsYrTzLPeo8Mpf6y9bw0LEFuaRCqS0ObeVn1rvSeXRA=;
        b=bogGKBbHuf4Qg7TXTQL7wfUsYaj6p80CtcbC3LMnaqGTHgP0l/V0HTN9SIVq2wS71d
         i8G3Tje6aM+ZNhqZlA5OaBOskgXYW+3ub9qtCE7I/Djb9OyEQnWsZ1pnRd5h9mrk732/
         OTlrIWnDXHxHKKWl4LsYej7tXCLIYhRI+0GBU3HptEc6GGWMnwBxXBUeIsP5LMet/snl
         OYU96sTCTVJaKC30pwuMdgpcIDOgfkjDGJWjjWb//p5J8GTkIrdAsKxuwzUGj3UU+fD+
         fNuvXk6rxkYOHN9nC+WhAZuHfglQMPIlXyXcI0SD/AZrDBFwW20JlMs2cy6428DLrWls
         Uu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767892951; x=1768497751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FsYrTzLPeo8Mpf6y9bw0LEFuaRCqS0ObeVn1rvSeXRA=;
        b=wGooF0xeqNTs6B6jRVXHzQhBVNQrOBXmS+JfE75rGLkjoz8Ksqz8P82KS+ZpqAPGN0
         xTiYFBVFL31tvW6u4jrvg8Xnj2N9Ha9FLWzbOWVidr1+wvqf5cbjMdmz4l/aujQmfL/Q
         k5fB1Z8ufqlr4CRqbcB9nWnhykExPkqZH9yuHcRFqUxJJ0PXVEW/46oZDUZExxDc1jvg
         dmsfw6rENGQIZZQdutoKoRQcTxVoKzFFVkYXUyMHZ6PQU6TMZErO9ry0lb62hPhE0xA+
         TWun1EeBjGUnGNzCZd9vV8Rhq/QJIV7jgierf5v8x6GQLgbsvU8i048UXqlERsQesYNy
         lRbw==
X-Gm-Message-State: AOJu0YyHrnJQ6tWXF5f8W7rXs1kWYIYAxbSskhQW51Qr68b/20jc+o+D
	2QcdECorysjX7v1n6TPjwanbaNaUgcnCSkGXiKDvUffHtPU+tP11chNSe7ZAA5Mcch9S0g2w5iK
	KbOt43iwGShsui+Cw1rM4fFP3jlMNJEf2jZJEwbkPcxhkqWPj3/U/
X-Gm-Gg: AY/fxX5mM+nDdweMIlsDyJSZwEVMpWwhky111neBQ/3aNCOcJTRUI1aYhHqUkyd6lqB
	3rVHaKADgEeTNoewiugP0CSiYtSIudiXPDkcnwR2URavC1ZnpY2LPT7L2XVh4ELHfrxeQPZaK+V
	D9G3j8uQ+1Se6pErl28gApsIY7NdOFJHn/+dG+ur+BcwPi6vlvLqz/xN6k1jHMFxnTgcUbouVCG
	5OvdY8UE//nNt4f6sjCx2BK9qPQw5/Q6J7XdG8J+65HPal41A7eVeZcc6SQG7ez1N1nrXiLIeDV
	y1S/860vJisrBt5K88M11nJ1kb6K3RDM35KZKr+C14+T7xOzA3ZW02Lof08rjtbcWBRu6wv8NNx
	oYVMAxZWBCxqIifMweBX6Ko06A1M=
X-Google-Smtp-Source: AGHT+IHTSPJk2NCiGaRT9AtWskwF/Ucr/ARa0VAfuMsoQitzHJhASpm2ZhfB81S7Tkvm6hWesFqlPAtyzvGd
X-Received: by 2002:a05:690c:fc9:b0:78f:cd29:51ad with SMTP id 00721157ae682-790b573188amr60194927b3.6.1767892950805;
        Thu, 08 Jan 2026 09:22:30 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-790aa5a795dsm6691367b3.14.2026.01.08.09.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:22:30 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.6.120])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D7B9A34051A;
	Thu,  8 Jan 2026 10:22:29 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C0017E42165; Thu,  8 Jan 2026 10:22:29 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anuj Gupta <anuj20.g@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/3] block: zero non-PI portion of auto integrity buffer
Date: Thu,  8 Jan 2026 10:22:09 -0700
Message-ID: <20260108172212.1402119-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For block devices capable of storing "opaque" metadata in addition to
protection information, ensure the opaque bytes are initialized by the
block layer's auto integrity generation. Otherwise, the contents of
kernel memory can be leaked via the storage device.
Two follow-on patches simplify the bio_integrity_prep() code a bit.

v2:
- Clarify commit message (Christoph)
- Split gfp_t cleanup into separate patch (Christoph)
- Add patch simplifying bi_offload_capable()
- Add Reviewed-by tag

Caleb Sander Mateos (3):
  block: zero non-PI portion of auto integrity buffer
  block: replace gfp_t with bool in bio_integrity_prep()
  block: use pi_tuple_size in bi_offload_capable()

 block/bio-integrity-auto.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

-- 
2.45.2

