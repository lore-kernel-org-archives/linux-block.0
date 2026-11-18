Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795044957;
	b=x/YQdKmx4aDD+1r583V6dVWJkRO8JX4BZT0WI9j7P1Nyi1My/pKOcI9qzLTyQGg6q+lR
	 LWdY0350F3gn159i3zRg4QYNqVntD1V6yZZL02YhX7UZ1rJf8XQuCr3fSgswfKms85Q43
	 ey2CK81TjtE01yoDKjSMCGhZtWvj/XnciEYGH3aTOjQtx2nO27Q0v98GgkKnGuuuUu0Tm
	 TNkMAs+5CX3gt30kL3iGwYh372nYWgKBAdl48IMdB3ZFM/MLGWrDsIkgRrCVuQTZLicCR
	 OIRcvTk5rWAmLGh36KsIGZcx91zlDkIzq5v5jf753vEyNeh2O7NUTTB7CBaQs3R2drg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795044957;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=1sqaAoxbPYdo18ldNOsiM1TbcJ03Gv+SVlc5ayXI+nY=;
	b=Zujf+vd/qTkB+SV3rUhDp9Zxs2ACzUyb3wul6ydXeEUP0wOwPggJx2FjytBdSawJ3eoP
	 iRsBGuMjCqSTF6HzH8wYhECmV/yxAAGeplK3MGAUs7pdVtd4GbW7AU+55ig3RqUCf0Zdl
	 6YwXZ2oAToTKNLyst01od3zLjuly7akEMYhMUrdpR6yCYcd8lfCUam4IcCBqdXQXUFyeI
	 +RMWury0UtFcBWu+4+sRNMVMHvV77/jj0cKPNLdzUGtnoVr5ibvFHh+VPnYUc9oDYSqIV
	 Gt2Iz7E1TgWttr5zoGQS0Y2fUmrE/Rvb83Adj9qFKNSpugLQ+OuNJjbj/qxIaizhlMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OeZtfPG5;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VV4lacCc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB0C606A32C
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 23:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDB0C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OeZtfPG5;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=VV4lacCc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795044955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1sqaAoxbPYdo18ldNOsiM1TbcJ03Gv+SVlc5ayXI+nY=;
	b=OeZtfPG50Fjqj40s6Sj+6Did4ufEl3tVHRxceE+mdWNbGwx7fNYk44K7y6G04p78xFCD/R
	1kv1BumxCx310EyVnA8d4SqhUasQR7TMJCm7IYNKBrDLFc8ygMd69JH4NPy4EA0UV5oaOI
	oaiqNL+fbnuAUb7jfi3vcX/vMHMt/3w=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-KyUrx0wuNF62oSGWJH88ug-1; Wed, 18 Nov 2026 18:35:54 -0500
X-MC-Unique: KyUrx0wuNF62oSGWJH88ug-1
X-Mimecast-MFC-AGG-ID: KyUrx0wuNF62oSGWJH88ug_1795044954
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-67db2bc1b82so1679751d50.2
        for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 15:35:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795044954; cv=none;
        d=google.com; s=arc-20260327;
        b=rIbGOvezMcUPtszTlLFRtD0KhHWoQDJn4eFsb1V5b4VzomNxd2ioVj5Hjof6r90VBi
         uoLW8qHjJ2ZjI/v+2A2IsU4p41rFG9F9yeuU2IRlwA2gZsuSIqKGSxWsPweSeQDAyeyG
         oJAjmW1p+kpQ4W/G8MvvxDKZlCEfmeGVrsSdnuwnaNqKAaugjVtFEmHnZIVHkNya68Qy
         ZMgVs0GLljDcvD1Hvik3UcRc4ukvRncoPE/6jYVVOClr0XgOvdGNHjsR+YEoyWF/9zff
         KOojMcfXqhCfJcwr0O/k20my6XWDWNWqLOLEwXtgT2yKA9AKkUlX6ZJHaflLfLH54HQa
         FknQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1sqaAoxbPYdo18ldNOsiM1TbcJ03Gv+SVlc5ayXI+nY=;
        fh=c2KNRQLuxpjALWLLVIpzVOeSxOXSAhhof1fiWzwHryo=;
        b=azA3g3EsvZv2rmbyaxz9COT08sCVILTSaE7HnpCFtYwwwVEaOnl/NUmqd+4LOa1tih
         qadLVbP0czs6kzki96hEXH5dS9W76+5rOStJYkD9bAU1gcjusaxGOlPK7WZ4by5JTWlR
         m8qkPJ50GHDtWo7PIVYSiwoiVZUcBKrkE/mC9QPqvbR/b8FeMcNVkZGuHNo5r5+Qoy0w
         Jy0xmJpb+6YvLjVm4x+bn2UNWxVVnrSxUfqCqO6XfksVjKhpIIwpePFj0IXfQWa/lZM+
         boqbiXgYPxwYKlcmoh7l1H9RzZ/ubpCnhnyD3DReGchiRepAv3n2BHqv4O9V9m+6ZdWo
         W7FQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795044954; x=1795649754; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1sqaAoxbPYdo18ldNOsiM1TbcJ03Gv+SVlc5ayXI+nY=;
        b=VV4lacCcYXl3jx6oU1yk7ocsmoMzxU9SP0AoOrXpBHytOyD+5/iloPPuTFDwHot85c
         i1CuguwIDMKYkYwOifW2jU2ON3pcwrl2ze+1M1zXcGvzpEjssC/9u8BP5GrnFxyulUg4
         m3kl+sBRcRdHC6cSbeJi+MrV0kK8R6nXJ+1+w101Ltg7NsQzens8JvDyW07HuceLJ6GS
         rA+E2+jV1u9T1OR/mFRBlrYQhI5+p4bfkvpqrJOCTWbtpDO3YyPi5JSYd2/v8scOcjke
         d/uPzbLWNdLsBIgq0z3OZKLiCCq8cx+Fg79vmPk4t0z6mQMU/UeaNF5w+hvK8lTtE+Iw
         eTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795044954; x=1795649754;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1sqaAoxbPYdo18ldNOsiM1TbcJ03Gv+SVlc5ayXI+nY=;
        b=wv0hAsRYNeEZ9O2eoA2s0AlR8UsE1DT3kYxDxab4oQ0VyIpleXYScsZDHAPID+L5Ax
         ZMB+6JqiTlv53lI1O00qg0Itcix9tU29YBdLDeL8gRPCKPUQwoXp7COXPzZQ/DDOaZMW
         VzW1CxtC9FyM/8dsSBuKTk8l/q88lm8Z9eFyP7XM7xfoG0OTynfW50gxZfotH15F5OWi
         m9JSsgQ2hPmSQOpWwQewV+PVgQ7iCHCJ51zZaoEGmvwf22Yi1bseebLQec0ik+fDOXuP
         mPYy2YypoZCFgWVodpfJyGShVleNBXx9lPSQw+VNVhtuvqcHf7MuQDNiU5a6NKTQWBM/
         jjJg==
X-Forwarded-Encrypted: i=1; AL+hErHzjdGloaqEoQ/PzgJVCJd7aQWIAGUsj3pGlbEg2vv+J6V+BUMUx6DOLsQv+IaCUM+UesOI3XwsAHsXTg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8WJb5Xa6cXfmXN8i7dmhbtluSxqiCRxmYib2U0RL3TYFF9Ro1G
	va+15k77ppcvaGkUrwF5FSZGCgmhG1D5Z5oeQGD9wf1BAYbnE1xvEwqg8xA44neKeFAB2BtU11c
	G3zKFKijlWXeWd8qg1tJvKYbxgnd/zk8xWqOb+Ko2fXfwse1hxWa51XIW4iaoXVqDfqdB8vLQrL
	ijJ4qRzh4eA6AWR/z0n/fRQVf0JL7weAjxrxPMO5c=
X-Gm-Gg: AZFdTZfio8byEkjyqtDII00Q3JTdQkwdkPM45/4DM7dQLndupPhSXLJH6eT8qE9MAlS
	OZZC2pvA/ULd+AOVC64847KsU/CtCz02wvZxrlhqNwt+DHn2pKpxAgMU3X5pP5Gbs1MCE5VgWgP
	AbLbgPDsxhCwRZ//mfdTt1MBT/LLxeT5oMuaZUtp/eSU7IVSZXrdTTnklles+4A7DhVBQlbioEQ
	ATf7fb/MKhmotrGTj2YRIX42hC59a8108aBGWo19BJGlA==
X-Received: by 2002:a05:690e:128a:b0:679:2a90:d3ad with SMTP id 956f58d0204a3-67dd403bf8cmr1618031d50.102.1795044953735;
        Wed, 18 Nov 2026 15:35:53 -0800 (PST)
X-Received: by 2002:a05:690e:128a:b0:679:2a90:d3ad with SMTP id
 956f58d0204a3-67dd403bf8cmr1618023d50.102.1795044953295; Wed, 18 Nov 2026
 15:35:53 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116171044.6938-1-jack@suse.cz> <20261118145941.1063127-19-jack@suse.cz>
In-Reply-To: <20261118145941.1063127-19-jack@suse.cz>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 19 Nov 2026 00:35:42 +0100
X-Gm-Features: AclHuK9zTsUN7zuq72-DSL1ny4jnrrzy1tFjBUU4DEu6A9maK7lyiUQZqwV6vuE
Message-ID: <CAHc6FU7NoZua98SGP9Kuga58gAcco6X__u=kOPfsUqbefAKLFQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] gfs2: Avoid racy dirtiness check in gfs2_fsync()
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, devel@lists.orangefs.org, 
	Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net, 
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	linux-afs@lists.infradead.org, Miklos Szeredi <miklos@szeredi.hu>, 
	fuse-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-fscrypt@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Wed, Nov 18, 2026 at 4:00=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> Check for I_DIRTY_PAGES state in gfs2_fsync() is racy because
> __writeback_single_inode() unconditionally clears the flag and
> reinstates it only later based on PAGECACHE_TAG_DIRTY tag. If
> gfs2_fsync() unlocked read of i_state hits in between, it will not see
> I_DIRTY_PAGES although there may be dirty folios in the mapping. Check
> for PAGECACHE_TAG_DIRTY instead and use inode_is_dirty() helper for
> inode metadata dirtiness check.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/gfs2/file.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 1efd0679badd..f5532f72ab99 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -749,7 +749,7 @@ static int gfs2_fsync(struct file *file, loff_t start=
, loff_t end,
>  {
>         struct address_space *mapping =3D file->f_mapping;
>         struct inode *inode =3D mapping->host;
> -       int sync_state =3D inode_state_read_once(inode) & I_DIRTY;
> +       bool dirty_data =3D mapping_tagged(inode->i_mapping, PAGECACHE_TA=
G_DIRTY);
>         struct gfs2_glock *gl =3D gfs2_inode_glock(inode);
>         struct gfs2_inode *ip =3D GFS2_I(inode);
>         int ret =3D 0, ret1 =3D 0;
> @@ -760,12 +760,8 @@ static int gfs2_fsync(struct file *file, loff_t star=
t, loff_t end,
>                         return ret1;
>         }
>
> -       if (!gfs2_is_jdata(ip))
> -               sync_state &=3D ~I_DIRTY_PAGES;
> -       if (datasync)
> -               sync_state &=3D ~I_DIRTY_SYNC;
> -
> -       if (sync_state) {
> +       if (inode_is_dirty(inode, datasync) ||
> +           (gfs2_is_jdata(ip) && dirty_data)) {

this adds back the I_DIRTY_TIME check explicitly removed in commit:

3aac630b5ce1 ("gfs2: don't worry about I_DIRTY_TIME in gfs2_fsync()")

Could you please clarify what's going on?

>                 ret =3D sync_inode_metadata(inode, 1);
>                 if (ret)
>                         return ret;
> --
> 2.53.0
>

Thanks,
Andreas

