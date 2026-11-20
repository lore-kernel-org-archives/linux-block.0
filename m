Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795139080;
	b=V+/k6r/JvMXHBdLKpxUgpW2SIvGggl7d3Yk5npFRk80byp/tpvTqvtuWIAQl2DsSBKPl
	 hVYziMpUP4eEyxxO9CD+Kwi669YNk3qoul7MWt3Naia4fgJdSZtMxnOwxhGS92nKoxxFH
	 eKPXGl/58UTYO/kjm5eLWI91y6lOWzKKH7oixhND5HM+XBwxFZINlRA7RDwbIV8mjlk9v
	 DxLZOZLpwOV3llsQI8JyK1MRJ19ScIiXKthy910hrQOv4EVUWOPHzAnqj+H+Pxc7ZqVBi
	 +HVerSYrqoGLx1A6E59NO6e3PEJ776e1nN5FrTOwDwepIjyKrCflogYtUfhW3eaw3uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795139080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jaTemiemWt/IbS6IRMeW1LosBwcuSLA0MnPohXWgKzg=;
	b=khPs7Wpb6p5/YJxc6xUslCCpTND8bhQQUwyrmsORqq68gId4JnuRLRx5WEyhYajFpnf9
	 nlaPFtvvU7MCfadXLsFLO9WNXJGACdyqSMaxyErdpjab/gwEe6+1ZBQvr7juDGjnOWxbg
	 VbI6T/SgRoGvGinli7j/gCSvEhtUUJDCfEppf685n48GGSfWkLkdTKblcoQxD+YItK1dT
	 IEyRjuq1TjOHVmLi+0GV5qfoIkIWAAeJXVLMAg+pdL0aFSQ3XyXP2uHdd0GsZsijrCr6m
	 pRTgmf6/U1+11EEyxhdMzn5lOYRxR7PYHEt5FkF/+8KBkIsEMXUxFzms30HafvrjB8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Dd+BDwPq;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DCE606A320
	for <linux-block@vger.kernel.org>; Fri, 20 Nov 2026 01:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7DCE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=Dd+BDwPq
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ed0890476fso2148285ad.0
        for <linux-block@vger.kernel.org>; Thu, 19 Nov 2026 17:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795139079; x=1795743879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jaTemiemWt/IbS6IRMeW1LosBwcuSLA0MnPohXWgKzg=;
        b=Dd+BDwPqbIgR4ya3hCngtZjcDoEKk5m2YHJPkCbALrqdsCOleSad/oryqy3Zjf0YzM
         8NyFz6smG9C1lWban+2plE8UUNEKwZJp2NjZbMjStUtWIdfB1pp3Dni1IbEPHUUrGO5o
         wYz5sLGefZ315Fs7fB7Z4FISkunINvIB5+WBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795139079; x=1795743879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jaTemiemWt/IbS6IRMeW1LosBwcuSLA0MnPohXWgKzg=;
        b=JknXenknXF7ek+1+kMR0kLAzkgqRtXRygNaqMpjNBS9cPmGAL41dURNU4V5r5fobUR
         qE+nmlSgh/llyDI5fvesk9T2n/bFFdiLigbpEY1ZN8cI1OpAEBbfbF6K30o1tk84eO0n
         MsJ8bOyCW/095yMKd80ebtkWs8IlRNfzEVAACjkrYEJmf9u12r9pDG1PcFVo744SFaWC
         xiv9FsCxbYDBS/2eRt8zhuzs2MturpCbkl/594FTZsYwrk0OD1CfsHp6SmRvrfLuRBDw
         Uo4zfHBIyA7yQOSlXv7yBbdrq3Q93Z/IDP9hqJcrYYztEkVhsWOGgcTBN6lnzwPdNlfH
         navQ==
X-Forwarded-Encrypted: i=1; AL+hErHF/y9c3BUGTtP1Dwms4GdiN8DjFgCTtFCXH0P6Dw9QvruQKtBfdVr8prTvODtPT339j3MmEg4NDDv6Ow==@vger.kernel.org
X-Gm-Message-State: APuU4Z8rWywJgrNW68gzBpPJmOrG3UxCDBq0Od+YiNPIOMip5Rnef6q4
	Tr/py9iUfX0r0CI+8NvD53pmBbCbVh4A6Kk7eSy9NM/S9Qi9mLFIgcCOomwfkSSh/g==
X-Gm-Gg: AZFdTZe/aRDMIMPKbttkXdGWK3e/sGfjBzdI+dvoo1a1b10cebG3xsNAtN+kym1kM6h
	7dm4yFH7NYPUNDiKWfjSqn+x1Hdfgqm4Lal919/Q7+JiQvmkYffIU5luqUAY5GT5DW0G38QWLGa
	4M/+1Vltr7lGE2Xce8MS0eb0ShtPuwczG0jj+JFHLUQVYP00YNi4JOB6p6e4lGZFpBokXajmZFv
	37OMhcAVq2pXk4KydSK9Tw5UwgBnUW72EcQXVcpqlKDhm+b2f8jnMABCMCWQNU90nRDy/rr1PTG
	TrsrHw8RnqmVhVoItlotc5TogvqvFaGUO0w548BHtNUTHLf67b1ZPlmIeGv/Pz5KCg4IrdFoaQF
	trj/PnOs76xy43e431oVK91LMrlsFiRyMiQeV1yTxOTbL6P6fkI4BF0DYX3EqmlMZ3VPRg8Fhj5
	caTB29QvRpOdvNdsDtqut+y3fSEpVfMA7e9goQ4f9grwHiFWe19THbfG8eIix2CJkQ5EAa9I95C
	hLz7AI0bDt0I1Z7e7IC6ip0xlhr07bEWUq5R9RPC0DQDjpKgKvePC9Q8whLH9Xz2rqjQScUL3+I
	viWFbZ3dRGmohCNiSxZ2fx/wvi8VejXjwkyrBdF1djI6BA8AktDmQ4bBdZs+EarmWQQHoOxlZIx
	uYRvvZM8n6d9Mz74=
X-Received: by 2002:a17:903:2f87:b0:2ef:df75:337b with SMTP id d9443c01a7336-2f03f246f17mr17438555ad.48.1795139079121;
        Thu, 19 Nov 2026 17:44:39 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:d5a5:46fe:fd42:7b73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84294sm6793145ad.9.2026.11.19.17.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 17:44:38 -0800 (PST)
Date: Fri, 20 Nov 2026 10:44:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Hongfeng Chen <chenhongfeng0212@gmail.com>, 
	Nhat Pham <nphamcs@gmail.com>, Hongfeng Chen <chenhongfeng0212@163.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Barry Song <baohua@kernel.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jens Axboe <axboe@kernel.dk>, 
	Johannes Weiner <hannes@cmpxchg.org>, Minchan Kim <minchan@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosry@kernel.org>, 
	Wenchao Hao <haowenchao@xiaomi.com>, Wenchao Hao <haowenchao22@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Hongfeng Chen <hongfengchen@xiaomi.com>
Subject: Re: [RFC PATCH v4 0/2] mm/zsmalloc: defer object free to per-cpu
 batches
Message-ID: <av-ltJooUJ0lqvqa@google.com>
References: <20261016120927.3191690-1-hongfengchen@xiaomi.com>
 <20261023123736.1542117-1-chenhongfeng0212@163.com>
 <CAKEwX=M4jTnxmq6cj115Gw4u5jdY7Ex65jPtVTEopW70jGzfuQ@mail.gmail.com>
 <20261109105957.2577351-1-chenhongfeng0212@gmail.com>
 <av6JvaCh358eSMCw@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av6JvaCh358eSMCw@google.com>

On (26/11/19 14:35), Sergey Senozhatsky wrote:
> On (26/11/09 18:59), Hongfeng Chen wrote:
> > On Fri, Oct 23, 2026 at 11:19 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > > Is there any more juice we can squeeze from zsmalloc in that case?
> > >
> > > It would be nice if you can perf zsmalloc freeing. And yeah, maybe we
> > > can't optimize any further, but let's eliminate that first before we
> > > rely on offloading.
> > 
> > Here is the perf breakdown of the free path:
> > 
> > zram:
> > 
> >   __swap_cluster_free_entries        90.28%
> >     zram_slot_free_notify            86.01%
> >       slot_free                      74.15%
> >         zs_free                      56.01%
> >           __free_frozen_pages        19.85%
> >           kmem_cache_free            10.15%
> >           _raw_spin_lock              5.53%
> >           fix_fullness_group          3.31%
> >           dec_zone_page_state         2.43%
> >           obj_free                    2.17%
> >           trylock_zspage              2.12%
> 
> We removed one of kmem_cache_free() from zs_free() [1].
> 
> [1] https://lore.kernel.org/linux-kernel/20261110054836.1515030-1-senozhatsky@chromium.org

I suppose we can batch some operations in zs_free(), something like
this:

---

 mm/zsmalloc.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 4a6ec43f418b..e0083962e4d3 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -43,6 +43,7 @@
 #include <linux/debugfs.h>
 #include <linux/zsmalloc.h>
 #include <linux/fs.h>
+#include <linux/folio_batch.h>
 #include <linux/workqueue.h>
 #include "zpdesc.h"
 
@@ -891,21 +892,39 @@ static int trylock_zspage(struct zspage *zspage)
 static inline void __free_zspage_lockless(struct zspage *zspage)
 {
 	struct zpdesc *zpdesc, *next;
+	struct folio_batch fbatch;
+	struct zone *zone = NULL;
+	int nr = 0;
 
 	VM_BUG_ON(get_zspage_inuse(zspage));
 	VM_BUG_ON(zspage->fullness != ZS_INUSE_RATIO_0);
+	BUILD_BUG_ON(ZS_MAX_PAGES_PER_ZSPAGE > FOLIO_BATCH_SIZE);
 
+	folio_batch_init(&fbatch);
 	next = zpdesc = get_first_zpdesc(zspage);
 	do {
 		VM_BUG_ON_PAGE(!zpdesc_is_locked(zpdesc), zpdesc_page(zpdesc));
 		next = get_next_zpdesc(zpdesc);
 		reset_zpdesc(zpdesc);
 		zpdesc_unlock(zpdesc);
-		zpdesc_dec_zone_page_state(zpdesc);
-		zpdesc_put(zpdesc);
+
+		/* NR_ZSPAGES is per zone: one update per run of same-zone pages */
+		if (zpdesc_zone(zpdesc) != zone) {
+			if (nr)
+				mod_zone_page_state(zone, NR_ZSPAGES, -nr);
+			zone = zpdesc_zone(zpdesc);
+			nr = 0;
+		}
+		nr++;
+
+		/* Free all pages of the zspage in one go, see folios_put() */
+		folio_batch_add(&fbatch, zpdesc_folio(zpdesc));
 		zpdesc = next;
 	} while (zpdesc != NULL);
 
+	mod_zone_page_state(zone, NR_ZSPAGES, -nr);
+	folios_put(&fbatch);
+
 	cache_free_zspage(zspage);
 }
 
-- 
2.56.1.750.gf70dc682cf-goog

