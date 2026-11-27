Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767024;
	b=Ou8ndJ3lJf681GndtemXacWu+8ICvEWwqjJQhBxMB307HTUI7SJuYufbtrmcJLE2/SSL
	 ONKP91ujSdbuFW4dUzck5IN3jym2lwW/EGBYwI4GgtJ9A4isgjjo70PoWuVvy1Y8z3wvk
	 1ATQTo2brgUH+IQTNKlDpKuwLeEQhej+p6cm7S6u/SrPTpUP4OPsWps0cPatMlHKM+Ta4
	 shipYRC4+iEvN1M01w4YZnms1sDXeNivGFHPdBb6UtYYdmeWgFdqiW8qalfQ/77HcFcZW
	 J5N/p/pmqTvwSa/FRUBh+L0AKlopbzjxVKR/0b0AE5mcfnEcbmidJstJO5S0vgy1B1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767024;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=z2WPS4JyLBQjVa8az6zNUmfoJeGYnzi48maeQui2YGk=;
	b=oMSGjN8ua4YW2xoCPcmXplch6KIdHGg3vmP2wUJ2Z4h3KY7ONYyzxBTt+mVhjNdqzjrI
	 /fsKKL9aOI9bLDhV0T43RKkzsOjkFvFBmXMRT8oXBIgJf2dsOkTHjeMvaL4ZZNN1Yy9sk
	 O6gnTxLW5M+60Oa656ZfS/5zawG33kZbYj3eXLVF3Jj3qWyhLXvSCjONkLz08luAjAIf1
	 kSJnGtzDRd/PHq9lIUBAObY6MFbxwUEuCTVf2uUTTdtl/S4ZEW+IkB5NaUhqPPmyl4uXw
	 vlHv9WZBam03fqbn0BhEIgOUYnaByo7BoqXTSZHeno2+XE0XOWO3EIwZ0Q43j63WQAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=xiaomi.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=V4DWH0yz;
	arc=none smtp.remote-ip=117.135.210.8
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16494606A321;
	Fri, 27 Nov 2026 08:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16494606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=V4DWH0yz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=z2
	WPS4JyLBQjVa8az6zNUmfoJeGYnzi48maeQui2YGk=; b=V4DWH0yz4Hxc2E44OV
	3qnKP624PPmfYc2UKZj/j4RHu4IvoUIlpmO4VdqRjF/UWsiC6ipP9NCGzYEstCXs
	HCFGgJBFVTQQZc0ZdJmp4U6pUC/wM8d+QVCuYrTD8zDZT+VZwOIZN47swrwxwiTp
	PQuOVlTqiJeXWHPT0Ss5MOh1Y=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3Pwd_OglrliZsEA--.60259S2;
	Fri, 27 Nov 2026 16:08:33 +0800 (CST)
From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: sashiko-bot@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Usama Arif <usama.arif@linux.dev>,
	Yosry Ahmed <yosry@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Ying Huang <ying.huang@intel.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Wajdi K Feghali <wajdi.k.feghali@intel.com>,
	Bala Seshasayee <bala.seshasayee@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Barry Song <baohua@kernel.org>,
	Bo Zhang <zhangbo56@xiaomi.com>,
	sashiko-reviews@lists.linux.dev
Subject: Re: [RFC PATCH v4 1/4] mm: zsmalloc: support objects compressed based on multiple pages
Date: Fri, 27 Nov 2026 16:08:22 +0800
Message-ID: <20261127080831.3599864-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-216088@kernel.org>
References: <20261115024455.1465726-1-zhaonanzhe@xiaomi.com> <20261115024455.1465726-2-zhaonanzhe@xiaomi.com> <sashiko-outbox-216088@kernel.org>
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
X-CM-TRANSID:_____wD3Pwd_OglrliZsEA--.60259S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFykWr4rXFyxtrykWr47CFg_yoWxXFWDp3
	WxCanrAr4rXFy8J3y7Ar4kAanIywsxKF48KayrurWfuFWrJ3s2gFy7Kry3XF48ArsrA3yx
	Xws2yw43Aa1rCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U9XocUUUUU=
Sender: nzzhao@126.com
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBowHLm2sJOoG5ZwAA31

> [Severity: High]
> Does this break compilation at this commit?
>
> obj_allocated() only takes two arguments (zpdesc and obj) and returns the
> handle pointer, so passing &handle fails to build until commit "zram: support
> compression at the granularity of multi-pages" reverts this line back to the
> two-argument call.

Yes, patch 1 breaks compilation on its own. I will fold the mm/zsmalloc.c
change from patch 2 into patch 1 to keep bisectability intact:

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1698,2 +1698,3 @@ static struct zs_handle *find_alloced_obj(struct size_class *class,
-		if (obj_allocated(zpdesc, addr + offset, &handle))
+		handle = obj_allocated(zpdesc, addr + offset);
+		if (handle)
 			break;

> [Severity: High]
> Does calling memcpy_to_page() here trigger VM_BUG_ON(offset + len > PAGE_SIZE)
> when writing a multi-page object that spans two zpdescs?
>
> For a multi-page class, page_size is larger than PAGE_SIZE, so off + sizes[0]
> equals page_size and exceeds PAGE_SIZE in the first memcpy_to_page() call
> (and sizes[1] can also exceed PAGE_SIZE in the second call).

Agreed. I will replace it with kmap_local_zpdesc() and memcpy():

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1270,16 +1270,18 @@ static void obj_write(struct size_class *class, struct zspage *zspage,
 	} else {
 		/* this object spans two pages */
 		size_t sizes[2];
+		void *dst;
 
 		sizes[0] = page_size - off;
 		sizes[1] = size - sizes[0];
 
-		memcpy_to_page(zpdesc_page(zpdesc), off, src, sizes[0]);
+		dst = kmap_local_zpdesc(zpdesc);
+		memcpy(dst + off, src, sizes[0]);
+		kunmap_local(dst);
 		zpdesc = get_next_zpdesc(zpdesc);
-		memcpy_to_page(zpdesc_page(zpdesc), 0, src + sizes[0], sizes[1]);
+		dst = kmap_local_zpdesc(zpdesc);
+		memcpy(dst, src + sizes[0], sizes[1]);
+		kunmap_local(dst);
 	}

> [Severity: Medium]
> Should these helpers use zone_stat_add_folio() and zone_stat_sub_folio()
> instead of the double-underscore variants?
>
> __zone_stat_add_folio() and __zone_stat_sub_folio() require preemption or
> interrupts to be disabled, whereas alloc_zspage(), zs_free() ->
> __free_zspage_lockless(), and zs_page_migrate() call these helpers in
> preemptible context with no locks held, triggering preemption-disabled
> assertions and racy per-CPU vmstat updates.

Agreed. I will switch to the non-preemption-disabled variants:

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -345,4 +345,4 @@ static inline void zpdesc_inc_zone_page_state(struct zpdesc *zpdesc)
 {
-	__zone_stat_add_folio(zpdesc_folio(zpdesc), NR_ZSPAGES);
+	zone_stat_add_folio(zpdesc_folio(zpdesc), NR_ZSPAGES);
 }

 static inline void zpdesc_dec_zone_page_state(struct zpdesc *zpdesc)
 {
-	__zone_stat_sub_folio(zpdesc_folio(zpdesc), NR_ZSPAGES);
+	zone_stat_sub_folio(zpdesc_folio(zpdesc), NR_ZSPAGES);
 }

> [Severity: Medium]
> Can ZSMALLOC_MULTI_PAGES_ORDER=9 overflow the 24-bit first_obj_offset field
> on 64 KiB page systems?
>
> With 64 KiB pages, order 9 gives a 32 MiB zpdesc, while
> set_first_obj_offset() masks offsets with FIRST_OBJ_PAGE_TYPE_MASK (16 MiB)
> and only checks BUILD_BUG_ON(PAGE_SIZE > SZ_16M):

Agreed. I will check ZS_MAX_ALLOC_SIZE instead of PAGE_SIZE:

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -551,3 +551,3 @@ static void set_first_obj_offset(struct zpdesc *zpdesc, unsigned int offset)
 {
 	/* With 24 bits available, we can support offsets into 16 MiB pages. */
-	BUILD_BUG_ON(PAGE_SIZE > SZ_16M);
+	BUILD_BUG_ON(ZS_MAX_ALLOC_SIZE > SZ_16M);

> [Severity: High]
> Can the last base-page size class exceed PAGE_SIZE when
> CONFIG_ZSMALLOC_MULTI_PAGES is enabled?
>
> Previously, ZS_MAX_ALLOC_SIZE was PAGE_SIZE, which clamped class
> ZS_PAGE_SIZE_CLASSES - 1 to PAGE_SIZE when PAGE_SIZE - ZS_MIN_ALLOC_SIZE was
> not a multiple of ZS_SIZE_CLASS_DELTA (such as on 16 KiB and 64 KiB page
> kernels). With ZS_MAX_ALLOC_SIZE raised to ZSMALLOC_MULTI_PAGES_SIZE, class
> ZS_PAGE_SIZE_CLASSES - 1 gets size == PAGE_SIZE + 32 on 16 KiB and 64 KiB
> page systems...
>
> Should sizes for i < ZS_PAGE_SIZE_CLASSES be clamped to PAGE_SIZE, and should
> the multi-page classes start at i - ZS_PAGE_SIZE_CLASSES + 1?

Yes. I will clamp base size classes to PAGE_SIZE, start multi-page classes
at i - ZS_PAGE_SIZE_CLASSES + 1, and adjust get_size_class_index() accordingly:

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -211,4 +211,4 @@
 #define ZS_MULTI_PAGES_SIZE_CLASS_DELTA	(ZSMALLOC_MULTI_PAGES_SIZE >> (CLASS_BITS - 1))
 #define ZS_MULTI_PAGES_SIZE_CLASSES	(DIV_ROUND_UP(ZS_MAX_ALLOC_SIZE - PAGE_SIZE, \
-					      ZS_MULTI_PAGES_SIZE_CLASS_DELTA) + 1)
+					      ZS_MULTI_PAGES_SIZE_CLASS_DELTA))
 #define ZS_SIZE_CLASSES		(ZS_PAGE_SIZE_CLASSES + ZS_MULTI_PAGES_SIZE_CLASSES)

@@ -586,5 +586,5 @@ static int get_size_class_index(int size)
 		idx = ZS_PAGE_SIZE_CLASSES;
-		idx += DIV_ROUND_UP(size - PAGE_SIZE,
-				    ZS_MULTI_PAGES_SIZE_CLASS_DELTA);
+		idx += DIV_ROUND_UP(size - PAGE_SIZE,
+				    ZS_MULTI_PAGES_SIZE_CLASS_DELTA) - 1;
 		return min_t(int, ZS_SIZE_CLASSES - 1, idx);
 	}

@@ -2305,4 +2305,4 @@ struct zs_pool *zs_create_pool(const char *name)
 		if (i < ZS_PAGE_SIZE_CLASSES)
-			size = ZS_MIN_ALLOC_SIZE + i * ZS_SIZE_CLASS_DELTA;
+			size = min_t(int, ZS_MIN_ALLOC_SIZE + i * ZS_SIZE_CLASS_DELTA, PAGE_SIZE);
 #ifdef CONFIG_ZSMALLOC_MULTI_PAGES
 		if (i >= ZS_PAGE_SIZE_CLASSES)
-			size = PAGE_SIZE + (i - ZS_PAGE_SIZE_CLASSES) *
+			size = PAGE_SIZE + (i - ZS_PAGE_SIZE_CLASSES + 1) *
 			       ZS_MULTI_PAGES_SIZE_CLASS_DELTA;

> [Severity: Low]
> Does the format string need a trailing space after the third "%5u" to match
> the header and Total lines? Without it, all subsequent columns in each
> class row are shifted left by one character.

Agreed. I will add the trailing space:

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -670,2 +670,2 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
-		seq_printf(s, " %5u %5u %5u", i, class->size,
+		seq_printf(s, " %5u %5u %5u ", i, class->size,

> [Severity: Low]
> The kernel-doc comment above zs_huge_class_size() is missing an @type entry
> for the new parameter.

Agreed. I will document @type:

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -1292,2 +1292,3 @@
  * @pool: zsmalloc pool to use
+ * @type: zsmalloc type (base page or multi-page)

