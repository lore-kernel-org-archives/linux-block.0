Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759140;
	b=mQvvMzYTcuik3TDfIsUfF+zbAOJJBZqKvmj0+3iDUViZSgj8clHDhcvoMetPedX8uPJE
	 XgDA29+G+qamNWYfTHkoC3uUX2y+DsI08fu6hsuVlSvwA6/TA+MYaSw9sP/6R24YioLSj
	 zl0OCaBJIDLIrxnB8XTBEAYai6Xqqp1x7VC+MVeegk/0hRYQj6lugelAY1bU6ua1cKReL
	 eN+mzKzg9+lnx4dbkcM1mhxpNMzHLv7z42xdkcL380HFvSHdoJTjP+GZdHTMN/UkXjj8k
	 8ksEORQpjF3prhlluWFDaD9cG/XPdukOMJq6liLnL5K0ErzOhR0zXIWmCmfOWKE21TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759140;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=cp05jW7hJV+9rE5FQ+Ld7f2LCLjbgtBVL5t7Y46XhuA=;
	b=oVeP8fqBvqxhESCW4SnFkEuvzrXXMAjpnmXbC5YmrQTnir9qMO2R4SJqasE1TDK5/TVC
	 Zrzej6KG5M6QZUpGyCkX0GLILFVldaTvSO+bO+EEl8iWb5LuEWqsUQ9Ei/bK6r6ZiaGj7
	 F43WxV0hgZAh/jbDM5JmQUppM/XrOgDah5cMLGVZt9K9QVqNFaIsdXqfv3retDicIuffZ
	 6/THnko5yQSPwsUgLFyCOwbX4E8/0mT1y/O6cWCJBbuqtqxDzZ1RXDlLpibsmYW8jmmXf
	 neiFlN1bagkTD4dCjPnQGfmMK38BvMzWO9xTFW6yHqEL8nszQ/Xglb5HkQNHXroCCfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="NwL/idF7";
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C48E606A322;
	Fri, 23 Oct 2026 12:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C48E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NwL/idF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cp
	05jW7hJV+9rE5FQ+Ld7f2LCLjbgtBVL5t7Y46XhuA=; b=NwL/idF7yLcNVy1Sqh
	wCBArmlZDfE3CETd4QWsLQicQ1DnbCevfOyjT9Nf5WHJ4Txi+50Aq408HisBlz5P
	ukvpaIcil4sCLfPuJ3cgvXk2hEO+rw0CCAVYffw0vh0PIdp9f7+ICJqC9UfRbcWC
	BsU40s1CE8mXgqDsdc2XwQRus=
Received: from hongfeng.mioffice.cn (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD31_UTVdtq41kmCA--.56769S2;
	Fri, 23 Oct 2026 20:37:41 +0800 (CST)
From: Hongfeng Chen <chenhongfeng0212@163.com>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Hongfeng Chen <chenhongfeng0212@163.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <baohua@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Wenchao Hao <haowenchao@xiaomi.com>,
	Wenchao Hao <haowenchao22@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Hongfeng Chen <hongfengchen@xiaomi.com>,
	Hongfeng Chen <chenhongfeng0212@gmail.com>
Subject: Re: [RFC PATCH v4 0/2] mm/zsmalloc: defer object free to per-cpu batches
Date: Fri, 23 Oct 2026 20:37:36 +0800
Message-ID: <20261023123736.1542117-1-chenhongfeng0212@163.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAKEwX=ONniSwdiZAe_8NT5XwVj=Mmc-WJs_rWE4Y5snjFg2=Eg@mail.gmail.com>
References: <20261016120927.3191690-1-hongfengchen@xiaomi.com> <CAKEwX=ONniSwdiZAe_8NT5XwVj=Mmc-WJs_rWE4Y5snjFg2=Eg@mail.gmail.com>
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
X-CM-TRANSID:_____wD31_UTVdtq41kmCA--.56769S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4UGw15Xw4kAr4kJr4rGrg_yoW8XFyUpF
	Z3GayxWws5Jr1xKr97Aw48ur18Aw1rGF48JrWSy347ZFn0yFnFkw1kJay8Zw1fAr4Fk3WF
	yFWktw15trsrZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U2XdbUUUUU=
X-CM-SenderInfo: hfkh0xxrqjwvtqjqjiqs6rljoofrz/xtbC7hXrBWrbVRW5MAAA3t

Hi Nhat,

On Fri, Oct 16, 2026 at 9:09 AM Nhat Pham <nphamcs@gmail.com> wrote:
> 1. Would memory freeing be slowed down?

I sampled pool->pages_allocated every 1 ms, and measured the time from
the start of munmap() until the zspages are freed. Three cases are
tested: 1 process x 256MB, 1 process x 1024MB, and 4 processes x
256MB. The results are as follows:

  workload                  base      with-patch
  1 process, 256 MB         14 ms     9 ms
  1 process, 1024 MB        51 ms     31 ms
  4 processes, 256 MB       45 ms     24 ms

Memory freeing didn't get slower and it actually got faster.

> 2. Would this introduce isolation issues, especially when this work is
> not properly accounted?

Yes. The drain runs in an unbound kworker in the root cgroup, so its
cost is not charged to the killed tenant, and it may take CPU time
from other tenants. I'd appreciate any suggestions on a clean way to
handle this.

> Another thing I wonder is, how much of this slowed down is because of
> zsmalloc's own inefficiency, and how much is because we just have a
> larger logical footprint

Mostly zsmalloc. I kept the footprint the same (1 GB paged out to zram,
then munmap()) and only made zs_free() do nothing:

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1455,6 +1455,8 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	int fullness;
 	struct zspage *zspage_to_free = NULL;
 
+	return;
+
 	if (IS_ERR_OR_NULL((void *)handle))
 		return;

The speedup is as follows:

  machine                   base      with-diff-above   speedup
  x86, 1024 MB              50.2 ms   20.6 ms           2.44x
  RK3588 A76, 1024 MB       89.4 ms   23.3 ms           3.84x

Thanks,
Hongfeng

