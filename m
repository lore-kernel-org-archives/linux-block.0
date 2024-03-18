Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3854D58224
	for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796336; cv=none; b=RPDlm6OdlPzONpRU0YqOvdzsID3+1cFCxnyrChRkgMYY7XwJdpwdi5WwN5XJz08AxypIl8KYd1CLNg8udC9XDczZUCl7hzEQ+Vkm2vOjjYx4zfTZxJlrn7tneRlGaanyDEPIhClWImk9+QV998T3N/2pIX1d6QZE7oyca9mU4Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796336; c=relaxed/simple;
	bh=Vd+/OJG1k3W2zx/Ke8sEvYEtZJ9Sb1ah1U7QlBuW76M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srNEl743el97Nz/Zou/cHELJhPVJg+sA7HxtM+FIrpb1SM0rfJUWo8Ppz+TedTIp2xzDCuzPJx6TXuVtBeUl9Bly0p/8duG4iyWeBTynQy4P26PGxFKU4KIIwzHnssYP+/uRqA8he5BrEeVJqqW4OqIFZPGciSV1YbKS5SjNX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYu/lLJ7; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYu/lLJ7"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d44fb48077so650911e0c.0
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2024 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710796334; x=1711401134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jOmSWXBGJKbpv4KQjbyvpjiMj6pPHXaAxI1UbGjWR3A=;
        b=TYu/lLJ7BwcrB0vO5okNI+7RjJGl46+uIz96FQZMW3jW2zmKwDSLjMEKAGDoxffJAn
         NiXW/BFd0UUWj/Z8kOo33Fl0YdXpbYTQZ4JqHTbHy/20KrxxcX3CXCKCATS24c6d5V7d
         dMFVIIfCMZBukNfB3puKNVR/Xo+in9vSfxKLFJYPgr8NeLmbvmgWDDoPhJMdZGzEHEfP
         j84KxGgKA6wXGCtdvMXWuaEZICFehktI+ZMtua1tWXo2Q2CfzAfXoyZk9t3YDL/hCrr9
         dNQTGdVEJBmq3X5rCqu3sNp94rhBM2FcZY2aF5VLt8jtjBz3MOegj9waWWfBqs2ut11d
         CbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710796334; x=1711401134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jOmSWXBGJKbpv4KQjbyvpjiMj6pPHXaAxI1UbGjWR3A=;
        b=rTy3I/lU2BOYAK3X3LEw48mKcxGoKT6h+wywwMOzNv28T9J+VLf8fwFjWvxUl0ZBoW
         E1SVne0GQdWDJ4a8Q8WAsOc4/4jV+G+GzWVR8soybMUT+Yjww7nc6wkOU0xeZSckjJLF
         oO0GYlFhNbc3czAbXe2lWSI5wkX4oCoX8yHDGljSaiRvjnfSWcy5JBD6daYUXeriUaTA
         0X7t7chtswoQG9ZCAW90XzljwQ8VLXADYL0wITe7V3qlh1qCQ8odjeMgUUlBKZhdUxh3
         oEKj7JqG4NNkjOqGzvMQyJ19/Gn/nP0ibXWqWA3qvlBRySAKDXnkDLDWBbmcUBZSNKsA
         OS/w==
X-Forwarded-Encrypted: i=1; AJvYcCUB3W0OoZVqiNbdfVdxWDkmOIltzCHG1oYUiL2soB2pbYyEAgyC2iOfNev18KYoCbQTGGesQku7vemZ6ziXnUdGHJWLuiaj/Sw1Sps=
X-Gm-Message-State: AOJu0YxwW9WA1ksxkLnSr+Bxu56exnpLtEC/L7u/r5w+bNOHK0sB2mKB
	HKdKN7fw56ps1D+CXQT0K94CfPPcyFAMU4k6j/pE04c4uc2RlnDaYOxpOp1q+8zEQjOoAd04RSa
	FVmHhh3znXXb1PEeCW48jePzwY0E=
X-Google-Smtp-Source: AGHT+IEAhnFwrXMM6Rg9dK7wlk0KB/AmNzUGURp45Z+sDG85WK9MSZZSjGyY7ZzAgyJc2CGBxoRdPDSNyZeqvGrWC78=
X-Received: by 2002:a1f:f401:0:b0:4d3:3446:6bcb with SMTP id
 s1-20020a1ff401000000b004d334466bcbmr320068vkh.16.1710796333894; Mon, 18 Mar
 2024 14:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHj4cs-kfojYC9i0G73PRkYzcxCTex=-vugRFeP40g_URGvnfQ@mail.gmail.com>
 <esesb6dg5omj7e5sdnltnapuuzgmbdfmezcz6owsx2waqayc5q@36yhz4dmrxh6>
 <CAHj4cs874FivTdmw=VMJwTzzLFZWb4OKqvNGRN0R0O+Oiv4aYA@mail.gmail.com>
 <CAHj4cs_eOSafp0=cbwjNPR6X2342GF_cnUTcXf6RjrMnoOHSmQ@mail.gmail.com>
 <msec3wnqtvlsnfsw34uyrircyco3j3y7yb4gj75ofz5gnn57mg@qzcq5eumjwy5>
 <CAHj4cs-DC7QQH1W3KSzXS8ERMPW-6XQ9-w_Mzr1zEGF7ZZ=K3w@mail.gmail.com>
 <d6vi6aq44c4a7ekhck6zxxy4woa5q7v5bnvn5qmad7nqk7egms@ptc72tum4bks> <gngdj77k4picagsfdtiaa7gpgnup6fsgwzsltx6milmhegmjff@iax2n4wvrqye>
In-Reply-To: <gngdj77k4picagsfdtiaa7gpgnup6fsgwzsltx6milmhegmjff@iax2n4wvrqye>
From: Daeho Jeong <daeho43@gmail.com>
Date: Mon, 18 Mar 2024 14:12:02 -0700
Message-ID: <CACOAw_ydoaJTDu1eu+Lasz4AHReHqT5Pgd9a1h5Y4E8y_Hh-8A@mail.gmail.com>
Subject: Re: [f2fs-dev] [bug report]WARNING: CPU: 22 PID: 44011 at
 fs/iomap/iter.c:51 iomap_iter+0x32b observed with blktests zbd/010
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block <linux-block@vger.kernel.org>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 17, 2024 at 10:49=E2=80=AFPM Shinichiro Kawasaki via
Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net> wrote:
>
> I confirmed that the trigger commit is dbf8e63f48af as Yi reported. I too=
k a
> look in the commit, but it looks fine to me. So I thought the cause is no=
t
> in the commit diff.
>
> I found the WARN is printed when the f2fs is set up with multiple devices=
,
> and read requests are mapped to the very first block of the second device=
 in the
> direct read path. In this case, f2fs_map_blocks() and f2fs_map_blocks_cac=
hed()
> modify map->m_pblk as the physical block address from each block device. =
It
> becomes zero when it is mapped to the first block of the device. However,
> f2fs_iomap_begin() assumes that map->m_pblk is the physical block address=
 of the
> whole f2fs, across the all block devices. It compares map->m_pblk against
> NULL_ADDR =3D=3D 0, then go into the unexpected branch and sets the inval=
id
> iomap->length. The WARN catches the invalid iomap->length.
>
> This WARN is printed even for non-zoned block devices, by following steps=
.
>
>  - Create two (non-zoned) null_blk devices memory backed with 128MB size =
each:
>    nullb0 and nullb1.
>  # mkfs.f2fs /dev/nullb0 -c /dev/nullb1
>  # mount -t f2fs /dev/nullb0 "${mount_dir}"
>  # dd if=3D/dev/zero of=3D"${mount_dir}/test.dat" bs=3D1M count=3D192
>  # dd if=3D"${mount_dir}/test.dat" of=3D/dev/null bs=3D1M count=3D192 ifl=
ag=3Ddirect
>
> I created a fix candidate patch [1]. It modifies f2fs_iomap_begin() to ha=
ndle
> map->m_pblk as the physical block address from each device start, not the
> address of whole f2fs. I confirmed it avoids the WARN.
>
> But I'm not so sure if the fix is good enough. map->m_pblk has dual meani=
ngs.
> Sometimes it holds the physical block address of each device, and sometim=
es
> the address of the whole f2fs. I'm not sure what is the condition for
> map->m_pblk to have which meaning. I guess F2FS_GET_BLOCK_DIO flag is the
> condition, but f2fs_map_blocks_cached() does not ensure it.
>
> Also, I noticed that map->m_pblk is referred to in other functions below,=
 and
> not sure if they need the similar change as I did for f2fs_iomap_begin().
>
>   f2fs_fiemap()
>   f2fs_read_single_page()
>   f2fs_bmap()
>   check_swap_activate()
>
> I would like to hear advices from f2fs experts for the fix.
>
>
> [1]
>
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 26e317696b33..5232223a69e5 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1569,6 +1569,7 @@ static bool f2fs_map_blocks_cached(struct inode *in=
ode,
>                 int bidx =3D f2fs_target_device_index(sbi, map->m_pblk);
>                 struct f2fs_dev_info *dev =3D &sbi->devs[bidx];
>
> +               map->m_multidev_dio =3D true;
>                 map->m_bdev =3D dev->bdev;
>                 map->m_pblk -=3D dev->start_blk;
>                 map->m_len =3D min(map->m_len, dev->end_blk + 1 - map->m_=
pblk);
> @@ -4211,9 +4212,11 @@ static int f2fs_iomap_begin(struct inode *inode, l=
off_t offset, loff_t length,
>                             unsigned int flags, struct iomap *iomap,
>                             struct iomap *srcmap)
>  {
> +       struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
>         struct f2fs_map_blocks map =3D {};
>         pgoff_t next_pgofs =3D 0;
> -       int err;
> +       block_t pblk;
> +       int err, i;
>
>         map.m_lblk =3D bytes_to_blks(inode, offset);
>         map.m_len =3D bytes_to_blks(inode, offset + length - 1) - map.m_l=
blk + 1;
> @@ -4239,12 +4242,17 @@ static int f2fs_iomap_begin(struct inode *inode, =
loff_t offset, loff_t length,
>          * We should never see delalloc or compressed extents here based =
on
>          * prior flushing and checks.
>          */
> -       if (WARN_ON_ONCE(map.m_pblk =3D=3D NEW_ADDR))
> +       pblk =3D map.m_pblk;
> +       if (map.m_multidev_dio && map.m_flags & F2FS_MAP_MAPPED)
> +               for (i =3D 0; i < sbi->s_ndevs; i++)
> +                       if (FDEV(i).bdev =3D=3D map.m_bdev)
> +                               pblk +=3D FDEV(i).start_blk;
> +       if (WARN_ON_ONCE(pblk =3D=3D NEW_ADDR))
>                 return -EINVAL;
> -       if (WARN_ON_ONCE(map.m_pblk =3D=3D COMPRESS_ADDR))
> +       if (WARN_ON_ONCE(pblk =3D=3D COMPRESS_ADDR))
>                 return -EINVAL;
>
> -       if (map.m_pblk !=3D NULL_ADDR) {
> +       if (pblk !=3D NULL_ADDR) {

I feel like we should check only whether the block is really mapped or
not by checking F2FS_MAP_MAPPED field without changing the pblk, since
"0" pblk for the secondary device should remain 0 if it's the correct
value.

>                 iomap->length =3D blks_to_bytes(inode, map.m_len);
>                 iomap->type =3D IOMAP_MAPPED;
>                 iomap->flags |=3D IOMAP_F_MERGED;
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
