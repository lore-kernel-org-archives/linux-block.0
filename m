Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463AD5505D0
	for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111554; cv=none; b=iZfBCp1BqYQ3gkvsu0T6q2kg1MlrbFuhCikUyGDbppK1A5P15A9axU1iiZArbts27bHxz0coEnWnwm1x8WzNM7sJYfZNUkVwHMdF57YXnSxvsTFnxmkwQtFDzOPKMV6oCREjjP4Mm1XDyvv+DRO9v27F2JXRoOJVe73uiYKE1A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111554; c=relaxed/simple;
	bh=2+E9WLAhddquoAhrHExJTH/ipVluXO40UC60vRyiwHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K/bjt1ZuVJgkV2IhuGFl5WCLCoKvHTfuhAAuMVAQudKzYLhFyNZtt8rpskOUMYvYKIa5QBlNJGNxakHKzAlIa8m3dY3frkYxoaH+tAhV1VKKVHKKyltiknkulIpn++zqqy7TWCCYFSyOOnvde1hufkkGC2s8dQ7EmsswsxTsgqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+ObHwaF; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+ObHwaF"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfbd148aso2416296d6.2
        for <linux-block@vger.kernel.org>; Tue, 22 Sep 2026 14:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790111534; x=1790716334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NCOJ4IYbfFaRdEJKYXl8sjbEptgWjDvoJQmY8J0q84k=;
        b=e+ObHwaF5irV8lCqiCCfQD+0jvXngq0cWnSJ7DRgHKo8UjBNIm6eXvW2tPIXT6xwtM
         ZbRx/c3Z382fZ37xfKtJCdtx4RP/x5qWVB6SzitNr2swgL1QnILKeKZrR1D6OqQM/JY/
         nSul8fAW2D91nnhcX08DeltgmFw0jh7yboE5LUcAU0rTC/WHH7QCnjZ0Phc+IvO78tDa
         5LxIc8KqPP3gCxmQCBAgtrmbIGixMyyP34jSlwKClHElfzMJVYQhpOOW0vipZM3MuDk4
         cg1hDTsH7gYlLYOk5DE2UEJRV37eh2BLnJkoX4nR1jBVB1LLMguUn4EeCQ6MdVTCCzUv
         gVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111534; x=1790716334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NCOJ4IYbfFaRdEJKYXl8sjbEptgWjDvoJQmY8J0q84k=;
        b=KSZLBXKLMfmsmKslYUZFYdVjrEBf5k7a283N9v8xBsJE34imdCKc7SYNtRQatkXmxa
         UaLHMaH/3Ev5pLZBMV/7KyqFeST+6haAe+o/NyfxEqj8hTJG9ivzyfkgF1H4g0JY9Upt
         +P8CgyArwTO/ZrSBm3ExAAhoKbTGpb8JAjOHdyvVZF40zFnWIaVnZf/UubE0v64gSuN6
         7dHwQU2RJqmDbrxpNM7HZn/f2iGzmhcYNF6L6yzxHsa5vwTX5D2bG3f7cdb/ryl1KmGO
         9+MRh9l6bCqsc7inXunFKobzr8A7VqxkZ9ip/jQMAIqHDuURZwHk/ePO2tdBw02nAO8l
         6rmg==
X-Forwarded-Encrypted: i=1; AKwUvBw8sVKuJ6TK0dcQ68K/jSoWuDMeSXMFrvlN9UaU5Z1dVk53+s+3k0Y12chj5Wu3mg9hHdmDPHztOY0lpQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k1uSqxiFZCV33q6v2KsFwZKiSgbOlaMyWtEhLBf07ZAlZLK20E
	RV+OlTFhJRk4N0c0fux2Hw5SRpQD6OmuHqmWF4QTzUeuG6Oj8vi1X0cmH0ha5ruA
X-Gm-Gg: AYBFou2yp1tE2W4i8hzbShmqwAue5l7MMX+Z32cSoA5dK7vS47EJw1HdC8yNnOTLBGW
	mHSDTxkep0GViT7caaqCyVLryr2BUEJaKuBKgog3J9c1g2aOJlQOSacNlNo7nb7c/1XhFDNoowb
	/G9RCfQ5E5jrFePtSqNTNCXClNLU2uh41Mou0h6xN+VBN7a3LmvacaLUi3qz4Kh3YXDr+Nft14l
	GRyYVjXmkXzOip67RAAZbXb+75K4SDIsTwa3XHCjXlvIzBFnKNNCdEQ0wBmXIPZjb6rOQ3lyKyN
	5bmlAObajmllAxe77o3P8QrHUDolylUY4OO3QGYicd5q3krcHjRKHZEH69kPYoPK8f2Ou5Jp7/1
	N8mwmQsZKdvoFw73d5wUSL+FBZKHEwgN5Zh6xpkwOjfXlTAoX+oEPFZt9Epi/nfZD32lOb7edHm
	3lSE1ofODetVd7FeI83+GhiGojAehGvMvYuNYda828JHQBbRQ+1zyQYUPamUfV87r7ZXnyGmc9y
	5AFVpWLARI0ksr/sMGShg==
X-Received: by 2002:a05:6214:4a88:b0:912:533a:4a43 with SMTP id 6a1803df08f44-9140c3f990dmr12597706d6.32.1790111533845;
        Tue, 22 Sep 2026 14:12:13 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9140c4640c9sm6319316d6.40.2026.09.22.14.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:12:13 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v1] virtio_blk: Reset device on probe error paths after DRIVER_OK
Date: Tue, 22 Sep 2026 17:11:41 -0400
Message-ID: <20260922211207.523999-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtblk_probe() marks the device ready before revalidating zones and
adding the disk, and either of those can fail.  The out_cleanup_disk path
they take goes on to delete the virtqueues, but nothing tells the device
to stop first, so it is still live when the rings are freed.

Reset the device at out_cleanup_disk, which is only reachable after
virtio_device_ready().  virtblk_remove() and virtblk_freeze_priv() both
reset before deleting the virtqueues for the same reason.

Fixes: dbb301f91fc8 ("virtio_blk: add error handling support for add_disk()")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/block/virtio_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 32bf3ba07a9dc..ed97dafebe164 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1547,6 +1547,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	return 0;
 
 out_cleanup_disk:
+	virtio_reset_device(vdev);
 	put_disk(vblk->disk);
 out_free_tags:
 	blk_mq_free_tag_set(&vblk->tag_set);
-- 
2.43.0

