Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620926;
	b=Hx5umg4EANmefZfaxbRt1nGRWHLYUMts6vmd1GJZZjMJA3yOCUx6ZVJyGnhFqDF4oxQ5
	 0UfuX5lVcoRciYjftZTR212Tv2X344L1uyul243Ikc42Wz0o61da9tx2ddyu9GIj05j1W
	 /cUE8wOhQdfQOZZn4nliRhcBpYpUMbfhoLnzzY+YKFDsF+T4jHtkOPX3oVOS2fGv9/QVR
	 /ZlrtdanhqnsZR0cTnM/7WyClFjy0I019jrT5RoF73E0+FolDSDcU27tGsu27Bq/7au2p
	 sliShvHI1GlYvKio1VQTkXeSf6d51/2+6CrJcodXpzSZYT//o9bcQHiEd630rkLLyMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RaW8x3wy2dy9KRWxzMBJFya20NKzKWRFujyB0bIcDJk=;
	b=1gKhKFNYF80AY9j3NqatzQBSVRf6FxSkxXkXU2VaJZhmpfXmhpMlkXECoVJ+1lQ6RupV
	 NcxfbuO6fwWyG85vrhwi8vhNXWrWxJcDzcBS5PBfEoaSn1muTG6mFPfZnWeK+UgOqNecW
	 qQJAa9ZdjWWSpeySSYX+E8O2yxn1UxQLTNWLm90xrFU0Mo5GqB3tqhMOnrDXvpjz9fNG7
	 CAwAWHCe1atQDK2RPN5MPnBFJeNbIAKmEKs9VQ6PHfJrqa6PUHorQfXT3CBPMN1tbsVKG
	 k8mbuR4mwy2L7LAdjWWxiLmcvANhj23CfoYDnd6VLQks1MUHthAkX4NxRAvu0O2pvhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=rjIL0cbT;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44C7606A33A
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 15:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E44C7606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=rjIL0cbT
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so40379415e9.0
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 07:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795620923; x=1796225723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RaW8x3wy2dy9KRWxzMBJFya20NKzKWRFujyB0bIcDJk=;
        b=rjIL0cbT0oNZNA2goGo6xIOOUyHMaIJc3CCNC0cQ9u3F8Ll2tMJuAW03iB3ZwRv5eR
         pkEIwRRc9XJrttGZTRAR/aadihv8X4HXW435F4AfkAppOFQf/Z6qg1zZfSSZeiLsC5gx
         xsCeb1MVAXDrkPWqYH74GOtfIPa9DBsgGxuyn2oVIVh26jIv8Nbx/ecSKyjhSuJees+v
         gBL9I/MLVZMs30lUZfDuEKMUQc4pzhnkZsjZZQbaZ+a9aIEAiq4idPMsBQeIwCu+HL3d
         XlYiT1Qfv0Rtsx95kwkXSJ0qEYsEcFWtJAOKrHMT/uY0KPwKPWruO1wmUSektPsfEInw
         Kcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620923; x=1796225723;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RaW8x3wy2dy9KRWxzMBJFya20NKzKWRFujyB0bIcDJk=;
        b=EEuWRKfWWSdsAWly67SC956NHqjxxf3WnoXiRBAahsxzmjmHgaW+27xcO9rhEVBcRl
         wWfbXfKXdx8s3ErihXA8EAXLRQyWs+mu6rb4A0Z1w8y9DhcNkg8hp6XNP2q8WaCKHqKV
         UMrb6YfmwO7Zkl631aNtJdSkJfvwOBgNkSbEygtHoJPyK04L0OR6wGRzhfkQo0DHhuIh
         yD7JUvzPfQ+dQ2e6AV3VU2YXQMrupq6R5cdn19xGC1CwMvh/xIyL9tgXKp8GupdDs57x
         e4KuHKaRZmubIfVMc5FbLRPkd5A/Jk/OEFCEEgRBux1DSRaT4BONUoBB9OLHd+nkv5Kc
         EXcQ==
X-Forwarded-Encrypted: i=1; AL+hErFax++OyGlrzyw/uSwIDfDo1Liy721O5TM5k47Pf6+kEka89YOH1GuurOZxnm165loPEcNmrq429XIcfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8gQbJcbkPATyGRrIFZCAeTgVsuRkVJs1Yr5wj3D2Pgc+JLGHe1
	5fUpwf1+uqdryfaoU26OeZLVZohfY5vKcykouKS5ElpjmGT09ldrFMI6NaZ+p7nYVvI=
X-Gm-Gg: AZFdTZfcvPZ0ayLhMBLVHABqCdUNXrDEZJKwXpP/BuKH99YxQge2CjliVJ7qEi8Fpqf
	W+yza86xr7mO8QL3Tlh/BoxlnstgAFc0FHbMLbtPLGXA3hEC+AMXDG8TPyWHzhhQipzb347Dxg7
	0smZK9E0o+J6TxWkBE71SF6QVYnZXAQ4jsPCxJi+4PqaW2rcPbRO98s5MI7eRVey4a2iu0dLZJl
	gSeEvwvqemtYx7K6LEVCAz+CiE16fqYNBghu2j6auxuMJ+HqSTuM/8SMVfc/gs9zkOZOjJ0jxxK
	TZy6DPhS/FitMV2Bsno0AvRZ1w9Y+IV6p95kCylKqqNx8f/iG4NG/SHoHf4+00+roqk+QBcu0QS
	1AISRp1rlK7HJvQvGjRSgw52QqYfNoKTRP+6FiSjEmUqOyBk0US/Vv8xmgSV2spO22rWglgWsMg
	gLijsws9wOCuNBXrDgkZyQOOxYSyJ39mJvR9v88t3aJMRwd2t2px09ax/8KkkYDnfGxMHtfkFCM
	Wm589dni03qgK/n8RJPxeF0VQqoA7nHTXlvWrC9EUbo6EsdAu83tUjzia5PYB89j9rQuuvvvdig
	z7aEyXLv7VhKKXT6PpMn6BiTcg8cGlsQzPwTX3rZAsN0JKCf2IQMC80UdTg8KIxDSkGFmX0Fn6v
	/wRtIttba87GNkWVtx+4=
X-Received: by 2002:a05:600c:3b8c:b0:4b7:6c16:7b43 with SMTP id 5b1f17b1804b1-4bb8881d019mr364067455e9.10.1795620922993;
        Wed, 25 Nov 2026 07:35:22 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm35816275f8f.3.2026.11.25.07.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:35:22 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Chuck Lever <cel@kernel.org>,
	kernel-tls-handshake@lists.linux.dev,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 06/21] net/handshake: allow the DRBD TCP transport to enable NET_HANDSHAKE
Date: Wed, 25 Nov 2026 16:34:56 +0100
Message-ID: <20261125153511.3060599-7-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125153511.3060599-1-christoph.boehmwalder@linbit.com>
References: <20261125153511.3060599-1-christoph.boehmwalder@linbit.com>
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

NET_HANDSHAKE is available only to the subsystems it lists: the SUNRPC
client and the NVMe/TCP host and target. The DRBD TCP transport uses
the handshake API for TLS-encrypted replication in the same way as
NVMe/TCP: its BLK_DEV_DRBD_TCP_TLS option selects NET_HANDSHAKE.

Add BLK_DEV_DRBD_TCP to the list, as NVME_TCP is there for
NVME_TCP_TLS. Otherwise that select would enable NET_HANDSHAKE with
an unmet dependency.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 net/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/Kconfig b/net/Kconfig
index 76ab44aa439a..db53f7474b7f 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -92,7 +92,7 @@ source "net/xdp/Kconfig"
 
 config NET_HANDSHAKE
 	bool
-	depends on SUNRPC || NVME_TARGET_TCP || NVME_TCP
+	depends on SUNRPC || NVME_TARGET_TCP || NVME_TCP || BLK_DEV_DRBD_TCP
 	default y
 
 config NET_HANDSHAKE_KUNIT_TEST
-- 
2.56.0

