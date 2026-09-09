Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A544FECC7
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949670; cv=none; b=TFQCZ/2rtcI9PRbzZoawrV0JHNFVj9aRg7EGLn6SiBgvgrhJJ9sNZZlefUsl7yX1qnbLd10mB8WG1okMTGOxv9H6tIfxHKebyRBt7elVpYDtViVfmZJTliGdPv+Sy2Fb/hwicVcVd28X4UqnAk3bdhL0n/lJtPRZ2C3k6QpVAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949670; c=relaxed/simple;
	bh=apGggQcJp2WV1URiHg8Asmh4iwaxGu1pF3vH60oXvTw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iYBJDWlP2xSWjHVFa+03pjP/bskRt9bgBvdahuBHDGrpyggh3fIMWiaSxkkxO0RfRVXI9peL3uoFYtNKhgAOjNycdTE5PwwnCkolL+DmStNyBqxlvP4oWg1uWC5Hkfg8P3zExwYTCzk88IuPwLfe1YXWQbTgbqIzISn1rP5zOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GxGDP+Z6; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxGDP+Z6"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66fb8a78ad2so6962785d50.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 03:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788949667; x=1789554467; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0mZ5Gk4/1Pu5bK3S+WjW2BlP4j/qxWTHvLM7mSgUCfk=;
        b=GxGDP+Z6oWxTSLrBtRAZa+DEityV8+saaWCj3GSm6C/hkO9ldhEfZILDAbNdoqixva
         J6c3/yfN3eNLcBhTKVSm/yaIjiQDK5sH06oFIzpl1p4Y0mVY7WnZZDXRbJAXU8kgmYk9
         A86jXkrLjNjN1LhmOCmobsBWYi/oJ+prJgffhPv4HaVxTmB2IMeTef1ZfZgriVtyAywV
         pA974nCln5Fv0zd59QRdRhjQ3+Jw7i2HwnCcUIMyKfKwLKG98Yg3z9RRTinyEpzcCW+X
         FOuutXxJfgEEA4ZsOziq+sniLVIoimIma1ZCtnS+HrK5T5Im3FwHtWt7fl7fmKA1Ai1e
         PISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788949667; x=1789554467;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0mZ5Gk4/1Pu5bK3S+WjW2BlP4j/qxWTHvLM7mSgUCfk=;
        b=ez+LFMIdX2AOG+3owxXJrgofRY9Do1ZJu5/kuJ+Et6+k0v6tXJWl/8tXZj+/YUTyJ4
         bKo2/yvIWnR3Ui/PLHAL8vBOcoiUXlfJRbl3OEuNMCt6RE7h7XbFU4E0ZB/9hQPxTqBQ
         kfG5wlHC+BFLmwcFHNBX80y78jqM1++PjZ5zAtVB3n7d0rmElIqh+jtFp6UIBq9ne16T
         avTTQmddWsHLriZiATAXmPKAo23AcZYSO5BeExIBlFHDH34FFMlppcW7Sx3eBulJ1XeW
         aDdggXQVZlioJQeFCU+UF/ifo/lcPC58k8TS7eGCU/FJrkqTFs7AdsZJtW8ISCoqeVhk
         WG4g==
X-Forwarded-Encrypted: i=1; AKwUvBxB6+dn9K2EweEIBGgg8ywULjvWNj+q3xPrFOHLd5gS/Dax91uDIxSIHzb5/2uucR0nI6ffvXNo3y4xyA==@vger.kernel.org
X-Gm-Message-State: AFuF++lKAId+KU1Ot3nU40OgMcZl9WhLcLpTHSRhHghmZ/IaRIm1fPqY
	W1wQ/S9NCeBUQJ3tvKvibcm7VXAnJ2gh/P9k2WW/L4dOTY8qgYIE9wTSiMDH7fX+Yw==
X-Gm-Gg: AYBFou2qdX0Z95wPWOKGuy6z2cKPlgO6E78KmGDEdLsqNoIMxrxdJXTSoyD419MnLAO
	4aXxHBbgtpjrxXY3+hy9ATqu2bO0jfv4m+uFBV0FwSQ0x2ySbVuxKjriI7sqonXkBPzF3LaytoI
	kExc1Sw1JplbmilY9hkNQ6Hc5VBtvkaI5IMzNclIe//nWxpK71v+pXFEnnM75OcfviSIMpCzQVH
	ARxD9we0TVzvgrRGozECxFDqtCLKAS2H4WK9wgPjFlyhw1wHRhLSFDmf4P9kyfj7JuUkC+/a8qi
	GxYkcC9SLdrNmLu/uxogW5foCZo1Vg78Ril+oDx4u/stRGsMP3KrIVGnfS1KIezKIQE2wkuo+rc
	z/nX5GO5n9AqZJPdacaXl9D22/EF7bdxDUBhC6BV2fvplKx7a3/l6gsopbc8Swww9VoWUblysvA
	Nie3kvq85HuYN0gC3hLqjHbyqZnQ7CNGu1NgSIngDhmWv4rwb7YocqU/ATqZK7GPSPnS0vrjB8v
	swaU7aAyO3P0Qwen0XZhcu5AWL+WTzedDNOYLsUMu1vHXs7wjGmzNY7MAwA8mpUi/5KUw==
X-Received: by 2002:a05:690e:48b:b0:66f:c1bc:4097 with SMTP id 956f58d0204a3-66fc1bc4874mr7597179d50.90.1788949666224;
        Wed, 09 Sep 2026 03:27:46 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-670febedc44sm2584559d50.11.2026.09.09.03.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:27:45 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:27:41 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
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
Subject: [PATCH v2 22/26] fs/fbatch: drop_caches invalidate_bh_lrus() not
 lru_add_drain_all()
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <75e9b5b0-6a70-06df-ba0e-4d7bf841c0cf@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

drop_caches has no good reason to lru_add_drain_all(), now that the
per-cpu fbatch references are gone; but it may have good reason to
do the invalidate_bh_lrus() part of it.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/drop_caches.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 49f56a598ecb..054af78e6a2e 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -10,7 +10,7 @@
 #include <linux/writeback.h>
 #include <linux/sysctl.h>
 #include <linux/gfp.h>
-#include <linux/swap.h>
+#include <linux/buffer_head.h>
 #include "internal.h"
 
 /* A global variable is a bit ugly, but it keeps the code simple */
@@ -60,7 +60,7 @@ static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
 		static int stfu;
 
 		if (sysctl_drop_caches & 1) {
-			lru_add_drain_all();
+			invalidate_bh_lrus();
 			iterate_supers(drop_pagecache_sb, NULL);
 			count_vm_event(DROP_PAGECACHE);
 		}
-- 
2.51.0

