Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C452F5A29
	for <linux-block@vger.kernel.org>; Fri, 13 Mar 2026 03:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773372422; cv=none; b=DiKC46YgMvyH7zchq/LBsAkpgTNNptiNR8dUuHB1fUbEu+M9+X9rIx19pyQqnhp2CwK0I3Ze+BKFfunXdjnQQxQECF29UnGECaVkG0KM0NfpI7POzxER4e/MjJF54/EZBrvSjcwfBaCzusLvR4sEVI5nCVQrR70ImJ0ItjDyFyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773372422; c=relaxed/simple;
	bh=F+8Jgg5odDS/dbJCYKB2hARbuCgRXLOzcDyc2OH6/Q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8bqRva158k9EBd+m91TBG+mZFmYJbokLYAhYaSy9f2FBXJCQ6Mm6VKYIhbNJyokNOnf74zghA9lyIv0CVJWnhO6y9WvT47s3iHiqdHXABjRWNjHvfk+oF7deL72bZvLnAKitxX7hQFktafVzNfIXgHt8vZsi1mE4LNSnpURP/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E86yibAM; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E86yibAM"
Date: Fri, 13 Mar 2026 11:26:49 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773372418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rSbfiTxi/vqjap87wKePmx7M5DxP+zH8U5U26XVOG7o=;
	b=E86yibAMh74j9jjKSh/XkB3laJG7xbOxciL9Nn+S0xRDxOCTHureiWxSAExl+Ue7Kz/8mz
	MsWaWO6RwHZYdFbxGJrqec0/SqWlpLW1EufalMDvFCGEA0hgj6siC/ZnNGYKeJd96Wy38p
	3aYZCBeJMhp2OCgQCYLYSGsMeqCbsU0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Ming Lei <ming.lei@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <sridjqup2hjlg2rjcm2e7spasbbgnh25s3p2sffy55waprupd3@7uzhbwvglzfs>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <fbssy5y6kpyjlefacmabuojiustr3nocj7timpgejpchkj3lw7@qfss5ffmwdxa>
 <abKp7-HzFT6llbYT@fedora>
 <iypdqo2s5oobenjrmoqqplgshsz65bwegih7kxhgd547fcofm7@yb6xqors6snx>
 <abLSuHU3eJrel6KI@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abLSuHU3eJrel6KI@fedora>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 12, 2026 at 10:50:32PM +0800, Ming Lei wrote:
> On Thu, Mar 12, 2026 at 08:13:18PM +0800, Hao Li wrote:
> > On Thu, Mar 12, 2026 at 07:56:31PM +0800, Ming Lei wrote:
> > > On Thu, Mar 12, 2026 at 07:26:28PM +0800, Hao Li wrote:
> > > > On Tue, Feb 24, 2026 at 10:52:28AM +0800, Ming Lei wrote:
> > > > > Hello Vlastimil and MM guys,
> > > > > 
> > > > > The SLUB "sheaves" series merged via 815c8e35511d ("Merge branch
> > > > > 'slab/for-7.0/sheaves' into slab/for-next") introduces a severe
> > > > > performance regression for workloads with persistent cross-CPU
> > > > > alloc/free patterns. ublk null target benchmark IOPS drops
> > > > > significantly compared to v6.19: from ~36M IOPS to ~13M IOPS (~64%
> > > > > drop).
> > > > > 
> > > > > Bisecting within the sheaves series is blocked by a kernel panic at
> > > > > 17c38c88294d ("slab: remove cpu (partial) slabs usage from allocation
> > > > > paths"), so the exact first bad commit could not be identified.
> > > > > 
> > > > > Reproducer
> > > > > ==========
> > > > > 
> > > > > Hardware: NUMA machine with >= 32 CPUs
> > > > > Kernel:   v7.0-rc (with slab/for-7.0/sheaves merged)
> > > > > 
> > > > >     # build kublk selftest
> > > > >     make -C tools/testing/selftests/ublk/
> > > > > 
> > > > >     # create ublk null target device with 16 queues
> > > > >     tools/testing/selftests/ublk/kublk add -t null -q 16
> > > > > 
> > > > >     # run fio/t/io_uring benchmark: 16 jobs, 20 seconds, non-polled
> > > > >     taskset -c 0-31 fio/t/io_uring -p0 -n 16 -r 20 /dev/ublkb0
> > > > > 
> > > > >     # cleanup
> > > > >     tools/testing/selftests/ublk/kublk del -n 0
> > > > > 
> > > > > Good: v6.19 (and 41f1a08645ab, the mainline parent of the slab merge)
> > > > > Bad:  815c8e35511d (Merge branch 'slab/for-7.0/sheaves' into slab/for-next)
> > > > > 
> > > > 
> > > > Hi Ming,
> > > > 
> > > > I also have a similar machine, but my test results show that the IOPS is below
> > > > 1M, only around 900K. That seems quite strange to me.
> > > > 
> > > > My test commands are:
> > > > 
> > > > ```bash
> > > > tools/testing/selftests/ublk/kublk add -t null -q 16
> > > > taskset -c 24-47 /home/haolee/fio/t/io_uring -p0 -n 16 -r 20 /dev/ublkb0
> > > > ```
> > > 
> > > The command line looks similar with mine, just in my tests:
> > > 
> > > taskset -c 0-31 fio/t/io_uring -p0 -n 16 -r 20 /dev/ublkb0
> > > 
> > > so the test is run cpu 0~31, which covers all 8 numa node.
> > 
> > Oh, yes, this is a difference.
> > 
> > > 
> > > Also what is the single job perf result on your setting?
> > > 
> > > /home/haolee/fio/t/io_uring -p0 -n 1 -r 20 /dev/ublkb0
> > 
> > If I use this command without taskset, the IOPS is still 900K...
> 
> So single job(-n 1) can reach 900K, which is not bad.
> 
> But if 16 jobs still can reach 1M, which looks not good.
> 
> In my machine, single job can reach 2.7M, 16jobs(taskset -c 0-31) can get 13M
> on v7.0-rc3.

Thanks for sharing your data!
I've made some affinity adjustments, and the test results have improved.

Although the absolute numbers are still not as high as yours, some differences
in the relative results have already started to show up.

> 
> 
> > 
> > > 
> > > > 
> > > > Below are my machine numa info. Could there be something configured incorrectly
> > > > on my side?
> > > > 
> > > > available: 8 nodes (0-7)
> > > > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
> > > > node 0 size: 193175 MB
> > > > node 0 free: 164227 MB
> > > > node 1 cpus: 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
> > > > node 1 size: 0 MB
> > > > node 1 free: 0 MB
> > > > node 2 cpus: 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71
> > > > node 2 size: 0 MB
> > > > node 2 free: 0 MB
> > > > node 3 cpus: 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
> > > > node 3 size: 0 MB
> > > > node 3 free: 0 MB
> > > > node 4 cpus: 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119
> > > > node 4 size: 193434 MB
> > > > node 4 free: 189559 MB
> > > > node 5 cpus: 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143
> > > > node 5 size: 0 MB
> > > > node 5 free: 0 MB
> > > > node 6 cpus: 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167
> > > > node 6 size: 0 MB
> > > > node 6 free: 0 MB
> > > > node 7 cpus: 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191
> > > > node 7 size: 0 MB
> > > > node 7 free: 0 MB
> > > > node distances:
> > > > node   0   1   2   3   4   5   6   7
> > > >   0:  10  12  12  12  32  32  32  32
> > > >   1:  12  10  12  12  32  32  32  32
> > > >   2:  12  12  10  12  32  32  32  32
> > > >   3:  12  12  12  10  32  32  32  32
> > > >   4:  32  32  32  32  10  12  12  12
> > > >   5:  32  32  32  32  12  10  12  12
> > > >   6:  32  32  32  32  12  12  10  12
> > > >   7:  32  32  32  32  12  12  12  10
> > > 
> > > The nuam topo is different with mine, please see:
> > > 
> > > https://lore.kernel.org/all/aZ7p9uF8H8u6RxrK@fedora/
> > 
> > Yes, our NUMA topology does have some differences, but I feel there may be some
> > other factors affecting my test results as well.
> > 
> > Even when I run with "-p0 -n 16 -r 20 /dev/ublkb0" without using taskset to pin
> > the CPU affinity, the best performance I can get is only around 10M.
> 
> What is the data when you run same test on v6.19?

I noticed the following output while creating the queue:

dev id 0: nr_hw_queues 16 queue_depth 128 block size 512 dev_capacity 524288000
        max rq size 1048576 daemon pid 545894 flags 0x6042 state LIVE
        queue 0: affinity(24 )
        queue 1: affinity(36 )
        queue 2: affinity(72 )
        queue 3: affinity(84 )
        queue 4: affinity(96 )
        queue 5: affinity(108 )
        queue 6: affinity(120 )
        queue 7: affinity(132 )
        queue 8: affinity(144 )
        queue 9: affinity(156 )
        queue 10: affinity(168 )
        queue 11: affinity(180 )
        queue 12: affinity(48 )
        queue 13: affinity(60 )
        queue 14: affinity(0 )
        queue 15: affinity(12 )

I noticed that each queue was assigned an affinity, so I also tried using
taskset -c 0,12,24,36,48,60,72,84,96,108,120,132,144,156,168,180, and the IOPS
reached a new high. The performance was even better than without using taskset
for CPU affinity.

For the good case, IOPS can reach 19M on commit 41f1a086.
For the bad case, IOPS can reach 14M on commit 815c8e35.

The results are fairly stable. So although the absolute numbers in my
environment are still different from those in yours, the relative difference
between the bad case and the good case is already clear. I think this means
I've successfully reproduced your test results.

Thank you for your help and insights!

-- 
Thanks,
Hao
