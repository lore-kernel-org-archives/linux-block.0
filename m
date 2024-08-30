Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744541667F1
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725007182; cv=none; b=pZDTnc8lkSY9UgPSbT6DQYasajdcuTqeOyN05k0tnM/5Zb1iqAIW5a+AFlsrOa8QRet+MVA4BUVzaUJ3FPC+B5KLaqjYscdG7ye9TZ3B99rM5dnkdNGq5sWAztdz0zCU6krZc4lR7IJd56wTMa11Zv8NNRCPIeBiop9+a3wLzaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725007182; c=relaxed/simple;
	bh=ByjhQZNBrmtwvjzAKA7p8qjIQOlMQlAbGUvLshQ7ARw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=mAXe0I1VENQrwFEt3NsXVh7WJB2QoCfrdn6UMXFpXvVFrhDZyDpBcHhYNMjc43lfs7JLDMv01Hq/nCZyVZJJU7tD0ABnAxcTSRgJgEUAToPE7mu9TvJdPhPKhSzDpdMv8IimrgiQfWMD2skitSeQVznBkV4fKxiihbgFOTE3hyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qvO7M0za; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qvO7M0za"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240830083938epoutp01c96eefad86c6f836417ebdc8ce115e88~wdOOzu_qJ3142131421epoutp01J
	for <linux-block@vger.kernel.org>; Fri, 30 Aug 2024 08:39:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240830083938epoutp01c96eefad86c6f836417ebdc8ce115e88~wdOOzu_qJ3142131421epoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725007178;
	bh=N908WA4PL4Ey099voGw4MaeeUDI9efP2rV1ZprSvzt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvO7M0za+FStJCqu7++ddqJjJUlG0WAYkqACCyxtcn7SCNu3ijl18bikW+j1ojZW1
	 1QBr67aLmlRqLB8SEW4ReZw5+awVFODx19MZtfhC5rQjOVTbH/0ovLyNVKmvG8iVUU
	 01ZLJXDEFfZIRxUvi1jDG8Nj7tYkDWhII5kyKZGc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240830083937epcas5p2ab2ae74b72ea51598cc5b2a9fc4adb2e~wdOOG0DFO2838628386epcas5p2I;
	Fri, 30 Aug 2024 08:39:37 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WwBQv4YQ0z4x9Px; Fri, 30 Aug
	2024 08:39:35 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D4.69.09640.74581D66; Fri, 30 Aug 2024 17:39:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240830080059epcas5p4c880e8052b5f8e70077746a947442e56~wcsfKp96m0511305113epcas5p4W;
	Fri, 30 Aug 2024 08:00:59 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240830080059epsmtrp178975af7d8e9c25c30d65169a7efae1c~wcsfJ5fcs1337013370epsmtrp1F;
	Fri, 30 Aug 2024 08:00:59 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-00-66d18547954c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	21.AA.19367.B3C71D66; Fri, 30 Aug 2024 17:00:59 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240830080057epsmtip20456ba5999e517d47785a2aa3a608810~wcscytv882259122591epsmtip2P;
	Fri, 30 Aug 2024 08:00:56 +0000 (GMT)
From: Kundan Kumar <kundan.kumar@samsung.com>
To: axboe@kernel.dk, hch@lst.de, willy@infradead.org, kbusch@kernel.org
Cc: linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org,
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com,
	vishak.g@samsung.com, gost.dev@samsung.com, Kundan Kumar
	<kundan.kumar@samsung.com>
Subject: [PATCH v9 4/4] block: unpin user pages belonging to a folio at once
Date: Fri, 30 Aug 2024 13:22:57 +0530
Message-Id: <20240830075257.186834-5-kundan.kumar@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240830075257.186834-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPJsWRmVeSWpSXmKPExsWy7bCmuq5768U0gxOLFS2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF+Vlz2C1+
	/5jD5sDrsXmFlsfls6Uem1Z1snnsvtnA5tG3ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnp
	tkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBnKimUJeaUAoUCEouLlfTtbIryS0tS
	FTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyMz5OaWQr2MNRsehBD3sD43O2
	LkZODgkBE4n3My6ydzFycQgJ7GaUOPp7BzOE84lR4vG8tQjO2zWTmWFaTq07wgqR2Mkocejc
	RiYI5zOjxKr9Cxm7GDk42AR0JX40hYI0iAi4S0x9+YgRpIZZ4CmjxJUvP1lBEsICPhLdizay
	gNgsAqoSDS+bwWxeATuJg40r2CG2yUvMvPQdzOYUsJfYMr+HFaJGUOLkzCdg9cxANc1bZ0Nd
	N5FDYnJHBITtIrG85TojhC0s8er4FqiZUhIv+9ug7GyJQ40bmCDsEomdRxqg4vYSraf6mUF+
	YRbQlFi/Sx8iLCsx9dQ6Joi1fBK9v59AtfJK7JgHY6tJzHk3lQXClpFYeGkGVNxD4uH3FrC4
	kMAkRomeWzwTGBVmIflmFpJvZiFsXsDIvIpRMrWgODc9tdi0wDAvtRweycn5uZsYwSlXy3MH
	490HH/QOMTJxMB5ilOBgVhLhPXH8bJoQb0piZVVqUX58UWlOavEhRlNgcE9klhJNzgcm/byS
	eEMTSwMTMzMzE0tjM0Mlcd7XrXNThATSE0tSs1NTC1KLYPqYODilGpjWvcs94HDntmzCvjnb
	y7amLr2hX3dBIOeT9dtXkhrbIwTX7rqdk3E17Uz0romx003eXA8Nrf913VW6ffVG6biqtPfZ
	LcczpErOsE/hEq248v+vjViPrN357XMZbxdnZjGZWXwTsEuVT+u66hF0sTdgWsDNEEeejpJ9
	tYd2dE64vr7xW2/q80q/bpHKTZ3sffEiUUdnifQtfm3GuX/5yomeTebyzZ8d1rEXnIlLaXwn
	en2VvHnjZRPf/p45zInTtO/WCE/cE3r+qOMnKyuG89PX7Ns5XfPQpz0/q5J4n/c0263RfWY0
	N73427Ipn8OX7ZmnPj3dMbpEtu+h4ox1yx4IvPtgobT4WX7E/a/XIsKUWIozEg21mIuKEwHc
	BKhJQgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrELMWRmVeSWpSXmKPExsWy7bCSvK51zcU0gw1nlC2aJvxltlh9t5/N
	4vv2PhaLmwd2MlmsXH2UyeLo/7dsFpMOXWO02PrlK6vF3lvaFjcmPGW02PZ7PrPF+Vlz2C1+
	/5jD5sDrsXmFlsfls6Uem1Z1snnsvtnA5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZH6c0
	shXs4ahY9KCHvYHxOVsXIyeHhICJxKl1R1i7GLk4hAS2M0rcbFsMlZCR2H13JyuELSyx8t9z
	doiij4wSX35cZepi5OBgE9CV+NEUClIjIuArsWDDc0YQm1ngPaPE7SXSILawgI9E96KNLCA2
	i4CqRMPLZjCbV8BO4mDjCnaI+fISMy99B7M5BewltszvAdsrBFTTcnURE0S9oMTJmU9YIObL
	SzRvnc08gVFgFpLULCSpBYxMqxhFUwuKc9NzkwsM9YoTc4tL89L1kvNzNzGCo0EraAfjsvV/
	9Q4xMnEwHmKU4GBWEuE9cfxsmhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU
	1ILUIpgsEwenVAOTb9S+HZs+LU7ufmkrqZ50lq86O6/mrfbZCuGm783rb9gr7bjhn/VV+/Ne
	o0s6mgtYJ79+9N4/X0Mwy+DEpKuFJwv3ubwXE3y1yMhdXOfYg3KOPU+3L2zb878iXsCutqXu
	XcmbvbcXX5zkwm8SGWgn0fl3wYEtsdasXV9/XeezmvR3zcVz/0Q2Jam5mYh4HXr/nHmBo+UU
	Tn3dO6obeZXcgv4xvs3ZPaPcSCwr91S/8N1XfLJqJ5bv5fKSNCxc9SCBU07jrpH+ebPQquoJ
	bzhKr8z6MlPGbfOKB7P4f3btjHploTBB/tTJO3y7vPwY1m3VXm13RSMgsOTF+xS7W7Ybt6//
	zyk6++siZhM/+ZW7lViKMxINtZiLihMBs2C7kvUCAAA=
X-CMS-MailID: 20240830080059epcas5p4c880e8052b5f8e70077746a947442e56
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240830080059epcas5p4c880e8052b5f8e70077746a947442e56
References: <20240830075257.186834-1-kundan.kumar@samsung.com>
	<CGME20240830080059epcas5p4c880e8052b5f8e70077746a947442e56@epcas5p4.samsung.com>

Use newly added mm function unpin_user_folio() to put refs by npages
count.

Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Tested-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bio.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index c8fc97b42410..1babe30f3a84 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1190,7 +1190,6 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	struct folio_iter fi;
 
 	bio_for_each_folio_all(fi, bio) {
-		struct page *page;
 		size_t nr_pages;
 
 		if (mark_dirty) {
@@ -1198,12 +1197,9 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 			folio_mark_dirty(fi.folio);
 			folio_unlock(fi.folio);
 		}
-		page = folio_page(fi.folio, fi.offset / PAGE_SIZE);
 		nr_pages = (fi.offset + fi.length - 1) / PAGE_SIZE -
 			   fi.offset / PAGE_SIZE + 1;
-		do {
-			bio_release_page(bio, page++);
-		} while (--nr_pages != 0);
+		unpin_user_folio(fi.folio, nr_pages);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
-- 
2.25.1

