Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E5E45D918
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788992954; cv=none; b=cvb3RPSjk7MZYnlBCdlyjH4dZsl3uH3yZtRaVgANdd2GPcAajFEW2FjkD1BH14P/YwzXE5dmLBvWKceYSvBL7Ho6Qt+bOwERtYzy5peYvBPKXp/XmuBUcX/mX3AD1AVuJ8IDrD5xfyRPNuh73xgyrFePOUmOD4zLwaXsyAo0ljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788992954; c=relaxed/simple;
	bh=WlsOlqUvKm0Axyc+Vr7Lx6IQyXMjzH3K2ebSlJNCLAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Prt82ID18P5B8pmi3htsddPOY4qmLbJ0wZHlaMBTzFW2aLAcs3fQEiuLl1CGybLXagfo52cj+KMI/iwI+g6LekM8in9y9dbXE7lUq0+fcbqCrR0Lxf+G3YujXbI4wbT2V3BsTrOkZOdT9U5XyW81SKt9TwCAeIzo2A4VEMl8Wjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YlaDTKAO; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YlaDTKAO"
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-52d2dbc8c33so2494351cf.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1788992944; x=1789597744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UMfVAOprw3d03YbEriUlDSnVZxTmhvnPgihN27iwNZ0=;
        b=YlaDTKAOPD8G9f6lPOdiST5HYvAvKoSvlH1Q0SKuFaO04MjE6GXwrFoaECtfMuWseT
         i6JIP9OpSkWmJrK+hCs5zwirb9PTaYOFEIjPhwYDxXlx0M3W4slMSObihwDMwEK+8Sly
         JKNS3jSK+MBICrCm6z/UfNqdlcUPH6zO3SXSeob9nWcjF0qeSNpwwm4wk5vSfzAjMpae
         tI94U6R6t6K8/p5ch9nWGNj4sr5i2Bpp44VbJYIGDBxW/SUzU0dK+fb3ptJmA18VTkta
         1aQWLCsngoLenxXlVpKPtsi8mzs2edAo/XdAkknk6Nnwomtk7366JjmabSnqOYnZa5ch
         K6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788992944; x=1789597744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UMfVAOprw3d03YbEriUlDSnVZxTmhvnPgihN27iwNZ0=;
        b=ZPeCRsvyvQahVBfXSccdBdm6TX/wruLbQqebPQPbOSSd4CCbu3AHRPooA2r9JARlMd
         ksjoknHBHAPLRy8BTR08o7xVM0DFSfqlUmaNGdgkYqwcFhEJZQxlXsiIcsreHcbk/Qr4
         NLfVK2xB7KVZDHJczV5Wd3Coa0p+NDYdfbK/SFIABd/ocn6fFWzGEMgD6okPQ8IPcjGB
         JTGYqpwiAdLo1AK/ipCGL7oiWYmnhC6PgcykKUzgpVIbEfRZqsrIDX3ZV+sO/FlyShN7
         mggAT3+VRRH2px07BAViRqNVyeYnK2mWIl6v+xRn1Xpjso0Uu7y9rSDKPWGPan+gY3vo
         g8Cg==
X-Forwarded-Encrypted: i=1; AKwUvBw5IKoT16CE8sT8HMfmfSs/h0viYnf7fCcwdyDsMgHLz1oNY8bIy9Quj2SPckfwcydvzlZ+lpgq057isg==@vger.kernel.org
X-Gm-Message-State: AFuF++nSDFBgQ6w4nyhf7lvn+LTe25JgW5dWVM6vLp964NWsWT1jpHe7
	FeWYsTl2nwPIyI5YcXxjG5peB55nZ5mxI5E3fE7ToZwyRCVSSL12rv078HElP5c57N6Q8rFm9wf
	xo3CacvY/LyjP+xQIwPA3k8WGzJvVwr0Y8iUuP9geZbQSi+nQ28ZW
X-Gm-Gg: AYBFou3IMGjHWdbj2J3C5AMA6v5eUFIjbY3ppQ2uMhprD2xJNI7+/D1QpobFhesDThE
	sPxkbcX0vhhd3dkXn1FASGowOMjE5wSP9AANBNXMjsRSfXv/OoMrWk8dfsEZMNujWoD93UkLf1O
	7xlhvtrLj6+K8OLn3DtqT1bhOOjIsjPPdib9PbKazNwjhlm3F7GkH94hIVLCNmwg1FY4xZSHLd9
	CBzzICWWMZq/PIiLWkoOhaRy5Bkzhzl8L1Q3P0o9WcMqJ92GhvzcpMbvvdV9V1vPMhcOreqHrA7
	fkb++yEDhDF7OZMMW6FjdhHCYhbPQRB7JClUeiQ/BHOf75vNjs9RWBUf4fJA27QpTWpmed783aT
	2CkOroM7/+Tm5XUTF
X-Received: by 2002:a05:620a:46a0:b0:939:8a2e:68bc with SMTP id af79cd13be357-939916a0e37mr2963766485a.1.1788992943812;
        Wed, 09 Sep 2026 15:29:03 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-91040757b20sm1488646d6.24.2026.09.09.15.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:29:03 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 096AD402B2;
	Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 07299E40322; Wed,  9 Sep 2026 16:29:03 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 1/6] bio-integrity: remove dead bio_integrity_copy_user() error path
Date: Wed,  9 Sep 2026 16:28:31 -0600
Message-ID: <20260909222836.2475352-2-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909222836.2475352-1-csander@purestorage.com>
References: <20260909222836.2475352-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If bio_integrity_add_page() in bio_integrity_copy_user() fails in the
write case, bio_integrity_copy_user() will return an error after having
already unpinned the user pages. The release_pages label in
bio_integrity_map_user() would then unpin the pages a second time.
Thankfully, bio_integrity_add_page() can't fail here because the
bio_integrity_payload is freshly allocated, so bip_vcnt is 0. Replace
the unreachable error path with a WARN_ON_ONCE().

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 block/bio-integrity.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index b23e2434d80c..8ba8bfa41f8a 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -299,19 +299,13 @@ static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
 	else
 		memcpy(&bip->bip_vec[1], bvec, nr_vecs * sizeof(*bvec));
 
 	ret = bio_integrity_add_page(bio, virt_to_page(buf), len,
 				     offset_in_page(buf));
-	if (ret != len) {
-		ret = -ENOMEM;
-		goto free_bip;
-	}
-
+	WARN_ON_ONCE(ret != len);
 	bip->bip_flags |= BIP_COPY_USER;
 	return 0;
-free_bip:
-	bio_integrity_free(bio);
 free_buf:
 	kfree(buf);
 	return ret;
 }
 
-- 
2.55.0

