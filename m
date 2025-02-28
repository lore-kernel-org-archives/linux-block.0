Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019FF26E63B
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751744; cv=none; b=iWr5AOGhkWPWeSykfqOY6tEcvzab9wqUq9fijIsOInn/q02wYMvK5w2oHcLxPxyKrIHBi14V5vd2Y3WsllNmGJNzmUrpIHStTFSPTiyEPVPdiFcR8ZBXQ26TfecSsjcYRsbDMcBTJ90lry73ZKXlpakgR7FNgAueddkVfkCpLIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751744; c=relaxed/simple;
	bh=wtRdQIjxj8oZDybNP77Rq60JK6MGRMlW4ONrnA4kUE0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=T+6QYFRLlRUxotXJfJ9RSRDllj5MkmyzUXA4xboQHYyQ2diuFLrqqIQ5i1wXqglxfMPTwlx9KIClrYD/jY08DDUe8eRawB+NOva3Q/utAHIV58UYM1JRz908ONYJi4eoLj4nEFX7Ui4kqRvRJ69Bdaj1ozm2MjGTcUIvnLUnaQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=e2ah0PCs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="e2ah0PCs"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fea795bafeso3108926a91.1
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 06:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740751742; x=1741356542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCyggvZ+qYQ4ZCnU7Xp1kRSxJbXbRg3JdPjepYpK/lE=;
        b=e2ah0PCs+wr2qmzvciqPgnmj1Iemew/GQRBI3Wx05A9+EiJPrap+/Igh20YC8tyPO+
         JyJz1HGDNKZW85cF7adG4Jz/ffF1EkPRDtt5xSERVzmZDw6iurDVIXFWj0j1phfjddHh
         kPSLQsaCDFQcmh1cYpMyxbg+p6nUuKI5x6JJzJJxxz0EY87/iD4tJWQ1/XaTx4GcLhIX
         /ETUnSBNqLQBWSnoCec9YouvRtniimlY0adY5Lmip3vbtElp/+T3QFbZWUfOq9soYf0F
         JXCtzM1oIkukM7UQFJ8Hzl/WlVR1aZMmOXZ1Di+LIAyLxY4JotFMebCdYz5xGA2CxyNM
         EUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740751742; x=1741356542;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCyggvZ+qYQ4ZCnU7Xp1kRSxJbXbRg3JdPjepYpK/lE=;
        b=JnghpSqIsZQLh1p9ji6PRUATKQehOn3XpwPktxqyKcBJvqyPvMQzhajkxOjDOcxeqE
         48jCmTYykRAqbqKsmXcDYp47N9O8UmkSgwWloAFZ1226Wnzpevf/Ovhwl2i+ZRgAppVG
         n6zs6DdM97tiV2nID1p6hlTEq7AM2k4YssKFh4UiyckDDP3hzyiCPjgOpGswi1xG0J96
         KgF/Zxiv1OdoS9+CfIGhcwvaewfN9XOYOwG2KLz7ty4Kt/rSAoV+8XugsaJRVYH1otRz
         izXcxCXOAk5J/YMlieQWBZ2rYc9R+jZfIqf5LOHHegXiaB2znOZsJmhbbWIC1l5bSzzH
         v6vg==
X-Gm-Message-State: AOJu0YznCbOHbLTumQJ/s+krqoKth0FLhmwWq/y8N+ffwujsX/SdfKJP
	arqMtzZwoWTa2n5Ya/uG/LgOolcrPIaedCJQ5vAf3rXDE25LmOqfzQBOxVt8jqu8aAV9mh19diu
	C
X-Gm-Gg: ASbGncskNQFfhpLdveFD+HsLfXDk8Ys5ShPYSnMCcrBo7Jm3A3U0lIlYL5MoICXyL/a
	BlGI5HQMQWabDnJ0jc0POxLAKVnD/Yk9ty5zQKZM8BhqRmGNrtW14UBrk3S7AP3DlI5SqNRQOk8
	XBQtXoMulFDRr2AHUNZU03c/bH3BIFiMGI4alBWmRTY65QflDe3q8VAhRRBmnxnaO2g2+qgPhSD
	tEHf8zwDTkIoz50JQxP3uUwBJZZ7dXbv+vc/ui1zodmOtyKawlcx57wfmkJbSIHFi9NtLKTyJJJ
	UvhfdvE5Ce3pR7WF
X-Google-Smtp-Source: AGHT+IGobyxbKAOO5giozHDIDDDpXcAGwJs3wqyfFTHuo8h99K3Ye2ToYfGFBTcDMlOgfftTl45uUg==
X-Received: by 2002:a05:6a21:99aa:b0:1ea:f941:8d8e with SMTP id adf61e73a8af0-1f2f3dec2abmr6337284637.16.1740751741716;
        Fri, 28 Feb 2025 06:09:01 -0800 (PST)
Received: from [127.0.0.1] ([63.78.1.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af14cd45d19sm671001a12.35.2025.02.28.06.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:09:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Guangwu Zhang <guazhang@redhat.com>
In-Reply-To: <20250228132656.2838008-1-ming.lei@redhat.com>
References: <20250228132656.2838008-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: fix 'kmem_cache of name 'bio-108' already
 exists'
Message-Id: <174075174078.2560460.4128921786328385965.b4-ty@kernel.dk>
Date: Fri, 28 Feb 2025 07:09:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Fri, 28 Feb 2025 21:26:56 +0800, Ming Lei wrote:
> Device mapper bioset often has big bio_slab size, which can be more than
> 1000, then 8byte can't hold the slab name any more, cause the kmem_cache
> allocation warning of 'kmem_cache of name 'bio-108' already exists'.
> 
> Fix the warning by extending bio_slab->name to 12 bytes, but fix output
> of /proc/slabinfo
> 
> [...]

Applied, thanks!

[1/1] block: fix 'kmem_cache of name 'bio-108' already exists'
      (no commit info)

Best regards,
-- 
Jens Axboe



