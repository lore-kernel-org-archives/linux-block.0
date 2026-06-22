Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE2037B02D
	for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165675; cv=none; b=mAgmQi6n33YaYPfP7IegNfu22N6qv9HwhYEcl3O3VtFIja5KBFA0kY/dXBl5hEFjJc6rL5/ze7IOmQ5CTykF4hhQMQhE1TB1ax6iukfQmm3JvzPK0UOX/BbmhSATZxekFwfSrhjI/7dOTCJQgvq4iRRN+B6pZi7fAYrS5lHq984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165675; c=relaxed/simple;
	bh=8bJf78WP3XFEFRZRn/ectGOEonpYKZH7gOpEITJi+no=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NpKXHF26bj4s8Epwtj3gY97oSvEsn8OnCx1tEzID3R9l9iLGnSbLl4+TO81UxD1vG4zARKIPO8MLyKXbnyIYeBm/dtG2/OhbItvwb/9PAd/YlQ64Q0iB1kzY2dgcDENId3F6dowK/f8O3hnhsCnWNbjXNMStILibMfx3soMFNF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=j6KCQ9aT; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="j6KCQ9aT"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-519b63eff15so46324821cf.2
        for <linux-block@vger.kernel.org>; Mon, 22 Jun 2026 15:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782165671; x=1782770471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4Lw75p2n6l8hEXIv7+z9jfsW1LJfFPe/bV3l7WiUWc=;
        b=j6KCQ9aT1dKrnKE9Sxi7tvSX6DjWmh9bHVUI/ztuOc7tFoBRBMclTiwJDP4mQXGGQ+
         o2nAzwVJVh3rucmq9jRUCR6Mzmak0RP0E47ucv5N9uDiy2/Rn01XDwDMrNS/jbvMd+Yn
         vsCrxtpVz5du5l7JD+xukHi5j/1Gx+n4y2Y/a/XPB3olIvSl4xqE851JS5UEK77bN6oR
         qBMPuXr0iWr84LptnBNOh2KIxj9PZQGQJ9or9LfjYTMOjcplg09nNDBjdebghULOonMe
         oIYbsW+ddNEyfkYdzKvzJ51dpK1V274sHrSjHVDE0PJR8/OSlI6rypUs2VpJzHv7WzJJ
         SFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782165671; x=1782770471;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U4Lw75p2n6l8hEXIv7+z9jfsW1LJfFPe/bV3l7WiUWc=;
        b=YnpLbK2rSkXdoHvl4YMl+MXTXue8mBP8HIBmwRevxJUTaNoyNDuIAG7zGR+zWEljBn
         E5H9IkZJpVe2HOcM5Ez/4peMhRCOVkzF8ag8/hzrMO4g1JBllm4jzH2qKQf6nwG53sq3
         qfTd1aaP4s2oTIa5Q/hoedziB3BxP2pbConsD68XzVyWMZclyMSjgxWC/eqVc8t+JuW6
         W5riYWaw7PlVDdRzdICi8T7Yv+RxgCgUuA13nHhoYK5VlYCrpA9PSElRrp2Rn9pHvZ8j
         7rJPxhb6DHFNIwP6m+X6uTyK53eA4P5xgPMgC6AXl0nVO/N2K6Dlue6BXld4er5lWkQP
         ufvA==
X-Gm-Message-State: AOJu0YzEQenquihTWErztpwWRI6RKOPF2yno3q6Y8BExwttdTnX8/HQa
	HcnzWj5KssW+JGjjRwb6svlFWv0wnyHKVPMtf2XEgMJXzIaGPKNPX1J65VlrPDkZyAM=
X-Gm-Gg: AfdE7cnANaRJ/RdPrXBo12N1FpV5ipvw6BGz6zq34gj/+XJkJ7BQUGtixGNh6BLWK6z
	GLBdhYrok52ZBrBPwcphvuS4zOZ5Vvq3hcogFQlKB0GJj6W6kKaiKab+0xE5MFlShE9QoL/oW8u
	rf7kaAooG3bpEgBPClci9iLckfUYlo0RNoDn9j3QX5tLrXJF86PLhgekl9d8OZpj/N2BgKMxHR0
	srShMzLugSLRazc8yxpnhwoAlHVGZlmwIOKcTxwBoeRlASq6Kbe67vFHHmeFp9jLm+rsYvTtzC2
	usCqxngm8RJj7Z02XvjCIK01JVdWFYn3k29mKXN/l0PhbYNJeFZ+LsxFu33VROyC7U/GZKELqp8
	bKwKgE1PXkBLOpxj/ihW8rZJDqt48D7QwpMx1u+iRDnulXX83KCrjO2w7CFO3+ktig95rs264Ci
	5ciAWclHV1vWZIvzan9WDJbLrO69s3q9sLdx4=
X-Received: by 2002:a05:6214:27cf:b0:8df:250a:5fa8 with SMTP id 6a1803df08f44-8df250a62e3mr248073216d6.15.1782165648876;
        Mon, 22 Jun 2026 15:00:48 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.128.58])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f018898sm106932496d6.7.2026.06.22.15.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:00:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: josef@toxicpanda.com, edumazet@google.com, 
 Deepanshu Kartikey <kartikey406@gmail.com>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+6b85d1e39a5b8ed9a954@syzkaller.appspotmail.com
In-Reply-To: <20260621235255.66015-1-kartikey406@gmail.com>
References: <20260621235255.66015-1-kartikey406@gmail.com>
Subject: Re: [PATCH] nbd: don't warn when reclassifying a busy socket lock
Message-Id: <178216564143.110437.13652604139496842570.b4-ty@b4>
Date: Mon, 22 Jun 2026 16:00:41 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 22 Jun 2026 05:22:55 +0530, Deepanshu Kartikey wrote:
> nbd_reclassify_socket() warns via WARN_ON_ONCE() if the socket lock is
> held at the point of reclassification. That assertion was copied from
> nvme-tcp, where the socket is created internally by the kernel
> (sock_create_kern()) and is never visible to user space, so the lock
> is guaranteed to be free.
> 
> NBD is different: the socket is looked up from a user-supplied fd in
> nbd_get_socket(), and user space retains that fd. A concurrent syscall
> on the same socket (or softirq processing taking bh_lock_sock() on a
> connected TCP socket) can legitimately hold the lock at the instant
> NBD reclassifies it. sock_allow_reclassification() then returns false
> and the WARN_ON_ONCE() fires, which turns into a crash under
> panic_on_warn. This is reachable by simply racing NBD_CMD_CONNECT
> against socket activity on the same fd, as reported by syzbot.
> 
> [...]

Applied, thanks!

[1/1] nbd: don't warn when reclassifying a busy socket lock
      commit: 9280e6edf65662b6aafc8b704ad065b54c08b519

Best regards,
-- 
Jens Axboe



