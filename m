Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686762;
	b=roiOQCg1XhxTYWPMGcEyIOyUOna+yr3ruWNCkjA33YoNMIxH6/EoTIjuqYFezb/yo3OD
	 zejGLNkdukLeg5izFc8vuQ11i44RtIRvy417Rj3DyWauaaZ3RasgL9NaI/6pvXCI1phde
	 yNzT5sRi84FeCj4Pn6Xc/GU6swxSxgIF7TeQn0Rt64m2J9fXv1w3cWlvafsvT+1INy+5K
	 q5faXPumqMmyM3ZFbQ/PxGt3umoUXL5rqn6AsR1NYRsCJow8EyVgSYyBmtIesEn0pLE97
	 wDNast2dROTEwgef+dod/HQdPm6Qlt3SB6BlsPtBRUlt3hq+0QLjpULIjKoZOeuNfKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
	b=DTiYa6vr/uaOgVTR3Pp8egh4RrfuCqGWED7YwfNI2+BZDt29Ejj8bNEXAuz0mVLuKm7P
	 MCKsM8U0xphNPGmNkfGOH7vPeWcn5oGqqF3pcJu0EqFPIVMrXXUZrJXwiLhsqnLB/BVFC
	 YPa/AwEQNLQ4dLEeA5pI/StyXJlznzqATJqz1RdcYGc5CYfsGlJbgQ7q4SYnvxwxVLXWS
	 be9eb55INScLNjptjVYh7DNhvq4HvfLLaaKP5t8BaG4VwGExTxqiHny8f0siAwSbk72f5
	 3+AXBxiz4yNikbkV0uSNbRkFotfmiVOyDCnm5lo+n+IECQI7IZ36+4vzR1v7oPfumLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=WyNKKpAN;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C3960A3811
	for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 20:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04C3960A3811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=WyNKKpAN
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdb628232d2so2076435a12.0
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 12:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686761; x=1795291561; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=WyNKKpANsG5sdrHWGAt+Y38DvSIGt+WnCUyNYCZoBM4YbSq3wCVAHI95jQ8BFTGgLn
         +vM7af/q0i5zrzjZXXnriwzXN4L/RbeBg/iztvO0eyeIXYNiQp/OYlS5LD9yZqr2gKgm
         1I+5A88e/cV4J0nLZfgp0f7sQwj9jY0Q4quBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686761; x=1795291561;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L9fh6nGpkdQ3PKE1Pv6VuACg3WWhS00/MicQv00SggM=;
        b=1/CtK4FMV10oA6zD5mM7PiFI7+upTQ8azOicTIGhEGpZliJLaCmsewYGOZSlPMvQnT
         5knXr0KZ1ne7/4JhPnyTgMs+uqspb76B7dJc5sOab167bVjoqwkR6nuTsNYk1ePPiWiY
         bltH3Ed8km8spUr8IPmA5QPdDBGRVQblJPKAOwx4PxYH26MqipkEls0ls7ZB2Tl5tJAK
         ktqnsXJ43bIuiBVm6hQ8of2ymYKmwq1Fu3XJZipCJz7tFAvpVDhA6RKJZOFYRleXt+1p
         FwnAMrxFYqdb1hOXLLEJUM24/lfnJvnwaVkaO/SIna4FlfsoQED3h0NLDX1EnpjbDwBL
         u0eQ==
X-Forwarded-Encrypted: i=1; AL+hErFvlFwqTR/OmnsFlaBprTraKLpWaDWUlTY490x9UCJSF2xsxY/qBUS+aKehLHTbVGsi4j9L1zOgCClZfw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8zFAPqjYnkNI5ZseNWFsx6sgZMKge4afyuU0TVAyMjCHW1xKBE
	GpPjcQlga0ZRUNoVWKeAs9+hSzlE7qjVoGhbITIkhe8lsyCzsmSCytGkMw+CP9MHwjI=
X-Gm-Gg: AYBFou1fcyzBFBwkfE+jCS/r8nrCxsqNojC/F5T7pLmhxJxgTTyZQeXQ8qOsth8KaKj
	SFBiR5ZlbkJXcFF3MHY5E29/y8iKrNntYI0m8SWPOKEQ5iLIufxmey1WIs7fRHN0JxPHop5ez76
	pumZiEqid9/xy7PTNu6C5or8tvy9/chNw+OnFyQhd+Z2tsoLWEwq0j0jXzwVZKFoy7cp8crKAuq
	fYZaajNkwX20CmCoIlcickiS2YpceWtHesdpDhx3elh7dvcfrGT7xV65mxaMHb4bHt47uIuwDsl
	YgW1P5EKiX5aWfMMuLYEBk3pS6pNp9LRmGzhfYd0pBZtLKQaS2L5G+D/wz3JxFjn+PfmE8+UUWT
	0BzPbTRy7xF+7qXx7mi0IXaAOKXvVvfZJdRSQii9vyjvwjeMGS28MTQw39vQ9xH30wnBcEcO9LV
	XwopfOJS42HqhJYh8UGL+C1R7IB77YADuoGv/kZxJh2OVG/O1USXMWotyS+Tb+A+wJ/04rIbZ6L
	coRjrB4JMth3vpHaX4E9N/msVypYTA+8h+NX3Y1TwGycjsBBGB3Lhgzgz5hKr1o5AyvU/vfcP4S
	VQ4hPCqnvMkBcbPP03OVBhAwVnPWyJbZ7lywKrkFoducHixlYy/PuPC1IwErcspTPnYOGc6Nhbq
	NRcnjsvBC2swbFrd3PfnLNxPEn350+CwnOEa6Ah8dIYcEvo1K3hyhKyFh2KPA2BtV3CMRt+YAqG
	/4lO74ZUgxflIJp5/pCj+e0y5f5bhHwCgVJS9ca98rA16iJYu/zA1UkMgh
X-Received: by 2002:a17:90b:2584:b0:3ac:9f00:3bc7 with SMTP id 98e67ed59e1d1-3b1b0ba61famr5629200a91.33.1794686761104;
        Sat, 14 Nov 2026 12:06:01 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm5258887a91.0.2026.11.14.12.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:06:00 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:57 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 33/42] fs: add file_check_backing()
In-Reply-To: <20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-33-98639a2286fb@kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120557.4bc1eb6e57218cdc@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Christian Brauner writes:
>+	/* Look through stacking filesystems at the inode with the data. */
>+	if (d_real_inode(file->f_path.dentry)->i_sb->s_iflags & SB_I_PSEUDO)
>+		return -EINVAL;

This looks good in general, but what the bots said about O_PATH files
here is real. With FMODE_PATH this is reached for a file that was never
opened, so on overlayfs nothing has been through ovl_open() to look up
the lowerdata of a metacopy file yet. ovl_d_real() then does the lookup
itself, and when that fails it hits the WARN(1) at its end and returns
the overlayfs dentry, so the check passes as well.

Only fuse passes FMODE_PATH, so it takes CAP_SYS_ADMIN to get there, but
it's easy to trigger with that. From a quick test with a metacopy file
whose redirect into a data-only layer points at nothing, registering an
O_PATH fd of it with FUSE_DEV_IOC_BACKING_OPEN gives

     ovl_d_real(/f, 0): real dentry not found
     WARNING: fs/overlayfs/super.c:79 at ovl_d_real+0xc9/0x210
     [...]
      file_check_backing+0x308/0x5e0
      fuse_backing_new+0x219/0x4a0
      fuse_backing_open+0xe8/0x390
      fuse_dev_ioctl+0x53a/0x7d0

and the ioctl still succeeds. A normal open of that file fails with
ENOENT, so nothing could have used it as a backing file anyway, but with
panic_on_warn this is now a panic.

Maybe ovl_d_real() should just stop warning when the lookup fails, now
that it has a caller that isn't trace_uprobe? The check would still pass
for an O_PATH file whose lowerdata couldn't be looked up at that point,
though.

Thanks!

Chris
