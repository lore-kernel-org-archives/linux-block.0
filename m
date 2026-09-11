Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449673E1CED
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789099086; cv=pass; b=IijN36jhvSSephmvpO9TVYVzwJpg6CCiYlMRLHqrneIpq+8u5Es7tt6Tf2tOJqHFZTJsLTfzAzXDsVbMvUFcT97PQfUn2VQDaDX+nbETiwit+Ovz+jLz6bqnIbmFPXKn390/84oghtJNSpc47b/fzyWypz5af67E5md4eUcwLoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789099086; c=relaxed/simple;
	bh=Jbz0JditIMqXliVHM+HmY267N4tGyAWcdvJ4Qd8Aco8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/WNn+IleWkLB5f67QQG2HtUCZI/x2MSSf7QKNe6DmOBi51AoRMow6E5+H99ErhME8/d1VYcvodPuAZmavwp8ioQITy94R4USQXyHFBxRjqaXT/JfWvmI3QKNrSqifcLhr86ZcwW1a47CvrQRrWYHyC1MCS6tF1bdpa7zSP+Itk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMT0v5ND; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMT0v5ND"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a99ac0e91eso945390a12.2
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 20:58:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789099083; cv=none;
        d=google.com; s=arc-20260327;
        b=GYBKLEKOthBf8wZDIg2NCmZEAezq5Rjpi64gHsq2Kfl/Co8aKtPg9OqWo8wSf+wWUE
         wK1ujPHxSh1gcO2n4DzCKBobLjeTwtQsRKd84UrHfm1rel2cZ2+BW6QSIiaNGdN+tP0g
         04IHfkPFQsFf74EilqROdMuokmxephzMVo89vkPzgKt72to+ZX03COGl7rDUE96sGh7d
         BdxkHoX97c4abGItOCd716fF3n1EaBiLoshkU5ngbR1GOFGSIkI1rd4Bywyq6DVs8Y1+
         IGO/IM/U5RhJEWuOFtZxbcYVCmV1wL8WO6sT+ffbKPTQaNBWmNcgsCbzsrjvo3p6Fnsp
         LYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Jbz0JditIMqXliVHM+HmY267N4tGyAWcdvJ4Qd8Aco8=;
        fh=L+nzFMAfXq4IhxuHXC37OtEmxaR4t6+K5cdiyl9dxOI=;
        b=OZJAG+wPxDcNbIptSkBOz7PPmBGh2qMJ22aeuPP5Neyfng711r0cOHD/V7KAECsMhF
         V46YCtc7AlZkQ7lqFgCeBFPTKQvRULnKKrXoNneIRUZpFaE0w1HAFxo5u5F2JxjEnXMw
         i24wld7SBS/s7pb0NIXuaPlOox8mq8FB9gA8NvRiT0UnQ2OFKC4t5X20vox9nhpJdfD7
         7WlggfdsURpmOFcgScRnw4+y0B7jdK37LmQcWlj3uVm1cv+7IgO0V9iw9UEJ2/zxavck
         LaL2QolrqxIuYTwXymfYWHdzG7Bg0x6FCgnW2b0usfsPNv1NB1OUQ+XDYXkjPKOnIr08
         1ZsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789099083; x=1789703883; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jbz0JditIMqXliVHM+HmY267N4tGyAWcdvJ4Qd8Aco8=;
        b=CMT0v5NDPn2VfGnpcuasyIOxqomgXCrVtbNq/6TMcEWMsihAheeAzZ/wK6u38YaOBD
         64NA8diXb6jNnARj4K+5x1iT8b2cviRKfs1mCx+qBpTvU6rZ8ddkl5u6evWkUpqug06G
         +nyGxdI89HdzqYjGoW54dmZ7ehCjn6JE01jGiyFDQG77dRU+ukX7LZ81hw4gRqB8oy36
         5h9D4uWC0hOSQtCg7f+UaphcfOmdCHZKuke4Hnl8mvJqzrpG0qPb4g+CQ3+4G02fqFYq
         zaEAZ8egsoV54BXeoxB19YknSdf/45+xifKWaof7+gxAbw0BXcTa8zNDrN74f5h7Vb5M
         MzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789099083; x=1789703883;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Jbz0JditIMqXliVHM+HmY267N4tGyAWcdvJ4Qd8Aco8=;
        b=YTOSYWJ5zR2BorotXJS5b1Cyk+oVIk2BPt+W9HVultKka91k/f+RdLQk7yGl2mUDPO
         2g0NesKHQJsCx20KNuwt49QP8+x6NsDmeOBfUueTAkrEgBZOUjYVCb8HP8TK5ws98UkW
         nuahf8mnGDKzN6jRWEU6wf1EGl7JdrvQ2eqQCNzJRIz16QMr6tISJgNdFd0NB101/W6t
         UuWSEREQRGLyqb3pf7di4BAcHNlPC21ln94mN2AS962suTr45RcSgc06YREnw5z1Ei89
         rO5XS+jLc7ODXYwV3f1ZduymYnKjAdDnXJ3yaq1JIY9pphpgrGLAlh7g8zeSUqytT9+b
         7shg==
X-Forwarded-Encrypted: i=1; AKwUvBzmD4AVdc8cLz/gXvnsg6vuYvhwOFDLMC5IjLNDX1GBMqZ81xKHvEL+hBWAGcQnybg6/hbZCZbM/+to2g==@vger.kernel.org
X-Gm-Message-State: AFuF++lg87vOo5UkKcjfd4BTZaOWs9ouR97q+136W0gSOmnIl4zNvmTy
	r391v7Fj1ynjgyaNZvvhzQJlPgwtTTTyO0/iLyRHasPDjT50tP3dwV36eHN0Wvio53qLI6SgbYg
	u9Uav1tWFmtHBo0LbmJHie8Df7StciQ==
X-Gm-Gg: AYBFou1LOJTqydiojWm5v5eIj6QPGyBAfX1UV0PuGIGItRHVo2o1riKjTZRQYS9IcJz
	2thULwLz/+Tp7Gk/+pLt0NnRY0inus1fcOdLXvS7s6acTDjaBgyd33cTlMm8+eXOJrkefuc9ece
	EFhzaADWBeLagArbcIFPZHNma3OSLTA+tpvbGTkv7wzpzpMv+6NGkgriSTmM8nJZ7x0NbY7LFKJ
	lrjeC3gy0o2c8/CCL1V5PLqynuhvqB+yzc32BfpApGC3mWLgQiIOXlFL9jWYrUK8WRJqUSVvq8B
	r5VbL7suOegsxoFjJvIaW+tX4vPgjD2X09SdxYBfy/pr09zwQ6tNT/zdL10c79++wBlbTeExU4J
	MMq5PGJQzT4qEtT561NjQ1nLBANLe0KShyPAn
X-Received: by 2002:a17:907:ea89:b0:c26:2da7:347f with SMTP id
 a640c23a62f3a-c29661fc502mr78725166b.0.1789099083258; Thu, 10 Sep 2026
 20:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909060924.1102037-1-hch@lst.de>
In-Reply-To: <20260909060924.1102037-1-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Fri, 11 Sep 2026 09:27:25 +0530
X-Gm-Features: AcwNN1VdycSrLLrtn8Jejfnce-6s5eyTxlcZ22co8XHRGHweLJX6Z-Wohcful58
Message-ID: <CACzX3AuraKdrv+VQ5MNT3XcLZiLkZVarpLY1-jfwQdcmRxa8JA@mail.gmail.com>
Subject: Re: lazy bounce buffering for checksummed reads v3
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Tal Zussman <tz2294@columbia.edu>, 
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For the series:
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
