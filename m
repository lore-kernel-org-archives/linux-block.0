Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794658799;
	b=J3qPePINxJ5Jx+R3dShy2IPxovGBHvMoAPaCEopOZaU2JZHbl2zfvYJu4cB4zzkwiUpm
	 ZYORxlHNwznq7JhPdV03a7RiKqryYhFQITKw1bEw4hfMF2MkFT6WoUdOZSsSfKWDSaWDE
	 tnuuf1mPR9SCz6xLpLqfwMJscU1m/PJ5D4U8HDPk8dWnfgIzuYShzcF3soWyTHh1H40eN
	 9j0dVRJBqMHw8GZYrrKZ8L2B8hKq0mRRO/pVOLSR+lOSLczf70c5HVk3Hpvb9MnP3KVw9
	 Q/97brkE7QhQsM9XtbeQBJW1yrvTyMHlmyjGDad558NSDNxNCx7xJfzr9cuRAwQKQ+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794658799;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=;
	b=gwCbhUuwib+IKnBjqOzPEjxc7eX1r2nBZxI9bZ8eUJL0IEeq5NpILAjPBKmCXIItPWpi
	 E+ta7Mg/ZVKCgbdNvkZaLLiXEVHzjOvHYl1ZcIav6acRxqSk/xV1hyp07+P+ZHopRlw7X
	 Y9lwNujwW0QKz35125UjGDKR/39M+dkqTHlGucGJ8Vkf4dIa3KwjuPgou1tRH1vV8BcWk
	 DaOfUMD7VEVAv6C338ybXzYhJ7Dg2YSlZZSIHlHpfFcnro2rcKYvzu4AFqzQJXC2dc0Qk
	 DdQuE6NQbIuHA/uZupr34iODQa25eu0Cqo7XQUjBAbSPcouSvGYSovoN+Nhn7cAWehA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zvg2B30u;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EC1606A333
	for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 12:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34EC1606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zvg2B30u
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c40e30c26a4so402486866b.0
        for <linux-block@vger.kernel.org>; Sat, 14 Nov 2026 04:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794658797; x=1795263597; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=;
        b=Zvg2B30uBzOFFo54OpfHCzqSK6TOyxTRmwNZV7t2nfrBwunaCrRH+5tI09/jIosXZS
         GdYk6iMfyO0nJ3moVzjaSKnXCCWxcV1Ye+R/4YjiwdwGG8ofIv4PWH24MjP/VV4CkNiq
         nSM7j6UNEdEDdNWpjUjn43q9YL/wt1IFltOrsPhL2VYrn8g/yyR7Uz6PFelA0j1tolIT
         QTqiv37OCVMy+5oEwlNBsw2cKiejzgZGAC7AZW2QPAu9cR2dMcfIteYf8vq02JyCIN53
         /PYiFz/vA+fp7KPo0fCiRfu55fCeLd5qLFIcUMGbAUVH1mkivaDzQTprXnn5n1PDT9pn
         6ZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794658797; x=1795263597;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nkM3J4QAu8kIsGHpB1EKb0NRF0JxtY2T/gqGpQ/nt0Q=;
        b=1bP7ZYwVCgLVxtTEwIJwRRc8uJOwUCGobJO7Nk4HXgDgy90ulkXpKfcdDhqdeisgjQ
         Cwj4+0mGnl1+z1iiMa31f546yjKXDGm/i6h99ToQb8t8Xxw3FqaqbvXZPVUpZtU2/BIq
         AnsE/Sc3qiE4EJJg+rCAFn/3w095fFuRZS9NePjfa5ZYd+MmKf/tOIn4Auiu+/ShdD4R
         ccblHtB9y8WsWA0YBABVen5ievLJipmRajk/k7jACOsmDEHlxUN2NAVQ/Bp3LyYW/FgC
         jNW6FvIdtmh1VqKAv693+gOTs1YP6RLSW5zbq9zNfszdgPI2LJOm+ktXt7V4HBpXPnoQ
         Qa+g==
X-Forwarded-Encrypted: i=1; AL+hErElVCwYI0atTViOzDwrfFhAepvMxmVAQjEkJghFlzSpsUyKNy/LquiUNxIk3i9LtXOmgUXr1mUzjxRzfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9hc/U/FswWM5oAqvPZFHbn41OqWlOoPmWjj5kx18OrWALRFpTx
	u2Y9rECo3ahxZpnJ+pTZ4/TtHYp/Fltbl/smooO7WH38lN/Lbj2KgAXR
X-Gm-Gg: AYBFou1MZDpJKjpUtzHx+a3ADYnlM0jxn4LFk9eXm7oG4U2Yb+j8fAx7XR8irDKEiyj
	eRJC2fLjqUEMMOgXvmTKsHQTOE5p7xUXp8YdwaZvkH2NzTAsGb54EUjD1C6q9wU6HHVDsq92OQA
	0UP9rtZt0druTo3itg3auqb5M8H6Av1/dEHSiMuF/dvzo3uFAcvcwhW0p/WmMDuabxPeB36yr4o
	6iSJVnzoeBtzVZkkbepUQuAeH7YV+7vgf/l6qlCMCEeoqw3aG6TY/EKITbQIyktxyVCZRPU+4TI
	NB8AvohbhNtnxB+2tzl24gzq0Muu0qB0RnsmFkDnpzsGPXjRLXQTCWCTyngTmXTRpPBRzr9R15S
	t05EFLLo/neT0nCPMy7F9S5pWtOBKChcWm0GYprKRGagxpwemVRcGeRGRh+DJUgnBim/Au/bLz4
	OuAPJUJ3T8TEuZTVDDLuVi5dzHE7xkY9Kyr8Wq2myiwBS8SAV8A/POjZzegLTP6hyIfLJVPNctK
	/jFdega5hrXnIQqpGCVPg2TVwX2X71hfCAmw0b0zrnsw+iFlP9rHKoxIU9Q1LAE/dy3oWbzpuYF
	zu47O0D0/xc32AqXmwC/6OOYQXQSLyXeVWeTHEmDKXVURdy4O4Z+s4wm5kWWuQW3I6VlWEmW6Q3
	cr3NDUwVIYeci
X-Received: by 2002:a17:906:1001:10b0:c41:4512:560d with SMTP id a640c23a62f3a-c5096387b02mr309942166b.16.1794658797424;
        Sat, 14 Nov 2026 04:19:57 -0800 (PST)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b5ac2asm211518966b.55.2026.11.14.04.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 04:19:56 -0800 (PST)
Date: Sat, 14 Nov 2026 13:19:56 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-unionfs@vger.kernel.org,
	bpf@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 10/12] ovl: take freeze protection when storing the uuid
Message-ID: <avhR7DbNbVDCyPDO@amir-ThinkPad-T480>
References: <20261114-work-fs-frozen_writes-v1-0-f5ae61c898b1@kernel.org>
 <20261114-work-fs-frozen_writes-v1-10-f5ae61c898b1@kernel.org>
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
In-Reply-To: <20261114-work-fs-frozen_writes-v1-10-f5ae61c898b1@kernel.org>

On Sat, Nov 14, 2026 at 11:47:17AM +0100, Christian Brauner wrote:
> ovl_init_uuid_xattr() stores the persistent uuid in an xattr on the
> upper root. That happens after ovl_make_workdir() dropped its write
> access to the upper mount and before ovl_get_indexdir() takes it
> again. So a freeze of the upper filesystem that lands in between lets
> the mount modify a frozen filesystem.
> 
> Take write access to the upper mount around the xattr update.
> 
> Fixes: d9544c1b0d9e ("ovl: store persistent uuid/fsid with uuid=on")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

> ---
>  fs/overlayfs/util.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
> index 521717209b2e4..67aa7b71e9c83 100644
> --- a/fs/overlayfs/util.c
> +++ b/fs/overlayfs/util.c
> @@ -829,8 +829,12 @@ bool ovl_init_uuid_xattr(struct super_block *sb, struct ovl_fs *ofs,
>  
>  	/* Try to store persistent uuid */
>  	set = true;
> -	res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID, uuid.b,
> -			   UUID_SIZE);
> +	res = mnt_want_write(ovl_upper_mnt(ofs));
> +	if (!res) {
> +		res = ovl_setxattr(ofs, upperpath->dentry, OVL_XATTR_UUID,
> +				   uuid.b, UUID_SIZE);
> +		mnt_drop_write(ovl_upper_mnt(ofs));
> +	}
>  	if (res)
>  		goto fail;
>  
> 
> -- 
> 2.53.0
> 

