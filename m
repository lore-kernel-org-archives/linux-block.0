Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793751561;
	b=jUWkyWwQ8VoW3rFyknKR9EGaUfDQPXgnzxNOkl30qUJB8odFY4h/Trz5QIh7O0ZMjDTm
	 icfJuRppKMzHwyw5zGTJ6HIM1JjmOhvdTk3+wDdE5ZAiI1z+F0sAR7DmnB5UzEbOijnBC
	 9q2VOlVgLZSHA1IfGtwBvFhte5WhrVkJxy8d2r77h9CrZHLaKhO4UY5M4vvgz4LP9hivZ
	 XUSJvCS64JHF/14QhBqjKRWwZaO7Up9agjNopmTEIKTyjTonRiJviQTItsMw/xT7HzSww
	 1U5aXzBj84U3AxJYO2iyugjhUMxv8py7rmlslxb8eactxwKEdp9hgbDOQAGTY3Luxfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793751561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q9rahWNqn5TrjQs9MBNRTiFNXPe8F3h3uvk3o1ZjbFE=;
	b=H78jZO8tbLstwJJF+3HYW6geoW9DwoPRUMVALRbB29+zZ2/vEWbWDjSQ9bgWosYZ0Yne
	 2hh6EFxWs6MN+E79ixpOB8lxTbwLV5zKfyjfpSBjf669U+Pj+Cbq2XOZQUm1bCPZIw3Bp
	 hSQhSSWWu0R+HMfz983ymNHst/DKvhYHb/YUjkzMrxzF73M1Ug/eQqkb4Uyd+NDX32l5k
	 yBDK68XVQ61msc/nObvuAgO8BHHD0Rm8Sj1glpRsiLPhNNUd2egZW6tkYhMPobLhluRwc
	 BpTqSH9J7+JM0qKAYfmpMmU7cgMwQN/1Iq6sJnfL6hoo23dg5GuNYHpXC3dfyuMOREQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4bw5pwH;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5A606A31B
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 00:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CF5A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C4bw5pwH
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so103006f8f.1
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 16:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793751559; x=1794356359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q9rahWNqn5TrjQs9MBNRTiFNXPe8F3h3uvk3o1ZjbFE=;
        b=C4bw5pwHYHKdBx7XMHDV2xpsCjhmtYFZlM0xZCGGFxbTeRU/HKmGYdlrUC0OpsaE76
         sxmnko+3wk5uDyFU/+r1JLpCP/eP9ukWXMWBNJMCD40nKwguWgcqYGGYt+IE7ll7C2pf
         o7W0xco1UcZ+wNXkxSW7dwlVniMCkCs5ZEsbiySzJNn0p//HrTw9Z7VwZ18jlUf8rH/i
         FmaFm9kX1Qp6PWhIQCdFZ15FF9zROPyZ71eO7A568PBC1uAFunqbyVVs6evwu0/IB0ns
         GY+oEPG4GDDP77pRv2pubjSoD/BxAS9jl91VHj8CzE8x35vhARJmsUOExuPjse5frMXu
         2HcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793751559; x=1794356359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=q9rahWNqn5TrjQs9MBNRTiFNXPe8F3h3uvk3o1ZjbFE=;
        b=nTczJasnfiLkR/uGBS8JC3O9ebmfrpbzrY7x6ureXaBzNBzIe0zwpCNwjqfTYlnYg2
         lJDYOVl/Yr8AVGIX9ewpMWB8MPa9y/x/k4dVJr0rzoUlXzl1S8/iQk57gStX5TCdd8Gn
         FmNiqa8ZL1A42cRyxSLkwFvhD7Wit/3RwXwk2ydnAeO98YcrtPbJIS2mP7lfgrHGx71P
         8Ombtw6g+W1nKh8RfWcseRoTaayefm8yaQA/ugIIl+QKSq0sEX2ekaWsrnIoSHZdQCZp
         zkLW76Cr+is8UmuF+PJ/+MU6RQ81uhPITebWNS+hVW6clx9KvB3pH2ueJiepzCUtup6Q
         KgRg==
X-Gm-Message-State: APuU4Z/mu3DoYsq6FdxEens/HrG7pxEe0FX/lWBC95b3gKQWAFnvShv/
	PM4lUkw8R9YkDv4hsL+psZvxN7ecg9SCJcGtBsM3G+Yzn2VLhVvqpMIMVWNEkA==
X-Gm-Gg: AYBFou2+ao8+OpAi/qkv35Ge1Z7GmLnVOEnN4jcVSxTTIQT0lTxDA1Q62k16w1J8O+s
	QD8dKXfJb+du2nZlv4/iEYq5ifHiv7qaJe5j1heZzBvA2hqYjgx4nBuCeqEyk9y2HamujAUyM0M
	+tS5fIA8oybjBEknebYuwo7Q0CqZQ1GPK17/IbKU65A2MWc5yISEZrua8DClkAXmN6KcBu0HTqK
	QUrwtbWP/U1T4xfeE/ckvTQvbORIVVdmYXBurfwYWzkQVSTsktP6ywhme0lDfxKfFESbH1AWTIv
	ALKLLbkAk3Kau7BRBkNczyMNj1CUEZyx/RmOOceeSTISMCV6perb7il7dDr0gw8p+SNIesmYr6s
	i9cOV9iphQuAeT3OCbkw4Bem8Cq4HipAvOneznl6rQRB1Trz1ijJ1lX2fkh0lD6Yb+S6/UXD028
	MZ9i1P/k5TJphceNvtFgDs6ZomRxnNNEghgLsqlamsS8u3Aepn6QJHT+cQnZhYrVmCMxEh/y39S
	miF74S4vK/ngHpmDP7O7XnwxVl44QvbTUi/tcetN1zMBodShuLqfn2eRE6w8NIwVFoIs+rgETmL
	Nu1uHJweKlaErbGqevUT8h6cYJ6aUV85Sw8s8XCt74+GyaxQjlyM5uESp4qY2j0GaQwt0IOSelk
	G0mY/sDfQtVxL91EiJl2yFi+CvkKKCTc=
X-Received: by 2002:a05:6000:2dc4:b0:48e:3b53:e100 with SMTP id ffacd0b85a97d-48e6e535ca9mr33172348f8f.56.1793751558968;
        Tue, 03 Nov 2026 16:19:18 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda1fb0esm676676f8f.49.2026.11.03.16.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 16:19:17 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH 2/5] block: set dma-buf-io tag to block files
Date: Wed,  4 Nov 2026 00:18:58 +0000
Message-ID: <91697f770aa09d1be8f358378f1e11e0143ebe5d.1793751001.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1793751001.git.asml.silence@gmail.com>
References: <cover.1793751001.git.asml.silence@gmail.com>
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

We need to set dma-buf-io tag to be able to share contexts between
multiple files. Use gendisk pointer as a tag, this allows sharing
b/w different partitions of the same block device.

Fixes: 839231d19393 ("block: add dma-buf support for raw bdev")
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/fops.c b/block/fops.c
index 60b9c9b1cefe..6f013780b76b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -687,6 +687,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	ret = bdev_open(bdev, mode, filp->private_data, NULL, filp);
 	if (ret)
 		blkdev_put_no_open(bdev);
+	filp->f_dma_io_tag = (unsigned long)bdev->bd_disk;
 	return ret;
 }
 
-- 
2.54.0

