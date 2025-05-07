Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9460A232367
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 11:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746617892; cv=none; b=YLIQfT1VWV1zLqNCk8ABpprbw+xX9GYZSpIuI61643JZKZqthShEQx5ywBx9hDI2k4HWZwea3ZZohqX+kp6u90PI3wom5IqZimiM+1ip0Jw/pBPQ63o8RHupsZ6Q+WjSlRPTpQGH5oFS8DLxgRV5tZN/MA1IOtua5IAgauL85dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746617892; c=relaxed/simple;
	bh=lwx047rGbrFkawU8qBzJimbB0KtPvNw4gWZ/kXPAafQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jn+gRnsKkeI8gpnUdVBCs1osS+NFB0y7ZQ/Jhd59+8UcZe/A9M49MsXCj98KR3nT+0rXW+CcA4HfovOniflHEJbSUtri4NN7inR9Iqt7W93g8EPe5YwbNVywlbCu/VDTz+Z+Bi7HgFYRrUOpz7jz6YyxJTp+lFwp7LPhUEXw3hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nkT6+9Nq; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nkT6+9Nq"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7399a2dc13fso9461923b3a.2
        for <linux-block@vger.kernel.org>; Wed, 07 May 2025 04:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746617889; x=1747222689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkT+tiv19cX2cFuziOZDznr5oqsLqy+oJ6rHVO98yfg=;
        b=nkT6+9NqDcyNSaQvDcxt4n5c1S3KuCMEL2Ez91hLLc6LcZQsGGp6A3DVL3CWDRwzJI
         AIkBAbvX+jcTkjxSiZxO1dT3lWFkVlO2YuppzDrIeTm3pejMOTT+wyMkFVM6+FzRs1f7
         ddcPp26yKWEf/hbBDTTU1oWwcihWcBmM6LIDLsOqONvnUu/nZ4E0n8rNK63mkg+OwaH3
         l4lWH+oxBVJHKvLEfg2H7tDMa6pQ/1z6endp9xJa7p/PoqJS1WraaoqgX6SM6FlyHk/n
         H9zI6wxiX7gfSNMJWxHiYlLDBJ3VA9vOUo1/H+kVkFYyDk2RLbdEdwRCJg52ocUS3SCT
         YijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746617889; x=1747222689;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkT+tiv19cX2cFuziOZDznr5oqsLqy+oJ6rHVO98yfg=;
        b=jpYxsdIjXJIE9OLvlSUJ7QotQAATwyiwtU4uxh4o+dPNRT+UhTbiojRa9kvxloKuou
         +T2Zeqny/gq1bXuoWGJogo7c3XsqSq7tYQf4U7c/bwcetwb90BKeZDXmoKrcCL+SxM1u
         WwaQTjPDq+0y90ca+i9i5vdLgQ0DYuByMsQVjLqin3VOsDOV+FXVPYCOrfUN2LPyVWcU
         rDKhu7P11dKkl1mOK9EraxxV3WdDKuUOcWm5wWMiISYe4hUvbWxoI6ng9v9EHtK3Ip0d
         TAV5fyKOJ2xoUeAIF+h0VOeR4J/sCiKS1h0ElQVWeL73cO/OtmkOzc+YnrdOsIpBNm8/
         4OwA==
X-Gm-Message-State: AOJu0Yyd6OnwlIzzkRTlXPnZScHUFVcgEpmJukwBrqhLXjbIX7hTIddL
	ZBq2Vaer/vzaIUHXLWpm7LDY0XvlGm1EmLKldYavs/jEQw5VkOTx2gphOomt+Q5tqrlkKnY7XX8
	v
X-Gm-Gg: ASbGncuodtZ7LhKKtgo5B2403EJ5ePq+Z8vTR7hgJl6HDlLGqEZSh77UEgCHyeUukxR
	o/cvZkENJY9dunwBDTwy8qsaMSNND8AhU1pYG0lyxbO/91PqAvC37hzlZp1iZxAcspcbjDnLsJ0
	D40L3cczYZloB0wtcrcfDTJswDO9JbfyCVWE8h4Ni+iVJMp+GI936dJ7YlSKH1a6O0Ta5/B7EGE
	8FaddwLYKh8i9Ufh7aHxaZPZGFu8D2PdrtjiqA3Tb4rm4EHwpwIqocoxOJOvpUIltqOw2YYAEwe
	lZPhCiDiNyc5gm8hHawpRIYh51nO65a1
X-Google-Smtp-Source: AGHT+IEXgE5gvpCD2i/FMJ2BBc0XnzFtTx8OS/CVSPhhWEoXph+k2xqwyvz9qCEqorfUj8MbG4mnPQ==
X-Received: by 2002:a05:6e02:1947:b0:3a7:820c:180a with SMTP id e9e14a558f8ab-3da739326ecmr25693975ab.19.1746617879155;
        Wed, 07 May 2025 04:37:59 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975f6d809sm30095175ab.65.2025.05.07.04.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 04:37:58 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20250507092537.3009112-1-ming.lei@redhat.com>
References: <20250507092537.3009112-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix warning on 'make htmldocs'
Message-Id: <174661787810.1789654.3857004286432977507.b4-ty@kernel.dk>
Date: Wed, 07 May 2025 05:37:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 07 May 2025 17:25:37 +0800, Ming Lei wrote:
> Fix the following warning when running 'make htmldocs':
> 
> +WARNING: include/linux/blk-mq.h:532 struct member 'update_nr_hwq_lock' not described in 'blk_mq_tag_set'
> 
> 

Applied, thanks!

[1/1] block: fix warning on 'make htmldocs'
      commit: f31acff017b1d80e649f674450d3b64d3265848c

Best regards,
-- 
Jens Axboe



