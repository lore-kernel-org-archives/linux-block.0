Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B9A43BDD6
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581565; cv=none; b=QERyCYdx9j/RozDtRPcUFXDQkDrGZ6mMiF4d3EFQYY5HHi7EwdnS83k8C7MWTPH6Vdd0bTPYkrlswlhynvq05GB0j1y/0XTQaahZMdM7AXheDFwLI3pHXmSqZIKeWyUFZ9LLbR9+I2VM1VWWmu0lkq++HSWiYP37uikDgX4rmrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581565; c=relaxed/simple;
	bh=1gndqcwixIf69ERl83wZ/ahlq6SVahr40TbASWBQcgI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=s0oT3oHD07gZzAGfJN1gT036X4r1Y4S8fQ5tSRZI/IUGf8Xaha4xxJCBbbqtktXiFIxqOndTcuqc9Jl0C+U6AVOgvkeo3dWID0GLgVDcf4jb7Wwuue8IS4XG7pjVSZzILNvOMRmLiZjRqYRxBH+hidXg25jZznPAPNOvaXC+nXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qtyj8YcU; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtyj8YcU"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-836c91bd782so42798637b3.0
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787581562; x=1788186362; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsHaeoqxnMhy2GB3rUAu2bzr8hj8izpjrzp8bJJzBnk=;
        b=qtyj8YcUWb3nhbWfFR1yFkoOzDGF3NubYDQbAGYRXxSFU9sFzPTnQXiVe1+L8Ya6Ub
         Y3ABAv8Skeh07ilRLu2LRwBRetxeZ3YjvOwJoSVd+ieEDuHymyt4KK7PyHaLFCez6/yA
         CmYhhc3hG7OddFHnmw1Zds95SnjpsFeq6aR4Wpgl5qB23W0fCz4t9iCoDsh/RU+pcBqi
         epj4aR0lPB6ForXt8ft/Mn+wYMS94Ze0kESzmtAXcUmhlDfYh9lsTD46vBBuJsMneRcq
         DsveRAU02svpn38yxs09ge518OuI/pVdkv3Knis9TnbAIvU4lDhnuCGaGoZiptRruc5f
         /2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581562; x=1788186362;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lsHaeoqxnMhy2GB3rUAu2bzr8hj8izpjrzp8bJJzBnk=;
        b=RyiOA8bO5yGXGnqmcRJ25dpotwL2jL0zpqbAzZ7GDO/3gIXoEVQNV3VPsjeJdWIJiG
         6utIF5KGt9jLGiLozyWi54HSpRr66iwwcQVjiRdWUW++uPlK213Bi7Z9aVSaOt8Cz4d5
         lG2pkp18eg6G/1hVWHUUoFgDxqGOyUzPpkbVe6FqWvUfL785k3hZq6zEYBD6I4gGw68/
         amonZtpX6KfiJ+tOuMzKH+xzDJPPDNy9H10PW4AbhCwULwEfsc0vAyFcygvKVg+4SEBD
         xGPHUZ0ztWO2aI61d6gTk5hjJBgGLX2QtUwhypBDnsg32lm7xqYwWrpy9XEcowa7bhiH
         Is9w==
X-Forwarded-Encrypted: i=1; AHgh+RrpSSDbKmd5ENocWnhYdRuXjwMPgbnelKXsuKTkzuoT53z4410TQpfRnX6Ja2FMJEY7cVS0BEaFtxdjag==@vger.kernel.org
X-Gm-Message-State: AFuF++nIWYkssOQNW2FQ5QEi7UHZf+opxE+wFk6alzNdrdfiIJXdGQkQ
	PhWZsTUnXLWwFkM42Mg5A7aDrTfIDRQjEVYFuIxIs39+Gagqu42o1w5FH4I+eeBVDQ==
X-Gm-Gg: AR+sD10RGvCLwu6ieqZZwvX4Mcp1CHRDuIooaWDOkTnxh+B81AUwRyH2U/fdOVYMxVM
	hjUSc2W15i3YUIGNgC2A7IR18OrDcJL9LkswJIPADRwIAkRlLoDSnEo1B3fCRMSO0b43hko0Vt9
	RYqAO+vo13ldGlM27zUluC1HSY28mK+YgGzVPv+dLBi3Nlf+tT2/0I+6rnAFJ+ZMTySoGnG2Ear
	qgpPTIGYlRwf9gzqbAyewI0EzJvQSrx75aqfLoZPf6TVnnFjRf3ZA2qUnduiLvytAg8F28W5J7z
	XT2c8L8IIaARH6J//VpCbDvPs8tN0pVzJZcj1BPvlj5ej3dryKenqSHUy46Yvk0DfSBW4G0jGPu
	dDldhBVxoJP7elkjYynzsquytMgupZk1D/o0+y+/TiD1Xf/nVXLUCqiW/giroO1t4M9ei/IZgiK
	OtgKvBLEbxcPw58o6U835kC03ZSmRWFRsm8pDx9AawI6zXqxYWa3/FFLuFQ6Fep7aWlcR9ckoqV
	HdEjE5USpy0dxhoCmFOPzZWSECLGlD3W4rJxk7BxKqdaFnK
X-Received: by 2002:a05:690c:c604:b0:821:1288:f820 with SMTP id 00721157ae682-84c95591347mr57984377b3.4.1787581561128;
        Mon, 24 Aug 2026 07:26:01 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84ca68c1b14sm34720667b3.21.2026.08.24.07.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:26:00 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:25:56 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>, 
    Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
    Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <ryncsn@gmail.com>, 
    Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
    Leonardo Bras <leobras.c@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
    Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 14/25] mm/fbatch: no lru_add_drain() nor _all() for
 memfd_wait_for_pins()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <4bad9833-60f5-30fd-098f-3a306722833d@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

memfd_tag_pins() used lru_add_drain(), memfd_wait_for_pins() then used
lru_add_drain_all(): remove those calls, no longer useful now that the
per-cpu fbatch references are gone.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/memfd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index c708d92533f4..064f24dcddaa 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -40,8 +40,6 @@ static void memfd_tag_pins(struct xa_state *xas)
 	struct folio *folio;
 	int latency = 0;
 
-	lru_add_drain();
-
 	xas_lock_irq(xas);
 	xas_for_each(xas, folio, ULONG_MAX) {
 		if (!xa_is_value(folio) && memfd_folio_has_extra_refs(folio))
@@ -168,9 +166,7 @@ static int memfd_wait_for_pins(struct address_space *mapping)
 		if (!xas_marked(&xas, MEMFD_TAG_PINNED))
 			break;
 
-		if (!scan)
-			lru_add_drain_all();
-		else if (schedule_timeout_killable((HZ << scan) / 200))
+		if (scan && schedule_timeout_killable((HZ << scan) / 200))
 			scan = LAST_SCAN;
 
 		xas_set(&xas, 0);
-- 
2.51.0

