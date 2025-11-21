Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65240285C91
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713096; cv=none; b=jw3qw3Co3PTaUmwY2vORVwbNkNxIJ0oCgyzAYeBrev0eTQeeNUjflGzoMbd0cpobSbFqafjRHha3taR27LVP4xn39SdZocVszmMy+XFl34oPxTaibhYyTE1WdBWs6qRUDbFcboeo32hl6RfmWihU+TOtJtGoaHOHY1rLaEq3fc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713096; c=relaxed/simple;
	bh=/P1RYgORKxwE9EU9V7IqZbnP/9QJ+9L8NguSmQu/jJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NX60KWvlUCkUB8KPNhZdOU6o3Z0aVYlRnc4vm8zSxB8CjOnuV28ckRg9CQqz+nzSrOoNFi3YkV1m7Mwc0qWnRnmg2gZo7zY9qj3AmiHHU45fRIKtHtHqPJP3eSpRzCU1/1VSfBWIEdafSUBQKLOUV3p+SG46xtIvf/2mQkJODNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KqV4ck86; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KqV4ck86"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so1218596a12.2
        for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 00:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713092; x=1764317892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2hQwsn6Sms438Pv0Q4ngdJSSkLE/b11prNvkoKJDYo=;
        b=KqV4ck86WNbsGDhmD/6yKH8Mgo1i6hIeId6gE5DfNCurQ/kEtVGj7gpSDHX5XWOS4q
         IR1NVC+k5Q7nkQR/Qul5FVkk/g1RXpu0dErfGJSoG8g7/Xqg4vyNDLSPputAFgOyZm5S
         sTAQufiTe7cGuqbwwVedvrxs5K5qG1IEYEKZuwaKen+ymwe/uyPE49nLjDbRohTL3Mp6
         Gc8eiMDnBq89zT9KLDl4EurhTdqNEofwin0joyfY/6Y8tpwH1d52QXmM8ka8YAoKv0mj
         50Fw11J5dBWu+4tHZvJiPgmeFHR0TzKHY4V/U+74kJY12vrz+0eHzWZaz9N0kR51gjnp
         KIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713092; x=1764317892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2hQwsn6Sms438Pv0Q4ngdJSSkLE/b11prNvkoKJDYo=;
        b=OblEXDSL8J1Wov7W2v6DyQSTsPcU5GM7AXB298VDbAjqFxviYV138gJCIlUy8vy14a
         WetPSckrJl5rpQla7VMNzwLR+/VPQX5ODBQevOm8y28NJpuUmxhaFm8cDxJNPquoBd6h
         uP36JO7HuOepAQLVlrYbOIxjaROSlJ25rQtZbEUI2Ql4dESPo2mj+T6b70SidoPun7DO
         4RX79uO90r3cFBlMwT2IL7AxyLDYDI+ZrQkSfXlR4G4NKUfrDbrMLnCIVjjsarEfnLkW
         QUa6TmjGp7BQ810D8UUazoz2PkHpEUgEsE55m2bbAa29CZiG5KJWbEZNygNPKE6FN6Ln
         zf4w==
X-Gm-Message-State: AOJu0YxijKcKHTyPGlfsBB8XE2ItUOJAg0IhTtvB+l89LUDHQDWDG3dz
	bb1rGp6syj0pFdU3Rc/IDMELtZOZnah3p2Wpy73gy/qo3DfjOANMW3aw
X-Gm-Gg: ASbGncuhNf1USv51F3aznLCxWDwBjS+TvefpmDlvfp+nk4y8nllrSUXKIt5kFagXgyY
	paD6kZRk/fO6ayD1zOvaIK2KZ0yRwtBAmRprI1WLd45kvydWYxcVhYBd7Q+HBWVWsNxiM9UKYWZ
	IiuTKneyUZjHN+w2UZnVoDLt+DOS6k4+ajng5FBIrXE8iNzsSsMk3CYNJ1QWBKdKiqAkYHNoeWD
	wYlMgULHIUYV3mimlR+Lfpl17fa9HB9FYGtk5o+fR4HH806YjlbU6IpGb6OESPcihnfctqV3RWa
	MSOJ02VtjeeIL6TKr2N6kZ0RFILO0sTyPAAPTkOZySIGQV3u1ZdNSgcvODmsYdwVNN0qUGUmtcO
	OlODisE0NYQDeEOFZieW/ZQrjUMwSr4k0DaW9C+LfinijGh6Vdb6PJOqjfMNSfPbS4JpzQI5DTv
	3QwIyxEo3hM+xaoZoGHUfwU0fBgA==
X-Google-Smtp-Source: AGHT+IENbSLlagXc9NX/smNIF96UgKjh9NXUi+KBRvhy18+CUMO6BxslQvGRE/2mRUDvnGhRtmvCRg==
X-Received: by 2002:a05:7022:ba1:b0:11b:b3a1:713c with SMTP id a92af1059eb24-11c9d60d20cmr498283c88.9.1763713092239;
        Fri, 21 Nov 2025 00:18:12 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:11 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 2/9] block: export bio_chain_and_submit
Date: Fri, 21 Nov 2025 16:17:41 +0800
Message-Id: <20251121081748.1443507-3-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shida Zhang <zhangshida@kylinos.cn>

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 55c2c1a0020..a6912aa8d69 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -363,6 +363,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new)
 	}
 	return new;
 }
+EXPORT_SYMBOL_GPL(bio_chain_and_submit);
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
-- 
2.34.1

