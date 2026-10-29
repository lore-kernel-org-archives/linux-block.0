Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793289266;
	b=vfkXKBEGVrJfe8ZFjG9FUeJeX1Q/gnw8TykwECJB6FcCFa/gTLlQIe+VCqpHVWDHA0PB
	 Acr16ZDaLluFPzvDow6WfHMw3PWVMeOukxS12BpbgSgKr3TbXmRMD06mutH/fMuTBDxoO
	 0o8MTA/X9FCFa64oYevwlEdwq6/Ij6l9e8DEHp1mrcsG3b2XMjpuUVCvqGr67dolHFrSD
	 84aIZ4ZGryB12+V1ejgHoLC9GcS+LomvNRvbS8Dt5HvCT3btLhyFlMq4T5A4VHYWsoUDk
	 kwjQowAocfKD5UHPUyGBGlejzMfPaQsTkPTcKFpM2bs3yJJHSDFyS5zma11WvbsERaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=J0441SvuXNyp+dPH0a7qYaBBZzYNLLrZxDgICCCbycU=;
	b=YKV2232ZTBfs+NY9Qf8+7Ln8gVjRWbZet33Qh4s7VRZCW4SinvWShlpLSlNfv0HfMp+j
	 j11RLC+SJ6K5eOVCldqqOulbfbn1Hu+VFt/kPpHRBs4KUziT/jmRezwmXf5S/imokcp5f
	 TJ5aO+6ec6msDrHMFK+tfKFpExog/9v0B3SRulC6X4beRBkWm089kF6pSLZWtcKggGKm6
	 WkDXwZywImAfsnINmtIrzhP8NbcZ/XO+USQV6mWnyXj9xGst/uu/RlW8InhoOmy1uexO3
	 foJLWP+leRBiEynvlIjUMuSb1a+YfHaFodP9MV5nlT3KqR2b2wuj9KWqZz3u1LDq45w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=fEV27xoq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.48
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1A7606A33A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 15:54:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE1A7606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=fEV27xoq
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4a7b47eb7b8so120401fac.2
        for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 08:54:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793289264; cv=none;
        d=google.com; s=arc-20260327;
        b=rPioi6eq4BeKx9+wDYlT+SsqY01+2VQ85YeeEcyiYwh3gTywV5S7tzeYCbbnOKCh2d
         /tdMjUrcOs6+YugoHTemRHj4o6qU5Dol70El0y3cIHkPpOKr4SQ5ZMOtsjgU46qFp158
         tzYFUCdUKm45NhckjxgCmzP8NUlHUsmfSAIXZH0nZ1i77Q2ec5GtE6q2GjR+Gqz3kPN9
         HnHPwgx9Q1rlQlkvBwFfKehW8hEb9bySL1mpBKxHEDT07IKQVBPcxHK+NRqhQPVLAKLT
         fPG9eXjlvE2mHoBuKQ63tBl3UDKxe1/1eaR8oG4LR3zXmLh06sO249huisrhfE7lPGH4
         ypSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J0441SvuXNyp+dPH0a7qYaBBZzYNLLrZxDgICCCbycU=;
        fh=tO9m5bxGDRKAgThROJb9BqWOjqRE4U4bitWucuv+sY0=;
        b=lCeT9FbVJhEb5XeVEKSlaMwiqVhbHf1W/awCBPPV+m2p68J3oXcJ3LgqQ67bv4mrnz
         STVMqK6H5fhyy2zoub8h+E5pd8s5YeVhy2blMZODAD59FrttVmEDMDH1dSNMm6keQ2tg
         7q4yAG2L75DO8VYrdKKo3TW3vPLz5PQoOy/yTD+gjZ7tLdD46YXq+TDw7tVcdKW78/87
         WYOmuluvAOQyc0RN7u65he+5rBu4SKwzKswpqzzn0xvufslPOkHi0cL2aJdd6ReOP9tF
         clClZfzrQJ4mELiPEJBo8vWxJn7+Z82Bfd1qoxtiYeOFIBb2r4PK5yU+j2BrSXL8vytO
         EczA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793289264; x=1793894064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J0441SvuXNyp+dPH0a7qYaBBZzYNLLrZxDgICCCbycU=;
        b=fEV27xoqw1M9SH398pbtNvixn5ZME9TnAyZczpY9fIe4qYVLaOxtCAhtfyionz6eDN
         KVJEyBCGIjGBir+FrCD6CpLzGVSIeEaSM2KWlMxS4QheoqS5x99uMRxu1Zh4LeZUU88V
         BzNSoRfZrTBji+OINyBurVKifuYV1grPWZzKhCgo8eaaPVsoY1X4Fq8tZmr/5d51Vyu0
         aIy9+p/OeJ4AJyynX1Fo3iVJzTak/APxEzrCKmO7iJygmKExihszmKnYu2p1gTMKtxsQ
         2gOSosw2XXGMJII91DR1zrjDzjaWBxsQ9lKgVUXncdTtrFbK8XJId7AltnY7AIgOTbwo
         8XCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793289264; x=1793894064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J0441SvuXNyp+dPH0a7qYaBBZzYNLLrZxDgICCCbycU=;
        b=cFSjD74qCgQ9CsDvCKGKEHdmYQMnbSXuhWrhPNQBbFhQ6d6nofnRvmX8jaRg1DHI3G
         g9rD9wzKN804f1c1RVzAbxtSMjsW08cCksQ3yHIymEDsq7tvMMkHW4bLSUKlgw5iesnF
         /8NldPlsGUpobgquY3O8yaMcnEiIj2BBAahFcaBYbsOtv0kpAmyhCPj9HDEEIpWUlv3f
         oArFXUvnUXF/dbfrx+g0GVzWMK2Ce2lw4hpJofr8WjxVtDAUnp+vA5kuypY3g6TjqX+s
         a5eQwNbMhNO5QRXijVKx1ZQiQRQl8P9rUgYhcOpie34wr/hwAmQPjRQUnd5ZyumKju7p
         ulUw==
X-Forwarded-Encrypted: i=1; AKwUvBxL+U8e/PZ3IT55YpZnrJOD+Z3M3o7H5s/sr2+6C8B8j7YyIxS7B58pjY6Mklq7RcaUBRmpeChXOEPvxg==@vger.kernel.org
X-Gm-Message-State: AFq9FYI/NXRNXxWiOpj2a9xQiW29IZDTwjRGMAdP5KWAV0ol0K3WvF/W
	ar4P7xkmyzSj3P5CRlYdgjzt7mnUKNjZbyQjGeqG1a1sWn6/Q5OSgWeGE/0IBjo2qlVTGXKYtF9
	Uyycy4+UarRZL+PpH+nU/H5vj+H1TAyBtAnwzExcpkg==
X-Gm-Gg: AYBFou2cm3Rvh1tgMUeWbOAYUjvEuz0C18l7lkfqR6915SJAGlViH8IZksFdlfVxqw1
	/gIhDiOqGS//m7egWL5HJJibBtgll/m5iMvcsnYu2CLPtjq+3DZBItnsZeuzsagXXPv1xGDgK0c
	L3S6L+HWZve+AiTznyWsVIVM0AcrFtkrzTxJAhbEpa7qUM+Jr8YuirTFgvJxT16iC0oPYvHZJRx
	23pViwDYCT0Wh1gcee7bDQ4CuP4KjMlFk6pBYz7FOdfGw92LrfFN0VVjaRMTIcvB773tjAReKej
	9Z0iisjfMvvJXdL8TZ9pNoyE15bsIKdyyB3PFtq0+Ij2ipr5YwEPJVSWTB9RNb1BFRupV6Rp2Qq
	flY37qAlrsVLkdiT2pA7Tekj1aLsBn4pMpmTncg==
X-Received: by 2002:a05:687c:646:10b0:4a7:1396:72a with SMTP id
 586e51a60fabf-4a8bb8e2349mr5536503fac.1.1793289263755; Thu, 29 Oct 2026
 08:54:23 -0700 (PDT)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <6ae2d5bd.84012103.26b497.074c.GAE@google.com> <20261029073745.324823-1-eadavis@sina.com>
In-Reply-To: <20261029073745.324823-1-eadavis@sina.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 29 Oct 2026 08:54:12 -0700
X-Gm-Features: AclHuK8LFHNXUrjGb0oo4IZd9KIl4s2UKSWkW36VswbAX2fDkzhZ5xHVAXoR1c0
Message-ID: <CADUfDZo9XZvYd0VUW8cMJZWM_BeUHCiVNSeWHegxtNnaWBcg8A@mail.gmail.com>
Subject: Re: [PATCH] block: remove inode lock for buffered write
To: Edward Adam Davis <eadavis@sina.com>
Cc: syzbot+39e465d3f7a1555b0f96@syzkaller.appspotmail.com, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sunjunchao@bytedance.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 12:39=E2=80=AFAM Edward Adam Davis <eadavis@sina.co=
m> wrote:
>
> Commit 2fec4fd97cc3 ("block: take i_rwsem for the direct I/O write fallba=
ck")
> added shared inode locking around ordinary buffered writes, but commit
> 1b1be9ea4e34 move the lock to blkdev_buffered_write() and didn't remove t=
he
> shared inode lock in blkdev_write_iter(), potentially hitting:
>
> WARNING: possible recursive locking detected
> --------------------------------------------
> syz.2.64/6167 is trying to acquire lock:
> ffff88802a5f1ee8 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: blkdev_buf=
fered_write block/fops.c:734 [inline]
> ffff88802a5f1ee8 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: blkdev_wri=
te_iter+0xd12/0x11d0 block/fops.c:812
>
> but task is already holding lock:
> ffff88802a5f1ee8 (&sb->s_type->i_mutex_key#9){++++}-{4:4}, at: blkdev_wri=
te_iter+0xc5e/0x11d0 block/fops.c:811
>
> other info that might help us debug this:
>  Possible unsafe locking scenario:
>
>        CPU0
>        ----
>   lock(&sb->s_type->i_mutex_key#9);
>   lock(&sb->s_type->i_mutex_key#9);
>
>  *** DEADLOCK ***
>
> Call Trace:
>  inode_lock_shared include/linux/fs.h:1039 [inline]
>  blkdev_buffered_write block/fops.c:734 [inline]
>  blkdev_write_iter+0xd12/0x11d0 block/fops.c:812
>
> Let's remove shared inode lock from blkdev_write_iter().
>
> Fixes: 1b1be9ea4e34 ("block: take the inode lock for buffered write fallb=
ack")
> Reported-by: syzbot+39e465d3f7a1555b0f96@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D39e465d3f7a1555b0f96
> Tested-by: syzbot+39e465d3f7a1555b0f96@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@sina.com>
> ---
>  block/fops.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/block/fops.c b/block/fops.c
> index 517b96c9d262..375ec2c15926 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -808,9 +808,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, =
struct iov_iter *from)
>                         } else {
>                                 ssize_t ret2;
>
> -                               inode_lock_shared(bd_inode);
>                                 ret2 =3D blkdev_buffered_write(iocb, from=
);
> -                               inode_unlock_shared(bd_inode);

Already fixed by
https://lore.kernel.org/linux-block/20261022062513.77372-1-mzx199711@gmail.=
com/

Best,
Caleb

>                                 ret =3D direct_write_fallback(iocb, from,=
 ret,
>                                                             ret2);
>                                 need_sync =3D true;
> --
> 2.43.0
>
>
