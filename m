Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8412EC0A7
	for <linux-block@vger.kernel.org>; Tue, 23 Dec 2025 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766471647; cv=none; b=dlKLpVRJ0Uq8MP00B4hjeHBuqj5CsGXaM5SgSDUuqklqVLqj3HeJlybAsZcdIp7SsXiFKAyb1nVfwFEA5BL7eK0EL/A7rx9nozDhq13QEJgb2CYWAuLQybjjXEZh6+DWVVrfW+Fd55nEjpLLzm4cbMRGxBONhV/Wxi1LPPxxeCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766471647; c=relaxed/simple;
	bh=zQMCxWwv+vy2hbOmutXkA1vn5ZNuVRvD6yhOueNtNZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nflj1T4hzDon7qgr7ulnuLU+G+GgxXMJJuQA2mZQamkjQB/kN5Z2lLEugpbo2HZpxli+Bowhw2YJDvc/O2lWsXILkjQae4w7Xmmy/luSyjQ4B1BSSfbMpz0Fq5Z85kjdWdjDH0bn0Bstr5mNSjjN5dyO7TCwIZDXwpPuYpEV4jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwAmUTBH; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwAmUTBH"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37bac34346dso34521491fa.2
        for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 22:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766471644; x=1767076444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=048jzD37H8lsx/zZlGI/PEx4g5lnBiNM8RokzD3mdsY=;
        b=WwAmUTBH+Z8XRKtBCqY+p4vhvOZdSmb+n+f1cbt8viJVJQHBr5U0jo/4s6d7qWWbBf
         m0+yEyt1/jvRcNLPLCeivO4iEJDrI+k3zJ4jS2PQa2ZNeiL1Tlbub2tME3cf4CpV5t5x
         y2v7G9wdrigZhwrK4c7Yef+E/fzqp/cS5XJetFqG4hBREaOaTvMWzFG+nlcM12NpLnyV
         bWftFqc5KSBKZ0BFk6cyJPxHYk5+KPRoe6KeznkQ0/TJBWIgfaUW2op7B7NEb1bQFuep
         6NgElzoJ6xi+uJ6OfcZAZFe+8coZdOUBZ5vF3OSWtmJtAEFFTI3kGZUoLI04b5pvc8/0
         nauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766471644; x=1767076444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=048jzD37H8lsx/zZlGI/PEx4g5lnBiNM8RokzD3mdsY=;
        b=cK0Bkomraq1XT/m+LNLdzxVPkyIMq4XIdPnMlu5sK/90TnlTg/Qwuz+My8+QQaeplu
         zYE3KyzKSjKZlsPywf3znDvTs1Z3r2jTX7XyvKuIDhLFZ6QGvCN9+BPg8EBqWhapSq9V
         WFM4MeZCPXxdqBHRTZ40ywywSQ4Ys1addTy6z5RtYAEUah72lxtFGEAtlp9L9ix+S9va
         Na+n0DvoOg3Tgm2QGnz8tlSY83Kppmj4lGFj01u7u6mHwVcg62jTjl2k+nrg5NU3zVkk
         H8x/yzxgHO+YxkibQo/hRjKTkgqlMbkUBZcblKze9dgAr08NULJFDlNPuJLGFlp95/CT
         TZ8g==
X-Forwarded-Encrypted: i=1; AJvYcCW3TNRuaQJpgPmdD1KWdEPhaZwkkHA3YwKLfML9R5SPYyFAEMe4VsjeOqRwddIeoV2Q2OYuu5AV8NK2Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwSkNG+rOvhzmeIjIku8ts8JXZSiEyFq7lnpb3lxVZrZWAUFpLW
	2XItdLvWIgGoSvBS9Wfv1ms29sDRPlP0+QNP5WrXV3kXEQCN0XZBpcmo
X-Gm-Gg: AY/fxX4eUJIkcYqHY+25GG/REa6M/ZRTZ12Rt6sV1kgAtHcJjWCWZkRUfIQQS1m6Kzt
	CjmY4ze6bcIaFoj4Ia2VaIC0LiA/wVVxVRlFoBVzbKa2Ci8U+xVeyLmcnFDkVNReDjN9S/r1dJJ
	21Yr2pX46tnGIbOt0Ho+v7bLZbagcYi3QHbaccrdgsDdvJCyrdf0SzTS853VD6CCKW/jlLsYLJc
	p1FMrrtjCA9Bf+9p+KRS1G7H4VZE1154mYBxn9HQjOOOhk+prgKBWhOFcUV5OTAdgT3ccjUUnJQ
	u6s+9LXVWvthNfQI0+92ZIVHC/2Upc+Fc/mDEwYnVlMcJcY1BCyQwIt472ZAF3XYcRqO0BKjrMf
	Cyt88pSlruANen+Ejh9CGRKIklum1wFW7e2sga79LOOGVRYnq1Ic6wtkE3E3DFTxwET5Fb/Lg2V
	Vrojy2IyovOcFfhQQq9z0=
X-Google-Smtp-Source: AGHT+IFaFE0nlDnowk+Ou3U+M9eX56ZCvZ4aEX/mIAF0sQ5oS0z9Fh1vnyWDY8DQIpJC2t19J66zfQ==
X-Received: by 2002:a05:651c:1506:b0:378:e055:3150 with SMTP id 38308e7fff4ca-38121566b66mr43783861fa.5.1766471643890;
        Mon, 22 Dec 2025 22:34:03 -0800 (PST)
Received: from localhost ([194.190.17.114])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-381224de6eesm33742031fa.6.2025.12.22.22.34.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 22:34:03 -0800 (PST)
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
	rafael@kernel.org,
	safinaskar@gmail.com
Subject: Re: [RFC PATCH 2/2] swsusp: make it possible to hibernate to device mapper devices
Date: Tue, 23 Dec 2025 09:33:55 +0300
Message-ID: <20251223063355.2740782-1-safinaskar@gmail.com>
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

Okay, I just read some more code and docs.

dm-integrity fortunately uses bufio for checksums only.

And bufio allocates memory without __GFP_IO (thus allocation should not
lead to recursion). And bufio claims that "dm-bufio is resistant to allocation failures":
https://elixir.bootlin.com/linux/v6.19-rc2/source/drivers/md/dm-bufio.c#L1603 .

This still seems to be fragile.

So I will change mode to 'D' and hope for the best. :)

-- 
Askar Safin
