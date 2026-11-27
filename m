Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768133;
	b=5Oe8ivlk5jAWG38mGucnaVxzZdnwYsE5j23WAcS8bdto97XsBtFQ1SxW7yOq0wChTgDk
	 ni9CCzjJjf3jXcLQskbFSKcoBcAQpXHyEpzeEInGmgcXbHYvh4Mr7bmlJM/H98X2V3vpg
	 thiRjVxqA0aQERVNGtoun7WFtFgThFFIrPN7hbmYh7WjWIB5Vji2w1cf3TEkBhDyMd7Qb
	 CaBUgqANoKUPJyJGp1+rRrouT/i8Sen8gvpZdGSx5mY7s2COwZLLkLo3TLwYpo6509w73
	 o4fQyCDTScbjNSch8cLy3EccX2bIfiHAFg6i1OLLsaT9M8QEesEeuJ/11x3Bq7do03Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768133;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:Sender:
	 X-CM-SenderInfo;
	bh=mc1AjUFz08l5NWa5nSsq48XQe3osLZopmAouGxSLMYs=;
	b=GX0GGeI9zAFWTpSaSwX3rPiTHGfJPcCSRz6go5zRTK7OvSL2mwVRD4JJu5Qq33Yrblp1
	 Pt6Qk33IGxl3MbyiJRcpv/TG3qgjffcc6DhyuUUBPFYHdw+2f01lzvMkl3ezPdza6X5v4
	 IzL0FqUi+EmEggfbU0zjXajxWk9iC+NfEcu86wrKgoNzXeH/i7d2ubDg2m7TMsx4bzflu
	 szEtX08u974rLfYtcE9qLS2b6QGd5TUV1jeL6NTrHYJBM7cvEveW+6BTusPO/2fBdqczu
	 V4bMUFvHI3LtMkx7zyunHVBnu492R7+BBFTsQmqgRogbj2mX3u/RN+5h2kVPkBFYE0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=xiaomi.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=L1aw4Yxh;
	arc=none smtp.remote-ip=117.135.210.8
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA91606A32A;
	Fri, 27 Nov 2026 08:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AA91606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=L1aw4Yxh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=mc
	1AjUFz08l5NWa5nSsq48XQe3osLZopmAouGxSLMYs=; b=L1aw4Yxh705ARFxiJM
	L3FHnFN2FHrn27dS0jGDazV8PaUiFx5OtOhnnG5BB2E+/TzSRwcRMhVkhBAtAbjD
	4ENm/cSy7u4dmNR/MaXDoUIvTj0jaobtFbxcbYGdGA2CRDeJnHMlMQjtHmLj+QhQ
	rB9k+5nzhmPsp7nNTmOwCYb5M=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3n8ToPglrpDfcDA--.16205S2;
	Fri, 27 Nov 2026 16:27:21 +0800 (CST)
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
Subject: Re: [RFC PATCH v4 2/4] zram: support compression at the granularity of multi-pages
Date: Fri, 27 Nov 2026 16:27:17 +0800
Message-ID: <20261127082719.3624596-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-216089@kernel.org>
References: <20261115024455.1465726-1-zhaonanzhe@xiaomi.com> <20261115024455.1465726-3-zhaonanzhe@xiaomi.com> <sashiko-outbox-216089@kernel.org>
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
X-CM-TRANSID:_____wD3n8ToPglrpDfcDA--.16205S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1ftry3tr43Wr4DZw18Zrb_yoW8KF4xpF
	WrKayFyFykJry5urn2va18Zryjk3yxGay7ZryrtryxWF1rJFy2qFy2ya1rZa4UArs7ZrZI
	qa1Fy3y8A3yqv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UkGYLUUUUU=
Sender: nzzhao@126.com
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsQnmtmsJPulG7gAA31

> [Severity: High]
> Can concurrent zram_slot_free_notify() calls on sibling sub-slots leak the
> multi-page object?
>
> __test_multi_pages_comp() counts ZRAM_COMP_MULTI_PAGES across the group
> while only holding slot_trylock(zram, index) on the current sub-slot:
> ...
> In addition, when comp_count == 1, clearing ZRAM_COMP_MULTI_PAGES and
> unlocking index before slot_trylock(zram, head) means that if
> slot_trylock(zram, head) fails, the last ZRAM_COMP_MULTI_PAGES flag has
> already been cleared, and another CPU can also reallocate and write to
> head in the unlocked window before slot_trylock(zram, head) runs.

These are valid issues. The locking and lifecycle model for compound slots in
v4 had inconsistent semantics between slot_free() and slot_free_notify(), and
lacked a unified locking boundary across sub-slots. I will redesign the
concurrency model for multi-page slots in the next RFC version.

> [Severity: High]
> Does setting ZRAM_COMP_MULTI_PAGES on index + 1 .. index + nr_pages - 1
> without locking or freeing those tail slots corrupt the slot bit-lock and
> leak existing objects?
>
> zram_write_page(), write_same_filled_page(), and
> write_incompressible_page() only lock and call slot_free() on the head
> slot index:
>
> 1. Because table[index + i].attr.flags aliases table[index + i].__lock,
>    the unlocked non-atomic |= in set_slot_flag(zram, index + i, ...) races
>    with concurrent slot_lock() / slot_unlock() on tail slots and can
>    corrupt ZRAM_ENTRY_LOCK_BIT, hanging waiters in wait_on_bit_lock().
> 2. Any single-page zsmalloc handles already stored in the tail slots are
>    never freed before ZRAM_COMP_MULTI_PAGES is set on them, leaking those
>    objects.

Same here.

> [Severity: High]
> Can two concurrent partial writes to different sub-slots in the same
> multi-page group overwrite each other?
>
> zram_read_page_size() unlocks slot_lock(zram, index) after reading the
> multi-page into the temporary page, and zram_write_page() only re-acquires
> slot_lock(zram, index) after compressing the updated buffer.  If two CPUs
> concurrently perform partial writes to different offsets of the same head
> index, both read the old multi-page before either writes back, so the
> second writer overwrites the first writer's sub-page with stale data.

Same here.

