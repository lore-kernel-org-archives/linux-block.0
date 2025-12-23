Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A628434AAFC
	for <linux-block@vger.kernel.org>; Tue, 23 Dec 2025 01:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766454091; cv=none; b=F4TBqHp6eBE5QoLb96IwL3HVHrrCqFH8SsT08etayRfFHBOhh2cLW7Dmrfe+HG4Vx2qKymexAY4hA/K5i2qvYqQ9M0gXHh1JQO2iG9YyjILHbAqdByJSDODRI/TR8mPm75ztwW0JtxX4eKNfteVrNuXbxGAWdS+6fB0LVWxrSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766454091; c=relaxed/simple;
	bh=Dw1tVh0CmnWqKDbnt9xHH3i4dpkMlWgLPtv4rSVZoxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wb1+Ru68OjCEY7d198CYqso/1y2KJ5dEqbaigI8DO+78twc6/phQpAlrVRB9uUPOFe4NUsbNxaONFIkzbIHUVlHqlxOUpBTcwGnY9ZgYDICEgs6l3YhDEzuKvZ7lfWPYOr/CCpy6E0HjrJPwxjs4ATU+e4RNb+zYnCXnUPhossI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfOsId7s; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfOsId7s"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-594270ec7f9so5340027e87.3
        for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 17:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766454088; x=1767058888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uzc2azkAT7+UZs63CJT4nkeSpZYqRpvq+hUurVd9/nU=;
        b=OfOsId7sIcDGQy2pTh1vUpxLeUMu89wMN8s4Lk5g1kjn6irxsnAKWeUrpNqRGyoG36
         KeetWAt4xPplCAfvWllRU2qX5LiXDYmB4HICp0vluIlAJj36byf5FlO7IURPnAFcLIfz
         EdOrskXj59Xi4pyqUHPyuUwgjUIFaXZtWIz1k+TrIRp3q+8hANEkpNpTzlkL1uX3AgQ0
         ZClbOvf3LRxSqsQg1qNBWzRHYzc57vVVkz/mG+VKQYTkkt3PAwUnDwDy8f5K8XKVszoR
         AeOMq3ZA8JcsAWy+d3QFwQ9mUBT9ymlXsOOpr25TL6BQd5Dr8Z9ZO80mclH1UxWOzlrI
         yN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766454088; x=1767058888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uzc2azkAT7+UZs63CJT4nkeSpZYqRpvq+hUurVd9/nU=;
        b=FWwojeXvSnvSvSd3TDpv6lv7hqPb6aZ7NclgO/lgG6sVDlyfLU/oJY+VByRItdsLGt
         wpOYjlLad43kRBlaFHL3OQ514TUVhX5EglXp4n2ofrjBn1WLcILQW1AFy+fEaZ6v+7dA
         hCrOVv2Vu3N0iHqSO2PI1OPotqoDet3PRbUY+tcmgveuQkaRDf/P4HEEtnIaCKIP8dvB
         DnD4aDVecDUxZG6fR9TH3FTDGj/XL8OLNnrpKLVTuhkh5lgvdvVx2sCcb/Am38t4Tt00
         8nEiLa+irANCOuLnkUJpXmO+GnRXQJvov+fPUXPOtQif1d5aRAnpO+oLWhUvTJRGV/dG
         r7sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY5YczMPuIGUoycE+ZoQWqA/aH8zvQDfToEUwDExUoYuoNeEFCX0QVYZ5+6FsslxTN+6SBinNdb1gkUw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1baVE8g+fSe1ODKFo+hkRYuIaHlx5D2+RyyfH4lwZABcDc5+I
	JlzyKnOFzWYGIiaJZttg6gIUWnCY2T4Xpn+4Q8vpFW2rI5xv0To2dDHC
X-Gm-Gg: AY/fxX7GC9TkAx2J8u/LSBVcChu5y07H8HZQXl/zlk4CXxbO5M2Q7EOlzbgG1mi3B/B
	bSn1Okr+RpWvjwq+rZOfQ3B9L3Ky2S5xhqGvuwZFsm6HEius4YdtOzYfoRpB64z3KVAxDUGbBOD
	Y1dj7tq0yojPK6eSiLSBLzx8dLe3yh6TcYT7OyJnUdRpWzIvFiOSBPWLkcaffRZsuhVr1GsGTzI
	K59OP9hMoA6tRbwskVMFbxUYBTAOki285stMs0X/cvzmefnVnsxvddQF+xsiNjM55xSJj4TqeEA
	r5DuI1MtGi8yIuEvl14XfpIh2ZaWIlU/oDfZeIKTBs6tllhQiL3vvNX5GMHOAK86omp7OD3NPCY
	mNzzhsVYEXU/xW8262mle4ibR0mYBF9TG92vmhCRcOA0EqsbvuMhcxwiYqAUWElNNSs3TjiF5sV
	wGt8QJEeqA
X-Google-Smtp-Source: AGHT+IHWUix04V1tUMjJhj8LmwIJFsrYjMJ2eegt/yizChdKwHOARh8H0MmDtl7KvKnzF0od4dTcxA==
X-Received: by 2002:a05:6512:234b:b0:59a:123e:69ab with SMTP id 2adb3069b0e04-59a17d08c20mr4858078e87.10.1766454087534;
        Mon, 22 Dec 2025 17:41:27 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-59a185d5ea6sm3600776e87.5.2025.12.22.17.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 17:41:27 -0800 (PST)
From: Askar Safin <safinaskar@gmail.com>
To: gmazyland@gmail.com
Cc: Dell.Client.Kernel@dell.com,
	dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-lvm@lists.linux.dev,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	linux-raid@vger.kernel.org,
	lvm-devel@lists.linux.dev,
	mpatocka@redhat.com,
	pavel@ucw.cz,
	rafael@kernel.org
Subject: Re: [RFC PATCH 2/2] swsusp: make it possible to hibernate to device mapper devices
Date: Tue, 23 Dec 2025 04:41:14 +0300
Message-ID: <20251223014114.2193668-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
References: <86300955-72e4-42d5-892d-f49bdf14441e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Milan Broz <gmazyland@gmail.com>:
> Anyway, my understanding is that all device-mapper targets use mempools,
> which should ensure that they can process even under memory pressure.

Also, I don't understand how mempools help here.

As well as I understand, allocation from mempool is still real allocation
if mempool's own reserve is over.

-- 
Askar Safin
