Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224A919E7F7
	for <linux-block@vger.kernel.org>; Fri,  6 Mar 2026 04:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772770669; cv=none; b=bJeoXWdvjwVNBomyU/8+kYlzJ8RqEDS6Jb2Ie8BAyokFeigXI+LUCmD2Pe4vr49DTTBYIOxM5ZWlo3A1zpOxgVu0hR7dBvSsr4JzLPnHqtoqwo9dXfNvWDBI9AfKtgNlRgyJ271CI3w8FTCQFj1vC2rV8WLZSH1HMXQlqRXzADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772770669; c=relaxed/simple;
	bh=pz61+fIgG0cjm7IRsCfo71xI8OgxrllESvVyLl1zWSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bowoqWyi8PaymKN/1z3cxnICEo3aZHhwZUtbjlRor1FvphKGeXWwxJM9jYbfpxmKkkIRorA3Qq+0moJjAioKmFjRIUZK42A8A8xrB6UgrvtaIVdHtBCupl6JamDgOWcM2yzcLFoYVtAxz6iBPy3o3ROMKuyuwXtIMHaL0nlb6gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wJ/AVrzp; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wJ/AVrzp"
Date: Fri, 6 Mar 2026 12:17:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772770665;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+KqhKXzprtckKIaikiBkk2NadowonKJk5/VnMbmq4M=;
	b=wJ/AVrzpZGjTdMVPwzINJk2+xxk17vfRHIbwEGOKtD9PeSv19VhP0P6MpMLOq9QSqrcprs
	+8qDYa45wTtthEUDbToAmhwH0LF9VM63xydmF6Cj7QAuRmyrt///xHWqT++p3fJKHtBMTn
	2EDIVfvDEXISu81Dh2lppOnxDq+iySc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Ming Lei <ming.lei@redhat.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>, 
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <ubczuk572wsppc37cqi4gu2s3cifpr7gjrvu4fjlxny35btytp@6mt2qpzb7eio>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
 <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org>
 <aZ7BbosIr2FvZFAe@fedora>
 <c6a01f7e-c6eb-454b-9b9e-734526dd659d@kernel.org>
 <aaFinIsCmitHSP_c@fedora>
 <08db9e93-3d29-42e0-ae57-79c295d75753@kernel.org>
 <aamluV66pLIdo66g@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aamluV66pLIdo66g@fedora>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 05, 2026 at 11:48:09PM +0800, Ming Lei wrote:
> 

[...]

> 2) v7.0-rc2(commit c107785c7e8d) + two patches
> 
> 
> - IOPS: 23M
> 
> - perf profile
> 
> + perf report --vmlinux=/root/git/linux/vmlinux --kallsyms=/proc/kallsyms --stdio --max-stack 0
> # To display the perf.data header info, please use --header/--header-only options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 858K of event 'cycles:P'
> # Event count (approx.): 667558170118
> #
> # Children      Self  Command          Shared Object                       Symbol
> # ........  ........  ...............  ..................................  ..............................................
> #
>     10.81%    10.81%  kublk            [kernel.kallsyms]                   [k] _copy_from_iter
>      5.23%     5.23%  io_uring         [kernel.kallsyms]                   [k] blk_mq_submit_bio
>      3.97%     3.97%  io_uring         [kernel.kallsyms]                   [k] __refill_objects_node
>      2.69%     2.69%  io_uring         [kernel.kallsyms]                   [k] io_rw_init_file
>      2.61%     2.61%  io_uring         [kernel.kallsyms]                   [k] blk_cgroup_bio_start
>      2.55%     2.55%  io_uring         [kernel.kallsyms]                   [k] blk_mq_rq_ctx_init.isra.0
>      2.52%     2.52%  kublk            [kernel.kallsyms]                   [k] blk_mq_free_request
>      2.45%     2.45%  kublk            [kernel.kallsyms]                   [k] ublk_dispatch_req
>      2.18%     2.18%  io_uring         [kernel.kallsyms]                   [k] __fsnotify_parent
>      1.87%     1.87%  kublk            [kernel.kallsyms]                   [k] __slab_free
>      1.82%     1.82%  io_uring         [kernel.kallsyms]                   [k] __io_read
>      1.77%     1.77%  kublk            [kernel.kallsyms]                   [k] slab_update_freelist.isra.0
>      1.72%     1.72%  kublk            [kernel.kallsyms]                   [k] __io_uring_cmd_done
>      1.70%     1.70%  io_uring         [kernel.kallsyms]                   [k] security_file_permission
>      1.68%     1.68%  io_uring         [kernel.kallsyms]                   [k] io_req_task_complete
>      1.51%     1.51%  kublk            [kernel.kallsyms]                   [k] ublk_start_io
>      1.32%     1.32%  io_uring         [kernel.kallsyms]                   [k] llist_reverse_order
>      1.30%     1.30%  io_uring         [kernel.kallsyms]                   [k] submit_bio_noacct_nocheck
>      1.22%     1.22%  kublk            [kernel.kallsyms]                   [k] blk_account_io_done.part.0
>      1.15%     1.15%  io_uring         [kernel.kallsyms]                   [k] kernel_init_pages
>      1.11%     1.11%  kublk            [kernel.kallsyms]                   [k] __local_bh_enable_ip
>      1.03%     1.03%  io_uring         [kernel.kallsyms]                   [k] io_import_reg_buf
>      1.03%     1.03%  kublk            [kernel.kallsyms]                   [k] ublk_ch_uring_cmd_local
>      1.01%     1.01%  io_uring         [kernel.kallsyms]                   [k] wbt_issue
>      0.97%     0.97%  io_uring         [kernel.kallsyms]                   [k] __submit_bio
>      0.81%     0.81%  kublk            [kernel.kallsyms]                   [k] avc_has_perm
>      0.80%     0.80%  io_uring         [kernel.kallsyms]                   [k] __rq_qos_issue
>      0.76%     0.76%  kublk            [kernel.kallsyms]                   [k] __blk_mq_free_request
>      0.73%     0.73%  kublk            kublk                               [.] ublk_queue_io_cmd
>      0.73%     0.73%  io_uring         io_uring                            [.] submitter_uring_fn
>      0.67%     0.67%  io_uring         [kernel.kallsyms]                   [k] kmem_cache_alloc_noprof
>      0.65%     0.65%  kublk            [kernel.kallsyms]                   [k] __io_submit_flush_completions
>      0.62%     0.62%  kublk            [kernel.kallsyms]                   [k] blk_stat_add
>      0.62%     0.62%  kublk            [kernel.kallsyms]                   [k] __ublk_complete_rq
>      0.61%     0.61%  kublk            [kernel.kallsyms]                   [k] blk_update_request
>      0.60%     0.60%  kublk            [kernel.kallsyms]                   [k] __blk_mq_end_request
>      0.58%     0.58%  io_uring         [kernel.kallsyms]                   [k] bio_alloc_bioset
>      0.56%     0.56%  kublk            [kernel.kallsyms]                   [k] __rcu_read_lock
>      0.54%     0.54%  io_uring         [kernel.kallsyms]                   [k] io_req_rw_complete
>      0.54%     0.54%  io_uring         [kernel.kallsyms]                   [k] io_free_batch_list
>      0.53%     0.53%  io_uring         [kernel.kallsyms]                   [k] __io_submit_flush_completions
>      0.53%     0.53%  io_uring         [kernel.kallsyms]                   [k] io_init_req
>      0.53%     0.53%  io_uring         [kernel.kallsyms]                   [k] __blkdev_direct_IO_async
>      0.53%     0.53%  kublk            [kernel.kallsyms]                   [k] io_issue_sqe
>      0.51%     0.51%  io_uring         [kernel.kallsyms]                   [k] blk_mq_start_request
>      0.51%     0.51%  kublk            [kernel.kallsyms]                   [k] io_req_local_work_add
>      0.51%     0.51%  kublk            [kernel.kallsyms]                   [k] kmem_cache_free
>      0.49%     0.49%  io_uring         [kernel.kallsyms]                   [k] io_import_fixed
> 
> 
> - slab stat
> 
> # (cd /sys/kernel/slab/bio-256/ && find . -type f -exec grep -aH . {} \;)
> ./remote_node_defrag_ratio:100
> ./total_objects:9078 N1=4233 N5=4845
> ./alloc_fastpath:897715187 C1=45250242 C3=50602079 C5=89955493 C6=128 C7=81923744 C8=128 C9=46275792 C10=128 C11=46037573 C12=128 C13=53037806 C14=128 C15=49291969 C16=128 C17=49716073 C18=4 C19=45475417 C20=130 C21=75693223 C22=128 C23=69595236 C24=128 C25=52992066 C26=1 C27=51082176 C28=66 C29=44931239 C30=2 C31=45853827 C48=2 C59=2 C63=1
> ./cpu_slabs:0
> ./objects:5404 N1=2665 N5=2739
> ./sheaf_return_slow:0
> ./objects_partial:3772 N1=1849 N5=1923
> ./sheaf_return_fast:0
> ./cpu_partial:0
> ./free_slowpath:580544104 C0=45249992 C2=50601817 C4=2 C6=2 C8=46275666 C10=46037443 C12=53037685 C14=49291858 C16=49715937 C18=45475167 C20=13 C22=21 C24=52991949 C26=51081920 C28=44931147 C30=45853478 C49=2 C59=2 C61=2 C63=1
> ./barn_get_fail:20733914 C1=1616081 C3=1807218 C5=23 C6=1 C7=10 C8=5 C9=1652707 C10=5 C11=1644200 C12=5 C13=1894208 C14=5 C15=1760428 C16=5 C17=1775575 C18=1 C19=1624123 C20=4 C21=6 C22=5 C23=21 C24=5 C25=1892574 C26=1 C27=1824364 C28=3 C29=1604692 C31=1637636 C48=1 C59=1 C63=1

It looks like barn_get_fail is much more pronounced on CPUs from memoryless NUMA nodes..


-- 
Thanks,
Hao
