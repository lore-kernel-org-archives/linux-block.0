Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A5F4915AA
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 10:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949233; cv=none; b=E4USlDuAebk3k6BShaev60HDYK3MY+L5LPJLZkKyzDkETFud74Jf1//wNCaw+iZUFyNoRE9kbylG8Oyz8qcXmCUiq92vEAnXGCQG7gVDZHlFp6O62c2w2WQVXP5+OFxGLn5Vt0KCoJbXlWGEIebVd9RL3cWSbp8MjF0tTHPfFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949233; c=relaxed/simple;
	bh=rPfdB3AFtBKPw/1Uy2omaI9Rtdatgf/EWcjp6PUwumw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RyPE5fAC3z+fUa+2sR+KFHJCOQTqaVbq8Too2k1GV41YPeAh2jhhVEcXNzDlQ9F2Wzs9dDHwygvBa2SWNxo/TEYRuMcxXEkknGaQ4dP7HKv5kvkT/cCT8CasdnY6CjoeR7fF+7GdOhtbB1/da5kvNdrjQueSiIotsM+NaOukpZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tT9Fz2UG; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tT9Fz2UG"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-85a50f6a7f7so78076107b3.2
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788949231; x=1789554031; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4U3+AfBAvn6B1ULZHKx9lvgAuWRYBVO83SclUxbDGr8=;
        b=tT9Fz2UGnxETlTmbyHAwZYaiPWS5B0cx5KG3uw+zIkiDXB4fxFV8HteHjg1CMJvcNE
         9Bv0QNlYapPVNxSE1zPdcr2zLNj/dQrH48dgU4rjjuv8PSeMBv3uc3+aKfxjwcnAFTTx
         Frgio4lW8raBbVZkfM5QT2i9GZaj2Miey2MReEoWuQfgvVOa9CsxC/HeLX0MzmYlWq06
         IGFKtqqJMntut2fy7aSV8czLI24+O+PB5sKQxQxtcI+Ge3ATfkB+jB1htGM7dGQPG2vS
         vn9BkOnMOIGre7A5K/55B2TwyQQA65k8AFHVQIpF/B1FUOiztBt1LXVQZ9BBca79zezB
         5L7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788949231; x=1789554031;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4U3+AfBAvn6B1ULZHKx9lvgAuWRYBVO83SclUxbDGr8=;
        b=Etq2ma0mc0TWuWLbAemhkPjRPkmnRLi0eurm7WpNOY+aKOz8GTykrUIeg992d4lHME
         qv+CCv7qFc8fA3EV9Sz4XlLvfdozThXcmyyG/n5nJr7JN1isx6NLi3P/bOXJAK786Qkv
         aCvcSnaNxaCBT6UDhHz87fmviCvAR+x/Fh494Lup+/RoanJnG8pzlvgMtE5nX6ONpvEf
         wF/RrSEx/AC6+HoEdsvz0EMCQBF3LxHXKhMXGdRiglNYSMfiv0XsJsp41esJi1MQZgpN
         mtlT/vW+JEeaF8oz5eAEZl8/DCts73nQQwa/WXRmr9Ch+mO1IRkpxEtFrqsNPHhqJJh4
         voGw==
X-Forwarded-Encrypted: i=1; AKwUvByLQAf78onKHgZO/ddzUBJskkLZd7smQi59JNS1kkWQApOrihUMcXgX1TCNb2LUgdOyEKyILLzLOFLZVw==@vger.kernel.org
X-Gm-Message-State: AFuF++lH9960ULa5sSRhVZF/OQEV/IYWzZgeQ9Tc6MjFdjrBVJIV3n1X
	I3k+jsk2aHYU983g74kuwOHIPOlOYxAVqxr4c0PU/i6s9qCSDIEkQslrEZ03k57xRg==
X-Gm-Gg: AYBFou2mgjUMAH+IO6rufCQz9+ZvwWMIIEovk9h2w4p+LW3aAgiOpQ5Xr1u1y0Ce53N
	bgEc57MsVeDkf3QLJ42UwOEDht0OT4o2KEJVT1CSqzWqu0ifhJbemRoLoEKitsCnXYnD8UBQKg5
	x+rk7QLorwnfx0IbnLhfGGl2S3iI+zCd3P9oy5Y/II6xqJjlnKu+iTMnlUK/Fje3Rkmc3It8LOr
	lngo2Cnc2l0AhmTtQsa3OXPDZp8+4PoOijw6hpH94LoSWFlHg7OwH85jiLO+TRbe/EdKBy/feL8
	SMBl2ZWe8YkUPlotI5rKaxal4So8v+fm3Rj3vhUzpAon81qXxYfpgFb92GBnRlokLAyIEqeCqMX
	v41EPGdxz+4pwvrj8hBrt4tAgZO9dwEI7WbJz6IO+vl2GNcysz8HKa2FKudyeTz1IZ+7Ku7+SqS
	5kvLU28ughQQf6fZnBJmXBwAEBS0QHqszVFWyXIrxv2OLgto/sjtwGlnQLw36fXW8ERc7i+L5j2
	A8qkIQbdEo/MOPQGJTOrupZsP8SqRGu2+0GX5E3i5rqyotR1Th0NTHs9MU=
X-Received: by 2002:a05:690c:e3ec:b0:877:e47:f399 with SMTP id 00721157ae682-8770e480a9bmr69779907b3.23.1788949230466;
        Wed, 09 Sep 2026 03:20:30 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714a0b6179sm106432667b3.23.2026.09.09.03.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 03:20:29 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:20:24 -0700 (PDT)
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
Subject: [PATCH v2 19/26] mm/fbatch: vm/stat_refresh include lru_add_drain()
 on each cpu
In-Reply-To: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Message-ID: <48e09d89-27d7-60cb-a0ef-d2a5ea74d90f@google.com>
References: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Reading or writing /proc/sys/vm/stat_refresh has long been a way for
testing to force an immediate refresh of /proc/vmstat numbers: it seems
appropriate that it should also call lru_add_drain() on each cpu that it
visits, before collecting that processor's diffs.

Add that in refresh_vm_stats(). I wanted it in refresh_cpu_vm_stats(),
which would include it in the regular (default HZ) vmstat_update() too:
which might be a wise precaution when proposing to eliminate almost all
the old calls to lru_add_drain_all(). However, that would go against its
"strives to only access node local memory" cacheline care, and bring it
into lruvec lock contention: which would probably displease its authors.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/vmstat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index cb57714539fb..d66cb67f55ce 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1990,6 +1990,7 @@ static int vmstat_late_init_done;
 #ifdef CONFIG_PROC_FS
 static void refresh_vm_stats(struct work_struct *work)
 {
+	lru_add_drain();
 	refresh_cpu_vm_stats(true);
 }
 
-- 
2.51.0

