Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738892EC081
	for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442962; cv=none; b=lWK9rTFHt0U5XWdoXbCkd+uoO2nzNSHl1mEQmefPGa5Jm8KEFEsVgnCZ6XGpbUKLJyEhzktAdcioILeb34RuC8QO0kXgYY/0N88Pdfw655a0+txryHvYhJle9wcCWbqaNopMiRPyo9I79Z6JKKDwtQrH1kh0ao+diM76sxidg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442962; c=relaxed/simple;
	bh=yECJFeUAthq1oieUXBWmYNMCNSw2RRXHhts7ofslujU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qyUo6/1gJZcqXZTLxslWKMOCTx1OuWGfdjHKh8hvPx2XNutkZKzNyxj1XIxlFRhD64Zj40MHXO88rhkdwCB61xRYpOSOHYF0nkPPumm15Uk/8fMEbBLBoEeJmQ+DJEqObbywHxYvi4PS5eVfNsQ7rMNor+LlHFvqm4cmL6eOG+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tUopDn9a; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tUopDn9a"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-464ba2bb3aeso539919b6e.1
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2026 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1774442958; x=1775047758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lM0vNLcYgXXRx2Hq0tkdrQu+12O7LPmYhv/aSagPRjk=;
        b=tUopDn9aqfER4WYhZMWrwqoHXHHIKyB4vmI7ocLI4jNNYIB+1MdadltvBslvpzCPWJ
         W5G6vzMHmRmaKmPHIhqDXxGAMSZKlpOc0/5E1GoVv0B10lxCVTYgq8yfikpGyFhysDB9
         UynyIB7InP4/Csnw4BydXmRgYN6gPv+7LB2/2KDrgxdaO7X7mQPJa/2Ii1AHV+48xwLj
         Y2bljRxl7pQp6y9Vluqc/Sbpzq8SVcoX1O2BYE/KAOGnX6DwSyc5/Bc9LHwoAk7mqnyJ
         yUh+y+Y2SOfKLOKkxs+Vg59RhrS4cKKVL3pQLoKLyAiaujCcmPKKNfscRQtV/YqNYBZ8
         fX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774442958; x=1775047758;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lM0vNLcYgXXRx2Hq0tkdrQu+12O7LPmYhv/aSagPRjk=;
        b=dssPzMK0jUr28GpilNx6E5rU3Lf0Sh+ZR5ASPu6zAXPCleyJUoHDjHtbyaJqULbie0
         nPEvC8EtY5rhwCN5LXFu6DWLMUpMnsONyhUdKaH5Bnu4xelA6AakSqLijmOlSQzsXGo+
         j7KcUPZd7sIQ9du6E3+nkRWKrJkmO/POis8T+pZx+NuoUvkvhsRargeuWr9XlpwMSd8B
         vM2YC8BrNmJzX7sJ6kD0iyb+U3++YOHMbft9dMyr0+Gdw66teDW1Wa8EWXL4AU1vRPOf
         Zfmq+c9dGZ7pPZnS0QOkUrLAQ15ySWwvNwJh1H65yfNL7tRrvk5LhiLX00cKrgb+T/ht
         PKhg==
X-Gm-Message-State: AOJu0YxFPyA5JavPubJ6ob3fcOlkr30kOEGZJtR5Bpx6MQLAj6BhSPVh
	3S1n2FBSL+EpHD+n+O6EzpodOc7y0K/MWnt8VpFXRZpK+JOIK65ovmGtWXq795FgE2iNqk2/Z0T
	80qupIIg=
X-Gm-Gg: ATEYQzz1pTArscfakzv9u1+30AYB8rRd0OUw7iYt7eY4+I0cST42O87/+YLSxGOnQPh
	tY1Qa+0CgtkXC/2eApSViiFvQEjSRJ15Sj/p0LPLLDeu/VmltU0fNX98Gk0QKM2sXYpFUGVjQ0R
	2LwvjkZly4lsm/6udP6ACWL7ravAAfOB7xX+h4O87+7ZokeKNnX24SlRCIqYnhYYadbSZkZBhjd
	YpHyllrv2Q/wlSMArL1N0W2M5GJdEJ6/N6GVXTTLsFuxcdEzUtzOioADExnQjPra+N99yyr5mXl
	+qcdDk24pS7Vw62UOotQycb97zXH3xkczr9K7YSE2290m6701Wo58iAJ3iv3zhdCyvId3ixkStL
	nZAjnTV61+h/ClUJz5LNy+uXPrqAA/e0CMYnO7QI1UwnUsI3EfFsOJVQB3c7xRjKKazQ/lJrS/s
	FHsWq22kVcHSqe263LupS+yDdaIawh88j2v83ja0iVhAQJaYOFj4jzH3dgmx5ejUDiLqsFHoUZz
	9GLcQ8Lysts65w=
X-Received: by 2002:a05:6808:1808:b0:467:da0d:537e with SMTP id 5614622812f47-46a5bb26c50mr1627306b6e.7.1774442958118;
        Wed, 25 Mar 2026 05:49:18 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7d4f7afsm10995008b6e.8.2026.03.25.05.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 05:49:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20260323071156.2940772-1-hch@lst.de>
References: <20260323071156.2940772-1-hch@lst.de>
Subject: Re: add a "discard cache" debug option to zloop v3
Message-Id: <177444295684.636937.4423592892926427601.b4-ty@b4>
Date: Wed, 25 Mar 2026 06:49:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1


On Mon, 23 Mar 2026 08:11:48 +0100, Christoph Hellwig wrote:
> this series adds a new option to zloop to lose data not committed to
> stable storage using a flush operation on device removal.  The idea is
> to help testing that file system code does the right thing in face of
> volatile write caches.  For conventional devices, this can be tested
> using dm-log-writes, but the concepts there don't work for sequential
> write required zones.  Instead this adds an option to zloop, which
> records the write pointer at the last cache flush for each zone file in
> an xattr, and truncates the files down to that value on removal,
> simulating losing the contents of the volatile write cache.
> 
> [...]

Applied, thanks!

[1/2] zloop: refactor zloop_rw
      commit: eff8d1656e83d186fdf9dd3ad0f229088440e4c6
[2/2] zloop: forget write cache on force removal
      commit: 829def1e35ca3a6ef07d53d47089ef7cff0fd127

Best regards,
-- 
Jens Axboe



