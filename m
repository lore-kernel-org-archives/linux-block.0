Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C31ADFE4
	for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309420; cv=none; b=ofrmI7NRJanE18LDUXwG9a4gAcSJJH7mXImTCtwd5BND7zzIbgwoouUtSs5+zGoc9F+SIkGOsoZo8PMMXvnj+sR69itwTaLfTkwLbLcB0OHB+B2aEzeXLkLfFVVDFG5A8rPgZl7oB4o77P/Ue5j3rfA58opcVWUg7ntP2pGEQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309420; c=relaxed/simple;
	bh=AF1IlyJR/U93o1LG6v6CBa5cEBHrm4/rODsO1tN/V3o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mWDnsCH6nYHHA2sZPVZB8vjLEdAB0Qh+t0KNVOdExpmntFvgf0grv8eiV8WtNhOWL9wlb7lyovg+sj92apfmu+Tl/afC0aYBIsFP4Ft36zJrD6W9tirY4YtPW88gVqhuQFFAoJ3bmYevEAQObq4kYqDPOVKixDj7diVa0ezVCRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SBlqT/eq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBlqT/eq"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8421ffff8a3so1903585b3a.2
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 17:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309418; x=1781914218; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfSZlFh04a3h2HSeDtAPuy7d2efg+siOhibP1darPB8=;
        b=SBlqT/eqY7qi1cC1BvIeH1130U+QPQqUT/VYwtbMCBRM/UUyNUV3Fg7H1GiOEKiURL
         nN16+XhQzBvJXbuDjWEshEa94SXT03OUxlkUmchax/65AJfeh1pHBl8iO+JsMSa+rtym
         IMVUOTHUKYFFtB7tT1uRRtp3/ebhmsA6nrQiHh6kiywsbY8us+OepRgXGnDgCIzaNT3A
         tikn8RScFg/Icf15/NJE9P66fWfZj5FOClLwD2uhi1W4P3w1SqNjW0aH2IxoCWvL55Jj
         9dV6wTTBRrFxiAuyrQ05+OkOi23UK+SKsa1Q/SuPUf0rJnW2DBxUBR/zTkFZkHhVFu+0
         CeqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309418; x=1781914218;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfSZlFh04a3h2HSeDtAPuy7d2efg+siOhibP1darPB8=;
        b=sFBkcG76ZYIIu6ZbQIRclIWMXMqsizUqDzpYquJkkIYScQKHqcXbFepTDT9zG0ofTn
         JJylsf7qPX5gMY6+eA4+Y2onSOxKxH/jEB3rTYNISV5bdffeegt/rpJYhC3QXUK98MKW
         kupElt4Qpy1p+toxsIYwQfuatPbxzINjKUzmtXhKfiKVtuRBR1EdAGSJs1pkA96VZh1H
         MpQlh+l7LzpJcRx4E3SW+cdvlk9IiqXM1NZFFLNr1fem2vpGi/TxfE0CGd88FCjxHcRL
         KsvPWaNFsicCsWOvdSbhbu2LpWvrUuWpRqI7FH2Q1HMKooTNUFtaGTewVaXUo+Cdv+up
         RRJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8OlxSmGenBSTfUO5spiT2OI1rFsPwhKRZd5ukKPJLfsgXfNcDRVxEDXz0FftEbdfh6V1wCAwlbt3Waww==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZCdFQ43pjmLHPlBHOeIK1A0tSMyNUdJJ7/yAk9J1kBbfiGK3Z
	PDVvK4yh6DXTnlttJVP8J8gHNqEAInK2mZfuH456dlD7hyhh75jVqEYyDuEO51x5zppL6QYEQPv
	Vkw==
X-Received: from pfff14.prod.google.com ([2002:a05:6a00:bd0e:b0:842:3b07:6355])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d48:b0:842:5c60:513
 with SMTP id d2e1a72fcca58-8434ce84647mr5472887b3a.30.1781309417753; Fri, 12
 Jun 2026 17:10:17 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:09:53 +0000
In-Reply-To: <20260613000953.467473-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000953.467473-1-tavip@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000953.467473-3-tavip@google.com>
Subject: [PATCH net v2 2/2] vsock/virtio: restore msg_iter on transmission failure
From: Octavian Purdila <tavip@google.com>
To: netdev@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowang@redhat.com>, 
	kvm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	virtualization@lists.linux.dev, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Octavian Purdila <tavip@google.com>, syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

When transmission fails in virtio_transport_send_pkt_info, the msg_iter
might have been partially advanced. If we don't restore it, the next
attempt to send data will use an incorrect iterator state, leading to
desync and warnings like "send_pkt() returns 0, but X expected".

Specifically, this can happen in the following scenario, triggered by
the syzkaller repro:

1. A write-only VMA (PROT_WRITE only) is partially populated by a
   prior TUN write that failed with -EIO but still faulted in some
   pages).
2. A vsock sendmmsg call with MSG_ZEROCOPY requests transmission of a
   buffer from this VMA.
3. The first packet (64KB) is sent successfully because the pages are
   populated.
4. The second packet allocation fails because GUP fast pins the first page
   but GUP slow fails on the next unpopulated page due to PROT_WRITE-only
   permissions.
5. The iterator is advanced by the partially successful GUP (68KB total
   advanced: 64KB from first packet + 4KB from second), but the send loop
   breaks and only reports 64KB sent. This creates a 4KB desync.
6. The next retry starts with a non-zero iov_offset, disabling zerocopy
   and falling back to copy mode.
7. In copy mode, the transmission succeeds for the next packets but
   exhausts the iterator early because of the desync.
8. The final retry sees an empty iterator but zerocopy is re-enabled
   (offset resets). It attempts to send the remaining bytes with zerocopy
   but pins 0 pages, creating an empty packet.
9. The transport sends the empty packet, triggering the warning because
   the returned bytes (header only) do not match the expected payload size.
10. The loop continues to spin, allocating ubuf_info each time, eventually
    exhausting sysctl_optmem_max and returning -ENOMEM to userspace.

Restore msg_iter to its original state before the packet allocation
and transmission attempt if they fail.

Fixes: e0718bd82e27 ("vsock: enable setting SO_ZEROCOPY")
Reported-by: syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=28e5f3d207b14bae122a
Assisted-by: gemini:gemini-3.1-pro
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index b10666937c490..2baa5a6ebd750 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -295,6 +295,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	u32 max_skb_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
 	u32 src_cid, src_port, dst_cid, dst_port;
 	const struct virtio_transport *t_ops;
+	struct iov_iter_state msg_iter_state;
 	struct virtio_vsock_sock *vvs;
 	struct ubuf_info *uarg = NULL;
 	u32 pkt_len = info->pkt_len;
@@ -368,8 +369,17 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		struct sk_buff *skb;
 		size_t skb_len;
 
+		/* Save iterator state in case allocation or transmission fails
+		 * so we can restore it and retry.
+		 */
+		if (info->msg)
+			iov_iter_save_state(&info->msg->msg_iter, &msg_iter_state);
+
 		skb_len = min(max_skb_len, rest_len);
 
+		/* Note: virtio_transport_alloc_skb() can advance info->msg->msg_iter
+		 * even if it fails (e.g. partial GUP success).
+		 */
 		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
 						 uarg,
 						 src_cid, src_port,
@@ -399,6 +409,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			break;
 	} while (rest_len);
 
+	if (info->msg && ret < 0)
+		iov_iter_restore(&info->msg->msg_iter, &msg_iter_state);
+
 	virtio_transport_put_credit(vvs, rest_len);
 
 	/* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.
-- 
2.54.0.1136.gdb2ca164c4-goog

