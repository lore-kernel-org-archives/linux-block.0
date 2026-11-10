Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305679;
	b=0P/Nw1gkM0tcIuEgNbTV6ldbSRLmODw/rMhiEVm6KpGBj47rqPz5O19eExdzO8hBsU+B
	 gxJM+modFUK4KQ0QrFcYfrJOMYygkb8kWtIetLv21U7g+tmqVUQeGTO96x48eY4Psbn0O
	 ZTcPsXeu4HX6DkMT5iTcdEpPf/74xM7yZzB1nlPYaA95Fdupt/GsFqE/PEn5BXvoOIrB1
	 /8N5je6X2WUtOOo35MAtwLiw3ScXx6hAF2D4U7LCo7bW2eOuGP466QDRCXhFnyL3nJYkd
	 zLYSivcPsh7clwtHDu64awudEL+2e9zNt+7UzlZZnycociD+BFyHWEENCR3hX7uDe6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
	b=z8CVoxhnDniZyrIhETfKFoVmK4PFUrAQHwJ6c2x0Ial+Rejkrw/NREh1OdrtDUfYDtLo
	 BQ+CW+iX7UXAdYYSuK1Jgsaa0m3ev2iORl2fCifNTBY2JIhRkFUjsDkhlbDVboGQlExg6
	 YGSSoEKu+G398QehcASn1ky0eO0vdWz+85m7Exe4T34wGoNIVK2Vk4E9NidgmEOuRQ0ty
	 XbPSApwm7MNkZ7LpZQG3JH26b3ZQbMP6gz6wpfqyI/Jvm4WcSHp2TB7ZyJ+M2+iawPGCf
	 CsGxZ9dR4jKuZLHEXlz8D6ZTlzphPlgzCwu4rlEDH8vTlBeqevP3CRdy/r57DwqtjAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DrlQYRb4;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89081606A33F
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 10:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89081606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DrlQYRb4
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso3959800a12.0
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 02:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794305678; x=1794910478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
        b=DrlQYRb4d+FJBQLFk4gip1vdMb9pZcbFm0QRoW/O9nsnnIGk5B/dcI7komCKzkv/uM
         Uz0TTkL3EB0XOLA2v0TTxwYvqDOvah1wiwbB4uUsiRRXfj1OcdvtnHWnMQS6yfKTNN5Y
         2S+sbZpFj/oUd6OIfB1K+t4luOgmpm8MRta8dNUBz+XdEb16ui6jztHrAySR2QYDDBtW
         UcH7ksMk3kyTCuhLg24n4RSbgP43bR1MD63YWBBHbNHKba+s6Adtgd3r0iiTavTYgvkx
         vCBmyxhjfzRfUpjuhY0K7x1CK/3uUIf/0FzbTbFW5bHu/k5G1xko0Cr6O3LrrObY61iA
         y+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794305678; x=1794910478;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WFltYRvNkpM0HMxRLJxGiCTEiP83WtKPHu+oXy3KTg=;
        b=ca2geSH7jTW3Fz3ZuqeKrWQ5ZtnFUWyyRUiToeD5p9Ss8k3yKUep0fuKArdDi2hf1E
         iJr5Ucglkj+pN+L/kizzK+PZUk+eoGTx3OdJDs2M+Uf2ytzu4FU4F+mNXTRq49Drzd9V
         9PmhaDwPuQLU838IHqI+sh/gBkWH8IyCG2IVwQOXu9ovAK0/OiHqcFjLam+xrlkho/Wi
         yB7awQTvC6cOTrvazSMCXUx+Ksm7lVg1Ga0x86RlWMA667N3bWB5Zg723hz7CzaCAbaR
         uIlzvX/8rLq8zF59gLo4zU2Lp5YXExASBkBCq4TvDDoh9YbiihpD2yK0m9jx/f7fifWR
         m+jQ==
X-Forwarded-Encrypted: i=1; AL+hErFfoHwyzxt19OUimpDKFFzpNVds/NNPOFh8z0v1duBzTN2RlvCwG+kMEdLiuvWoKnZpM/BUWVbul6aRkA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/6w51Up7QAqMhyLTbNPgbDMaSyZoUXkMOXmd4GQtyMGjzqMFU9
	NLhDT2j4aybVXsH8yZ5roWQMlGZCD8EEQdPg1hK0Z4WwNBKwyMfjlbjS
X-Gm-Gg: AYBFou1ABBQ1T+ysBeogp7hdWVMhJzTFEGi2o7L7t0HSr0OrYqGg/EC+FCGvjhHNj5a
	ar5T9Vk+w5EGqCKR8wQN6bG+MgvmrQIcybcc0D224Bu68eP+drz+GfhgNdqNe4ne3AfKjN/3aFT
	r0k25S+K85mJWG2rrygNs+3b4E8z1rAtvV/lcih0ouLaMIUL9pQ32PHwdV3HlLWTAHyDIX2l2Nl
	cER1byss/1sC2V1mc0AqxPNlmmx0nI68O3Rt5QlvtgvFuiRcs8Ldfi36S56q8SS78RjS6doClYv
	eVgbhj6XCF4GCP6QPvZgHsUj3mIuXTdql/9PhOa9GteqCDVi5xfylz9FfK+Eu0u12cWMv3oHRFE
	mR+2nATK8QZZqw2JDpzZfEAVgjNz3dcmBL0HDovijf8J1+gYxWu6zOY8kqg5NisK50t6qFvtNwD
	+vqC+nWpji9AX2vi6Plw+RLuZ9oHBab3QT8aCQ7fBPKSL9gGBr5tZpEcGCA+UufTtMWAdTt4YV+
	2qxrgvs5x0dhLtxnXxjENz5v7/Qp+QhUQsc7LPfHwcc6nGxfbBU3nkmFrGQSLOXaagcqJKl4g0W
	n6ZY+gSkp99T/cDgTU95i4Cdej41FD10W/hgcohq6yLdnORXfUwTsvGmUJZ2G19oOkvX7/tIdgq
	RyudUFUwc4uSU
X-Received: by 2002:a17:907:944d:b0:c41:4c20:5a80 with SMTP id a640c23a62f3a-c504963ce05mr189793966b.44.1794305677695;
        Tue, 10 Nov 2026 02:14:37 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a593eacsm90433466b.36.2026.11.10.02.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:14:36 -0800 (PST)
Date: Tue, 10 Nov 2026 11:14:35 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org,
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
Message-ID: <avLui6Mpf8GbKbtc@amir-ThinkPad-T480>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>

On Tue, Nov 10, 2026 at 10:14:54AM +0100, Christian Brauner wrote:
> The fuse server can register any regular file as a backing file. procfs
> and binfmt_misc files are already refused by the stacking depth check as
> both set s_stack_depth to FILESYSTEM_MAX_STACK_DEPTH. sysfs and the
> other pseudo filesystems aren't. Reads and writes of the fuse file would
> then be done on the pseudo file with the fuse server's credentials.
> Refuse files on pseudo filesystems just like loop does.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/fuse/backing.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index 8c21a8a74efb..4e4fb810ddaa 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -147,6 +147,9 @@ static int fuse_backing_open_file(struct fuse_conn *fc, struct fuse_backing *fb,
>  		if (inode->i_sb->s_stack_depth >= fc->max_stack_depth)
>  			return -ELOOP;
>  
> +		if (file_is_pseudo(file))
> +			return -EINVAL;
> +
>  		fb->type = FUSE_BACKING_PATH;
>  		fb->path = file->f_path;
>  		path_get(&fb->path);
> 
> -- 
> 2.53.0
> 

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

