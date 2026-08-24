Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0161143B4B3
	for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 14:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582516; cv=none; b=m/0I69yl59Y87XYySuadWPxcdeSBS4t8Kbrzvu+cn4kklXQOM921F3RHgJHiv+cE+vcLvdO1NkgeElArHdgNWEUloNPIQFvMZDL1ZMpStKEkZ1/iMmwP/ptDxx9FPRKB/aaXU/TFnr7KfQffKH7g6jCxFTYO8fXw18jGdeAPZt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582516; c=relaxed/simple;
	bh=PA7/Pbx5AEThbU1dExwqFT9w9coLuAoGrR7Ue2+wOTE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=neaX4My/JIRhhhZEPzMw8Tmh4wiXraBaqidOg5WBSYkzh9g/yNreXfMKImk9RCcEPuBEUkgNAUqlaFXQcHmNjEi1rDERBuDky9qhMXDmYQ1tUXOz4SMgWPTToTUS87nBytLeKLrv58ND2qpCT9YHx7rDa8vdrlK7iWoTr8e++zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rcFBr73Y; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rcFBr73Y"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66cf1f9965dso2248873d50.1
        for <linux-block@vger.kernel.org>; Mon, 24 Aug 2026 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787582514; x=1788187314; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tbn1aAX73v4jfLOAScY/xk2YxlfOe4UtWahA1Ug2y2k=;
        b=rcFBr73YIy47nKOwBwDuCgz1JK+wC6/lD6EuW9Isgoigtk5Wwk7ahW30oOmczMv4J8
         Zs2r5rzqFq1Rdw3M+a9FtgKaYDrU0nNN8dxzGWoMtSuOKvsj+McppwvPEHfT6j+6f/kf
         OVVby1pB3/oQ8e+TscMluo4qRb6D43Wnj49aw2VcgXFD1VLCJCsQoesu1IcEXSqM5bRT
         kGxWhiScnSC0h9ug1UZEjOpthm8GS3LE30uHrPDfs4ddXPrxSnIVzyHeHsFc+O39zOW3
         2x77IpHhRCR/Bb6g5YZmnvm9xrlh8drOBetRlA4xh0jh7vM4ClvivDELUUpHhYvzpdTS
         tSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787582514; x=1788187314;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tbn1aAX73v4jfLOAScY/xk2YxlfOe4UtWahA1Ug2y2k=;
        b=FQ7BS/SaAmxbHqgwxaZqDIAVoSEzJUFyat5NlaibOK1FOoKkrqumeO50LqVVe6dQAZ
         uqmlJSyKUmWbvV+QGvDe5enJ5D6+jObO8N4blSs4mdUTa4s9nMzLVte59Y99BHvdqmNT
         ps9LU58vHTEzGH9F7NKZ87VhV4TEbm5Lexe3f/eHlYcugtMIvtv+N3F46DQoC9MslTi1
         fhU2SqJnngdH21/aE+oS3rkM1c57vgEdWEr04kUeonuLns42fuP6XrOQQEoLEbKAIAb/
         +JYOVL3FuTxMZshA2PaaAYoYKogg22O1yIv858o0242oLj4VVTKTXvVb4N/IxHCyDJCV
         AjOA==
X-Forwarded-Encrypted: i=1; AHgh+RoESDbBk002wtDUYTr6EW+A61PubRIiOswP5+J/cpOtJxty/o5+5CQkFYSh0wKMymny6smU/6cEdxhdcg==@vger.kernel.org
X-Gm-Message-State: AFuF++k7obwOBqluL8RogpTqMbTiF1zFu1uRH9rOORc+YUM6U06C3imo
	bvdN57i8xQ89OJkQ6YsWYbVuZKuBu/1l6tUMuPvaRSD6c6iXpqNdyQc6WDTB6ePRqA==
X-Gm-Gg: AR+sD10M6umVHwgAKH3RxnTb01xxTdxJ8WjVtvPZ6Pm90H6THHwR2DEBMcuI1m5MRNk
	msQT8lOo0oR9f2ZHFGzydGOZSJLPRcxloX9RsZVNpWBlvCIkiLsXn+l2JtXeb7v0eGo/6ZnLA2z
	slxs5WTY5vInjzw6gSKkIRON2cKv/QrtlqEMk6kRFfuDgl/cLoIa2Y4saCGuj7yMy8oqsojN45g
	O8yM+JB+cJFAu/LOTx01vvLnlssfAGGJP6acX+fyCeB8vdo+WE2FJE2kXwrZ8TbzTgEbhKsk5FT
	Fa6br4E5VoxstcAS7ymQqhDBa7QrbfmXL1bXn5AnGrhK1qb7IjPMP5R29UVdDPXxxE0fwzQ1I3f
	Z7T6AUHw1mSPKlFQO1PR0ExxxWWfMWwYDvOdHKXR7wBFL7H1pY9yGhD0LoT3FOXloMBGWsWXG3J
	lgTL3iCJNwmxITUj1JMnqHGWbWPNRLvz8HAEbD2nuR5U7V5U1KRwyPsAfSxk1OYqXi2UeMuJYPZ
	+omQETmIMyIml3c1sip5ThDYpczIWgUh/8ndg83WffMFXMSQroq6Ba6ZMs=
X-Received: by 2002:a05:690e:7b1:b0:667:cf87:5838 with SMTP id 956f58d0204a3-66cf222e93amr4903896d50.25.1787582512262;
        Mon, 24 Aug 2026 07:41:52 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84caabb8b35sm34455727b3.27.2026.08.24.07.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:41:51 -0700 (PDT)
Date: Mon, 24 Aug 2026 07:41:46 -0700 (PDT)
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
Subject: [PATCH 21/25] block/fbatch: no lru_add_drain_all() in
 invalidate_bdev()
In-Reply-To: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Message-ID: <8facb079-aa8a-2973-4882-173e7d06ac07@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

invalidate_bdev() has no good reason to lru_add_drain_all(), now that the
per-cpu fbatch references are gone; but keep doing invalidate_bh_lrus().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 block/bdev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index cd8323083740..853545b29b7f 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -97,7 +97,6 @@ void invalidate_bdev(struct block_device *bdev)
 
 	if (mapping->nrpages) {
 		invalidate_bh_lrus();
-		lru_add_drain_all();	/* make sure all lru add caches are flushed */
 		invalidate_mapping_pages(mapping, 0, -1);
 	}
 }
-- 
2.51.0

