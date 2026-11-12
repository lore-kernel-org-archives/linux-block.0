Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481196;
	b=Tvoudy8CArbunOekwU5bP86ChDV6qujxo62dRrrowsJLSsgEW6q46bcgVqYEtG6MOgGj
	 +Y+kzdFCICuvXShg1O7gg1UqH9566kG6YEFWrSaqG4Rdl0zAif8giaosWkEVgHbqMFZV9
	 Z6mv/i+7HpadCHlX7WHmU0YNL8E1FzN6LLS1EbdVFEUc3qIWd41/hAUEZu03oNGS5QEzG
	 BnevIF6llKtlLr6U4suuPlyBPZGEHiF0k7hnHHqfsLtEYNL44C5xrUE6aI9GNax6wnJK+
	 ufi52/a2GihjixKJOS1rsZa3DRWXbAzrWt2dOZ9C6DMRROG9cORWiVlaRkvSmfCMW/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Nd4FeLTUAjKet8H5al5vx/GFjrDE46lTiaHz/821DAE=;
	b=UNLF0PD1/5If81ZNXnqvaVaxMDeoGEgWbAG9v0eTAeHxcSQsKm6eVqsxVtx72QFzAZwa
	 5BnwLXnT8EUzaC0luN1eJ2ZCBnqIf6CcGkC1f4cssvjYuSHDV40KfEYtce4Vt8E+qXWf0
	 m4WVLQGoeQhPsNVAmza8oXWJ25EV6wdS1Qhrp+xEtXgT9+xLYJEzxlIqN4SnVgWGYzTu8
	 juKSCqVdOq9azQIPDvewNRq1nvkfFhBCUhqKB353pFrwwEm7MBT2NF2p5Z1svG3ZZWBhW
	 05UI699Ab+ZlL/MdfAMZcfxgGzcxW2S/IA93kSN4Djshxq6dMUGWv0WX92Bo/o7UWRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KwI5kf1I;
	arc=none smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD3606A321
	for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 10:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65FD3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KwI5kf1I
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67c6f1019a3so1618142d50.0
        for <linux-block@vger.kernel.org>; Thu, 12 Nov 2026 02:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794481195; x=1795085995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Nd4FeLTUAjKet8H5al5vx/GFjrDE46lTiaHz/821DAE=;
        b=KwI5kf1IbQFDN1P24r69j8TL+uSJxA4MkyfRnjzWVatzqT2bntg4sxPfV67qGOciok
         WNv3Tbih8JmgRGQf3zppUNj0tljCdz+ph6fkmUt8tZVh+C349qIc3oCVoUaTIFZd0wWw
         sjaDF5Sy7JrGMA6X5cnCMH1qEeA38ETg5PzJPXyQbRLp/amsHfHu443HZSo7KqJV2493
         09WHmWDzbEqMAIL+2xN7a9z5qT/EWH7znT8icv+v+0yCDzkiMU5JGV3/HTPvgpSZ9GGL
         n84jYsX/Hgtkrp6BlCnkzC+VWQfltGTOBJnq0Bg6j/D6V50/2m6DH4URavWu33NSTvef
         pp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794481195; x=1795085995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nd4FeLTUAjKet8H5al5vx/GFjrDE46lTiaHz/821DAE=;
        b=lsxNVL24TFs2sU0+hwB8ceMu8DTatdi2itrm0bRObIvbRq8oion+ohcbc1Sod9+QMf
         yIQNDc8WPmXKYgQgtE3YNGOiW67daWN2Kd/ulzXEujIjBW7SbE879MKZutXhmu3q3HOO
         pX31FZ5wMFNJV+fg6Ofd1qG/+1cOYUoXTCq0wHzzb/JXOjMjtfm3sI4BB7W2hXNeMsVP
         htc6B0pKBmrM8nek/lmZZhcUsYegttCCI7oRMgj4qfeZEFP5J84XdvoSy/Sj159IKBYW
         gtE8/qD7+HBXfqHo5eae3wNC7/pQ8SUEzJHBWbsQrZvuF7PA15IWnhyluz5e6G6jsFtN
         RX8w==
X-Gm-Message-State: APuU4Z+Cp7biXfcoTdetOJ+wG+7PmNC1vZ+a3FlISVrvxr6VRM9foFME
	qL/cmOE2q7/XCftnzOeVL+AcjlscSkmEfrNKd0O1Dsx9E43jn9MYX4Q3SZQnJxUr
X-Gm-Gg: AYBFou2tr6UsoaOo+ZnR8KHH5ukNzlUeJYPd2TZZIQ7oeFqCRo1ZSzm/NimvUIb0Yim
	npWgRnQ0E8t3ha32Zc+TIsySBH4P4wdyYqqgpDt1DrmqPJNKdZuvQIZJr2bBVZOgV2F6/m+njsl
	CuMrjnuJ+T3WrOHvdENMJOwdFvT4OT5z+YhAsP6tLwy7q9CRt0IlqTbSFvz69fH4uzUdtZGplr7
	wzhM4euQPEE1n5UJv+8/Fc9BckRUSODfcRhkFj47eP4ucm8v9xxMKkPJ6gi+j6CIXHMHwhQ6KEZ
	xphBiI+/nR95RJA1jRcU1CGg01w73ojAK7/yEH0MRDOXwTBPydal0oHaUFpA1/PUodIDvutUyOf
	O3+uw+m9+aXuYzIZCsJK87YOhdwbf6yXcJF/3T3Rfyca30DnN+djTNBE+AflnyA0MNdNEjhjyxj
	omcYRqT97KB8aLJgqXZtquCj4S3ZrkEKiyJ8yzD7DCy2R2c1acCgIb9yZtGI1jUk0Nu13s/+iME
	mNJ2XWiDZNSrJdEs8SN1LItvWXdjR+HRgVC0kMvbLA2L3eoSvhHh9Jqc4OKjwzyTROIjeukIUHq
	ieNBfgpkvfA23XaIFsIEIUHZ5pdgun3fjoE8NWzdNwC4yBY3pmes5TPwMQkFn3/FPEt9Sc6+drQ
	LFQXLIMUC
X-Received: by 2002:a05:690e:47c9:10b0:679:8c5f:3fd0 with SMTP id 956f58d0204a3-67c67cb88b6mr2073402d50.19.1794481195328;
        Thu, 12 Nov 2026 02:59:55 -0800 (PST)
Received: from fedora ([187.120.157.132])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589a266dsm6964218d50.7.2026.11.12.02.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 02:59:54 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: josef@toxicpanda.com,
	axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-kernel@vger.kernel.org,
	Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
	syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
Subject: [PATCH V2] nbd: Reclassify sockets in the reconnect path
Date: Thu, 12 Nov 2026 07:59:39 -0300
Message-ID: <20261112105939.260856-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular
dependency") introduced nbd_reclassify_socket() to prevent lockdep false
positives when NBD sockets are used in memory reclaim paths. While
nbd_add_socket() reclassifies newly added sockets,
nbd_genl_reconnect_sock_cb() omitted this call when replacing dead
sockets during reconnection. Consequently, reconnected sockets retain
the generic socket lockdep class and trigger false-positive lockdep
reports.

Fix this by reclassifying the replacement socket in
nbd_genl_reconnect_sock_cb().

Fixes: d532cddb6c60 ("nbd: Reclassify sockets to avoid lockdep circular dependency")
Reported-by: syzbot+d7d72f3d467710442af0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d7d72f3d467710442af0
Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
v2:
- change previous patch to a single line addition of
  nbd_reclassify_socket()
- improve commit message

v1: 
https://lore.kernel.org/all/20261110215723.199948-1-trintaeoitogc@gmail.com/
---
 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ffce519bf008..b2b27f90a7ed 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1356,6 +1356,7 @@ static int nbd_genl_reconnect_sock_cb(struct nbd_device *nbd, unsigned long arg)
 	sock = nbd_get_socket(nbd, arg, &err);
 	if (!sock)
 		return err;
+	nbd_reclassify_socket(sock);
 
 	args = kzalloc_obj(*args);
 	if (!args) {
-- 
2.52.0

