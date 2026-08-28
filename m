Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD3937C11C
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 22:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787954569; cv=none; b=Mcw1+rmGAHaPEo89UPSsN//pfe/PWdSd19eTws/nGE3rhwOTgAqnoaPTSxVGNMcWCO14ARHyUtOqSxNejedFgraZkZ54ekV/B6mdtyHsgzJ3vx/+IYrsBPUV2LBYM6NSSBVBbjhuiokd9zk3pUTdL7HvKaHB7S6P9XzVqBEloWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787954569; c=relaxed/simple;
	bh=C0Lc/ScTW7fF2d+eNiSG940ybJdGv1UZt4Xd8+iuGxI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=PhOyxEuSI13AXeVjIc+ydmRaz9dapZtBVLxs+HNtKc+H0IZyeu8xsHrerdEq/HyQ0mcjsH+vz0USfUEPoSORPAWdOcfJIlSGwcTeOVvBIL/unirArFemtKmP6yuSL+w2MhxdxWmqMl/H9l2YKjsMdV86XsQ9UJtifeF6IBIe+38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sBC4WQoY; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sBC4WQoY"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-836c5b01e82so23501577b3.0
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 15:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787954567; x=1788559367; darn=vger.kernel.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wA8fy7HWE3V3WB6sMl8dDfF3ITuMIwqNn0Xomqm4doc=;
        b=sBC4WQoYs8GQSIqimBn8xzQ315Fj59wL2qQoiJrY4J0oixs3aZurBXDzqF5rEbHomu
         /U95D8YuGC2LCu8vX5bpSEVtk74AkfzfUodToAB01mxvf2aINgs98KINPjXUlv9C5zBP
         mgn1IqdMgSmeThjr9DN8n0tIBYZAHp58WpR14Ada7H5rPe7Mvs5tIhTyP41achStTj7Q
         RMc9+mL2P/JnPqgeSROTpULhMSMjy1shj7gCB4XNYSnN+HmyozK3WJHbmbJMODYM2ZRS
         HYLD4K1gYxrcLGG4zNOMGx8XQzTyPPSm1TJyDATXw8BnhU0hdlgfLMfHt7cnFr6jCF8Z
         4IJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787954567; x=1788559367;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wA8fy7HWE3V3WB6sMl8dDfF3ITuMIwqNn0Xomqm4doc=;
        b=hPCj120OhKMkDKHqj/HZLDaiz1UMEYWh2Ib71/nYRx0LDTiEXZohgDyTBLe9dkXMDE
         ogwrL4vNzNMOK4PqPj4zFOaDk52IXlNMfWPQVb6C2UOHIFGEPPph136mDJemXmBsB1wp
         9JsjVPT0kEEJ+HPanzDg5ic0rbK0Mrfxg1xgnddxoNZGDR7iMCQg+nwudI1FwQsCt+g0
         d5Nxvz/KBN8GmIYlN9xC4/IIJL9Ysr01g3ptUrnQPCY8JkofxUtxTQeNh9JwiSU+0ID7
         OnDkGJVmPK2nrepvI4SgyoJSiVEKwU2dmdaUoPrN5WjwiVCRuhmoX5rv7BBN75tPamFh
         NBaw==
X-Forwarded-Encrypted: i=1; AKwUvBzz7ySyOqGgggcPX6RYL8nzTzeXwJYr3mLBxf3QJl15RIFPaQxpotDs5Fr3xoKjD4H4qwY7ZTyx0aH1uw==@vger.kernel.org
X-Gm-Message-State: AFuF++m/3lLcJjH0rlTQr5ZaRKRM0HWyJYVqheNL9b3dfceZxxh79HDD
	/fQJyLQwANTF+cfl7zqZ4NWfb3JznNS4qNnSftU9OAR+vjRRKRnNtfnk8lHFBJnuQQ==
X-Gm-Gg: AYBFou388GPgrOkUp48+SIriksWLBgOH/b8U3SwaNfCr7jKO/VoYkSBNA3nk9FvXduz
	+VkIOLMQpyrJUZzYlK4CtsiwwoHPfOanpToFFB16l874nBS9S80lkNgiimUbsJdUr236rv6ja8P
	o2bp8qlJ7rBuE56FTQx25hxi4NSqHpnvfYkPN7M8gunU3xt4mdndBBmI2tEimXzYaKqFnHFDMFv
	b04qrEIAgDODyxCMwqi2XyEvH1kA/L32oN75fO+Ghg7zveh+2qdO5bByV0iR6iF+qxrlU490YJG
	g82r+5Fa3Gf3uVDaQ5henfGbfnICvWgi/9cTepU2qiY461U5O1kVw4CSMUWfWDtORfsF23DD229
	FPsKAVLtGjaQA5Zup+YQTEpwmIAbLHk38XZ2cyHV8kzkn0ThYPg1kHr6D0G0sQutRL9RwiVaJTG
	BN9Ou5u9jKyuCIW9oP6SPK695mf43nAC7Ovj9CFx9ZUroRx1DgCSRDcok2aVOVocmAjvU+KkAM8
	PAQ4QnIl+mWEtuPUtpOar2oyrjg8aY01L7iVREcbwyUtwzt
X-Received: by 2002:a05:690c:692:b0:84c:6169:49f4 with SMTP id 00721157ae682-85d6a3d835emr43441127b3.19.1787954565878;
        Fri, 28 Aug 2026 15:02:45 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e66abaf31sm12814067b3.35.2026.08.28.15.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 15:02:45 -0700 (PDT)
Date: Fri, 28 Aug 2026 15:02:01 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, David Hildenbrand <david@kernel.org>, 
    JP Kobryn <jp.kobryn@linux.dev>, Jan Kara <jack@suse.cz>, 
    Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
    Kairui Song <ryncsn@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, 
    Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>, 
    Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, 
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
Subject: Re: [PATCH 20/25] s390/fbatch: no lru_add_drain_all() in
 s390_wiggle_split_folio()
In-Reply-To: <20260828170217.324c3445@p-imbrenda>
Message-ID: <ef4081a0-908d-bdad-4e6a-91c4c8b20130@google.com>
References: <14a16945-529b-8bc0-ab38-3ea97e54e223@google.com> <7bf68e7b-f88c-6ca9-39ab-e9fedab0c8be@google.com> <20260826155722.0198d3ce@p-imbrenda> <2319f670-fe0b-f032-c0dc-486cbec0f3e1@google.com> <20260827145502.2fb4505b@p-imbrenda>
 <cdbaa4ff-d2b3-34bf-dd41-01fdc65edebe@google.com> <20260828170217.324c3445@p-imbrenda>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Aug 2026, Claudio Imbrenda wrote:
...
> 
> so if I understand correctly, with this series the LRU caches
> will never hold extra references (as in refcount) on pages anymore,
> therefore calling lru_add_drain_all() will never decrease the refcount
> on any of the pages that are in any of the LRU caches

You understand correctly.

Though just before hitting send, I remembered one further detail.

lru_add_drain_all() also invalidates the buffer_head cache on each CPU:
entirely unrelated to mm's fbatches and LRUs, if I understand correctly
it's a genuine LRU cache of blockdev buffer_heads very useful to some
filessystems (e.g. for quick superblock access), which prevent the pages
(folios?) they are attached to from being freed while attached.

My understanding is very poor. but from glancing at the folio-oriented
kvm_s390_pv_make_secure(), I'll guess that you have no need for that
aspect of lru_add_drain_all(). But if you think that you do, then
we can replace your lru_add_drain_all() by an invalidate_bh_lrus()
(like 22/25 does to drop_caches).

> 
> in that case the lru drain can indeed go

Thanks for confirming - but please reconfirm in the light of those
buffer_heads.

Hugh
