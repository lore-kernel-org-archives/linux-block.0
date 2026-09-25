Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348149E5E3
	for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 13:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341248; cv=none; b=qA4Md/eArAZF9g0RkF+GPEvQbNf5M9YrXh2q8+DeP8cPpOxRWL1dS0Cn7eI+nXZjVrw6yD8wm/p7Zl96/KYX6/xBM5UETV9FU1bxUlERqx0xhp2Neg76Fn2cUbAgLzf+LQdxtsxCt7tl43OeND/1cCBZIbcu5A4IoZTISXeuDgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341248; c=relaxed/simple;
	bh=B8ekT+PUp3P7wgce1HzrjF1OT3YV27elGIMsBAW8Yg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nzkLoDJRwdl4aghLElqknF9GyBgxJ8Un6HwcLT9CKE7waVdP3WiY0fK7puKV88sB/sBaaM4hhcnC6ySgFpKrqJnG+gnoeds5KQkiKADr1eB0r32ChKnk8aGaNeMUon+Tp7BMvcjhaJclHR12Grk+TLbOoo5hu2O5h1hGpEp+y/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=F/h2mjeC; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="F/h2mjeC"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2df9754484aso2581775ad.0
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 06:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1790341246; x=1790946046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OrcFZRDnFkiDn+MYWmxCF8cD4rC4Rzquwa4PDTiGChk=;
        b=F/h2mjeC59Wwql36M4rkKs3r/Hv2Xu9l1dAZdrJb7UXzNzVoN/GVybNZt68kCR9LOS
         0X42LqEg3ELZKS2EH7LM5ERS4Sa8yO75W2TAXkw21LRbiqJCtdi1r1LzPPNtcAwz1pBz
         wepxGFoW+o3GJGljlq+/ABDIMAPOmzJtqKa1VPotl1b0L+3mxqUq0q8c3ltKTNnwCewY
         DU27b5yjIjAwxUr2USqOv22ysUvXAjOljy93EX2UiR17Y6XigFlE1RHG8SERhDrmFD9o
         aVopowMvHin1pxlQyNX2tPBFpzyh9yU4IfZjBaU550RMBmpwmNihX8nO8ZuUlwhrvvc1
         tmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790341246; x=1790946046;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OrcFZRDnFkiDn+MYWmxCF8cD4rC4Rzquwa4PDTiGChk=;
        b=o0XX/3dBvEfacuhmZYUGJdetK9WFku4r2V5EkAWrziy5hVZ8jpVrPW2czYNYGS9Nzl
         pHbVXgKv6LJEGNWRLQZMqSGQr8LQkbIMDLy/ob124Uf1yN5qs0JB1/SOpZhkzDWnWDCM
         nnOqYQkEiCuwF4d5U0fSCvZfQy6/eTS1T58GCNPgZ5gUfhHv0VDsDAjn7CWdv+V6bASj
         C/FUOBqZUaKHGMjaMdjLbtfWnt5T3q40fOV1SveQiOBYJaaMULmqtPNZOoZfnrX8ZMV+
         Gf7DI86JRaCYYySfKHirEPjrby0HNw1MTlFpQcwoTvLz7MuGyGSrodz/Gki8N8ER+C8I
         nSkg==
X-Gm-Message-State: AFuF++lBijXMbqsrUfEsnJaqs+KysaALEPQsedfoZbVQjU0Q9BWSDtYx
	maU/Y6b0T88uCtUht2aCxiy1KxF5pW+cbDBaSFbDQMrbyV6hR261ufz43KwAWJ3CT+o=
X-Gm-Gg: AYBFou0IMLHC25xnZWT0l3dAzt3Ui/DFvPiawD+P8aIlCEYn5SBXvt3easMkrrHjXdC
	w/ChLA9vMRtoUA1PCFhHhAfUgjg1s1yoeTptGScvomVA7oogHlvlfR+JG1PgP+iu084LKnH98oB
	5/Xepu71Evmc14xWnwDS+tQDijDGf/1GyZ6EO/kKB+1EoRAPXNPlxs3ZIgeSwBuQYpNi3x8mDCz
	PlaRwuIBiXAO5hzA1m3g7XcqcgP2QnhDWukVBJrKDv1Z7AhddwCCeGZF+qwu9ewFhRL0YV3L6mI
	bmakrsZUVni8SmItIonO7X3lIFmMmTxs5zd1x1wsU0y0r3tZzujqMBF2uo18MjW5LfKQMnsRKVV
	2bn1lOfcBQmVjfVwOV2cBvvNBP8XINXRhuwhyt34IcdgoxWysqfgt3f5zo842FK9aPinvMA3Gb7
	Kf9Cq1UoIn+YhVS/MsnwWsxQDB6WwxWMN4EzsSdBeo2dGgN2HeJZwdbw8tPrvsZo/qSXwL/Q5rH
	B6KlXVij6f6Gqe9YqVHiT2iM7e5C0I=
X-Received: by 2002:a17:902:ec8b:b0:2dd:c053:82f6 with SMTP id d9443c01a7336-2df7deb7a71mr48844055ad.45.1790341241383;
        Fri, 25 Sep 2026 06:00:41 -0700 (PDT)
Received: from [10.254.237.61] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913de18asm9819175ad.26.2026.09.25.06.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 06:00:40 -0700 (PDT)
Message-ID: <87e10baa-13a8-4766-8d6d-9173a4b0c5c5@bytedance.com>
Date: Fri, 25 Sep 2026 21:00:28 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/3] memcg,writeback: flush foreign bdev mappings
 separately from owner wbs
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, willy@infradead.org, jack@suse.cz, tj@kernel.org,
 akpm@linux-foundation.org
References: <20260925064444.3944820-1-sunjunchao@bytedance.com>
 <20260925064444.3944820-3-sunjunchao@bytedance.com>
 <arYa1DbKNeAN-PLl@infradead.org>
From: Julian Sun <sunjunchao@bytedance.com>
In-Reply-To: <arYa1DbKNeAN-PLl@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/26 2:55 PM, Christoph Hellwig wrote:
>> +/*
>> + * No extra memcg reference is taken: this work is embedded in the memcg,
>> + * and mem_cgroup_css_free() waits for it to finish before freeing the memcg.
>> + */
>> +struct memcg_bdev_frn {
> 
> No reason not to spell out foreign here..

Yeah..Andrew and I discussed the naming in another thread. The idea was to stay 
consistent with the existing naming and keep this patchset focused on the functional
changes, leaving a broader naming cleanup to a separate patch.

https://lore.kernel.org/linux-fsdevel/20260917065759.2643940-1-sunjunchao@bytedance.com/T/#m0d196c3b8376c9b51276f6c5d26ab9f29e170169

> 
>> +		/* Reserve the slot: it may have become busy after the inflight check. */
> 
> Overly long line.
> 
>> +	struct address_space *mapping = folio_mapping(folio);
>> +	struct inode *inode = mapping->host;
>> +
>> +	if (memcg_bdev_frn_wq && sb_is_blkdev_sb(inode->i_sb)) {
> 
> Why do we need a NULL check for the workqueue here?
> 
>>  	memcg_wq = alloc_workqueue("memcg", WQ_PERCPU, 0);
>>  	WARN_ON(!memcg_wq);
>>  
>> +#ifdef CONFIG_CGROUP_WRITEBACK
>> +	memcg_bdev_frn_wq = alloc_workqueue("memcg_bdev_frn_flusher",
>> +					    WQ_UNBOUND, 0);
>> +	WARN_ON(!memcg_bdev_frn_wq);
>> +#endif
> 
> Instead please fail the boot.  If we can't alloc a workqueue at
> boot time, we're toast anyway.
I followed the existing memcg_wq allocation handling here, which also 
warns and continues. Would it make sense to change both allocations to
fail the boot in a separate patch, so the policy is consistent? 
If you prefer to address both in this series, I'll make that change
in the next revision.

Thanks,
-- 
Julian Sun <sunjunchao@bytedance.com>
