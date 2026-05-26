Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5843B0AD7
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813423; cv=none; b=aiMldndVT8f2nX3lOrahetBtKIdsXR6G9CY0EVd2CgnFqjorjg9JqK6Oibxra/AVXazOoM+FPc/JBMeftd94da5saFwqJCvRVdmI/nZ9adfGU0DqBOCAT7AghDUQnuZ/0vJJfzVZhQMWxUH/4Ik+jU50UWPzaHRRIBsBdyZKeWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813423; c=relaxed/simple;
	bh=s+BHrTyK+bMHO5iiJGA5ie9MctNkpfULkFQmmfjBr/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JyVOLW103oT/GMyCcfD7k5FS8cRSHMXbAA3ZpBMBivpyVuyH1GEVi8S3cZnzZMATDOvk1BfMW9BAzoq36EDzSnD0dYPFY8URlMjh1AJGbC2UH4Oa/A4EDLxLlhJP1tL3t9IEDQjRvNqc537uKnGp6pJGVJbamhw9tooM13g3LaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=dT2fjf3a; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="dT2fjf3a"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-43bf95c3f6fso1063550fac.0
        for <linux-block@vger.kernel.org>; Tue, 26 May 2026 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813420; x=1780418220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGmZSJTM92Vl79lLjuAT/E/OXHWP+RudsX5qZkZ0lRg=;
        b=dT2fjf3a2HjlDfoj3CIAkKoJEEQWpI27/8dXjkpy52+zQVitgzRUTRn/EK5E7hQsr1
         2Jn67mBfpLn06Zbe2fjvN6aLdFI2MjpUOWShsve/zi8G7FfL0tgAtHZayKdWmch14pXg
         FwWOtQitmG20dFyAjXZ8QG1H0o2+qCdbajdHuNREjOua9BCe/LgKu7lQj6tvem5QSwsZ
         Ft6mIf3h45vUDPlCV59UdXW7J9mk4LX2xOsni7N0RuCuvQHLlwsGGn5PE7WgcUD0e3Cy
         ZhESZV9aB57C5DpNYZi5UnTxo5Vok4OMRrVEzfz45tn+qsSRC9O971IPQtF/hYgmQlul
         jGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813420; x=1780418220;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LGmZSJTM92Vl79lLjuAT/E/OXHWP+RudsX5qZkZ0lRg=;
        b=Nc0ltgYWhUd06aNQkal90GTynkg1x1I3RY1GoY76BDe5sT6ek0ud5gRtsAl0IL3XWg
         Fp+V8zYZnODqdLwrBwOA+gE0KXoS78KEUW46ZihJq3tAPrhDlXqP+ilQRjewTBmdgYS2
         hb6danwD4b1NnQpliHI5MnoX8onABXZWABn+VHTVVUjrTTFqaSzbske35UezYEn3mTYf
         5PQ11WaoekbbCr5O0rzFmL7/HjPVZHJjjetsXVAB+EgYJYCvHqvCFZ7n2iDQa3vmHWSw
         SGkHvkVdWjrQqOAQwBLHQyeqOAh8L8y5noh1c2SSVKGURlcgySBeGmuwoDXg1pDGVy06
         5EqQ==
X-Forwarded-Encrypted: i=1; AFNElJ95YM2E99lVXg7WDHycN0UtiQUlW6xqXQyYKD8qYhFhwsHSlyk1+7dGhtJ5A9Q5QjVnqFLCLUpHHXLEsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7J71GJbszxkvIHEkMd43mVs6ukvznjy1FO8VmEeOywloNZ2kO
	M/c630FTlk1t5zqs/jW7D6uFxcj3ATGDazfjhUMiA7x6QJM+E0Jc+ItWuK/9gg5572w=
X-Gm-Gg: Acq92OHOgzUs+yHi8vajQE4dbXb1Pey4clMkVuUc1d/WFRdbm6XhnVqhtk9FAbsvkZ8
	WkiJ5vwrumB4R/tzhryvhP0C8qBmA+GhV3a3u8ymEEMyWTkvgwTA2510JLUDKmOxuPPma9WaPKY
	X5DU03NZMn8Mw4VlDReUrNatxmxyJ2rKO+gAv09WKJDRxK52dxuUFQV9056ptpYPBgzJRy9HhI0
	meaU3O9qxwNf2rdGF3bE80y4tTNt6aynruVmTAvA7yxwLhE78zq9V6rmeQQ0m2axZ8om139mtGD
	jVX4RQj1wtfRFYnzTJwwketMdrjjvKH5vfuJRV7lyhoUKH311csjfbSI87EIGNlGimh6+Vt6GET
	ykjtV+AdXFA5lozdzawW+0eFbgM5Rchk8NqLUrluH8N7KiZQDJi7KzOkLqjUAE8EEIJNYN7wpz9
	cVAeobEstIfGVaJ9ndrFZlGd02Zw4z5S3e9Db+SHY6MW6d/E0Zz1M1UCZpLrlVLTYKR/1onWUl3
	xU=
X-Received: by 2002:a05:6871:ea14:b0:439:b99e:4414 with SMTP id 586e51a60fabf-43b2f7fde1bmr11858804fac.6.1779813420627;
        Tue, 26 May 2026 09:37:00 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd7adsm13561265fac.14.2026.05.26.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:36:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: stable@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>
Cc: Josh Law <objecting@objecting.org>, Kees Cook <kees@kernel.org>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260526102124.2283846-1-vulab@iscas.ac.cn>
References: <20260526102124.2283846-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] block: partitions: fix of_node refcount leak in
 of_partition()
Message-Id: <177981341919.464267.12762011041724879743.b4-ty@b4>
Date: Tue, 26 May 2026 10:36:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 26 May 2026 10:21:24 +0000, Wentao Liang wrote:
> of_partition() calls of_node_get() on the parent device node at the
> beginning of the function, storing the reference in 'partitions_np'.
> This reference is leaked in two paths:
> 
> 1. The compatibility check at the top of the function returns 0
>    without releasing partitions_np when the node exists but is not
>    "fixed-partitions" compatible.
> 
> [...]

Applied, thanks!

[1/1] block: partitions: fix of_node refcount leak in of_partition()
      commit: 148cd4873115feb266c002d4d4618ea7f14342d9

Best regards,
-- 
Jens Axboe



