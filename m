Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5E220628A
	for <linux-block@vger.kernel.org>; Fri,  6 Dec 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503780; cv=none; b=Fbs0DsGmrSU+szytR5fF7jU3GFb6K2Ye5Z16GiUAZM+IBw+D0HMMqTCl7gyL1f3ogC71Aj+c0YxC8tUQcI16NfH7KZSV3O860tC84qxZPxtxhYnEjcm72CPhY2CftMMm8QmmPKqTZ1TIGsZW56xt+rgHtO18DKSxLRTeSepyBsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503780; c=relaxed/simple;
	bh=0n1KkGdZKTU9DNLbJmCJB/c741H7SmEOJCW5oimBGlQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GJ++L4T2SkkdKWxwFyGZ22Oc1K7CL1COEju3EDuKchwtDzVhAhjr48+Y+xCawi37AY1EvA1cTqmXTAEyqu6yrP8tZjcb+Dr/tYj24CQlTuHAN02YN1z6/L4J9iq5vr0+1NmhB/OapRNtbzN4tyj8n4sncdT7a4ga1YgbnCCNGfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=onJTSkgI; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="onJTSkgI"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7fd21e4aa2eso1035936a12.2
        for <linux-block@vger.kernel.org>; Fri, 06 Dec 2024 08:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1733503775; x=1734108575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ejhqce7r2jq8/79kqeq4PQYwzmKb+nlxlhksW/30qlw=;
        b=onJTSkgIF3X7v29RqJukEBzDIKMUrmSKRIMaBXbSFOpX0Lo+MfvJTaKAMFEEWbRemc
         93URahWc+B570QHkdxjktIP5Zem3BBVK6hnyL/YO9LP3I8T+4WFJKo+h7E6avWYK66yy
         bEUimYbG3HoyEEUTGZCyjxHHnfhCX+082CkZmpdYjZLDppZKIgd3MFMivsM4L9QmYalh
         ReQKyOp3WIOiM1V7O7ycoRyXwHI4RPElxca/Fkj8DzRHw1LsWFfVU/lO4cgLw4bArrfE
         BA8ff7jr//0SZS3kekHL20f6+P4Vbx4+4zMzdVL9ZuL6RDBTlxrB/S1dz+3N5f28p0zq
         fuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733503775; x=1734108575;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ejhqce7r2jq8/79kqeq4PQYwzmKb+nlxlhksW/30qlw=;
        b=T7neNrfkfsKccMp/rINhTZn4gskdoi0DNP51rKYHSIMXUBBnMJmzEeeIYK91cMqOhk
         +KECykDQVp/HdW7fLUE7DGCsNWt1hcNkRbbtKvkgZd2mSug84N6W+g2O8WUVF2PYYsOG
         3RfwcMakgOLOwMCgtCIrGMWqg8N+K8zzptN1cc6XVgZVd2QelTVniCMJW40bHY7qY1sa
         C74UnvA1zKu6D6Ba7kNPLwL32WUbOxv0DiSMNjGCHhSNyTp2jEFkDUimyRdu89LYZdN3
         YQErBbPVVZF8OyO3fH3ULR5RO5YxHBLsgMxtvGHm4dJfY0q4NJ75xAJb1TZts+nCsavh
         GZHw==
X-Gm-Message-State: AOJu0YyCi6/eQLXbqglpmRv5XAa90TVW8qP7O36fYlhJgkjFQ2YPGNPP
	SNPHA5n6v+jFKPtD6rrIrhNO1SItOPKANkR+IH2ArOUZ5wbiw2znZ86WS8Qao5grqFbCcErzpgJ
	2
X-Gm-Gg: ASbGncurA6RXLtqhPsXdeLX9hsoYKFvXP72hJoNL5VVSfTYL6Zoz/Ij+Fk89G2xH1ZN
	+QIB2RyiseF6h23+EJq41xu6DU0BxY3/A+e/iJQfiJeXaeh2BsRXFmEXM/sHw0oZk74AjW8B9Dj
	3HKOcUlbSHr1UbWeBV7t3MoM4ONrRlVnIBg2nyBj4rT1+StfkGj0dj+3SN5xKaPJQ8xhQeen9Bc
	hq/gCojkgvcXsMcJo3c5ckNGxayEg==
X-Google-Smtp-Source: AGHT+IG94TyD8NsbtloqL6F7GRX+TAchV8C/DtAAU8oFW5QGkHdFawclOSjx3Im6r4aN+MVH3fMQVg==
X-Received: by 2002:a17:90b:1b08:b0:2ee:ed1c:e451 with SMTP id 98e67ed59e1d1-2ef69e155aamr6354694a91.15.1733503774772;
        Fri, 06 Dec 2024 08:49:34 -0800 (PST)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:47b4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef45ff78fdsm3385176a91.33.2024.12.06.08.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 08:49:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20241206111611.978870-1-ming.lei@redhat.com>
References: <20241206111611.978870-1-ming.lei@redhat.com>
Subject: Re: [PATCH RESEND 0/2] blk-mq: fix lockdep warning between
 sysfs_lock and cpu hotplug lock
Message-Id: <173350377352.721410.8481147947549124524.b4-ty@kernel.dk>
Date: Fri, 06 Dec 2024 09:49:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Fri, 06 Dec 2024 19:16:05 +0800, Ming Lei wrote:
> The 1st patch is one prep patch.
> 
> The 2nd one fixes lockdep warning triggered by dependency between
> q->sysfs_lock and cpuhotplug_lock.
> 
> 
> Ming Lei (2):
>   blk-mq: register cpuhp callback after hctx is added to xarray table
>   blk-mq: move cpuhp callback registering out of q->sysfs_lock
> 
> [...]

Applied, thanks!

[1/2] blk-mq: register cpuhp callback after hctx is added to xarray table
      commit: 4bf485a7db5d82ddd0f3ad2b299893199090375e
[2/2] blk-mq: move cpuhp callback registering out of q->sysfs_lock
      commit: 22465bbac53c821319089016f268a2437de9b00a

Best regards,
-- 
Jens Axboe



