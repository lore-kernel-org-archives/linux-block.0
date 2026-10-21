Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580303;
	b=mPzyMOBI0XZ43ZFBUGkaoefi/OJ1HV5E8ITtsqVrjoraC9mFoDRsyvUrHnxuzKJ02yGW
	 MRqBf3MSzOM1M8yC22qob418ujt36rWbJb8sscvStVMuIHWsFY/o4j0qNaLbe5da20qie
	 7CV40maL1JgQN7SlMk3e6NFMTp/cGH77T5VIVqfrwTIOGdLF+/tUzjLUm3ju3oOL6xov8
	 zDAAQjkgyeBCHNd/+Jk8K/EFteDLN9k5OVjYYcnIuy0mCPtMq6dd21QCQT9eu381EUrOk
	 CKF5jyN08utfCXGMqHHGJsqTsT9ezvc3fsUtFBrwDkeShpJV1oPlw1eqruZUMfGzNYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580303;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=D9XpsGJWEwNtJOnAsBPr5CyPfHqVCX6IANnhZBr3+2Y=;
	b=NIzFyLHa7Vu5gznDOaf4Fq8LD8ob1wbjVThRKHN+salyzN62dEMqNci/UFWJQ1pkMVXf
	 ktRos4QDnaovAm7yKurz2xlGBYoVx0XOZKdyhZHAn4HbLfX/ogP0ApzKaF1qUA79Nd6Ag
	 isvVqMbvvF/RKUdBwzFEaRGh+uFgizSjzQkTJRVumL1lVhvhwdXuTmidOm5ap3BACaQcx
	 sLyjQYmgLUP4QEirSKVsYbZbdvaQ0L6uFCuEhG/ofQzxC6JsEcZrygPXCvsB9zXYPuo8C
	 0dz3hWQvvNkVL6bAndfqmWSE8wpba1pFSSaKTCtiVavFoMx1TdVZi5rn9oc2eSbjegw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKoLXKaj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F31606A319;
	Wed, 21 Oct 2026 10:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKoLXKaj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C5E1F000CB;
	Wed, 21 Oct 2026 10:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792580303;
	bh=D9XpsGJWEwNtJOnAsBPr5CyPfHqVCX6IANnhZBr3+2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MKoLXKajy/1QnBAFBg/llA4yMM4S5y2QW0wKrn1OYvI8psAMeOg9QvL2BMamjYHpJ
	 RwXLsQv5lZ96bI/082VobpmK+/mU1aQLHnwRHeBxo70QDhKMhZ9dDgzQ54N9hSi6no
	 vgRY7N5MQTu+QlS/4edEO7i470qiVe7PBIrbktEEoi+Fnp5cJh4RbomHOLaSG3D8WH
	 YCuLvk//zclWN5gYRkI7/rzIIXvplGaQPzDLqGYZ1i24Mwje84d5cRNQNUAbcxj4P1
	 oj0OaQoxSbtdBhG7pt5DXE6cVskeXbx5sqFGXodaWVrRL/avL/SmiS/Kmo+0EskC/m
	 4kl+6Mtsylihw==
Date: Wed, 21 Oct 2026 12:58:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Huang Shijie <huangsj@hygon.cn>
Cc: axboe@kernel.dk, viro@zeniv.linux.org.uk, zhongyuan@hygon.cn, 
	fangbaoshun@hygon.cn, yingzhiwei@hygon.cn, jack@suse.cz, agruenba@redhat.com, 
	mic@digikod.net, gnoack@google.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, aleksa@amutable.com, legion@kernel.org, david@kernel.org, 
	sandeen@redhat.com, ebiggers@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-security-module@vger.kernel.org, sunjunchao@bytedance.com
Subject: Re: [PATCH 0/3] vfs: add inode iteration method super_iter_inodes
Message-ID: <20261021-chiffrieren-quetschen-kostspielig-b9ca4b0c83ff@brauner>
References: <20261015093854.2082600-1-huangsj@hygon.cn>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261015093854.2082600-1-huangsj@hygon.cn>

On Thu, Oct 15, 2026 at 05:38:51PM +0800, Huang Shijie wrote:
> This series adds a single superblock inode iteration helper,
> super_iter_inodes(), and converts the open-coded sb->s_inodes walks in
> the VFS to it.  The design is based on Dave Chinner's patch set:
>   "vfs: improving inode cache iteration scalability"
>   https://lore.kernel.org/all/20241002014017.3801899-1-david@fromorbit.com/

Jan has specific ideas around this are so I'll wait for him to chime in.
