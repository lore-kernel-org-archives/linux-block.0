Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85DF429023
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582225; cv=none; b=Bqk7mt4h0Vx/xwLcMkYnnPQ7dv+bXKiJvNNFTAtG9HeOXgCyfXqyqfyJ/SmrW6pIiHLEJCnSLy1pshhTzJZU0RvtM50/ui1ZFn2MOwHp3Ara5quQv/7QBsXJBCeo5VQEU1ajSAELaeRHmww15NziPoKJsIGsUsmsC/kZ2mIBOog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582225; c=relaxed/simple;
	bh=1YRYVGkuKNtQk+ObMqK/890RkRJk46OHbYzz71c/FoY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=skTAz/xT5vNaajjXPeYvS7sT/2g4ZD00+yGCXuxaEPa2oBwtlMfg3UrGnCOWXHIX9XcCVh0oFvI8VFY+5nA4xEVRXXx/N6ZbLuXq2r42b/UMxKGJ0pz7xQsnDjoDr6TiuxMQ77EYyGul/2KGxZimJJAMSgnJGNRgsXRDaZcj2JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CpoTD5X2; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CpoTD5X2"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-669944f60b3so4040762d50.1
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787582222; x=1788187022; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dFFCpD+eyjMYiOlaAWIMnRn59i/x4sm2LgO1kNi90A0=;
        b=CpoTD5X2Yap6uyOE19vYISXLZLUPaFug+oYxYnFCxjdDvc/IoO+SW/2rh9+xSgQaCo
         MxsDfnJdHR4y4UsTLKJ9tB5Eu3l/k9lwrum05vtjfTL6VFXGra1GIDZWaDJSjrAM6nwj
         aOIzSjO/H69XukuT82R+NGw3hyFDx3YegL7S5PRdlzPOdtEoyB/qTVRrtdGa1MwzAcxh
         H1PNXBt9gLhpHKRMVy8RP/HaVXlhrOHTI2ZXz6NUWxzGW5RulmZ2LrtgJTuYaj4fWNl6
         4RUJpUUkoPUMOzaHzrUOYgmftSCaIQ6reFW+xKhc8L7+qgiEv8+BI4UcNtYj9curBKdR
         T/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582222; x=1788187022;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dFFCpD+eyjMYiOlaAWIMnRn59i/x4sm2LgO1kNi90A0=;
        b=JO34bHsirc+JkcT6DrKbLryREcY/I/ddkJO3YFahkeexbVfaOKDUzrDAatqCy4z+lD
         HpZCZYD5W4WsOdUfHxq+XnYYqnJ/fhC77+ucQSBW9dH3CEGBEFy7ZK9zipP7kMPdrMV7
         azgMSDZQ237G2bpvrrHIv9+ebvggoxf6VyWWJ/LDvLNHwgRTeLy5pjve9IOFafmi9gqn
         wd9cs8axE8uiQ673QsmPMb5GQyRkqr7Iqb4clLQYnOAeVhlXdgIzI+smCmqlOz396HTu
         piVFScqZ+KM0myeZpQ/Y4pL6nXIzsynAoVAbPDZhHReY0t/uAFib/4uhSAaOxbvyRXbB
         mYag==
X-Forwarded-Encrypted: i=1; AHgh+RoHLDMqosN6UjVI/CZZt2TpjaYp72KtK6dWyIw9uqdfvA4+67dhrhacDqG1zAVoxD/Nb+AOyKAhEy+N/A==@vger.kernel.org
X-Gm-Message-State: AFuF++mTV8hz55JoWE+Y8friq2tJ+ywwBN1ZCTgJHObG2JYEE+zSDT21
	AxUUGfh6l7fm9RA85TxtqRrzzrZGIxfUhDsn/tRek8Wu6UE1kHQMMNGlsVLll2k7TQ==
X-Gm-Gg: AR+sD11f7ArSwUrkXLN1Zg3jEkexOir/AsW1d+Xm8fH9WGIbEVeuxfMeoojJUC39cdG
	P2TDgHMVwnBWRfe9OF4C/L/TfmKwl0toXc2UoTLbcM5T9879pqveMRxHY1+hn1K2TaRnRK5rvLj
	zQ9YNlGazAHRixwNfEmKfN/RALxO0OP4TO2qut6qIApcuh2TgoIysgaxswGvF7v0sZ+G9duWsR2
	NOtc+EHuPDMZ36XIrqMTIH/ZNgH93JynDqk352nZleTnFy8aGicP+0gE7s11Fp52jjCVtm5j/T3
	k9U8Y8clGcd54UaJBKl+tORcyTa0kcjadNslzGhwiLz9ezpSN9Gu4mmHexVyFuEY1eewgMHTQaa
	AV7kK0rY7a8JRPFwpYmlhRWEUVQl5BnPk9b7gbL+VRC7I+dQLQbXTqVcuouYgnrizAjMJhZ6HFN
	WOfrPjuXVP9E21RKSGgg4c8lS/dL0cGmFScxID6QGjYtOJ9ZyZhX4/Ky/zcu3euKFSrBu14Aha5
	YOOdGhMnR86YGTIi5kE+fR6easPlZqMqK0AN1jDOSp1g67a
X-Received: by 2002:a05:690e:1309:b0:66d:7b7:e36c with SMTP id 956f58d0204a3-66d07b7ea83mr2357073d50.48.1787582221803;
        Mon, 24 Aug 2026 07:37:01 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66cf46460aesm3729534d50.6.2026.08.24.07.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:37:01 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:36:57 -0700 (PDT)
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
Subject: [PATCH 19/25] mm/fbatch: vm/stat_refresh include lru_add_drain() on
 each cpu
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <509da837-bd5c-2090-d26d-0002fef0b1ac@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
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
index 3b5cb1031f72..0f75488687b5 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1973,6 +1973,7 @@ static int vmstat_late_init_done;
 #ifdef CONFIG_PROC_FS
 static void refresh_vm_stats(struct work_struct *work)
 {
+	lru_add_drain();
 	refresh_cpu_vm_stats(true);
 }
 
-- 
2.51.0

