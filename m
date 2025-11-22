Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFC62D0292
	for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763806066; cv=none; b=rNUSqbkgta7CzzG09+l37Oj9UZ1WTUfXBoqDJO2BeaUfLGDUTlyeUD4P0kKkRAHINAZ1aj34ziSk+Dv+8Df6Rpgco0PqxTmq0tOqA4vJk/GhG6hbuk7YVEuw9pqrQohZvMYs25RVKZHYb5pSCPxtMccN0uBnkSAeBvMyMHnQw7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763806066; c=relaxed/simple;
	bh=YC6JASOKhDeq+v1c3niPp2jV/65g8GLXWjzEC/6bKhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVxMipDtOL/G6HgjlbdzwETSUSAoat0Zsw9ZhgGo8ZqMLhIaC3sIU6Susqy50hm/FxQwLW+xZ+gPOh1wAGmXZ+l9QdgTAjnKwVgtY9OX9bBRQ4DQKGiqahu8p8wWDDPW24agAWnYbdkzcB2zPnERSUqG5zqKcy817yz98vqnuSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y0ks8rgh; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y0ks8rgh"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-340e525487eso1878855a91.3
        for <linux-block@vger.kernel.org>; Sat, 22 Nov 2025 02:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763806065; x=1764410865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mQ4gPN6s8Xd/11O+MQ8+DSVbaktr3U4P884klWVkPdQ=;
        b=Y0ks8rgh5GGKxYkvTxmejFyxGsMTQy13IfH1PxgP8XdEyttE3SMNUDaXCmLLhw7j0o
         wBio9RCptwC3+UzE1GgHXJC6kgDZxQrENuWQ/Um55cEc/LVf4FsYMYkYcnk7KSjQemJb
         Ld9WukOshNpiaUK7AVVWJ6O5rDycokfchLN4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763806065; x=1764410865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQ4gPN6s8Xd/11O+MQ8+DSVbaktr3U4P884klWVkPdQ=;
        b=qyxo5Irpj82F9nyBvYMwsGi8d1ECJaWnecPPgx0ogKF++FSWx4r97IpkIfCBrqr7XW
         3lgWE6MsQSUGiMOdbcSZOPAK5b5zlPutMAzhERWy+WHDwE2i/2I7SB94jgJX9fQMFVOw
         LkZBky8lvlpr75eyFKme8Q0aCo26fKtUW3rOf8UJapVqdXG1w4ndZQMFwxlL2KsgNoWJ
         dutu6HG7RHJhcWEWV+7n4Uh8iHIUlp72hnO1nQTkeuCOk54E8JgJRtj0nbSPRnVeFLQR
         BHE7jq1hkTZl7FBZCy1AW2RQHZMWtycbBmlRB+lmrpCwHgtWIPoC/C8LRoKTMjsaD0tn
         GyHA==
X-Forwarded-Encrypted: i=1; AJvYcCV4MM59deN4bBPCrHbJj+dhGb4pPOFiCnytReAxXUdRsVSFqioDmBR9/B7zrkAO0LakX3KHgTZFoYvjSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5q0YZl2T2P5oOIKrpHzujoQk4Xs/Ixnj3Kw6YzgcIKmRGz7De
	zExgn+k1qRScwYCJt/cM5GPSdbWX2Zp/bi6N/rolGVQSi1+0vNpFKPiEoskfZMvhJA==
X-Gm-Gg: ASbGncsRglgz7Q1eD07CVOE8PsHia5mpLTju+yrLXeX3DpziHftGLyh7nPkSZ/hGv2A
	4OP0wQ6fkxMILRUteMIdK1EE/K4tsmRte4dfwSULsjDVFmIAkpqkV1BPNjU4oyg9HJKxRyd8AbK
	XhoFwYucnOvOBhlCjXNE5pNfSLowgp1kKtfS7LpltPPisXGvyh2PZNuhaIIQWtJ4JVMWP2STtqx
	RMcUlPUbXZ/n0CxVvPdUnthjK5Jo+V5aPEIFvU0bo3vZ71dp1PotZbO+VSC3J5AWlTGb9C4YEgE
	JWjrjfBRmBjBQK2+lYhwheaDWZv3mtre6+zINedclZJFPOuKp1V9gV9SBzJtiFelQtFW5aft765
	lOi2cdIDy+17j1UKIimIww5VMb7RD7cY2NriXrZuYy+8Ui5zKyek909jDkQpt2B5EBZRIqc+R80
	UFDuZVrz7RhYa+76HbsaaAiKPqfeGe5sVDU381MEfd/yI5+FElZoE=
X-Google-Smtp-Source: AGHT+IF9STMF1f3EeytoDQYWwe6bTpFK7Jtci+bPHUYf/65uMEfrVs9GVfGDvjF8U9gEVKfwR/cOkQ==
X-Received: by 2002:a17:90b:384f:b0:341:8c8e:38b5 with SMTP id 98e67ed59e1d1-34733f3e483mr5344655a91.25.1763806064741;
        Sat, 22 Nov 2025 02:07:44 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:948e:149d:963b:f660])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-347267a1231sm8047177a91.6.2025.11.22.02.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 02:07:44 -0800 (PST)
Date: Sat, 22 Nov 2025 19:07:39 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Yuwen Chen <ywen.chen@foxmail.com>, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, minchan@kernel.org, richardycc@google.com
Subject: Re: [RFC PATCHv5 0/6] zram: introduce writeback bio batching
Message-ID: <kvgy5ms2xlkcjuzuq7xx5lmjwx3frguosve7sqbp6wh3gpih5k@kjuwfbdd2cqz>
References: <ts32xzxrpxmwf3okxo4bu2ynbgnfe6mehf5h6eibp7dp3r6jp7@4f7oz6tzqwxn>
 <tencent_865DD78A73BC3C9CAFCBAEBE222B6EA5F107@qq.com>
 <buckmtxvdfnpgo56owip3fjqbzraws2wvtomzfkywhczckoqlt@fifgyl5fjpbt>
 <8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c596737-95c1-4274-9834-1fe06558b431@linux.alibaba.com>

On (25/11/21 20:21), Gao Xiang wrote:
> > > > I think page-fault latency of a written-back page is expected to be
> > > > higher, that's a trade-off that we agree on.  Off the top of my head,
> > > > I don't think we can do anything about it.
> > > > 
> > > > Is loop device always used as for writeback targets?
> > > 
> > > On the Android platform, currently only the loop device is supported as
> > > the backend for writeback, possibly for security reasons. I noticed that
> > > EROFS has implemented a CONFIG_EROFS_FS_BACKED_BY_FILE to reduce this
> > > latency. I think ZRAM might also be able to do this.
> > 
> > I see.  Do you use S/W or H/W compression?
> 
> No, I'm pretty sure it's impossible for zram to access
> file I/Os without another thread context (e.g. workqueue),
> especially for write I/Os, which is unlike erofs:
> 
> EROFS can do because EROFS is a specific filesystem, you
> could see it's a seperate fs, and it can only read (no
> write context) backing files in erofs and/or other fses,
> which is much like vfs/overlayfs read_iter() directly
> going into the backing fses without nested contexts.
> (Even if loop is used, it will create its own thread
> contexts with workqueues, which is safe.)
> 
>  In the other hand, zram/loop can act as a virtual block
> device which is rather different, which means you could
> format an ext4 filesystem and backing another ext4/btrfs,
> like this:
> 
>   zram(ext4) -> backing ext4/btrfs
> 
> It's unsafe (in addition to GFP_NOIO allocation
> restriction) since zram cannot manage those ext4/btrfs
> existing contexts:
> 
>  - Take one detailed example, if the upper zram ext4
> assigns current->journal_info = xxx, and submit_bio() to
> zram, which will confuse the backing ext4 since it should
> assume current->journal_info == NULL, so the virtual block
> devices need another thread context to isolate those two
> different uncontrolled contexts.
> 
> So I don't think it's feasible for block drivers to act
> like this, especially mixing with writing to backing fses
> operations.

Sorry, I don't completely understand your point, but backing
device is never expected to have any fs on it.  So from your
email:

> zram(ext4) -> backing ext4/btrfs

This is not a valid configuration, as far as I'm concerned.
Unless I'm missing your point.
