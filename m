Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794859646;
	b=GGkxD1QiFryKOzEeuRTG/THgeAzcf9G6urRfCNH6xXoJimj81y1lCjr8nBAqeZNYutUm
	 hSZI/EgFI1MmfSB48jbIQMruchnTSZHGLvUsWIdUzDy654p5zVIzxibFo9Qyhu78ee5sQ
	 zc7z+pQ33EExTTUje+KVNn3ec8pEv/FobsAqtHEwGd+0FePLHGtJKzr5ORlF4/5bKYJ9W
	 JSdT3PLyXm4+w0ftqJRit29MMaVIszAdcGKoRdatx5unoWB8YCuVWg45tKODv6WD5LwU5
	 0StzXqVhBF0nEDZGX1xGruK3544O/SzvNxnv+NnG/QANC9McHyaFBvFRYLsMpBzenEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
	b=5me54uzvdkmZdxMp0Mx5jw4ZRDti75eX4vxRhpXSaHYcW72kLCgUHa1JYqYYZJt/q/bL
	 +DWntENhweXujoXPNNe7Xp66WMDncic2bUIF0eQNvpovQNohWot0HgwP+Rt0UdMjBy6Qr
	 FjfwzphI+MzHu5DjhXSivFrjwqZ/DnHjuhtm6V92EJKxcNwaFjbPD27QejVHcZXvinXgw
	 kgsW2bWZOg8GXDrwMadyytPKFZpSfdqu1hZcAjZZmcpwwptL6axCyZXS3C6ZP+UPDvWGt
	 6/YOis068uxZ7w/VDU6y9Earr9EAU2zlcAplbLa4ihffh5Rl4ghcr1SQ1KrZEv2bJ7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XFDBy0c2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2415E606A888
	for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 20:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2415E606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XFDBy0c2
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso24829925e9.2
        for <linux-block@vger.kernel.org>; Mon, 16 Nov 2026 12:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794859644; cv=none;
        d=google.com; s=arc-20260327;
        b=j3tRV+rdC3HSW0FaHoqZgAfXTRySvY0ucPbPxWzlibh80cchu/U/2oZGvtEvPB1ko3
         a55YueMWW6CucUrBj2Z2kuh/M28Q9EhnWXNplOX4dtN099DARHIqUiW4BC2POsgEu7Gp
         JFoThxpVRw4ltSvIQs0iTOr2JGbRbsJtYyHfPTTL0iU0LptaiIwf8U0n8nLT7QGDyCGA
         JL88mjQuw9ofFlRwM0DvDRdcnWJ7dJifaexFVrnPXhxzxlB53wH68jRYSljx9sGR8T9O
         +qV+lnrOnA8I2iGX91FK3jh7YINaHegF5GFsk8wHPzGSdecbog8MSiLjKQf0HHxbyKyq
         y90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        fh=NaLhpJr0M5hRdRR9PncwmggjuhqLZk0M2Bi4at4swsE=;
        b=pybafe0UyT6ziJcCLiJ+ryQDIFu3qdgxFLcrhyxJjbhYsafWQVJL0/pCCHVkQO9tiS
         fpk9GAk00BKnAqiRWEVd5swG9rD488Yl9NnkAne3SRKNzH4QExxyzU37Ea9YFi4phYsf
         Fk1hlW8KiTya3//J+/tdYT6KSb9NjW7tm3MHNqAZF5ge1rIZhLZ1F36E1Q2AXu2Xbm6b
         edUf6ydlXJyJtl7yOc4OmG1uXi9HVGomE/b4m2vDJhi84j66k5ik9FbHjUnaaiN3FwfL
         9O/ZOfzcM3OTIGMDK30SHRMi2INBRP+iVJmQ0xyy7SoZ61ncnAi8/VsM1+kWjyxiMql7
         BVxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859644; x=1795464444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        b=XFDBy0c2q6nTYiJ4dwLENH1mguXX/IcFF58gOeYQArjps79P1XpkrhGZpUclTyZwpS
         r/ZYwRoOG8WhRg+8JvLZN08T5FQLHs7jA/CzeQCQsJeulI93s02F+iYtli/pBjYHG+CR
         W2MoU0n/+grSPpLZW83MAsn9WQiLh5CCwtBf/0GxLqRHC416IFZ4i13TeIFhLxmbz0il
         NPxDzLDOL7N17VVYsTOL0jDLDvB5woBcjlvcU+oGB0Wrnz6q9rCc3VHuwmdjl71ac6+n
         fuvYHmykPJU4vuSvTSKMetyKY9BqLddb2of0qXOJ87q21uNxSrudqkhk+T/+cyqihyd7
         2YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859644; x=1795464444;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        b=gg3vNH0MV7eCe8iKXr42dOFpfk0QvAuBtHKT/hDI1ZjS53UHjWpkhCEYoiiyE0IiLi
         Zfh34FM1dM4DI1o6wqbnKWoFrhp2XkSWeKujnpqu+jQCOf+d6fUyB+od8MgLzes5m5IY
         wpWBWquSVspmS0auQIjGLCtkU7PmBHtdjC2uojGj4J/LVZG6zkj28ZObReOSZ/krdtat
         O8daniMQnhpMevyX5j3K97iorynhID8ugvj7yC0YJ4guZnNBxIqGLs/lI5ZjivL0zsh7
         HNhVINT+VljXMvoBiBJL0E7JAqqAPEyWq57pkYz6BIkkHFWUSc39/7ma+17NCbhO712R
         a6MA==
X-Forwarded-Encrypted: i=1; AL+hErFXTm/FEGtrQ+ySjWOtBRtUSDWPp7VsmuDdCsncufkJbOIklUK/hmgdIB9wL8wbPIOVS9QOr+4+wINLDQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+bTWnnswDP0gAqD7W+lDDd3WEIU0cKtSutWszXoKeQtjnZxDNY
	75x6JnPMQiDQYd+UjOMAuP6GSaFlUkCAj3SeiNxrjq9FM4FLxr6F4V+z7VyEUBwcITO0OGBzKMr
	sjvIN3rV+mF2AzEYUBykvsOtcGzR7SzTDn5YtJxk=
X-Gm-Gg: AYBFou0z7GWXeDHfgEXFEhIBP66j/E63Uoc7caYS+JeiqtNTT6QNTOT8KwDDr41xazz
	Zv02P92ay0siKrQYlrCo5sKqxCNgFadEUyYWSBtKfCMBxedn5gcCvqYsTNyXeqac56zoZlyHt6G
	IHk0Dg/gL19TF9UNcSFzLcjyXzGadWn4wdYVXo2bRuh7BBMdtuSZ0Wy4Ki1s6fuSjdZI41/1d7o
	LSDkkmWQWIdBMcND+kkto/Ly46Xhg92OBA7VslkEa7zI6NdklG2IKUCdhmR6Tlz31gAvjmoG34E
	BZ/yw664fdUzRvFYkkUmDzisZCCT6kYMdxkFBWWyNiPHFjqZ3xRa8wD+7+V1ohvHUUIUqR5jEiz
	V/N+0jPyo4zLAChuMSO1vW1s8JrLxoE8Q4dO2U8H/ePxaM0bIlyAyGj6PKaj0zQB9m/NIvoplRA
	mBdrP1lrMlJylUHJjUWg==
X-Received: by 2002:a05:600c:506:b0:4a1:f377:5c6c with SMTP id
 5b1f17b1804b1-4bb55a5d6bbmr165067875e9.10.1794859644313; Mon, 16 Nov 2026
 12:07:24 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org> <20261116-work-fs-frozen_writes-v2-13-ecc4a2aac40e@kernel.org>
In-Reply-To: <20261116-work-fs-frozen_writes-v2-13-ecc4a2aac40e@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 12:07:13 -0800
X-Gm-Features: Aa3M54rpWiCplKeR8o5TX-NbYGDID_36BWk-3VAyUzdEoXSYZ7J-t8pfWvm9Fcc
Message-ID: <CAEf4BzYANM9vtQ8L9-rJPQC-tTcw3YUGsw=qnCaoym3+EU=DBg@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] bpf: fs/xattr: take freeze protection in the
 xattr kfuncs
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 3:13=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> bpf_set_dentry_xattr() and bpf_remove_dentry_xattr() go through
> __vfs_setxattr() and __vfs_removexattr() which leave freeze protection
> to the caller. BPF LSM programs call them from sleepable hooks such as
> file_open where nobody holds it. So a program can modify a frozen
> filesystem.
>
> The hook may already hold freeze protection or locks a frozen
> filesystem would make us wait under. So don't wait for a thaw. Fail
> with -EBUSY if the filesystem is frozen.
>
> The _locked variants are only used from hooks that run inside setattr,
> setxattr, removexattr, unlink and rmdir. Their callers hold freeze
> protection already.
>
> Fixes: 56467292794b ("bpf: fs/xattr: Add BPF kfuncs to set and remove xat=
trs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/bpf_fs_kfuncs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 35ccd98a4de64..7f61e2efa08ba 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -295,9 +295,13 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *=
dentry, const char *name__st
>         if (!inode)
>                 return -EINVAL;
>
> +       /* The hook may hold locks or freeze protection already. */
> +       if (!sb_start_write_trylock(inode->i_sb))
> +               return -EBUSY;
>         inode_lock(inode);
>         ret =3D bpf_set_dentry_xattr_locked(dentry, name__str, value_p, f=
lags);
>         inode_unlock(inode);
> +       sb_end_write(inode->i_sb);
>         return ret;
>  }
>
> @@ -323,9 +327,13 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentr=
y *dentry, const char *name_
>         if (!inode)
>                 return -EINVAL;
>
> +       /* The hook may hold locks or freeze protection already. */
> +       if (!sb_start_write_trylock(inode->i_sb))
> +               return -EBUSY;
>         inode_lock(inode);
>         ret =3D bpf_remove_dentry_xattr_locked(dentry, name__str);
>         inode_unlock(inode);
> +       sb_end_write(inode->i_sb);
>         return ret;
>  }
>
>
> --
> 2.53.0
>
>
