Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3853C2778
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772725708; cv=none; b=svF+p2wJD1cOCjqAxjr0/6QDWNWCtn9CKJ1ekZ728vNASpEv74VaWNBEQer6D++pqHVmfQshsZDspMZEPEaFvaNapdilcsrtVpKQEKxbE30RTFXrV29RMIT6xCZ6Fb2MGmhUTgv0Gpl7iS3Zi/6Au9iFQL11+LUMdGns/zKBaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772725708; c=relaxed/simple;
	bh=qsLCLgpJXJCZDel+mV9PYtJMM0rYXQgSCMx0auj2xGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMUVlC32dpDmYbLNerehKXXNHNywMpAb69n1+u2z/AEm0EAHuFfl9jTpE+aHx+PS5HtyonXZ3hAE0aVXKcxEPcWkQL1YAKRHorgYeLGXd/ZzX+y5l6NxLbcqs+dsaaD9FnYnMGNPCqU8ZRi35x3Z5Ar+IqvxwKECo5TleDgskFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mx1T5E+W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mx1T5E+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772725705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y9N++HEdnRTRosbNSI04R8cqI3DzzCmnUhA8yKf3s2Q=;
	b=Mx1T5E+WVNrbduFr6IC5o2tF1ZxPw1Vsf907rGrEOi6TI4OnaEPDW6QP2WSsXfUBuXFnCE
	ll1fLKg2wd0IgnFojW1/ogg0faxhwENOArJ7PbBZa5VgeS1WeQFk4Rxx75z2qio7ZLvcAC
	8XDHCu6u94pOijozfMDZxw0XgWPTs48=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-i2FRZpkmNOqpyTgbB_FfNw-1; Thu,
 05 Mar 2026 10:48:22 -0500
X-MC-Unique: i2FRZpkmNOqpyTgbB_FfNw-1
X-Mimecast-MFC-AGG-ID: i2FRZpkmNOqpyTgbB_FfNw_1772725700
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 680071956053;
	Thu,  5 Mar 2026 15:48:20 +0000 (UTC)
Received: from fedora (unknown [10.72.116.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 70B6D1956095;
	Thu,  5 Mar 2026 15:48:14 +0000 (UTC)
Date: Thu, 5 Mar 2026 23:48:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Harry Yoo <harry.yoo@oracle.com>, Hao Li <hao.li@linux.dev>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <aamluV66pLIdo66g@fedora>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <5cf75a95-4bb9-48e5-af94-ef8ec02dcd4d@suse.cz>
 <724310c2-46a2-4410-8a5d-c69dcc8de35d@kernel.org>
 <aZ7BbosIr2FvZFAe@fedora>
 <c6a01f7e-c6eb-454b-9b9e-734526dd659d@kernel.org>
 <aaFinIsCmitHSP_c@fedora>
 <08db9e93-3d29-42e0-ae57-79c295d75753@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08db9e93-3d29-42e0-ae57-79c295d75753@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Mar 05, 2026 at 02:05:20PM +0100, Vlastimil Babka (SUSE) wrote:
> On 2/27/26 10:23, Ming Lei wrote:
> > On Thu, Feb 26, 2026 at 07:02:11PM +0100, Vlastimil Babka (SUSE) wrote:
> >> On 2/25/26 10:31, Ming Lei wrote:
> >> > Hi Vlastimil,
> >> > 
> >> > On Wed, Feb 25, 2026 at 09:45:03AM +0100, Vlastimil Babka (SUSE) wrote:
> >> >> On 2/24/26 21:27, Vlastimil Babka wrote:
> >> >> > 
> >> >> > It made sense to me not to refill sheaves when we can't reclaim, but I
> >> >> > didn't anticipate this interaction with mempools. We could change them
> >> >> > but there might be others using a similar pattern. Maybe it would be for
> >> >> > the best to just drop that heuristic from __pcs_replace_empty_main()
> >> >> > (but carefully as some deadlock avoidance depends on it, we might need
> >> >> > to e.g. replace it with gfpflags_allow_spinning()). I'll send a patch
> >> >> > tomorrow to test this theory, unless someone beats me to it (feel free to).
> >> >> Could you try this then, please? Thanks!
> >> > 
> >> > Thanks for working on this issue!
> >> > 
> >> > Unfortunately the patch doesn't make a difference on IOPS in the perf test,
> >> > follows the collected perf profile on linus tree(basically 7.0-rc1 with your patch):
> >> 
> >> what about this patch in addition to the previous one? Thanks.
> > 
> > With the two patches, IOPS increases to 22M from 13M, but still much less than
> > 36M which is obtained in v6.19-rc5, and slab-sheave PR follows v6.19-rc5.
> 
> OK thanks! Maybe now we're approching the original theories about effective
> caching capacity etc...
> 
> > Also alloc_slowpath can't be observed any more.
> > 
> > Follows perf profile with the two patches:
> 
> What's the full perf profile of v6.19-rc5 and full profile of the patched
> 7.0-rc2 then? Thanks.
> 
> Also contents of all the files under /sys/kernel/slab/$cache (forgot which
> particular one it was) with CONFIG_SLUB_STATS=y would be great, thanks.

Please see the following log, and let me know if any other info is needed.

1) v6.19-rc5

- IOPS: 34M

- perf profile

+ perf report --vmlinux=/root/git/linux/vmlinux --kallsyms=/proc/kallsyms --stdio --max-stack 0
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 1M of event 'cycles:P'
# Event count (approx.): 1045386603400
#
# Children      Self  Command          Shared Object             Symbol
# ........  ........  ...............  ........................  ..............................................
#
    14.41%    14.41%  kublk            [kernel.kallsyms]         [k] _copy_from_iter
    11.25%    11.25%  io_uring         [kernel.kallsyms]         [k] blk_mq_sched_bio_merge
     3.73%     3.73%  kublk            [kernel.kallsyms]         [k] slab_update_freelist.isra.0
     3.53%     3.53%  kublk            [kernel.kallsyms]         [k] ublk_dispatch_req
     3.33%     3.33%  io_uring         [kernel.kallsyms]         [k] blk_mq_rq_ctx_init.isra.0
     2.65%     2.65%  kublk            [kernel.kallsyms]         [k] blk_mq_free_request
     2.01%     2.01%  io_uring         [kernel.kallsyms]         [k] blkdev_read_iter
     1.92%     1.92%  io_uring         [kernel.kallsyms]         [k] __io_read
     1.67%     1.67%  io_uring         [kernel.kallsyms]         [k] blk_mq_submit_bio
     1.54%     1.54%  kublk            [kernel.kallsyms]         [k] ublk_ch_uring_cmd_local
     1.36%     1.36%  io_uring         [kernel.kallsyms]         [k] __fsnotify_parent
     1.30%     1.30%  io_uring         [kernel.kallsyms]         [k] clear_page_erms
     1.19%     1.19%  io_uring         [kernel.kallsyms]         [k] llist_reverse_order
     1.11%     1.11%  io_uring         [kernel.kallsyms]         [k] blk_cgroup_bio_start
     0.98%     0.98%  kublk            [kernel.kallsyms]         [k] __check_object_size
     0.98%     0.98%  kublk            kublk                     [.] ublk_queue_io_cmd
     0.97%     0.97%  io_uring         [kernel.kallsyms]         [k] __submit_bio
     0.97%     0.97%  kublk            [kernel.kallsyms]         [k] __slab_free
     0.96%     0.96%  io_uring         [kernel.kallsyms]         [k] submit_bio_noacct_nocheck
     0.92%     0.92%  kublk            [kernel.kallsyms]         [k] io_issue_sqe
     0.91%     0.91%  io_uring         io_uring                  [.] submitter_uring_fn
     0.88%     0.88%  io_uring         io_uring                  [.] get_offset.part.0
     0.86%     0.86%  io_uring         [kernel.kallsyms]         [k] kmem_cache_alloc_noprof
     0.85%     0.85%  kublk            [kernel.kallsyms]         [k] ublk_copy_user_pages.isra.0
     0.77%     0.77%  io_uring         [kernel.kallsyms]         [k] blk_mq_start_request
     0.74%     0.74%  kublk            kublk                     [.] ublk_null_queue_io
     0.74%     0.74%  io_uring         [kernel.kallsyms]         [k] io_import_reg_buf
     0.67%     0.67%  io_uring         [kernel.kallsyms]         [k] io_issue_sqe
     0.66%     0.66%  io_uring         [kernel.kallsyms]         [k] bio_alloc_bioset
     0.66%     0.66%  kublk            [kernel.kallsyms]         [k] kmem_cache_free
     0.66%     0.66%  io_uring         [kernel.kallsyms]         [k] __blkdev_direct_IO_async
     0.64%     0.64%  kublk            [kernel.kallsyms]         [k] __io_issue_sqe
     0.61%     0.61%  io_uring         [kernel.kallsyms]         [k] submit_bio
     0.59%     0.59%  kublk            [kernel.kallsyms]         [k] __io_uring_cmd_done
     0.58%     0.58%  io_uring         [kernel.kallsyms]         [k] blk_rq_merge_ok
     0.56%     0.56%  kublk            [kernel.kallsyms]         [k] __io_submit_flush_completions
     0.54%     0.54%  kublk            kublk                     [.] __ublk_io_handler_fn.isra.0
     0.53%     0.53%  kublk            [kernel.kallsyms]         [k] io_uring_cmd
     0.52%     0.52%  io_uring         [kernel.kallsyms]         [k] __io_prep_rw
     0.52%     0.52%  io_uring         [kernel.kallsyms]         [k] io_free_batch_list
     0.50%     0.50%  kublk            [kernel.kallsyms]         [k] io_uring_cmd_prep
     0.49%     0.49%  kublk            [kernel.kallsyms]         [k] blk_account_io_done.part.0
     0.49%     0.49%  io_uring         [kernel.kallsyms]         [k] __io_submit_flush_completions


- slab stat

# (cd /sys/kernel/slab/bio-256/ && find . -type f -exec grep -aH . {} \;)
./remote_node_defrag_ratio:100
./free_frozen:203789653 C0=13137513 C2=16103904 C4=5312681 C6=9805649 C8=14262027 C10=13676236 C12=8700700 C14=13041782 C16=11558292 C18=13258018 C19=2 C20=2813290 C22=7752577 C24=19173693 C26=16631916 C28=21707419 C29=2 C30=16853951 C31=1
./total_objects:6732 N1=3315 N5=3417
./cpuslab_flush:0
./alloc_fastpath:1284958471 C1=80252197 C3=80197810 C4=125 C5=82882536 C6=125 C7=83898247 C8=125 C9=81412735 C11=80400026 C12=125 C13=78664565 C14=44 C15=80954403 C17=80070327 C19=75310035 C20=125 C21=83788507 C22=81 C23=84943484 C25=78466239 C26=125 C27=78389061 C29=76890573 C31=78436849 C50=1 C60=1
./cpu_partial_free:37988123 C0=2275928 C2=2190868 C4=2789178 C6=2685497 C8=2282195 C10=2266792 C12=2340158 C14=2302589 C16=2359282 C18=2154683 C20=3028332 C22=2921916 C24=2103757 C26=2157902 C28=1972836 C30=2156210
./cpu_slabs:58 N1=28 N5=30
./objects:6167 N1=3092 N5=3075
./deactivate_full:0
./sheaf_return_slow:0
./objects_partial:608 N1=287 N5=321
./sheaf_return_fast:0
./cpu_partial:52
./cmpxchg_double_cpu_fail:1 C7=1
./free_slowpath:1361594822 C0=85109840 C2=85495921 C4=86775189 C6=88474098 C8=86495486 C10=85287670 C12=82701232 C14=85802194 C16=84711284 C18=79945983 C19=2 C20=87399505 C22=89361232 C24=84116440 C26=83560456 C28=82780090 C29=2 C30=83578197 C31=1
./barn_get_fail:0
./sheaf_prefill_oversize:0
./deactivate_to_tail:0
./skip_kfence:0
./min_partial:5
./order_fallback:0
./sheaf_capacity:0
./deactivate_empty:3616332 C0=269533 C2=262401 C4=116355 C6=112383 C8=271620 C10=266348 C12=278359 C14=271083 C16=264315 C18=242601 C20=170557 C22=159604 C24=231322 C26=240708 C28=220103 C30=239040
./sheaf_flush:0
./free_rcu_sheaf:0
./alloc_from_partial:11612237 C1=660211 C3=634301 C5=949155 C6=1 C7=914355 C9=661811 C11=658753 C13=679880 C15=669226 C17=684745 C19=624788 C20=1 C21=1037955 C22=1 C23=1002678 C25=611243 C27=625403 C29=571631 C31=626099
./sheaf_alloc:0
./sheaf_free:0
./sheaf_prefill_slow:0
./sheaf_prefill_fast:0
./poison:0
./red_zone:0
./free_cpu_sheaf:0
./free_slab:3616434 C0=269535 C2=262407 C4=116368 C6=112391 C8=271622 C10=266351 C12=278359 C14=271084 C16=264354 C18=242601 C20=170559 C22=159611 C24=231322 C26=240711 C28=220114 C30=239045
./slabs:132 N1=65 N5=67
./barn_get:0
./cpu_partial_node:22759400 C1=1312100 C3=1260562 C5=1821488 C6=2 C7=1752623 C9=1315094 C11=1309216 C13=1351244 C15=1329937 C17=1360857 C19=1241554 C20=2 C21=1968791 C22=2 C23=1898000 C25=1214784 C27=1242922 C29=1136091 C31=1244131
./alloc_slowpath:76640471 C1=4857913 C3=5298367 C4=3 C5=3892806 C6=3 C7=4575965 C8=3 C9=5082878 C11=4887906 C12=3 C13=4036796 C14=1 C15=4848003 C17=4641269 C19=4636149 C20=3 C21=3611116 C22=2 C23=4417922 C25=5650460 C26=3 C27=5171520 C29=5889792 C31=5141585 C50=1 C60=1 C62=1
./destroy_by_rcu:1
./free_rcu_sheaf_fail:0
./barn_put:0
./usersize:0
./sanity_checks:0
./barn_put_fail:0
./align:64
./alloc_node_mismatch:0
./deactivate_remote_frees:0
./alloc_slab:3616566 C1=303677 C3=296031 C4=3 C5=18366 C7=18301 C8=3 C9=305344 C11=298932 C12=3 C13=309156 C14=1 C15=303522 C17=313382 C19=288344 C21=21685 C23=21353 C25=277789 C26=3 C27=289631 C29=265057 C31=285980 C50=1 C60=1 C62=1
./free_remove_partial:102 C0=2 C2=6 C4=13 C6=8 C8=2 C10=3 C14=1 C16=39 C20=2 C22=7 C26=3 C28=11 C30=5
./aliases:0
./store_user:0
./trace:0
./reclaim_account:0
./order:2
./sheaf_refill:0
./object_size:256
./alloc_refill:38652283 C1=2581925 C3=3107474 C5=1103799 C7=1890686 C9=2800630 C11=2621006 C13=1696518 C15=2545318 C17=2282285 C19=2481464 C21=582686 C23=1495892 C25=3546646 C27=3013564 C29=3917013 C31=2985377
./alloc_cpu_sheaf:0
./cpu_partial_drain:12662698 C0=758642 C2=730289 C4=929725 C6=895165 C8=760731 C10=755597 C12=780052 C14=767529 C16=786427 C18=718227 C20=1009443 C22=973972 C24=701252 C26=719300 C28=657611 C30=718736
./free_fastpath:4 C1=2 C11=2
./hwcache_align:1
./cpu_partial_alloc:22759385 C1=1312100 C3=1260561 C5=1821486 C6=2 C7=1752623 C9=1315093 C11=1309215 C13=1351242 C15=1329937 C17=1360857 C19=1241553 C20=2 C21=1968790 C22=1 C23=1897999 C25=1214782 C27=1242922 C29=1136091 C31=1244129
./cmpxchg_double_fail:6247305 C0=396268 C1=16193 C2=484201 C3=11558 C4=198887 C5=7233 C6=336779 C7=7332 C8=444665 C9=11539 C10=403230 C11=10130 C12=258163 C13=6666 C14=389004 C15=9620 C16=357182 C17=9184 C18=378255 C19=9012 C20=103655 C21=2375 C22=260015 C23=6160 C24=552885 C25=22738 C26=464990 C27=11172 C28=592307 C29=23777 C30=451529 C31=10601
./deactivate_bypass:37988161 C1=2275987 C3=2190892 C4=2 C5=2789006 C6=2 C7=2685278 C8=2 C9=2282247 C11=2266899 C12=2 C13=2340277 C15=2302684 C17=2358983 C19=2154684 C20=2 C21=3028429 C22=1 C23=2922029 C25=2103813 C26=2 C27=2157955 C29=1972778 C31=2156207
./objs_per_slab:51
./partial:23 N1=10 N5=13
./slabs_cpu_partial:1122(44) C0=51(2) C2=25(1) C3=25(1) C4=76(3) C5=51(2) C6=51(2) C8=51(2) C9=25(1) C10=25(1) C11=25(1) C12=51(2) C13=51(2) C14=51(2) C16=25(1) C18=51(2) C19=25(1) C20=76(3) C21=25(1) C22=25(1) C23=25(1) C24=25(1) C25=51(2) C26=51(2) C28=76(3) C30=51(2) C31=51(2)
./free_add_partial:34371762 C0=2006393 C2=1928466 C4=2672820 C6=2573112 C8=2010573 C10=2000443 C12=2061797 C14=2031504 C16=2094966 C18=1912080 C20=2857772 C22=2762312 C24=1872434 C26=1917192 C28=1752730 C30=1917168
./slab_size:320
./cache_dma:0
./deactivate_to_head:0



2) v7.0-rc2(commit c107785c7e8d) + two patches


- IOPS: 23M

- perf profile

+ perf report --vmlinux=/root/git/linux/vmlinux --kallsyms=/proc/kallsyms --stdio --max-stack 0
# To display the perf.data header info, please use --header/--header-only options.
#
#
# Total Lost Samples: 0
#
# Samples: 858K of event 'cycles:P'
# Event count (approx.): 667558170118
#
# Children      Self  Command          Shared Object                       Symbol
# ........  ........  ...............  ..................................  ..............................................
#
    10.81%    10.81%  kublk            [kernel.kallsyms]                   [k] _copy_from_iter
     5.23%     5.23%  io_uring         [kernel.kallsyms]                   [k] blk_mq_submit_bio
     3.97%     3.97%  io_uring         [kernel.kallsyms]                   [k] __refill_objects_node
     2.69%     2.69%  io_uring         [kernel.kallsyms]                   [k] io_rw_init_file
     2.61%     2.61%  io_uring         [kernel.kallsyms]                   [k] blk_cgroup_bio_start
     2.55%     2.55%  io_uring         [kernel.kallsyms]                   [k] blk_mq_rq_ctx_init.isra.0
     2.52%     2.52%  kublk            [kernel.kallsyms]                   [k] blk_mq_free_request
     2.45%     2.45%  kublk            [kernel.kallsyms]                   [k] ublk_dispatch_req
     2.18%     2.18%  io_uring         [kernel.kallsyms]                   [k] __fsnotify_parent
     1.87%     1.87%  kublk            [kernel.kallsyms]                   [k] __slab_free
     1.82%     1.82%  io_uring         [kernel.kallsyms]                   [k] __io_read
     1.77%     1.77%  kublk            [kernel.kallsyms]                   [k] slab_update_freelist.isra.0
     1.72%     1.72%  kublk            [kernel.kallsyms]                   [k] __io_uring_cmd_done
     1.70%     1.70%  io_uring         [kernel.kallsyms]                   [k] security_file_permission
     1.68%     1.68%  io_uring         [kernel.kallsyms]                   [k] io_req_task_complete
     1.51%     1.51%  kublk            [kernel.kallsyms]                   [k] ublk_start_io
     1.32%     1.32%  io_uring         [kernel.kallsyms]                   [k] llist_reverse_order
     1.30%     1.30%  io_uring         [kernel.kallsyms]                   [k] submit_bio_noacct_nocheck
     1.22%     1.22%  kublk            [kernel.kallsyms]                   [k] blk_account_io_done.part.0
     1.15%     1.15%  io_uring         [kernel.kallsyms]                   [k] kernel_init_pages
     1.11%     1.11%  kublk            [kernel.kallsyms]                   [k] __local_bh_enable_ip
     1.03%     1.03%  io_uring         [kernel.kallsyms]                   [k] io_import_reg_buf
     1.03%     1.03%  kublk            [kernel.kallsyms]                   [k] ublk_ch_uring_cmd_local
     1.01%     1.01%  io_uring         [kernel.kallsyms]                   [k] wbt_issue
     0.97%     0.97%  io_uring         [kernel.kallsyms]                   [k] __submit_bio
     0.81%     0.81%  kublk            [kernel.kallsyms]                   [k] avc_has_perm
     0.80%     0.80%  io_uring         [kernel.kallsyms]                   [k] __rq_qos_issue
     0.76%     0.76%  kublk            [kernel.kallsyms]                   [k] __blk_mq_free_request
     0.73%     0.73%  kublk            kublk                               [.] ublk_queue_io_cmd
     0.73%     0.73%  io_uring         io_uring                            [.] submitter_uring_fn
     0.67%     0.67%  io_uring         [kernel.kallsyms]                   [k] kmem_cache_alloc_noprof
     0.65%     0.65%  kublk            [kernel.kallsyms]                   [k] __io_submit_flush_completions
     0.62%     0.62%  kublk            [kernel.kallsyms]                   [k] blk_stat_add
     0.62%     0.62%  kublk            [kernel.kallsyms]                   [k] __ublk_complete_rq
     0.61%     0.61%  kublk            [kernel.kallsyms]                   [k] blk_update_request
     0.60%     0.60%  kublk            [kernel.kallsyms]                   [k] __blk_mq_end_request
     0.58%     0.58%  io_uring         [kernel.kallsyms]                   [k] bio_alloc_bioset
     0.56%     0.56%  kublk            [kernel.kallsyms]                   [k] __rcu_read_lock
     0.54%     0.54%  io_uring         [kernel.kallsyms]                   [k] io_req_rw_complete
     0.54%     0.54%  io_uring         [kernel.kallsyms]                   [k] io_free_batch_list
     0.53%     0.53%  io_uring         [kernel.kallsyms]                   [k] __io_submit_flush_completions
     0.53%     0.53%  io_uring         [kernel.kallsyms]                   [k] io_init_req
     0.53%     0.53%  io_uring         [kernel.kallsyms]                   [k] __blkdev_direct_IO_async
     0.53%     0.53%  kublk            [kernel.kallsyms]                   [k] io_issue_sqe
     0.51%     0.51%  io_uring         [kernel.kallsyms]                   [k] blk_mq_start_request
     0.51%     0.51%  kublk            [kernel.kallsyms]                   [k] io_req_local_work_add
     0.51%     0.51%  kublk            [kernel.kallsyms]                   [k] kmem_cache_free
     0.49%     0.49%  io_uring         [kernel.kallsyms]                   [k] io_import_fixed


- slab stat

# (cd /sys/kernel/slab/bio-256/ && find . -type f -exec grep -aH . {} \;)
./remote_node_defrag_ratio:100
./total_objects:9078 N1=4233 N5=4845
./alloc_fastpath:897715187 C1=45250242 C3=50602079 C5=89955493 C6=128 C7=81923744 C8=128 C9=46275792 C10=128 C11=46037573 C12=128 C13=53037806 C14=128 C15=49291969 C16=128 C17=49716073 C18=4 C19=45475417 C20=130 C21=75693223 C22=128 C23=69595236 C24=128 C25=52992066 C26=1 C27=51082176 C28=66 C29=44931239 C30=2 C31=45853827 C48=2 C59=2 C63=1
./cpu_slabs:0
./objects:5404 N1=2665 N5=2739
./sheaf_return_slow:0
./objects_partial:3772 N1=1849 N5=1923
./sheaf_return_fast:0
./cpu_partial:0
./free_slowpath:580544104 C0=45249992 C2=50601817 C4=2 C6=2 C8=46275666 C10=46037443 C12=53037685 C14=49291858 C16=49715937 C18=45475167 C20=13 C22=21 C24=52991949 C26=51081920 C28=44931147 C30=45853478 C49=2 C59=2 C61=2 C63=1
./barn_get_fail:20733914 C1=1616081 C3=1807218 C5=23 C6=1 C7=10 C8=5 C9=1652707 C10=5 C11=1644200 C12=5 C13=1894208 C14=5 C15=1760428 C16=5 C17=1775575 C18=1 C19=1624123 C20=4 C21=6 C22=5 C23=21 C24=5 C25=1892574 C26=1 C27=1824364 C28=3 C29=1604692 C31=1637636 C48=1 C59=1 C63=1
./sheaf_prefill_oversize:0
./skip_kfence:0
./min_partial:5
./order_fallback:0
./sheaf_capacity:28
./sheaf_flush:84 C4=28 C20=28 C22=28
./free_rcu_sheaf:0
./sheaf_alloc:120 C1=1 C3=1 C4=10 C5=1 C6=3 C8=1 C9=1 C10=1 C11=1 C12=1 C13=1 C14=1 C15=2 C16=1 C17=1 C18=65 C19=1 C20=6 C22=7 C23=1 C24=1 C25=1 C26=1 C27=2 C28=1 C29=3 C31=1 C48=1 C59=1 C63=1
./sheaf_free:0
./sheaf_prefill_slow:0
./sheaf_prefill_fast:0
./poison:0
./red_zone:0
./free_slab:2252626 C0=217768 C2=178064 C8=177352 C10=188763 C12=172593 C14=195156 C16=189975 C18=178757 C24=179036 C26=187498 C28=189290 C30=198374
./slabs:178 N1=83 N5=95
./barn_get:11327366 C5=3212674 C6=4 C7=2925838 C20=1 C21=2703324 C23=2485524 C31=1
./alloc_slowpath:0
./destroy_by_rcu:1
./free_rcu_sheaf_fail:0
./barn_put:11327384 C4=3212682 C6=2925843 C20=2703321 C22=2485537 C28=1
./usersize:0
./sanity_checks:0
./barn_put_fail:3 C4=1 C20=1 C22=1
./align:64
./alloc_node_mismatch:0
./alloc_slab:2252805 C1=175514 C3=194092 C5=9 C8=2 C9=178894 C10=1 C11=177472 C12=5 C13=202580 C14=1 C15=190184 C16=2 C17=194266 C18=1 C19=179219 C20=1 C24=1 C25=205268 C27=197542 C29=177638 C30=1 C31=180109 C48=1 C59=1 C63=1
./free_remove_partial:2252626 C0=217768 C2=178064 C8=177352 C10=188763 C12=172593 C14=195156 C16=189975 C18=178757 C24=179036 C26=187498 C28=189290 C30=198374
./aliases:0
./store_user:0
./trace:0
./reclaim_account:0
./order:2
./sheaf_refill:580549592 C1=45250268 C3=50602104 C5=644 C6=28 C7=280 C8=140 C9=46275796 C10=140 C11=46037600 C12=140 C13=53037824 C14=140 C15=49291984 C16=140 C17=49716100 C18=28 C19=45475444 C20=112 C21=168 C22=140 C23=588 C24=140 C25=52992072 C26=28 C27=51082192 C28=140 C29=44931264 C30=56 C31=45853808 C48=28 C59=28 C63=28
./object_size:256
./free_fastpath:317166967 C4=89955177 C6=81923631 C20=75693051 C22=69595106 C53=2
./hwcache_align:1
./cmpxchg_double_fail:2518173 C0=176664 C1=2695 C2=217757 C3=3198 C5=1 C7=2 C8=201087 C9=2783 C10=199017 C11=2839 C12=222146 C13=3146 C14=215883 C15=3113 C16=208327 C17=3279 C18=199045 C19=3150 C21=1 C24=225357 C25=3445 C26=218118 C27=3183 C28=197089 C29=3083 C30=200710 C31=3055
./objs_per_slab:51
./partial:146 N1=67 N5=79
./slabs_cpu_partial:0(0)
./free_add_partial:29301755 C0=958223 C1=1323669 C2=1094832 C3=1480537 C4=1 C5=11 C7=7 C8=990458 C9=1354237 C10=983110 C11=1348401 C12=1142550 C13=1553516 C14=1063308 C15=1441153 C16=1029143 C17=1463851 C18=949985 C19=1335529 C20=7 C21=3 C22=7 C23=17 C24=1107242 C25=1562991 C26=1056543 C27=1505571 C28=939243 C29=1319586 C30=948581 C31=1349443
./slab_size:320



Thanks,
Ming

