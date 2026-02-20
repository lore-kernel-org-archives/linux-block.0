Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C6E331202
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 11:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771587587; cv=none; b=Zal1oMBZd2TwE7V+yq4OBz+ATUZ8VsdwJ096+4tHS/hO9aCFJZQ4bGHQ2bdrAbRXRZAAwjyZ/0SZHaPdgxD65ApbivyMzDAr/sySF+CpJys++FPVXHKBXT94Vhxf1Rs7+p1FdUsWW/E8k3ZjuQcxJ1C7nafFuO+WRQTaBW+JSoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771587587; c=relaxed/simple;
	bh=09UEbk9dCc1/v7GTUjrY4SUM9KDAOWfH15C+AzLS2AM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h2MdTBC5sbg75CCPb2+5kqMo1NTWx+uqFmsYFj3+LRyt6YehuHAO+fYnCFJFR9PO2xpQk0jIKTLjLmOLOhzma05sHo+6LjDZYL/kudEi3og7pUcke8om+x1tA3ql1RlEJk7CrEt54by1btA/DqDTph3QSGclhoFF8S40kcDKSiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=Mh8hHb79; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="Mh8hHb79"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483703e4b08so15514235e9.1
        for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 03:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1771587584; x=1772192384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NAZvmYa4+oLnoaGzT3J4OlkyuUdxp/o/vWFvPoP3fG0=;
        b=Mh8hHb794dTdhWTQo28a964za56bBpuZ9D4oliBPpVgnd1Yrs2rgIgfwZHn/yNRvQg
         EF7iJyFR3nf0tOVrBT7Gy89mRTAfnZgwUIxjWn1CXc6tVjwMzrU4hQ9W7JpZXZTRAOY4
         gu+nivpZ87n3oKx/u8rhnpLqXjOfUBgD25tMcp0FrnmYosm+N4rhzLDdrk6d3mzOFkfz
         UBbUWfb7Grs+oHCZuQy43E8JtOizYc3030pIbWR0dw2TyoTq+Om3XALDBTZW9zQBEZM7
         YlsheWQLhIdJZKU7Eq22Wb/2XJvXPTf9TNq5TPgWQxLSvNnEQus7YE9ByolRRLZt0ViU
         c5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771587584; x=1772192384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAZvmYa4+oLnoaGzT3J4OlkyuUdxp/o/vWFvPoP3fG0=;
        b=EQykX9rbb5vMff4WnCQzZuO9y8ginnGa0q6VvAd6Lxj7yO0x2HAtvnR84vzis08tWv
         AOkqr98A5DX9/9IWTNpeJPoVNEOHQwqPssV7f6k+XcIDiYhD5lUw6biT9p424c6KBdm2
         PySy54sYNvB+/m8OMGUHS1H8mS/7zF1zNtuIs5qmXQ9TbSZ1+N/6bP85QYswKM9+5nnE
         sQbVkWsLJiJRIPPAutbDf+oWM3sdhMQo1cA9Y1X9Br0srOrrqS54b2zmcQS3OPec12CO
         GiNMFjpO7WHvl6/ro1fWnnjkKcJ7g224HG97c9pmeCTdFCNHjjeyZbkoo9YemwxQIJ+7
         vx0g==
X-Forwarded-Encrypted: i=1; AJvYcCW5EnHW8PE7MWSa0AndBD3FFXSt9XpkXt3yIHbPJ30Qt9MBs7WHuHDNG0Xy56Fgypm/k3g+wJEgVnrwMg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7Da720/PbktkMZL8r3x4EjUoZ3kbG3r0m2GmOTRSkP6qWccIa
	GViwc2DXIpD+8RX0VdG+aYqHuSUgL3iqDxIJMkNX8xitfPlA46CKXcMOa950tIgWxpg=
X-Gm-Gg: AZuq6aKo9xRI0ivao/TN3TAwT64IpPRjsoiy7efhyGnaGMIZB4ekm7WrKy8jiYmB+GS
	LTesdgIZ4g2U+1gr5z06QPnPuNKGo4KgHUvJ+5i+FHgGemi/SKefbGAvBPlfvosv/dXvmUohVKX
	v5YfJTvMdE9a2XZyiQtDvxX61iUTjQWA2UDWcgWmXrW6/IaPxLfhM+48UW8NFv+hIsMcmHVL4aT
	nfcsSr2SZc9s63NzhBkIUiqBr1wplCJahUXEJwfIbl4WMqC1x2HH544e859f9V7iMYVogdhDrv8
	yPm971pt4KiOc/P7xS73xubezgpvikkq67BDoGmgxNYxPaUSSUasaBcC/pi8FgeRWlMMKvf0FT0
	Lw/jGvv1MOxPHyjTJttZzhRppk2XfKBsqsQmG517iYud9+4B8ERoRI4p/+Nxky4sKoPF9aZvJ1m
	lvgzYyECIf0xsUpiBPc3fi7Cc38y882sY+MVRKl379KxugPkXnuNqAdDE3M0jZvqRF4PJyKHL/2
	VRGw9f0KNwiWWlIx9wuEw==
X-Received: by 2002:a05:600c:c114:b0:47e:e97e:11aa with SMTP id 5b1f17b1804b1-4839fe8e843mr76621565e9.4.1771587583811;
        Fri, 20 Feb 2026 03:39:43 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a316eb08sm75529045e9.0.2026.02.20.03.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 03:39:43 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	stable@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] drbd: fix null-pointer dereference on local read error
Date: Fri, 20 Feb 2026 12:39:37 +0100
Message-ID: <20260220113937.2691322-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In drbd_request_endio(), READ_COMPLETED_WITH_ERROR is passed to
__req_mod() with a NULL peer_device:

  __req_mod(req, what, NULL, &m);

The READ_COMPLETED_WITH_ERROR handler then unconditionally passes this
NULL peer_device to drbd_set_out_of_sync(), which dereferences it,
causing a null-pointer dereference.

Fix this by obtaining the peer_device via first_peer_device(device),
matching how drbd_req_destroy() handles the same situation.

Cc: stable@vger.kernel.org
Reported-by: Tuo Li <islituo@gmail.com>
Link: https://lore.kernel.org/linux-block/20260104165355.151864-1-islituo@gmail.com
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_req.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index d15826f6ee81..70f75ef07945 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -621,7 +621,8 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
 		break;
 
 	case READ_COMPLETED_WITH_ERROR:
-		drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);
+		drbd_set_out_of_sync(first_peer_device(device),
+				req->i.sector, req->i.size);
 		drbd_report_io_error(device, req);
 		__drbd_chk_io_error(device, DRBD_READ_ERROR);
 		fallthrough;

base-commit: 72f4d6fca699a1e35b39c5e5dacac2926d254135
-- 
2.53.0

