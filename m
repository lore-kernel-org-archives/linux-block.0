Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205965;
	b=i6SDy0nb7IXRzMSLhVEu7zW3X+ZAvAHrUVmj9dE7dE/ruM6ZwNlaqu4pzWZzBCmzybt/
	 zYlJkabz0mQHDOdlufPVT2+hCJ3pqALVzvWria3TqmLkcCv5EuJtNLic6OTqsdHcsNlb5
	 Sx8pA44P1scW/+rd5XWYQnULDLpsBohVhZ85LT3B+fuqqKN8br3MdkoVIMUqPZ1Zjj72b
	 R2MYhNsOHn54W/NNma3yMt7jhazENFPxBtQfmmTGMK8qH4E5/kATUFd1I/AISwzyoYZ5m
	 LUfjK8VRsRZPCziu1tyYUC+yn1eDRIjlWaQt81pNlQ7N8fwZVOdvoSJyY34ecqxn6Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205965;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CDESht0AN8bxmZcMh60WJz8yZHponAR0XGJGMwaFhL8=;
	b=p76chrb4gX7RjksOeCmqT9n1DsV3Ig5whRX0bNUqdKqzFTLfobIveJbix6rPStWGuLXU
	 dAFEbTaefQdc+OaSdZL2AsUyHFlDH1hgMt4S+kO55gxfIH6XdR5nZRmqqwHh0hNywnays
	 bxvusvy2EjZYWaCJGs6eWzWLdYfZ4bcZWubd4vBTM6F5sc1GVyLrW7TYkjX48Or6HKmUq
	 pK7kcQWxiKM2bUaVTjQBr94qgoWrt7w05DA0ZvYjMx/0vsGtP8nubhItS/GymWVTUZkm0
	 mFzn795d53n1u6DqxuJ/RBk6pMGKm6CH3C74k6r1vZZN8AK/czwDq4nM+DjwkM7mUXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RlJcBQie;
	arc=none smtp.remote-ip=209.85.161.51
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2D2606A31C
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:46:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F2D2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RlJcBQie
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6d68de53053so669780eaf.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205964; x=1793810764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CDESht0AN8bxmZcMh60WJz8yZHponAR0XGJGMwaFhL8=;
        b=RlJcBQieCKFVF6WIzLoz8RCK5kwG37mSODwVpLC1YyOlE8iNwaaFqbSMXavpqQssb1
         fv6Fp7XX7/jMHutEcQK4G5w12SPbdKb15g8Ad1ok7JbS80ZH7qJiIZHkX/6p0JuC3Gok
         9mpnru70NmI046Wo+WGpmeh/dQxk9q7+dq0wy+5BF/36iXm7EmiH4BFlHIyrVQtcybF8
         7sCJVmNwCn1jpwZC6JygxKxG4yxJrxm5WFt3uawaNYD/Y3dQUkFv+2vGl+IQikcPGtGq
         LCDRi0rUhBnUzT8b+tflM0D09qB7QLIurc9i/ntUPbZWxkHVr+zDLleyDzwNwPoNJs1e
         qH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205964; x=1793810764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CDESht0AN8bxmZcMh60WJz8yZHponAR0XGJGMwaFhL8=;
        b=pVGK8wQXe+1ogULTVvVilkhoeiv0SASQ/H4rF/H6Xgsi2S3GsgrgTAEozHSDh0cDDt
         aVlcWZ4z/y2xdBPoFLB+S2jBvDm3wgBZaIxZj0aJNWdE0bZs22StzngkBhz7f4w/5YoY
         CdsFSP2ShI5nI15XYjh2SWiZln5hyKMxf1r6IQP9yuqdnGTE6d3q/Oci9BfSH6lzAsMr
         iWMdqEiLiIZJE2V5CimhKL8sbo6cQFxlKIpurIa+t7ZfmWAub7jyDhNUuTBjZpvdDN14
         7CnlhRqAXNywe8pRE9XxLu1i48VJXZCsYHX4Sp6FNtSZ7JaNlVnt5LINPXJSGq1bOl0L
         iwYA==
X-Gm-Message-State: AFq9FYLlI2ZQPT+BcYbcg0x+dlB/IonTr7eBfBXV/0HXvBi6QVEaozb/
	3NNn8DQKRHlaU2dkae76nU1kGSy0WzItQKOgKmPxltg4tXuZiDWfrbmcqUflfQrXDtoobw3beEl
	FnOBYYL4=
X-Gm-Gg: AYBFou3uyJu+olL36UCH059Jdtl0gtnwxNaABzH0DeiO3VNLL0uPgPM38Bq5csX3/99
	DGbmAwFu/Uc37AxlpFZPbyEhbU6ACzWSMsz+uUcDm3s7LJ/TS5hlvJNTYArbQ6MN5oJe3kDW1zv
	VG8MkE6VvBD7sv+N3UjZujc1dses36PPxjq1M5xiN4os+fICCmSjBZ+7K1/wTnilvlYAAX592Y5
	SjmY6f37wkcvlTulNfiafCQqb9N0fHA2mm7Ewva4VbXxVDU0eydqEiiU74hfrhs2+7ffZxASVoI
	FC9NsCiAGRIaoc3+6z3GM/nzhFeZM84pbZPq08ONPvCdURA7GTkfbBbzqy3yprY00SQcc63VkOZ
	dn9gayd7JS9+mmN3Jryh2E6ALQgrDqYhVINgyBliXdmRgCd0hpBXjjVQpCb+B4j8Ni/FU23U+9k
	tF/3ImOOeafG86mrcIu5kwNh+ADOYaQW/CfRELv6viGTGHAreKcB2nqaW2Rwqd1U+pZjPWfaXFe
	MyAehu6qLbm1wOcRpS0I3zrdhgo+L9Zru3V8dX5r0fT7DKoqwaIXuKlZ2PYqlEUd/3Eb3mSLW6Y
	cqt2WAgd3VFHLXqUbYdi8Ke9l4JanqYbZK8+x+dPp4QfUU33jx3cQYjnthdXnrUOIEp10D2qaA=
	=
X-Received: by 2002:a05:6820:8597:10b0:70b:8379:c170 with SMTP id 006d021491bc7-713ee85c744mr1085204eaf.27.1793205963840;
        Wed, 28 Oct 2026 09:46:03 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:46:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 84/98] nvmet-rdma: disconnect only established queues
Date: Wed, 28 Oct 2026 10:42:27 -0600
Message-ID: <20261028164415.1262013-85-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
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

From: Chris Mason <mason@kernel.org>

Over iWARP, rdma_disconnect() sleeps in iw_cm_disconnect() until the
ESTABLISHED event of the connection has been handled, and iw_cm handles
all events of all connections one at a time on iw_cm_wq.
nvmet_rdma_destroy_port_queues(), nvmet_rdma_remove_one() and
nvmet_rdma_delete_ctrl() walk the queue list with
nvmet_rdma_queue_mutex held and call rdma_disconnect() for each, while
nvmet_rdma_cm_handler() takes the same mutex. If the walk sleeps on a
queue whose ESTABLISHED is queued behind another queue's event, both
are stuck and iWARP connection handling is dead until reboot. A peer
sets that up by connecting in a loop, or over siw by asking for MPA
peer-to-peer mode and then staying silent, which delays ESTABLISHED
indefinitely.

Only call rdma_disconnect() for a queue in NVMET_RDMA_Q_LIVE, which the
handler sets when it gets ESTABLISHED. A queue that never got there is
left to the release work: ib_drain_qp() moves the QP to the error
state, which ends the connection, and rdma_destroy_id() tells the peer.
Over IB and RoCE the skipped call did nothing more than that.

Fixes: f1d4ef7d8883 ("nvmet-rdma: register ib_client to not deadlock in device removal")
Fixes: fcf73a804c7d ("nvmet-rdma: fix use-after-free when a port is removed")
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/target/rdma.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 13243e3edca5..c5970bd2dc29 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1687,7 +1687,7 @@ static void nvmet_rdma_queue_established(struct nvmet_rdma_queue *queue)
 
 static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 {
-	bool disconnect = false;
+	bool disconnect = false, live = false;
 	unsigned long flags;
 
 	pr_debug("cm_id= %p queue->state= %d\n", queue->cm_id, queue->state);
@@ -1706,6 +1706,7 @@ static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 		}
 		fallthrough;
 	case NVMET_RDMA_Q_LIVE:
+		live = queue->state == NVMET_RDMA_Q_LIVE;
 		queue->state = NVMET_RDMA_Q_DISCONNECTING;
 		disconnect = true;
 		break;
@@ -1715,7 +1716,17 @@ static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 	spin_unlock_irqrestore(&queue->state_lock, flags);
 
 	if (disconnect) {
-		rdma_disconnect(queue->cm_id);
+		/*
+		 * Over iWARP rdma_disconnect() sleeps until the CM has handled
+		 * the ESTABLISHED event of this connection. The CM handles the
+		 * events of all connections one at a time, and our handler
+		 * takes nvmet_rdma_queue_mutex, which callers of this function
+		 * hold. So a queue that has not seen the event is left to the
+		 * release work: ib_drain_qp() moves the queue pair to the error
+		 * state, which ends the connection.
+		 */
+		if (live)
+			rdma_disconnect(queue->cm_id);
 		queue_work(nvmet_wq, &queue->release_work);
 	}
 }
-- 
2.56.0

