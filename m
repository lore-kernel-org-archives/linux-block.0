Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C7D2AE6A
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 02:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742439011; cv=none; b=P90J/nAYrv3/kjFfvqI4txo2nz8eD2C3MxYfpOi7xO1XqhNh7AGMpNiOz9uPGcBeKeNuQXvWUrFXAhjsA/ODR/jeFfWFaZh0bVQb2cYRVxg2Y2l5IYyfHuLiaSxKZf8Q5VINRPlZLum/dtd9n3G8g8u1dEoGiqh+t1tcG2jaCdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742439011; c=relaxed/simple;
	bh=P3SiIqeVRj8iaEhNM+RBJmR1hKc8A4iDN9+dTEaaRcY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=A92hsQpwXW/mCJg0xr3KU/5/UPD+f/M6x6xGMxy3GUwH9aahbEeoHMv4tjglJYqeIK4cUOKBkDajbOgFU7o5ywtwfqGK94EwU1MOwPwFMuT0YMcQClWDKOZvz2CRqSsevaJQaOrErSEEqvh1PH3U2GQrGVx1lDOY7IQZBZM45gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MNc2KZDW; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MNc2KZDW"
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B70ED3F2E7
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 02:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1742439006;
	bh=B6K+THwXySxBQJQOsWXD4oxCuQIyOq0AdqsbklaeKoI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
	b=MNc2KZDWkNTrQrKEU4WEFt0aQkhudHoRADEFdl4WXt+gO77ygT6rd6oKSrAw2RSkN
	 s9nkqo+q3AbPH8tpyx9ZDJa9vMitKgIYqoGcbrH78lsTEdSQ0GJoyXswdYURiPExLW
	 A+RDTpqgCdPgFP6EmkNxzOquFTD+j+xeoxSg0zq9EIBgfeEr37pxiU/BeaILn32Oyt
	 /ZC0nVUUny6Ny4qtByq+OsPu6Yr/A4aFolK0mi/YIXSMKrvg8ypeCr2dNBhlNfJpyL
	 QhglWQSH91RrRYSiq2+z8FhnAe7lt7ZB9N8BglMRIHqV5hYi/FX4ylIV7rG7deS3sn
	 ETnAGZarGU+ww==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac2db121f95so23295666b.1
        for <linux-block@vger.kernel.org>; Wed, 19 Mar 2025 19:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742439004; x=1743043804;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B6K+THwXySxBQJQOsWXD4oxCuQIyOq0AdqsbklaeKoI=;
        b=eptrh4buM5+xH3OqujOAfUo3pDIHUdO44AwBOXWp4ZjmK3zTa7OTV9egghQxO8pzyL
         yqj3pMVnkLqqrMCDu4WCmIYPWw7pQfxRDkXuh9p5EGRTx1Ryz2nrdIvN/0HIEVCeeR1/
         TK7J7bJX2q0XDw74tCBF22KlCK0Ii9XgUWuUP1jc9gKg6OKQJb+IPfeXF7yOZdevGJyy
         ly0Jfg1vIDbHcpQR5PzaPxyrjVRSuLn/f4Tt64freqHp0lry8NVtRcA+x8B/xd/JwMgN
         0rO7cfnGDyT6yt9bttmQlxR/FUvPGzFdiCuxjGjcxRD7tINtdfVNmYQcrA0sYFck6Hbi
         fG8g==
X-Gm-Message-State: AOJu0YziVG2Blh3xxu94Ug5QE1e0xZQapr7+dbq+WCeKwTCIroJlJ5zO
	Y13RY+mZc0GSHRuYWkHj+ZYy0rVvajRuRSM+fz3+eJBve/IgX9UaHui1LDI/1K5S+5cphfLjHw6
	Lk5wWgaVEt7dCaTpH2U4SOVTpsudF2U0iAAz1278gMwS1mneSJVGuQj+Nl3JMciFcoJfYMQ4pdx
	lSvREiLCaFNF7Jf3YMPcWhyyT3nbFhNoULuOW9PCEfPCA1vO8hGR+bfMu2BBJQd27n
X-Gm-Gg: ASbGncsbW3E83pNChc0D7mQWFdgSHcIxQQtBX+TvGvl5tknjMRHnYrsLzHY2EEEJi8/
	rORWD3RW4R07kOWJ/O9688aYvbkhe4kXcm+PgtkSOGnl11/uwJRFXx/SoknfBCyqSH9LuLc8wOr
	AwCMQiNZ7tspml0n8K
X-Received: by 2002:a17:907:e841:b0:ac3:c7c6:3c97 with SMTP id a640c23a62f3a-ac3c7c63e02mr312152266b.0.1742439004260;
        Wed, 19 Mar 2025 19:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxwS+F32m6Dcu78HgQNZGqxJlY3fybv+AmFOl0HtP3didoMbVm/KSAg3G+rEAHFJesanYJAO0wJ6h7PYuGw58=
X-Received: by 2002:a17:907:e841:b0:ac3:c7c6:3c97 with SMTP id
 a640c23a62f3a-ac3c7c63e02mr312150166b.0.1742439003877; Wed, 19 Mar 2025
 19:50:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: AceLan Kao <acelan.kao@canonical.com>
Date: Thu, 20 Mar 2025 10:49:52 +0800
X-Gm-Features: AQ5f1JqrpuKUwPyaCxlP-DpgVkJ4Rtp6uFAR420KNM7iPB4x68hQryVObfFPATM
Message-ID: <CAFv23QnqgTVoB-XRe5yNndRz4-Z_3y38+QpKRxQMeZ2xQTg=gw@mail.gmail.com>
Subject: Regression found in memory stress test with stress-ng
To: linux-block@vger.kernel.org, axboe@kernel.dk, 
	Christoph Hellwig <hch@infradead.org>, 
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, yangerkun@huawei.com, houtao1@huawei.com, 
	yukuai3@huawei.com, libaokun1@huawei.com, Dirk Su <dirk.su@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Hi all,

We have found a regression while doing a memory stress test using
stress-ng with the following command
   sudo stress-ng --aggressive --verify --timeout 300 --mmapmany 0

This issue occurs on recent kernel versions, and we have found that
the following commit leads to the issue
   4e63aeb5d010 ("blk-wbt: don't throttle swap writes in direct reclaim")

Before reverting the commit directly, I wonder if we can identify the
issue and implement a solution quickly.
Currently, I'm unable to provide logs, as the system becomes
unresponsive during testing. If you have any idea to capture logs,
please let me know, I'm willing to help.

Best regards,
AceLan Kao.
