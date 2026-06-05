Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B522BE03C
	for <linux-block@vger.kernel.org>; Fri,  5 Jun 2026 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680117; cv=none; b=cQqvF9iLQwZwDBd0FAM4ILNYAfzQtbi09ZlQiop8fxBWXvUxnc7Xg20oNJ0K4uLjgkB244Vm1jk4oCKNX53zCVYUGXRrqoRejd95bHuJk2SMbXeqBhs3IgNVfh8bZNPwb/VgpjX5JmBifgZY1ULdsrFMmRuOYFOlJtQY7qGcOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680117; c=relaxed/simple;
	bh=BactFefER3D0iF37FFheQnx5qQm8yP8GUJDCu+5jKy0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UoxKTvE3lwwZBk0MDnzjVeqNB33pZ2r5yxXUGh8xFq1T4gBLBQq9wwff3+wr0jv6dY/Cl35C0PUMHTEOlEFcWVJ0TyEj2DWm6yq6bX0x6dOGfzQs2PDtATxcfK4WvxTONlm8nav0mYxutmvnP51OBlUbqLtCtWKxrDKITFI1Sqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=WWL9kSBS; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="WWL9kSBS"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-486852c7b68so1129495b6e.2
        for <linux-block@vger.kernel.org>; Fri, 05 Jun 2026 10:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780680114; x=1781284914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTTWGzbZ8trGBym4HPb8vd41FHu7AC8v93XFb5G9Knc=;
        b=WWL9kSBSQlvQmhWAqpBoS8u8ZimoQV37QLZVm5PK/qvTks7p6GgulSlzXlmsUvA+fw
         hr3t62v4n3e91dUS8sRQhgwvmOFMTgoKRVV1mGiFeAK+O649lNucEuBEH/vwmAuG6Ix7
         WTE80DBcoUSe8Hu6AwF5xpl0U6PUKH+c/LiHolpLQqH1Z1HXfKxeS9YBsXUlIOqdV9m8
         /C4YwPE3JX2PVnHq+wXJfSXbpD+4UmWeMvtIlTa6mLvu0XP4jeKwDqL2pzwyClGh7Czp
         +zB2gnDzotZxgcbu4fAPRa5WKNBPLU7MDEVD22HyYNTdluupRu9+rX10p8AcuIDDioZ9
         uihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780680114; x=1781284914;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZTTWGzbZ8trGBym4HPb8vd41FHu7AC8v93XFb5G9Knc=;
        b=nVcxevNn2zSjQp9G+a30bdgMBh8PerOJHzGeaDKcnj/wpF9O6tIIXm4dn0ndZkR4Bh
         fFB2GZ37SCQ2B3l3em2q2LtD7IUHMLIqHbvcqZWbEUMGKsva9i8Hb/0yrqxAe2yKcijE
         tqdmL298Hokr8Vf4p3Mrd7H/EgUG4wL3VcnqMtme231Nz+elVaxfj+Boi1ixvM+vsRvG
         04dUFrn3Cc0K6yWQJdq/w7Cwt2kB7TKdf14ZnDEso7m7JSLHRRzuLKbzie2G8S5FX3J1
         IQgS/QDkJCpQw8/sCfu0keVVbwKzrxbkw8t7+Lni94lR3Lvf8SueLxnEwc76t4ImumAS
         rJpA==
X-Forwarded-Encrypted: i=1; AFNElJ/zYC9PRY4i7E5tDHZwkxl7idOFLhK3emvR8iTeHDn1T9q0RascWfZJOKi9075SZN9PvreOLGmEQnDBEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/a+sMq0ct8NUju9sofiPkHPS96UXtkiTiif7lAGyFaShIQtb0
	ya69PjmXb1TnfF/B7AJX7eeXAItMT+BclLyzqyOPgk5n8XpKPEHBzpLVQk/yHkDJed4=
X-Gm-Gg: Acq92OHlnN/yx+itFLEu1JgteXk3fj5skhEuo97aXMc/uFMEtInpSJlIt504INbQQY4
	gnkQHRdZzxcK8IjZCVtktSSulJu8DhZ6XAcDGHW0euGt6r520XT4fq5pSkrwVI0LigKU5rMcfpO
	AmKoYcud0L0etuIHrHt2Ugff1XN6+E3bIi1PkSTCgOa1BrZw0UruH9j661+i85pEOpFZ5/eovok
	+X/DuSy4OdbClcgb6RZIjfHQLkxA0VRQVGpbjjvbrkMasS8lJ0KEjNEuuU4Obb/AYApVor/uNAf
	tOZfFtEdUDsk/H7xfy0E5rlOlys4Yo3elAL9Cni5JhSZWL/6oE0RtwTyWdp9GnefB5GmO5MK+wp
	/pOa6tml5J/uysYWvT0sncFFSm60lNl67YNZIOOps/Ak/q65w+9u2KyOvcloWou38w3ebJv9Gi6
	xFD5XRqhjMYglYzz2zMwYzu9gphbdOVbglgfK+/MN1K/hWyFQJDckncF/yzVkTNrQgaUv/QJUWk
	3qUx1331DgqUg==
X-Received: by 2002:a05:6808:1488:b0:474:28c1:4877 with SMTP id 5614622812f47-4868df1d0c5mr2853327b6e.39.1780680114125;
        Fri, 05 Jun 2026 10:21:54 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d84c0ce2sm8962648fac.16.2026.06.05.10.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 10:21:52 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Marco Crivellari <marco.crivellari@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Michal Hocko <mhocko@suse.com>, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20260604105347.168322-1-marco.crivellari@suse.com>
References: <20260604105347.168322-1-marco.crivellari@suse.com>
Subject: Re: [PATCH] block: Add WQ_PERCPU to alloc_workqueue users
Message-Id: <178068011170.856067.204306158214952007.b4-ty@b4>
Date: Fri, 05 Jun 2026 11:21:51 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 04 Jun 2026 12:53:47 +0200, Marco Crivellari wrote:
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The refactoring is going to alter the default behavior of
> alloc_workqueue() to be unbound by default.
> 
> [...]

Applied, thanks!

[1/1] block: Add WQ_PERCPU to alloc_workqueue users
      commit: 7e712f292e7f01e91d09e83eb7b9526f77f66c71

Best regards,
-- 
Jens Axboe



