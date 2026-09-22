Received: from mail-wr2-f27.google.com (mail-wr2-f27.google.com [74.125.225.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48713549389
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 14:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085966; cv=pass; b=d0T5PCgp1PGgi+K7ouRXPlvte4qgNODK2deF08oX+BzRtyrzcfh04e11S4DKGNQF4lQiYDVB5wmHlTspEFFOhd4S4cowJ5TRNyaaPPWGZeWAKahLh2kubydvjMskwP13QKW0gbY895TaIMX2nsY7LhSNxwi1/se3/R+TbNAoEFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085966; c=relaxed/simple;
	bh=FFDGTIkdjwlrSIKakQdYABzBT/A8PNvRaqDPQjmAe6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIPHTgzICLma7VOnR5pDajOycDp/i2fVdgfKLNe4+DPFvhcj44DB10ll8BvJkxL/dwtU1TgQxOozEKzOG5ktPulqJull/8BN+i4nEEHZ4uOculEgw1Di+xAZQGSemoMtwXVEa9r+jVHpCZG/5exS2Iv8i1ctd3VXOjIaAgg2X1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y2mCWJGM; arc=pass smtp.client-ip=74.125.225.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y2mCWJGM"
Received: by mail-wr2-f27.google.com with SMTP id ffacd0b85a97d-4843796e373so2439761f8f.1
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 07:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790085963; cv=none;
        d=google.com; s=arc-20260327;
        b=lTz6gQfnMs+ZszXeGi5436kFOpJQPLtzaMPabe4965+ZZMSSn5qngpjcJK0ZSaCkOa
         iAUSo6Vr5NBwaZQz4PpdW5HvCZTnXXmSXrWyUs/CwyuZh+zLMVjXpNUQoloSlF9I1aDt
         CFGCr6HKw9Zoya/ryTIx57Y81uG53EM2FzfPkRWo1CGXeANnVk0SdIXS5FA6VCPdN37q
         aphSn6q4KkcLJ/yfvVXoCmBFyOVMlKRgLK9yxqP5IJHYrPPTnr3WQ/2Y3Qi6OHZJnmA3
         ttabVOc8r+Q8CmGCHJp8KGc2EjFZNIT/iAOiBPcbc1wxhyjsbslT2fM+pYbT+SNWPNNe
         1M0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HQ5Sa3kOLjyBVe2SVv4WjG5tA5uHiXwiU9nv/zosuek=;
        fh=BMaL7fscoZGCJkVdgqjbKnPc1bq9MRmosh6C0aLz6pg=;
        b=sxZcdJsLA4ArTZNwY9IHAZQozKvdlLZOqRxEOVYcTriXL34T+EJ38/lJdowSDk0gyj
         z7Gh1Y5PKUTZOpgHEcFQx+CHX2CnNvnSa3VJ0Ae9aQCKYe+UthhlFXY46OEWkGTvEPOb
         rkDGi8+Ry1XBM48TUW9dorKbANjDSOH/AIlM/f0hb3MztbsY5lppMqZTsOv1+NUkxAKh
         gy6FbHJklfCSJiDE49mgh8tdJF7wdayR9L8IKOAR5cVjRK+Zn0H6/tAqyDoXo86eANx6
         LxJb+wNapFS0/xCMOLpgiVJ7gOy1Dz7mw0t5GIo/BVef1xSryjlxECTqkFZ0YKl8x21Q
         7VCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1790085963; x=1790690763; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HQ5Sa3kOLjyBVe2SVv4WjG5tA5uHiXwiU9nv/zosuek=;
        b=Y2mCWJGM63FTGl4+yJW4u+r0juwVDCmvwuHvh08vBoh/KHFZxx1mQrlB4lOpzLGQkd
         +PoPDF3QjeFaDtroPLiULmOeE+PQFuJ4pwcUXjRAZ8Kdws5qRDV+RttmHRfXlh4FGt07
         ICZFwgy6nM+mR5fslmAPAZNVCuIheNoI2G3r3svUf9EUJqSgw6sDDiDY/Q3BE3V5/2ut
         whQPnVzaooSi/VV/jgruiDIvINZFSRvpb6BFoiqPw25LpeFLwd2bAqVzG38z6CNMBfds
         wjpVpgyQufgMueHsbd7zyqTl9DOLfgyBul+EvaSMTPh6Ekl9YjstZjQ46O7hJanLyAD0
         e1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790085963; x=1790690763;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HQ5Sa3kOLjyBVe2SVv4WjG5tA5uHiXwiU9nv/zosuek=;
        b=udTIPeAYHUiOBGaUho5Cq6Bwlqm9DDGSQWJnAsO6aV1bGqs/JNduZd+rp0oeawla+t
         FnuSRBS8visyt9NwQqWO5shdJjHi2KWkiN8L7zHWHoqNeMMx6MfkAcfef3iGgitfe+Uy
         bQLR+oRs3P1xMDL6rB3iA6QSwwCvos9nfAY9GFd+r9CgzfcONhQJ5fQi8L8Goo1MtDXH
         IblQwMuVfX/rpoIemQpwC7WUp3Fq5v35UWWHTdIBRCiHvm9hmIK0ofMXOz6P1xdZxQNS
         ertjDKzeH72SH5kyva9UG5d5xZuhZmQn5D6vxxhhjPXdGzi+lfuxT0vHKBgHGOpOEdZm
         xJxA==
X-Forwarded-Encrypted: i=1; AKwUvBzQRi4Kw9pocIHKYx0CM3D+wEePI4IEJGdfvgE0SbN9VYcAAvJn3s74AXryYCa1ygHu80c4FZRj5OACmA==@vger.kernel.org
X-Gm-Message-State: AFuF++mCXiJZcEr+Lqpcjcc9RfmLQZv0qSWF6dZQtqZEKueWb/2xOVT9
	PSx7UuLqroO27OSrfSyrKWUe2KCvGp/DhsE15HtI+KtHjEeQGnFip4HczD8fxNjHeeWeQ4D869A
	hYUaKZ8tQNGCQ6+Q8fnQq5kT/6PozKiuEsJvMqVZTlsvPblvxVAoftSg=
X-Gm-Gg: AYBFou2P3Q6yM4MqrZ9Plgm7kieoAENIwmzXas1K8XMBNJT+hhH9Zt115Wtdgia5uRX
	8bvCNHWNdMuGCo4sFAKYGdkVc/+oXrGyZaK8MWEf4VMRQXlRd5c5JTw6eEm/Pob6ApdJWc1Ym/W
	542uAHV79ZpuL4bLHrKriwhgXV53tEzAI2t/uAJ00Ni3vuFGLKzauIqPkrBP/7fTkT7pvdiopva
	tPPeTzf3l6ciFUG//oGNvy0EPLt9hOtz+B9xv9X3YpzOtxn9bEPMPROoVGhsyhETnAX4Ybt2djZ
	kKfsscmqTFQtQBeYeCla2MNdhUEvtkMXrzmRLs3ZgHkksyYspsNSeRzP4OBOT8EvSmfnKRzHp0e
	pDQP2rc+7VLwSFLCBDLsAXLpK0ia9fDVFJLRbf/cFODtNT0CaZd8vwufykMu7wfLi
X-Received: by 2002:a05:6000:2081:b0:487:936:7ce0 with SMTP id
 ffacd0b85a97d-4871e268810mr20353521f8f.28.1790085963456; Tue, 22 Sep 2026
 07:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513085340.3673127-1-neelx@suse.com> <20260513085340.3673127-16-neelx@suse.com>
 <20260602023556.GC2295@sol>
In-Reply-To: <20260602023556.GC2295@sol>
From: Daniel Vacek <neelx@suse.com>
Date: Tue, 22 Sep 2026 16:05:51 +0200
X-Gm-Features: AclHuK9CuIsJsfiw8COS456pIsuT7e5VI7VW-i2_tJPdheeuBMmFVb8b2MLQ3fY
Message-ID: <CAPjX3FfSeE+WOya6Dg8aLSCRADBvnm0nFBk_uBbaeFM4egvqGQ@mail.gmail.com>
Subject: Re: [PATCH v7 15/43] btrfs: implement fscrypt ioctls
To: Eric Biggers <ebiggers@kernel.org>
Cc: Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 04:37, Eric Biggers <ebiggers@kernel.org> wrote:
> On Wed, May 13, 2026 at 10:52:49AM +0200, Daniel Vacek wrote:
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 6a37dd3cc5ee..2e0b79f41197 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -5159,6 +5159,35 @@ long btrfs_ioctl(struct file *file, unsigned int
> >               return btrfs_ioctl_get_fslabel(fs_info, argp);
> >       case FS_IOC_SETFSLABEL:
> >               return btrfs_ioctl_set_fslabel(file, argp);
> > +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> > +     case FS_IOC_SET_ENCRYPTION_POLICY: {
> > +             if (!IS_ENABLED(CONFIG_FS_ENCRYPTION))
> > +                     return -EOPNOTSUPP;
> > +             if (sb_rdonly(fs_info->sb))
> > +                     return -EROFS;
> > +             /*
> > +              *  If we crash before we commit, nothing encrypted could have
> > +              * been written so it doesn't matter whether the encrypted
> > +              * state persists.
> > +              */
> > +             btrfs_set_fs_incompat(fs_info, ENCRYPT);
> > +             return fscrypt_ioctl_set_policy(file, (const void __user *)arg);
> > +     }
> > +     case FS_IOC_GET_ENCRYPTION_POLICY:
> > +             return fscrypt_ioctl_get_policy(file, (void __user *)arg);
> > +     case FS_IOC_GET_ENCRYPTION_POLICY_EX:
> > +             return fscrypt_ioctl_get_policy_ex(file, (void __user *)arg);
> > +     case FS_IOC_ADD_ENCRYPTION_KEY:
> > +             return fscrypt_ioctl_add_key(file, (void __user *)arg);
> > +     case FS_IOC_REMOVE_ENCRYPTION_KEY:
> > +             return fscrypt_ioctl_remove_key(file, (void __user *)arg);
> > +     case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
> > +             return fscrypt_ioctl_remove_key_all_users(file, (void __user *)arg);
> > +     case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
> > +             return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
> > +     case FS_IOC_GET_ENCRYPTION_NONCE:
> > +             return fscrypt_ioctl_get_nonce(file, (void __user *)arg);
> > +#endif /* CONFIG_BTRFS_EXPERIMENTAL */
>
> Are you sure you want to auto-enable the "encrypt" feature flag like
> this?  It doesn't even require a privilege.
>
> It's also only in FS_IOC_SET_ENCRYPTION_POLICY, so this doesn't work in
> cases where users add a key first.

The filesystem is flagged with encryption once the first file is
encrypted. Adding a key does not change any on-disk data if I'm not
mistaken.

Though I'm open to suggestions.

--nX

> - Eric
