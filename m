Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79143232
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736779661; cv=none; b=VsBjjiCCegeFqKWMSnt8bdpQuMylJr/NDo+5CDn82XqdHcnIxygCTd0gZsYH/XIrq9PQKUE/1zuk21h1H1sTNweiOPLR0ZbYVy+liec8k8qouu/DcxU68IAauo7cW0+2qdUAzMVr8zp5Zdx1PdiRghfnD0ozMn5C6M7sY6t/1UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736779661; c=relaxed/simple;
	bh=3tjGVV08o2bpb7T0UYjHEQ4bbZxoNR7ms8YvttGwRIo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=slVO3oagrOCD0+rlZ2NKeIIBL/yB6wA3FMAeDlPPQirUDKcDrpksMFgQSaRWhdApFioKo8RPsvq3ubcLIk4GubfXTU8iVXTCmiSCmG8G1n5OdnPDMbfYgcRjGrfA7JjOABWaTj3X/sKPc7kVZvPHqlUR6jWbfOaBrZq/ZtLwF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ttsfd9qb; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ttsfd9qb"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a9d9c86920so11074015ab.2
        for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 06:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736779658; x=1737384458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ct4Iuy5ssYGDDfyGiWQYiwxiSnqVWA8sWTzSYRjyxC8=;
        b=Ttsfd9qb3CDvXWzD0nODPdVEFva6gHA8eIivbKRv9oo5cA0x4I/6QGa2LnqLg6w3cs
         oH4z4TTKBzOmJZykOa5v98mhWbDxUbC0WGUk+yUeAHkiG5Z7C6a7AMDhq+cvfMJcqb1x
         kMmvkKkJhU9z2KfyHRuY6DSWq3+DOAowv1y6N2Am5CNpPUgbFoIBBCfbjE/JRZcXyNbA
         gbQhiv3lxR5MOIyjy6LXYnxRkxr1AilkkvfSSukHP8IeefhAVerYoxhEVKUpdo0XZf47
         i+kmhNJXgeuTy9wszYbG26UGWhwYgQH1QChj9Ygv7wqtM9P/cORg8F4SN96GtsYsatsT
         Sppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779658; x=1737384458;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ct4Iuy5ssYGDDfyGiWQYiwxiSnqVWA8sWTzSYRjyxC8=;
        b=C/YW0P23QcND8uxUdg7I7JdxCUJKmqAR5dBbbKc/FBDc4XQeYFr43dbeu8/TMtZgJo
         lwIu1NIeOKgtZGGKMRjMdr/Wm+gfD7a8M6fCCcUFhRnhxBwJonP7ggK4/qcWYEBO86nV
         7vW30nZXU0hTSg4/ziraMEtx6RHsBLapat7Yj58xuKPpTUuR+Fo0UF9cyHeN7FX/reck
         TGa5cYWqdrwk/kKQ27EL22zTtzDXxt5wElzCK09znWt2oXmtzc/D0AbxO/A9fGxSbXyM
         JCKtt3pC/CLvYUGLZmLtLM18of3yk2vqv9O5sB+FEj98pQVkNlTaxB3iOnjUR5I5vm/i
         fkYQ==
X-Gm-Message-State: AOJu0Yw3JgB2gyS746CXGzGaJrqRXTQ81UBZROKlKbmb4kbeugo0yW5P
	hlNpbF9tQz3c/zOZ1zuKjDFSeQZo7jFCZsLtT5BFnCZlbulRmViaRQOuPAGX7m8Byh/THESnWH3
	u
X-Gm-Gg: ASbGncvjYrbKeug1gLFZKUCrhHGWLlJf1yaNsvZpDPocM8brBWSMy47ElQPgmIUsPy3
	D82NXb5hQ7aDImbd6DB0VWSNGYiucQ9iUc08GTdlsQoiE4yxuE20i6mj/zRdcjevzYTEjgzefgc
	K82DXwTCpKu10NFKzJ2U15GOGmyt4eCX4zsT8Em+AHoekCj8wEUWR5vObRuwiqZMzo1oNuo8JW7
	Ojm6iHvDZpgdGn4BrJG5uPkgAXqnPwOR0eInToP3jE8Xfs=
X-Google-Smtp-Source: AGHT+IFUkBbeeOx2e+HVkHy2G5WuzcqIZ0M7VyDn/3MtrPSV4vWvMlC2PHbhksx8+sm1qjrdgAG3Ow==
X-Received: by 2002:a05:6e02:198e:b0:3a7:8d8e:e730 with SMTP id e9e14a558f8ab-3ce3a8ec729mr147588965ab.22.1736779658334;
        Mon, 13 Jan 2025 06:47:38 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea1b7459e9sm2768810173.118.2025.01.13.06.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:47:37 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 cgroups@vger.kernel.org
In-Reply-To: <20250111062748.910442-1-rdunlap@infradead.org>
References: <20250111062748.910442-1-rdunlap@infradead.org>
Subject: Re: [PATCH] blk-cgroup: rwstat: fix kernel-doc warnings in header
 file
Message-Id: <173677965739.1125204.17578281446586670021.b4-ty@kernel.dk>
Date: Mon, 13 Jan 2025 07:47:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Fri, 10 Jan 2025 22:27:48 -0800, Randy Dunlap wrote:
> Correct the function parameters to eliminate kernel-doc warnings:
> 
> blk-cgroup-rwstat.h:63: warning: Function parameter or struct member 'opf' not described in 'blkg_rwstat_add'
> blk-cgroup-rwstat.h:63: warning: Excess function parameter 'op' description in 'blkg_rwstat_add'
> blk-cgroup-rwstat.h:91: warning: Function parameter or struct member 'result' not described in 'blkg_rwstat_read'
> 
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: rwstat: fix kernel-doc warnings in header file
      commit: f403034e8afd12ed6ea5de64f0adda3d90e67c9d

Best regards,
-- 
Jens Axboe



