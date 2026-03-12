Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C899D35B12D
	for <linux-block@vger.kernel.org>; Thu, 12 Mar 2026 14:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327073; cv=none; b=tBNNr/MIHVLk4K/Vfosmn8o5UB7AmGQtP0dF4SOINhh5PUvofoFgkNhq0goDmsNKZMYASwCGG45riNG1NuC5NGo3/BnZ1R1pPk/9pYOdyHws2BmIagcNtpKlenqM2ahSItskKkbPYz42TaNTDFAGU9e+Fo3xEkNehacPwVKEp54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327073; c=relaxed/simple;
	bh=WwUVLMXTMoptUDAR1+bymxprLDard3EVCC3Hy0qcIzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHDy3fgmWmcos37YySfwN64q5N4KnIlxesjojvg4lW7RhVB1UTJAfeofgWnKdEmIbuTDMpfMR5lmPiKmTPgGQesKSuY1Fe22XwOj1qf1Ht9RdzxmG50DCxPOmF5p/40EVhtwG6qTTRJkgmyNaPeiaNJygxgW1YiqpfIXLLIt8z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5dUpUTJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5dUpUTJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773327070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lE1rb2S8uojZcRiMtzZiFU8yO1ZMQjlNk6yVeVq/BwU=;
	b=B5dUpUTJNmzvA1AgYolYGYe9s13Tx5OMmUKTVaXvBeKrKz+r5t5XfvdlOd313vGFXpTipB
	W49zLlMkkN0Z68a/WJ9AiX3baimzmtrBJ12OwF3niRV+/a5UbaSgjGFur1j9ZdXqLBN6MV
	2HnG5mmzi6cQzE+ZW0TjKWBhyaabQjA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-vTJ5wrXXNF2xbUlIumCVbA-1; Thu,
 12 Mar 2026 10:51:09 -0400
X-MC-Unique: vTJ5wrXXNF2xbUlIumCVbA-1
X-Mimecast-MFC-AGG-ID: vTJ5wrXXNF2xbUlIumCVbA_1773327063
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54CD8195609E;
	Thu, 12 Mar 2026 14:50:52 +0000 (UTC)
Received: from fedora (unknown [10.72.116.147])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4849A1800759;
	Thu, 12 Mar 2026 14:50:45 +0000 (UTC)
Date: Thu, 12 Mar 2026 22:50:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hao Li <hao.li@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>, Harry Yoo <harry.yoo@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <abLSuHU3eJrel6KI@fedora>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <fbssy5y6kpyjlefacmabuojiustr3nocj7timpgejpchkj3lw7@qfss5ffmwdxa>
 <abKp7-HzFT6llbYT@fedora>
 <iypdqo2s5oobenjrmoqqplgshsz65bwegih7kxhgd547fcofm7@yb6xqors6snx>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <iypdqo2s5oobenjrmoqqplgshsz65bwegih7kxhgd547fcofm7@yb6xqors6snx>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Mar 12, 2026 at 08:13:18PM +0800, Hao Li wrote:
> On Thu, Mar 12, 2026 at 07:56:31PM +0800, Ming Lei wrote:
> > On Thu, Mar 12, 2026 at 07:26:28PM +0800, Hao Li wrote:
> > > On Tue, Feb 24, 2026 at 10:52:28AM +0800, Ming Lei wrote:
> > > > Hello Vlastimil and MM guys,
> > > > 
> > > > The SLUB "sheaves" series merged via 815c8e35511d ("Merge branch
> > > > 'slab/for-7.0/sheaves' into slab/for-next") introduces a severe
> > > > performance regression for workloads with persistent cross-CPU
> > > > alloc/free patterns. ublk null target benchmark IOPS drops
> > > > significantly compared to v6.19: from ~36M IOPS to ~13M IOPS (~64%
> > > > drop).
> > > > 
> > > > Bisecting within the sheaves series is blocked by a kernel panic at
> > > > 17c38c88294d ("slab: remove cpu (partial) slabs usage from allocation
> > > > paths"), so the exact first bad commit could not be identified.
> > > > 
> > > > Reproducer
> > > > ==========
> > > > 
> > > > Hardware: NUMA machine with >= 32 CPUs
> > > > Kernel:   v7.0-rc (with slab/for-7.0/sheaves merged)
> > > > 
> > > >     # build kublk selftest
> > > >     make -C tools/testing/selftests/ublk/
> > > > 
> > > >     # create ublk null target device with 16 queues
> > > >     tools/testing/selftests/ublk/kublk add -t null -q 16
> > > > 
> > > >     # run fio/t/io_uring benchmark: 16 jobs, 20 seconds, non-polled
> > > >     taskset -c 0-31 fio/t/io_uring -p0 -n 16 -r 20 /dev/ublkb0
> > > > 
> > > >     # cleanup
> > > >     tools/testing/selftests/ublk/kublk del -n 0
> > > > 
> > > > Good: v6.19 (and 41f1a08645ab, the mainline parent of the slab merge)
> > > > Bad:  815c8e35511d (Merge branch 'slab/for-7.0/sheaves' into slab/for-next)
> > > > 
> > > 
> > > Hi Ming,
> > > 
> > > I also have a similar machine, but my test results show that the IOPS is below
> > > 1M, only around 900K. That seems quite strange to me.
> > > 
> > > My test commands are:
> > > 
> > > ```bash
> > > tools/testing/selftests/ublk/kublk add -t null -q 16
> > > taskset -c 24-47 /home/haolee/fio/t/io_uring -p0 -n 16 -r 20 /dev/ublkb0
> > > ```
> > 
> > The command line looks similar with mine, just in my tests:
> > 
> > taskset -c 0-31 fio/t/io_uring -p0 -n 16 -r 20 /dev/ublkb0
> > 
> > so the test is run cpu 0~31, which covers all 8 numa node.
> 
> Oh, yes, this is a difference.
> 
> > 
> > Also what is the single job perf result on your setting?
> > 
> > /home/haolee/fio/t/io_uring -p0 -n 1 -r 20 /dev/ublkb0
> 
> If I use this command without taskset, the IOPS is still 900K...

So single job(-n 1) can reach 900K, which is not bad.

But if 16 jobs still can reach 1M, which looks not good.

In my machine, single job can reach 2.7M, 16jobs(taskset -c 0-31) can get 13M
on v7.0-rc3.


> 
> > 
> > > 
> > > Below are my machine numa info. Could there be something configured incorrectly
> > > on my side?
> > > 
> > > available: 8 nodes (0-7)
> > > node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23
> > > node 0 size: 193175 MB
> > > node 0 free: 164227 MB
> > > node 1 cpus: 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
> > > node 1 size: 0 MB
> > > node 1 free: 0 MB
> > > node 2 cpus: 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71
> > > node 2 size: 0 MB
> > > node 2 free: 0 MB
> > > node 3 cpus: 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
> > > node 3 size: 0 MB
> > > node 3 free: 0 MB
> > > node 4 cpus: 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119
> > > node 4 size: 193434 MB
> > > node 4 free: 189559 MB
> > > node 5 cpus: 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143
> > > node 5 size: 0 MB
> > > node 5 free: 0 MB
> > > node 6 cpus: 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167
> > > node 6 size: 0 MB
> > > node 6 free: 0 MB
> > > node 7 cpus: 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191
> > > node 7 size: 0 MB
> > > node 7 free: 0 MB
> > > node distances:
> > > node   0   1   2   3   4   5   6   7
> > >   0:  10  12  12  12  32  32  32  32
> > >   1:  12  10  12  12  32  32  32  32
> > >   2:  12  12  10  12  32  32  32  32
> > >   3:  12  12  12  10  32  32  32  32
> > >   4:  32  32  32  32  10  12  12  12
> > >   5:  32  32  32  32  12  10  12  12
> > >   6:  32  32  32  32  12  12  10  12
> > >   7:  32  32  32  32  12  12  12  10
> > 
> > The nuam topo is different with mine, please see:
> > 
> > https://lore.kernel.org/all/aZ7p9uF8H8u6RxrK@fedora/
> 
> Yes, our NUMA topology does have some differences, but I feel there may be some
> other factors affecting my test results as well.
> 
> Even when I run with "-p0 -n 16 -r 20 /dev/ublkb0" without using taskset to pin
> the CPU affinity, the best performance I can get is only around 10M.

What is the data when you run same test on v6.19?
 
Thanks,
Ming

