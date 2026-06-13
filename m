Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E3F171AF
	for <linux-block@vger.kernel.org>; Sat, 13 Jun 2026 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309418; cv=none; b=ndjUe+gg+JUcDs1j4FILOePgCJcvg71P/qwqj5X0Q8HYPkACAjfj/e0ruChq1AZ1ufhzWnQA4Lm/s6iyUs1wIf2mi6L7m95yBZnrQzUznPAEhFjJOW9P3Mkr4/NTmwdx1APZ2fCuPS+E5NnInoeb53ZXgl2VjKbqXu/jTxI7tKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309418; c=relaxed/simple;
	bh=c0Q49lpbntXNXsuLl1k74yDPvD9eCdJopUkpac70rjw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OGFJB2jDXM7tEBXQMRqLf0s5Y7r6shut+KGCDDaht2lKH2eRhOuQ4SufAGjNRRIjxZf0Zcs2dMCCg8tPt3LFjEmzUk0bB5WIwBi4ugHb+phTRFDpek4e6fTcfF75fId+PWmsttnma5BJTvGWt3tt5luhiqq9zlIJ7N2ouI9NubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DA2CCMNE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DA2CCMNE"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8422a0eee68so1990696b3a.0
        for <linux-block@vger.kernel.org>; Fri, 12 Jun 2026 17:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309416; x=1781914216; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kz/YGgUT7Uc36MorqsAsmMwEDPJGbRICV4QU2IwdKQo=;
        b=DA2CCMNE18tSTB8R2nZCGKO6vpDH4JpNW8vPFx+u3kEtnmopDWTIV4lHu8lgS7DyZ9
         o6M6xKIdHWo56ECXSMATCvNaT78iP9g5DfxoEH+SP7Nc9lMToT4ierR9HEsn98Twapdc
         i6BLj1o2RfuGoy7HNvmJX9LiQvUcHw6yqo2bz0HaYSqqRE53CvYt2LDeAtYOHdsEOqt9
         xncte5BnWZLX0y64rT7A+3Jaq4Chkb2L8AMbrPn28IyLPtfEfljTouWfd7ZFWmOZTuyh
         Y3d/IjOOfNoceMZFji/bcQe5mrdZQ1csh1jIY16SLCRRt4edTFjIr5n3vKBC6/rD/D2o
         WLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309416; x=1781914216;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kz/YGgUT7Uc36MorqsAsmMwEDPJGbRICV4QU2IwdKQo=;
        b=LmZW64NuK29D7jAtKiAT+Vsbx3BpvF9c1f82/gu0LDmjU8c4CNG0DOuD7eNf8qf6Zo
         fZoOvK+nXr0+Ex1sgLItdhNf/c/ytQWEgC+yQVmEhIs5B68vnvL1WaJTsu+S34J5sV3e
         nRerK+TzZpHInamRP4TekdE7me58runOy1edhxWzrMlc7wqbtIjpvQKPpUcQnlsjO4Y0
         0N6MgFe1MMrsJ5/SQrjq+eAeXow2oPLKAkHdQ86pnGrKWrPj0Ie3WsGJMbwjmhKMmq4w
         yh1WbTDw+4FFgjuoImxL47IRPvbZjp2QG93rZ8DxBvc3UJO7ryQSv1G4ZulK42RPeqfs
         NZcg==
X-Forwarded-Encrypted: i=1; AFNElJ82ZVpJvhFGj3VmJcpxFDVEHE5Aw1lG1M9B4EpvWjFnXRMBLDn/hvCEXMEivvc4fRUZhMcSUm2/nVMmhA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvoWK43rmq1DmlHWyDFRXg8SN2384yY6yRme0ZnoH/yNkU3eqy
	6qQnm4i6lbpZ3DXw3MNroppKtSLUWnb4cX4YYBy8iMu1w6fgLL1YPxzpqXScn+Rc4e+n9SEQd8t
	ZJQ==
X-Received: from pfra26.prod.google.com ([2002:aa7:8e9a:0:b0:835:3df8:d72])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1404:b0:836:3f6a:3e77
 with SMTP id d2e1a72fcca58-8434cd4b0abmr5407830b3a.17.1781309415402; Fri, 12
 Jun 2026 17:10:15 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:09:52 +0000
In-Reply-To: <20260613000953.467473-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260613000953.467473-1-tavip@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613000953.467473-2-tavip@google.com>
Subject: [PATCH net v2 1/2] iov_iter: export iov_iter_restore
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
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

Export iov_iter_restore so that it can be used by modules.

This is needed by the virtio vsock transport (which can be built as a
module) to restore the msg_iter state when transmission fails.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 lib/iov_iter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 243662af1af73..067e745f9ef53 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1491,6 +1491,7 @@ void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 		i->__iov -= state->nr_segs - i->nr_segs;
 	i->nr_segs = state->nr_segs;
 }
+EXPORT_SYMBOL(iov_iter_restore);
 
 /*
  * Extract a list of contiguous pages from an ITER_FOLIOQ iterator.  This does
-- 
2.54.0.1136.gdb2ca164c4-goog

