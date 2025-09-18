Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832FF1DF73C
	for <linux-block@vger.kernel.org>; Thu, 18 Sep 2025 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758156379; cv=none; b=TF7kNi4iftFbfbenmMuVaQfq5/eOe5d0erwY7EN3ffAwCl7ctsA/dm3WCL7Vy0nK/Eir9+3XHeUjtgl5SF1xWIkWLFzLhhTC6YjxQc9pcwdpOzjQJ1fdeH+7Ef+J1rtjhrVS64Ub0AAhjahy1BLX8MJNqNOxcYsOwbOzD20MDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758156379; c=relaxed/simple;
	bh=UIo7RA/G/xDD02JBTiyBlQlJJd9IfyisvvvnbSKMNJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MHyA67E6b1rMtxLMPplWxk2MLUI40OxdF32GNNT4jn6OSVik0Xj9AJHJoViVB9Ff5tMjINKcDfNRtEONKzhvcBGRneMYGLh1w2Gx3XdpMkngAGxLJhSZfaYrBVfI21EsTn1r1JT3o+h8ZqJ91lOOlxI878Oda/53qJTmaktyiq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzGvJlF3; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzGvJlF3"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb78ead12so53541966b.1
        for <linux-block@vger.kernel.org>; Wed, 17 Sep 2025 17:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758156375; x=1758761175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScdSoNWwYp7Lx1FqF0sJinLc5HuMMzMbeEOteqLeKGY=;
        b=KzGvJlF3KPV470aj9p2+WGc+dHQyYumQ/n1JBBocmuZJA49YLeiUqmwy+/yYPZgQZj
         ssXCb7z6YgYiOutrT3AfsrRikN0B83+7ruvziWNhCwsz2ELTIiizmfls7PvsFdkvcJLT
         qpJdXp6xZhBTLS5nekg+F1LDSdhm19EysHMtk07fabj1P6oLuOyCMfvOGen6jT1eBwbP
         6pMnjF6KJT+0XEj91pCTwQujjt7F6ghOtnCnJ+EU2+tXugoJTsFgk+QsjwfhKOKRRjgu
         d9FePQZs61kpvgUTD0qeflLnFiVK5p7eAvAv3yf1sOrJiE6TsrG+zJ2UIlYBCl4PmRtc
         hKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758156375; x=1758761175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScdSoNWwYp7Lx1FqF0sJinLc5HuMMzMbeEOteqLeKGY=;
        b=UC79mKOgCZPqthySnDz73smWyfOLq+bgfsXqGdMpXURGDHazzvgvQdcbE5UfakFVzd
         agOTsdI8Yv1wHKUefxtPP3RMjFjczNuOwg68KDGESAaybVDj9jb8XXOqUmuZS8hsTRbG
         uM1X/0xgSXrYQ3lAdK7DW7GdWRrUAQzGg6S1f2lv7Kb2Zqjw+zt1vfYZH1KB5lVwGZ8m
         WGP6JlUHYLi+rl0kzWPBaEheC0KbmMJEkvMuSs+dMIQffbiYcIgjwyzL1mdy/gi25AFm
         1mf+1p1WCKehVhUoKn3y1Oi3Jex5hGtqhUEAsMeGarK0dhunEsOyyk7bYpIhTqYY5z24
         7BaA==
X-Forwarded-Encrypted: i=1; AJvYcCWbJSSJXAviZt+xY06IsnloSzUj0o5cxkjGeDLdGSX48HsrE0H4OSkjGXw6KRszD6NXvm5llkqZtbGtgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcEKNX2Wf6rdZz1Ddm34OTEFl8BiIO61XqxIyYF4h0wTGZv0lK
	j3ZUhE71OSai2wYE0A8E/xb6AL7Ndn++OvrEFNQjnwRLgcZGusOrFay0
X-Gm-Gg: ASbGncsiaSm+4eoqjBUX/kUjSE5K3SuyuOKQGf9gzNBUIhCVXxBXgIX/qaYepj6ADBc
	Zl+YTLTiJhovff5kQ/9f52UCFqrbnddMxKvFTzs2SKcjzoUXn1RB0mHDvsONotc866nBjYgZCkQ
	C7aZEwcIMaY7eBBPanJVKp2cjxL4KwnYccug4Zoe7fJij8E58cA/EDVWIf8DG3lYgswfVyc0ah0
	KN9hF1ZjCN4MK7Xb3VJWuA6SORda6YkjVdyRooJ1f+9pY+0q7p//65yw6aIZBzPNv7V9wYo7DvZ
	Fu6DVzrDnZbDXphQHicorhu+CatxpIa5rxJxh9+00nFE1D4D0l12pJ72s76vS+p8FW7JqSPf6Qg
	DP8XiPf+PwTbeU097c1OkZQYpRQbHbvGiOteZuw==
X-Google-Smtp-Source: AGHT+IGtolM3WpmMOfPkC5aQN2+QGXojyD9zctBgGDhejOP10KXv+fVObxP+zNTcUHL0l2vGVmYa+w==
X-Received: by 2002:a17:907:7291:b0:b07:c28f:19c8 with SMTP id a640c23a62f3a-b1bb7d419c3mr514517266b.30.1758156374473;
        Wed, 17 Sep 2025 17:46:14 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b1fd271ead3sm73266366b.101.2025.09.17.17.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 17:46:14 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: brauner@kernel.org
Cc: amir73il@gmail.com,
	axboe@kernel.dk,
	cgroups@vger.kernel.org,
	chuck.lever@oracle.com,
	cyphar@cyphar.com,
	daan.j.demeyer@gmail.com,
	edumazet@google.com,
	hannes@cmpxchg.org,
	horms@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kuba@kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	me@yhndnzj.com,
	mkoutny@suse.com,
	mzxreary@0pointer.de,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	tj@kernel.org,
	viro@zeniv.linux.org.uk,
	zbyszek@in.waw.pl
Subject: Re: [PATCH 17/32] mnt: support iterator
Date: Thu, 18 Sep 2025 03:46:06 +0300
Message-ID: <20250918004606.1081264-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250910-work-namespace-v1-17-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-17-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Move the mount namespace to the generic iterator.
> This allows us to drop a bunch of members from struct mnt_namespace.
>                                                                       t
> Signed-off-by: Christian Brauner <brauner@kernel.org>

There is weird "t" here floating at the right

-- 
Askar Safin
