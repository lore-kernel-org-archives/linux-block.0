Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D031A37FF70
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708535; cv=none; b=uFhi2U0eBY8JXdrz+hpZiX1bhZS54sYtBpGI+nAjRMt/4y0WZgVNn4580u/I22P5aJmhQ8ajb7StOy+3VdFwX9JCVEYKNh8XOZSVM7QMsgtDbuUmGvwZUMLt77gf0+H1UfmL8I+GvSUfOpJwG5Yk6Kq2dLt5A4547J/EGBVd+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708535; c=relaxed/simple;
	bh=FYq+ufpnoB1Od+q+pFk33rw7pZTsRQAkgSWLwYU5kMc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jrDGqa4Zf4YSon/GX85tnyLCb6gl6l/8TolEsPKrTL0Qnl0V7RtAViW/r0wRWlCrmiCoboGnTIjZIWbhpOa9L0uN7uobenp0QPV13hD2TscCRz+wKsi9UbEtinctTc942rWkIuEKeDwX8Y7zDmKoAcyIzod098E5De3hGHSnIwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1NOOsobW; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1NOOsobW"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5ffbd778410so406395137.3
        for <linux-block@vger.kernel.org>; Thu, 05 Mar 2026 03:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772708531; x=1773313331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOx46F6ZAxHltUyYEJyT3IZOM/FgFqlzHdJf5Ml+RTA=;
        b=1NOOsobW/p8ooFgxilxXKY8sVbK4io1jI8UxI0DjwV81ikUFoT9qOIqpcknidzgjTK
         moaLAhDUK8K8YV4mFu83KUqILp7w+IwyBAlkbBzBzJ9xXy6dXSo+z/Zl8hWGNnzFGdLt
         Vf6xJpjBkasp7GUHOd2x/1JZGoybxFI9uQhFN9XmEE1VS62mUQU8wTO6/F04Mow0kdGQ
         wDQYdqeErtoTm0OEdosuywbp+m6vaj+Ge5TkjgG8quM5GlNjeZNVz4ntf5dS83tJ5xgj
         h0rgSPs5vvQhQl2bccYfp11rUKuMDCfazWd0VFLpLbvJzTrNW5ShlfLk2lwW9F4+r8+9
         FVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772708531; x=1773313331;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NOx46F6ZAxHltUyYEJyT3IZOM/FgFqlzHdJf5Ml+RTA=;
        b=wVUHukGREYqIvS/XvDuvgO0rPQI9vDiG8Fe2NNq7QvHELQC38J/7sZd2G/Fy16F+Zn
         prfT9UqtvlimYiChy8hHw9xHe0XmA9EAS8PwTUlINWU2Vaag6R++Md399JoMyO2A3ryf
         gETU6VjQYMiddYBs9gXpkjQ+c9SoiEWhu9yal847KjDh6YEFX63RmGIgIVbg/Mf1REXy
         0JjfPlFUsYZq1eTzxANj3oz/fX9TiGah9CnU/vYBzGT0S8c6z/jwcpnk+BTnY6HSs90i
         r/CzsrzPnTFPqPfNejYNYwAMW9RPxFSB8xlYAN0GYZwqkoLLxBCLmNX3SGGEOoFakzTy
         X9eA==
X-Forwarded-Encrypted: i=1; AJvYcCVQDHp7s0Gh7l62nZGMnsw6zjf0wYmSDo2p+zAU0B41CfIpM7bKUXEEVyY4DEc284QWWCHH12vc8zjzbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzk0KJo0KiZ2PZ2Y7YSXkRHvZxSOoJKdQsumTbMU0/i4N8E8kG
	SkWWhaW9XTFHEcMQcbBg1pzsTrBhvmSQMoy5mNTiysIAhcUaSLpMv8GgYE5hYMw/G39G0Qv3QzP
	PhL+L8EM=
X-Gm-Gg: ATEYQzymYNAKw0t9WGWMBSJ05DZwt2MEqgHQF9UWgN1dgA0+ExoiEA/GdvKVHQ76OVO
	QuZCIMwXomkoRwCqrDZs8xs5cxOYxO10A1geAE5iJipLCXaWLdYjyRfVZz+ROGwRGyZFvoWSo2N
	HZZwHmopIUwg6DV3hn3p0+NZUzhC0YmYAszBFYJzh/5hg8V87dZ/LrgRI5Wqsa4jNbztn67LF2t
	PaH/FaDjZRvQU59H8W9jpr8srZhzh+QJ03fMR/DbdK9Yw3rJlTGEKB5IsF1PFfggV3k8Gy96PAg
	De6KqFXBU1+QvaimtZ4xwuf7lJ0y+gnyWo8um56mpO/4UVT7n0YIfGdN0vPhIcI+wKbad1ZU897
	rAVrj6u/5hfjfV8WesoaF3m12l3tteM7FmnlArzWvXc4hXevByTviGMnYM3T4/yzzCx+uHiuKRL
	f3LRlOdClvulnK/rJbxNnlCkjsgB89I26afms/wbSAMyrZmIPC9dKfPVJNw2VgyyMy/n772ISWy
	pxFtLKIdyvjaCICUCrsFKVZR5GI0o0aLb6+N8sTACX2iw==
X-Received: by 2002:a05:6102:c8a:b0:5ff:a606:3d0e with SMTP id ada2fe7eead31-5ffaaee6b25mr2030322137.23.1772708531032;
        Thu, 05 Mar 2026 03:02:11 -0800 (PST)
Received: from [127.0.0.1] (syn-071-043-216-131.biz.spectrum.com. [71.43.216.131])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ffd1d8983dsm602937137.8.2026.03.05.03.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 03:02:10 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Yang Xiuwei <yangxiuwei@kylinos.cn>
Cc: hch@infradead.org, kch@nvidia.com, linux-block@vger.kernel.org
In-Reply-To: <20260304045119.396832-1-yangxiuwei@kylinos.cn>
References: <20260304025335.225965-1-yangxiuwei@kylinos.cn>
 <20260304045119.396832-1-yangxiuwei@kylinos.cn>
Subject: Re: [PATCH v2] block: use __bio_add_page in bio_copy_kern
Message-Id: <177270853008.429313.3455132232549739749.b4-ty@kernel.dk>
Date: Thu, 05 Mar 2026 04:02:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 04 Mar 2026 12:51:19 +0800, Yang Xiuwei wrote:
> Since the bio is allocated with the exact number of pages needed via
> blk_rq_map_bio_alloc(), and the loop iterates exactly that many times,
> bio_add_page() cannot fail due to insufficient space.  Switch to
> __bio_add_page() and remove the dead error handling code.
> 
> 

Applied, thanks!

[1/1] block: use __bio_add_page in bio_copy_kern
      commit: 8da8df43124128e0478beadb58faa9cab56a3f13

Best regards,
-- 
Jens Axboe



