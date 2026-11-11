Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367679;
	b=Qh4XicHi2SU2VQrMLQlFtsMv/dtkBkQXY2WzhK/pgFzm1hyH2yqPDPillwAEGQBlVMt/
	 4MYBoP98ymguZ6oWf1+aOhcRT+zks2D9nT3e+Sg/OOVE5B1KQFhToy7Vubk8dZjcC1phU
	 uld/n7JvEvBCQYPHW7tywZm1BRyvDV16/pRvT/7mGIwc6pHPK6pDVZC4DX1yCakcIpEhr
	 E9+d2LZNeYQdWXxUaPQ0p+8o3uWKxtNv6OeVhfAd+MMU79eLYy8hrcT43DuybtLc4AO4b
	 eoFnxdFtmwsrqLiZTDxhsSQPteRn3D4y7Xz9X3L32aeUYycAW6O0RpnK3qDJQrNVAlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NnXwX3mhbFBCtPNDjVP4JRFl+h/k9geedy1O43m05/8=;
	b=3xKecc7iU8OHf8C/XzXMWEtc66/WXwRchVQaLOrpy+Tj1dhrbZfMQQlnfdVP/D+CgsPL
	 5BMz91yD4EuGPbdNFKTCtJLn1S05Y26mQwP7ULlXZcxrzdW1wykZjhlhUhgTZg4UhD52O
	 2ELTBoii/FOtTQxxAAtlzyOypbTj7Q/kG0KTuTLzrM6LZhoSc5A3ZzKBftiHU3dGxN0CA
	 zZEaojLYffWz+YZvq0fs1MnHlj4G51Uu6QKMLAEakhZAowRnYGLd3NdNg62ZthhNBun1O
	 YMhJJ3J1mqGXrtxJ8NA78mY4MMO1r9IHNSIszwElvILpju/7QTI/LA3fFx8edsXm0qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G7Yr1kXW;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0C606A32D
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 03:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14D0C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G7Yr1kXW
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso289458eec.0
        for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 19:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794367678; x=1794972478; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NnXwX3mhbFBCtPNDjVP4JRFl+h/k9geedy1O43m05/8=;
        b=G7Yr1kXWbesBwpFdZxtyKSaOTaPcCqab4Vwc9kB5tcK7PIA0OTosLbaJRrmXvpwsvy
         hcm36lv3wOZvjpV9buuI26VHBIfDEp9vXd7DPkv12CrYECDocIWEJNp2e7QLnI64wtNj
         sDKBTkgPOwX78JeqXlftRRouzqWW/X4KaeaRnm3o42wHWPXt2cXOL8HwB5v+ykJAK6ie
         PvIudyMmSMWa3zSsHdqmI8KwSkinUGeuBkDfZtZDaZs52ZgxxXR9ow778MoMBk+vIKiy
         4T/RQeJT/Vizec+IbKM17Ly/Y4MUyqlliHkqL+lBNOJu/wuJhuaBHnarboElTtcpL+xs
         ZI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794367678; x=1794972478;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NnXwX3mhbFBCtPNDjVP4JRFl+h/k9geedy1O43m05/8=;
        b=CpHEwM2FrmHUBb/Kpx0JAFwSHHVj6DmFm76btx2KaQn6UnsxNomXnlUKtJjntqdC/f
         AfeS4rjIfxQDDTLbspt69M/8bQJE9XgVKvMl3gGEOFdRgZBJjHGtyTF0DI0lkrelvpZN
         1BjqR8kHzLpXADibXgtiLe1vX2CY6wkKc5Qj8oubiIvrdnbEqmHOKQZgBbXWCvtsjZ5x
         IcELqOSvaI/Y++iemKWAK8rSCf8zjA1dp+iQLO7ZsbidZ0UQssOONB9ahla3dFdT6KpY
         ObFul/hyngiy9+LhR53WYS4POQG3GJE7bZAoJ00t8tOivsYKIW8pYtLeYYbzU7PlKhKd
         /nJQ==
X-Forwarded-Encrypted: i=1; AL+hErF4eJHpSfGhI8srO/uiT+R0JMPwsvFqOh+soHAAfmmdkyVDt/QZ/7v7nuS8+XqeHa+RUcetyqmjda+ZOA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+nz9I6CeU3ebvwIlJ5Qy9uSfiX1u4BIqaJ1dSz2aLAkpQpA8UX
	FY6nsL7tMylI+0B0BAvM3jvaV1gmObowBUh028aa1vnxsDeIVxYnlwYMRSzASBHH
X-Gm-Gg: AYBFou1wU76eqAKfeMf7y1alYFrz9St02J4DfGXQg4FqAiEfYOgBTIiWI7/MtjzAPGs
	OgDGe1OMrn85LrBUiKg08IVxgP2a7BRNk6kEjjD+6MwJNbdnjc1VQnrDQKg1WSt605OhlZEqZLX
	Kvb/tbhWCpuaLGCedAGP07Lkdx2XbcQzxRUyIljMwZIGQ1YZLPdQZsFEXUQitLVMkn2c5c8aron
	+FZHYZJ5eJKQ2lM0YCqFr33YvmmMd6DAJ36yzIpvjtkS+CBZ9xNPaPM4SKF/Do9KavN8b0vr9RQ
	DBH7sYjQXXy9v23J46Pt6sgCqmu5K6nAccidL1vnDa+JWyUEyk+H8anRa6zImM++DZBbJgYPwnx
	L6eRUcjDIicOHUNHFZMHFEiC5fM29NAC1LVKgmIzZ3B0nNSnpEZyhAoHXV8Aao9zj8c780gVn6V
	k7ey9WR96ZO02BAZraWme6xjqCD/t50OIQLYrEgzsfMVKAH7xcRmn4ArC3fvufRf5mIFciyA87v
	t8zZ/afp1BBcaxs1AV/6r+/bJC9HLACVOZ56Z1BckVRK7sw8wy09bIifpWxIuuq7eE4VhDaXhkf
	cW9dk8F/ZwjVwwnwwJhn81tJJVVyXpZ1jWjkFfqgJQCrZ/J0owDX
X-Received: by 2002:a05:7301:c011:b0:36a:5042:85b1 with SMTP id 5a478bee46e88-37683a53694mr1662811eec.2.1794367678022;
        Tue, 10 Nov 2026 19:27:58 -0800 (PST)
Received: from localhost.localdomain ([152.136.45.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060dc0csm13113892eec.14.2026.11.10.19.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 19:27:57 -0800 (PST)
From: diasyzhangqing@gmail.com
To: Jan Kara <jack@suse.cz>
Cc: diasyzhangqing@gmail.com,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	syzbot+d4ecb9a1e5b3dcf8baec@syzkaller.appspotmail.com,
	diasyzhang@tencent.com
Subject: Re: [PATCH] ext4: make concurrent DEFAULT shutdown waits killable
Date: Wed, 11 Nov 2026 11:27:43 +0800
Message-ID: <20261111032743.549426-1-diasyzhangqing@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <glup36pqwuh2wsxjozp3x4kne2spsud65ftlw744p72hmh54mx@hi2s256gr3iy>
References: <6af1e75f.3e87765f.91969.0010.GAE@google.com> <20261110132118.11265-1-diasyzhangqing@gmail.com> <glup36pqwuh2wsxjozp3x4kne2spsud65ftlw744p72hmh54mx@hi2s256gr3iy>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue 10-11-26 21:35:56, Jan Kara wrote:
> Err, no. This is really syzkaller self-inflicted damage we aren't going to
> work around. If anything you could make the wait on bd_fsfreeze_mutex
> in bdev_freeze() killable. That will actually be a sensible change and
> should address syzbot warning as well.

Thanks, that's indeed simpler.  All current callers of bdev_freeze()
(the generic FIFREEZE ioctl, ext4, ntfs, ntfs3, xfs) already propagate
the error, so only the wait itself needs to change:

---


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
 block/bdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index f20f91b3176e..e57be2320423 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -301,7 +301,9 @@ int bdev_freeze(struct block_device *bdev)
 {
 	int error = 0;
 
-	mutex_lock(&bdev->bd_fsfreeze_mutex);
+	error = mutex_lock_killable(&bdev->bd_fsfreeze_mutex);
+	if (error)
+		return error;
 
 	/* A device being removed from its filesystem refuses freezes. */
 	if (!atomic_inc_unless_negative(&bdev->bd_fsfreeze_count)) {
-- 
2.43.7

