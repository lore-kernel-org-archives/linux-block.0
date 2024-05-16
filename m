Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2366810FA
	for <linux-block@vger.kernel.org>; Thu, 16 May 2024 02:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715826076; cv=none; b=OjQ0jCJbeZgnQ3PoMhRZ664Ogmc+j76PxeyhsLeh9sYEBdQT9Wu/tFrVslStn5XnNJCuihgi9etfr22xmJUw/uoVXZPuyO7ZJFU0w7kJr2wtTdxGuwiuX6rN9x7HyZJRQ8AWNdgCmhlYPFrzxfj+EwS9Hc3sO1pm8FMt/BCfykQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715826076; c=relaxed/simple;
	bh=4c6t4UIiiK42ooOvVuu1cfmVoG2dM0nRNsvGg0L1bCU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sh/454aEzLDG8MfljyyfKk0xLzj4PTuxgqLpclMzibePZ2/IjXUxQy421bCWBrcBYEcL7vZw99Xbj2KQDDR5In6mTfNgYnNXDXq5zYfz/3Pmey1/kpI1olmt7zMCaZlSVDRv9odAG6RduaBMmAwheVDrWA3XAt+WxopXbOljQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=lm6v2Zl6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="lm6v2Zl6"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2b59b993389so1820409a91.3
        for <linux-block@vger.kernel.org>; Wed, 15 May 2024 19:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1715826072; x=1716430872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drAuK3nWXGNAmV8o1D01JU9C9opOmO2DbB4NgD91LZQ=;
        b=lm6v2Zl6XNUmy4hHpBxN3sAacwa71XQHZI9HacDiaSZ7pdD7NLehLJrEy/O9j3VLqH
         pfNn7EPEPIMh0VAVYVVsGZQ81fOLCe9acMIayn21HzFu1iVlDzRew7CWTiYDTpR9IYBb
         M89yl/sed+RODZwD4kEWErER6EiHmk2y8D9X9KkvNlHzivjksX2139nv0shTE+CKnTrw
         LvWSkozZeVRthf/dkm3JaXHJlQJZhTrvXlN93TprIM7PkJG34QBBD6evjL2OUZsjWV1j
         NU1/IKVtbeVsB4e/1haLb85PEk44olott3VX8oxlGhe3euKcyShhIMxDaESTFsaeuBXl
         k03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715826072; x=1716430872;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=drAuK3nWXGNAmV8o1D01JU9C9opOmO2DbB4NgD91LZQ=;
        b=sX1c8yltzJOs5VR7buakQRS5uwnS9Ml8aTG1ZDBuwHl/jX7uh1oEPeCksC7FMlpVZ8
         NSenY4fFo5i41NGpSI0bP4nszUC3eIe4XJbXDoQYTGSWF8cPpyNsw3Z+cM1rub2OaE59
         3w+0+9CLjrGBbHMWBKwR9/IxiMnewvz4bz48i9cKyu+dZrJxuWmB53tPhu0Ft/oNcz/Q
         G2J4XkgBwFECNAGYig25Dy0+DwuNrVmK7g6vDaxQyX88dwKm5M54Iyvce0ILrLW4IjEb
         9NgQ1QO9oqHdb9en56CNPA32zmbzUkuKZDdxspdFHNu+jo4r1TIkad4K0yPWuCnIWioE
         mI/w==
X-Gm-Message-State: AOJu0YzGr4fEMzfHQ8DOBxUp0sZH9i1sfd6wVL+WdcLqU2EaZgVYp/Pg
	9668Fa5tCpyvyPeqr5WlM8PqdCqQlOhC78fsPUVz52JaVuQRgEcQlMd65mYaAis=
X-Google-Smtp-Source: AGHT+IGXQYcQuFAiidPAFIwhIrYmfqDZGLfaLYmWGqp/mp34ixBSRxIrzk6fOgMbXnueRfzK3GsNSw==
X-Received: by 2002:a17:903:2351:b0:1dd:85eb:b11 with SMTP id d9443c01a7336-1ef43d17f37mr218928985ad.1.1715826072065;
        Wed, 15 May 2024 19:21:12 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad5f30sm126361695ad.64.2024.05.15.19.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 19:21:11 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
 Waiman Long <longman@redhat.com>
In-Reply-To: <20240515013157.443672-1-ming.lei@redhat.com>
References: <20240515013157.443672-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/2] blk-cgroup: two fixes on list corruption
Message-Id: <171582607077.10952.871110091370477688.b4-ty@kernel.dk>
Date: Wed, 15 May 2024 20:21:10 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 15 May 2024 09:31:55 +0800, Ming Lei wrote:
> The 1st patch fixes list corruption when running reset_iostat(cgroup
> v1).
> 
> The 2nd patch fixes potential list corruption when reordering of
> writting to ->lqueued and reading from iostat instance.
> 
> 
> [...]

Applied, thanks!

[1/2] blk-cgroup: fix list corruption from resetting io stat
      commit: 6da6680632792709cecf2b006f2fe3ca7857e791
[2/2] blk-cgroup: fix list corruption from reorder of WRITE ->lqueued
      commit: d0aac2363549e12cc79b8e285f13d5a9f42fd08e

Best regards,
-- 
Jens Axboe



