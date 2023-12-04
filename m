Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVz6AdDW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1D2DF
	for <linux-block@vger.kernel.org>; Mon,  4 Dec 2023 06:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701698871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cx/FH2glJNRXLr0W/z9kDPTOMXxVSYaSs/fbwHr60CU=;
	b=GVz6AdDWT8xLhIm+sP2xf3G6udN5KzR3I7WpaUFW08vveq8fo0E1a8wjR+1uMHpu4DFKpf
	b8wYmsuXz37JkKwW8tkZStZsIF3sUUcx5swlO4FlIv4k1SaDz76w3u1om8XE6fRpywYV6d
	ybVzqOsYmQ8F7BZda/LZOD/+jtOafcU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-5-9Omnj8Ommtyb9aUDUfLw-1; Mon, 04 Dec 2023 09:07:46 -0500
X-MC-Unique: 5-9Omnj8Ommtyb9aUDUfLw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D5CD862CA7;
	Mon,  4 Dec 2023 14:07:45 +0000 (UTC)
Received: from localhost (unknown [10.39.192.49])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E21311C060AE;
	Mon,  4 Dec 2023 14:07:44 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Suwan Kim <suwan.kim027@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] virtio_blk: fix snprintf truncation compiler warning
Date: Mon,  4 Dec 2023 09:07:43 -0500
Message-ID: <20231204140743.1487843-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Commit 4e0400525691 ("virtio-blk: support polling I/O") triggers the
following gcc 13 W=1 warnings:

drivers/block/virtio_blk.c: In function ‘init_vq’:
drivers/block/virtio_blk.c:1077:68: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 7 [-Wformat-truncation=]
 1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
      |                                                                    ^~
drivers/block/virtio_blk.c:1077:58: note: directive argument in the range [-2147483648, 65534]
 1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
      |                                                          ^~~~~~~~~~~~~
drivers/block/virtio_blk.c:1077:17: note: ‘snprintf’ output between 11 and 21 bytes into a destination of size 16
 1077 |                 snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This is a false positive because the lower bound -2147483648 is
incorrect. The true range of i is [0, num_vqs - 1] where 0 < num_vqs <
65536.

The code mixes int, unsigned short, and unsigned int types in addition
to using "%d" for an unsigned value. Use unsigned short and "%u"
consistently to solve the compiler warning.

Cc: Suwan Kim <suwan.kim027@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312041509.DIyvEt9h-lkp@intel.com/
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 drivers/block/virtio_blk.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index d53d6aa8ee69..47556d8ccc32 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1019,12 +1019,12 @@ static void virtblk_config_changed(struct virtio_device *vdev)
 static int init_vq(struct virtio_blk *vblk)
 {
 	int err;
-	int i;
+	unsigned short i;
 	vq_callback_t **callbacks;
 	const char **names;
 	struct virtqueue **vqs;
 	unsigned short num_vqs;
-	unsigned int num_poll_vqs;
+	unsigned short num_poll_vqs;
 	struct virtio_device *vdev = vblk->vdev;
 	struct irq_affinity desc = { 0, };
 
@@ -1068,13 +1068,13 @@ static int init_vq(struct virtio_blk *vblk)
 
 	for (i = 0; i < num_vqs - num_poll_vqs; i++) {
 		callbacks[i] = virtblk_done;
-		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
+		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%u", i);
 		names[i] = vblk->vqs[i].name;
 	}
 
 	for (; i < num_vqs; i++) {
 		callbacks[i] = NULL;
-		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
+		snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%u", i);
 		names[i] = vblk->vqs[i].name;
 	}
 
-- 
2.43.0

