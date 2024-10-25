Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C28F42A81
	for <linux-block@vger.kernel.org>; Fri, 25 Oct 2024 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729826339; cv=none; b=nZwfUQWEZOt3H9t2o/inQF4YRB9/Lj5OFy93OUdcJWrMyyEeQ00waQ3k8HyUuM7q+VAatfQtbi6YWqJp+N+/IDgFuFOi3370WRRw9FI3pjOH6PbantsSjhiVW2W5N+TGeOXkg040nKHfIZQcMI2X/rOt5obP5nJv6yBhi1TEHDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729826339; c=relaxed/simple;
	bh=tXQkeaeiyjrP8ovNzD7qPH0VZDqqmd80n8mUaW1CdTY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=bUvNEHhlgjjkZ97fuYPNgZtF4rPnTG1Ow8fkeRvuA/1lWM5DMvyKr8d5K0Z7BfWZCYdbKij+UKLv6FgHmBeaE1+2pq2YZB73xCdJ/lpwqKD+tEtZ+3zqCCBIwLJdrUNIOf94Uk2yTdvc7kenSJ1EoE/a0JPo5b1j0pHM4wHpYAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=crIVqVKU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="crIVqVKU"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7203c74e696so1158728b3a.0
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2024 20:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729826334; x=1730431134; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXQkeaeiyjrP8ovNzD7qPH0VZDqqmd80n8mUaW1CdTY=;
        b=crIVqVKUWkbuJ8p4m4BSg47Y8e7SyXbJqjBzf/0riDVD7ZDDPjAw5IJBEAsGJq5C/K
         NsdpxYP9M+jfpdODD898Zto63qX9DIuI2dAwO3+SA2WLJLKy36zlkc+8CXV1l0oP+iNq
         JO+LymLuVpEby5En4/k6BshEKKNx+96gBVwDPVUENQ0Lz6G3+5mH+THYtW50jTFIkg/N
         4OR80+ZQ/PSs1ZwqBENjM6cQcCbJYu7hRA/KexgaS/87UmlLs+i626TEmYqEKoa1wyrG
         Cn2qiGd/q8Z3aaQRNii39dwjiVofxvGvq072RxnbgoZcwWMrHa0Ohq1f4perDXvA7zEi
         CUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729826334; x=1730431134;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXQkeaeiyjrP8ovNzD7qPH0VZDqqmd80n8mUaW1CdTY=;
        b=JPkBtyOmEBZU1B8Y8RcEfrYnRsR6oiwnUu2mSAkSPOfwQZfmNKAVwACwNl9q755kLv
         YP5NcPeJoZiGzNi/DX4CmJCt5hT/tgY0w5jdrnTsTozwcT0dgxoxH9lSh8y8aGIVhgxj
         ruLSfsjCvoyQCCgC6WHxCYvN4L2oqzhF5MaxDXomEFDAWo2WSYyuQbhu2k3rGagGJ1Mc
         QmDqk5D8BqQahKV7LbnSZT8bcojry9xEqOsIfLAOi/g8msh8otmdbNJtAMQ3glEP6U05
         1sxLnrDBKSmiWk7VdOup9wTUyQW5Sp2y8VZZfZd07U2tYS0UvPvqe0iihXXCc+bTVmQ+
         4/rA==
X-Forwarded-Encrypted: i=1; AJvYcCU2nuWPPNDm2jDsuAqQ5aVtaz/ImR/Pd1rfvbDzwyyCTvf5yTwMVxbXNwKvlih4bAX8DmtPuSeuXd4srw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2eeQKTg9R9FhbDIvNo/N5HNxNChYFE3GouKV5r1T/YS++HPCW
	+5qxTq4Hf26q2fmc4C9vNjThaHDkMyYDUIR88iKxF7V3YfiRQTIWZMmu2MR4+Te8dxFu6r96aDl
	V
X-Google-Smtp-Source: AGHT+IGMOtUun+mqvBAqwf3N2awxftRn2vQwoWZVT/1fKy4JV+aPQ2RLWjvghe6xyUDIIdKrHEXEmg==
X-Received: by 2002:a05:6a00:2d25:b0:71e:6a99:472f with SMTP id d2e1a72fcca58-72030b992eemr10198723b3a.24.1729826334455;
        Thu, 24 Oct 2024 20:18:54 -0700 (PDT)
Received: from smtpclient.apple ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7205794f996sm164136b3a.93.2024.10.24.20.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 20:18:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Jens Axboe <axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] blk-core: replace call_rcu by kfree_rcu for simple kmem_cache_free callback
Date: Thu, 24 Oct 2024 21:18:43 -0600
Message-Id: <9324E4C6-5AA8-488F-A26F-8868A96747E7@kernel.dk>
References: <20241025030709.9520-1-zenghongling@kylinos.cn>
Cc: inux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 zhongling0719@126.com
In-Reply-To: <20241025030709.9520-1-zenghongling@kylinos.cn>
To: Hongling Zeng <zenghongling@kylinos.cn>
X-Mailer: iPhone Mail (22A3370)

On Oct 24, 2024, at 9:07=E2=80=AFPM, Hongling Zeng <zenghongling@kylinos.cn>=
 wrote:
>=20
> =EF=BB=BFSince SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache_=
destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.

I=E2=80=99d take an extra look at that one if I were you.=20

=E2=80=94=20
Jens Axboe

