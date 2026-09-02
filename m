Received: from mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E003B47DF
	for <linux-block@vger.kernel.org>; Wed,  2 Sep 2026 23:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390631; cv=none; b=V4AAJnOF4ay2D2tuQ5l7NV96Fg8gbFamHfjI8XN4sjeTYdli/QHC533G6m4KpTJf9kQA0Wnt37SY8UqWjIuA9ZK7ieoR6Y/hEO0LMCMYQjt3SmlCqo5+TlUF54aOzmydcXEsNeg6hrQXqwrpiXDy6CV+bTQ+QUlk/GLOJXcO/cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390631; c=relaxed/simple;
	bh=gh0fIpKiPd0DP6/RuTzi5CpiJJOPRkFRWWSg57qcjP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBLXd4b8IQao4UmUtk2mDtjaiLZRmWv14JuVqb90xwzzCr6hLuQ7+J1+g5hKNtfW4TkLPFndxnKOl5iGxlsh+PGYBjPJXz2hILGCgMt3oOKADP+HbaUQcAXViQBN2SDehr9f95R77F3oNKvwewLWJB8+q8LyoSBVCUZCPlDV5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g5GAOmHr; arc=none smtp.client-ip=91.218.175.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g5GAOmHr"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=gh0fIpKiPd0DP6/RuTzi5CpiJJOPRkFRWWSg57qcjP0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788390624; v=1; x=1788995424;
 b=g5GAOmHrH9h9fSPe8sVCYbE/pbjm3LHnXzLzdTBsSeQQH0nFnBbRCr0G/2BSNOZE6gCKRtaH
 qZKs9txtSEdfl4pZKSy0geWGtB5cmQTtt1E/BHgfjJRlQV6pelaYhSfoQl57Pkm5XEt+d2+Xl3l
 k57GVP+fx/ryzBj5hTqVX2vg=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1b76ea144a7bccf6;
	Wed, 02 Sep 2026 23:10:02 +0000
X-Mizu-Trace-ID: 1b76ea144a7bccf6
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 16:10:01 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Ziyang Men <ziyang.meme@gmail.com>
Cc: kernel-team@meta.com, Jens Axboe <axboe@kernel.dk>, 
	Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Ben Segall <bsegall@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>, Mykola Lysenko <mykolal@meta.com>, linux-block@vger.kernel.org, 
	bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] cgroup: expose cpu.stat and io.stat to BPF
Message-ID: <apisezhyZe_3vp0x@linux.dev>
References: <20260820211758.3393984-1-ziyang.meme@gmail.com>
 <apX9KtGrmfA7u0zV@devvm16600.scu0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apX9KtGrmfA7u0zV@devvm16600.scu0.facebook.com>

On Mon, Aug 31, 2026 at 03:16:10PM -0700, Ziyang Men wrote:
> Hi Reviewers,
> 
> Just want to follow-up on this patch series. Please let me know the possible
> issues and I will fix them.
> 

AI bots have raised real concerns. Please address those and then resubmit.

