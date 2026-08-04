Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325583CCFD8
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 02:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785809925; cv=none; b=FNIt6WuoPHII4NEc6tzR7Qw7cN3UdgIeg56mONtWWkwqQORcDF1KKUQOWxilGmBrGRa6z6woW31WYIGHenqUWUO3/Nv8rKqPU5koISN92dKhQ0O0SMCz9VRVYQyQdd8Ce2DJYbfwefSpuwUlWbd0rCISQg42yUWcKVKA8WDZvWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785809925; c=relaxed/simple;
	bh=pmJMriNBQCqUGHeZqy6wsbcjTG2fGf0Zyc7A1+GzgEU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N9qTn/UkM6v7k+YrGbnsiwDJqpA4sn46IvcSVf1UTECqu+xJqp2gSbzROVcR3+KexYDAseXY7KPBwROj0YfsixwGa4LPGf5C0VvOfJSv6dCSxpZOu21KyOPREtpOEfwBw2+uWQDStVbtBVOoCJpeiGsBxKKknzHWPqYuEbuzaKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=za9K6veT; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="za9K6veT"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb6573bd52so2793089a34.3
        for <linux-block@vger.kernel.org>; Mon, 03 Aug 2026 19:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785809923; x=1786414723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Y7g3mGGhWdn70/LKwOlCWoCG1+0V5HkHLeaxW/1f5A=;
        b=za9K6veThrvQCsyLEQ5ixBxqEznGTvPcqrCs+zc6GdZvq0qBixLmhH0gQPq3g/O9ss
         LR4ATJVLhvuTzqSz9i5zKxv7utCL2cp5NjiwZe5Ar+ZudC9pHCncDBFwo3S9sKzmL75B
         WU8YI48XJrgojNKL8c3nE8v9z+BaL9YdfJfLHRqFsVlw7N4Co4ffBoQl17RBwgwzS17E
         kNVeca/nrGZUSUEsznQZHWphygZ9uJ0jQRIykE5oxIBntKVwyPBPXo17ny1HqG15SrYb
         VxOWSIOTE0+x77LEF/1YmptRjC+olllPddM4caI0/C/nJdJoPMrWKyYP+cZy1PoipSX5
         LaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785809923; x=1786414723;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Y7g3mGGhWdn70/LKwOlCWoCG1+0V5HkHLeaxW/1f5A=;
        b=oChzAi16L+3k9WF4UIMmyVexdHgpsHHStRGhKnPV4f98D6zWvSsTvDLwvzX69GhTxJ
         Kw44LjNoD1Hml7+RiY/TDy26XfjZuDhHyfit+3MgBihfLu/7kIUvJY3pbyH57buwSBoo
         zRY5+tbrv/qnAiQlFK9A38MpM15kwj1v37bpvu01jn96Lt0ClUPhd1qM1L3c3E2FRYJr
         Pu2lZvNtGVHMjiJpUZ+LmgOHKySv/k4E2RPyqXp+lS9n96OPhCpT3bbN/EfwHyJQHGdl
         E2d2xTIpymTMYdMaKysOJDLOjmQ0MzUajbYrNRorQAnFiHdE4K0A6QKcfPHHhxedHoJX
         3XmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq+su21jwJKY6J1Gh135QFF5GFMV6hlurJVVt9kPEmXvlps3dxlJACJcB2yLOp/pLaJtJquejOZhLAC2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YypSDHXSQv729cX3KGDRR114xE2cwvvAPQk4q9TLxdTzKBsaPHt
	9xZV9za+jBgzG8qMf6E0HZ+Tk9YDAr3BJGfGnhuXYTZTVLe7VxLG3hEU+qGv9crdx78=
X-Gm-Gg: AR+sD13AjgbwByVB4lofRrM+i5lC9mGB7JNn8YpDCG3BWP1DKBg7tc7k8C4ddv6u/dM
	73R8Nedwlvhp+CTrZ+/6Ifw4grD3M6R2b1nPOUG2crJdL54DYYPjMuiQpVQE5PRTBduvBtlfQfM
	y4KQvV5UZkOpF5hAAPUWWmlxXZpmkdOE5QKieHV7YbeXC6mzJR2kNk3iz33g6jryMzjos7hYTCS
	9uypvk5Ej6qAwIN5DXAXp/7KlGG5cGgQOkRu5Ux96fPtJBmvJalCOi6Z6+eNtXXaBODGUz2A5PZ
	669Cidw2PNWVnpF5Sx+A0whBZrET5YbCFWec7LxyA8UoxSm+kYfew9iD/GQzwsupMqqyQ796VQK
	gzPeE6/XxpM+fk1UUuEUK6GUlxLdCvJWCLtZL0ixHYdX6oqmOCyOdhoCFatOK/mez940IRfCsyi
	k3lG+xuZ3zsO654mw+ewh9CzTnRdIr4Tx1hzCO3cV68cqrC5KseQk4oVEy9NK2vo3ob4Jt3ZX5O
	MDKdj3QMFqSbVuerj4UIhg/GQSnQo1MUy3+CSbXJA==
X-Received: by 2002:a05:6830:3691:b0:7eb:3af8:8c09 with SMTP id 46e09a7af769-7f196cb6591mr21082116a34.3.1785809918236;
        Mon, 03 Aug 2026 19:18:38 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18ed96df3sm8941838a34.9.2026.08.03.19.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 19:18:37 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: yukuai@fygo.io, Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, josef@toxicpanda.com, cgroups@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tao Cui <cuitao@kylinos.cn>
In-Reply-To: <20260803134104.138411-1-cui.tao@linux.dev>
References: <20260803134104.138411-1-cui.tao@linux.dev>
Subject: Re: [PATCH] block/bfq-cgroup: use data_race() for online test
Message-Id: <178580991680.519961.8800080646193720210.b4-ty@b4>
Date: Mon, 03 Aug 2026 20:18:36 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 03 Aug 2026 21:41:04 +0800, Tao Cui wrote:
> bfqg_prfill_stat_recursive() and bfq_bio_bfqg() read blkg->online
> locklessly, same as blkg_rwstat_recursive_sum().  Annotate with
> data_race() to silence KCSAN.

Applied, thanks!

[1/1] block/bfq-cgroup: use data_race() for online test
      commit: cbe81d612038fa3fb986a1e31fe7b8f808079cf1

Best regards,
-- 
Jens Axboe



