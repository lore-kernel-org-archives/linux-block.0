Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FC1236442;
	Wed, 11 Jun 2025 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629329; cv=none; b=SgvMSFTfMdWBies2fuLhnwBzWh11tbNkLnxpfPDrypsS9Li81DP8gdGuXJ/kIvr/HJU3ordUsulMc96S1jh5KDaWdrPJDIJ9XIve96+/FEcOTkJXTJRwBI3NX0lEH+nBjpRFCYPOuIRb6LHfUPlsePrNuu26SS+eCwfMvdjtGos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629329; c=relaxed/simple;
	bh=KnDDIm1qdlSLJu6NRdL1REmX0JGZlnsrv3PCGBq43EA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=epIz3+2AAGmcM8RLyunSUvCv5BWhAo4cVnok336EXkyS5vvChX05up+Br3YAcIQQOKs/ekn9WF9rl+cwUKKzUfN2y5Mrc9neUHAyT2QPrDMM1LAdvXVeMal51fLP3ex7WAgNPUHYyrBYNWmVzgFA9hbIurhdSiHAm6DEV15QxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlCArnYK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlCArnYK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00B7C4CEEE;
	Wed, 11 Jun 2025 08:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749629328;
	bh=KnDDIm1qdlSLJu6NRdL1REmX0JGZlnsrv3PCGBq43EA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mlCArnYKvWQxUvCbz8RvRMFtZNr42NmT7Q9XAEjp8ompSWW2qHkeQMvs53y2u0KXL
	 AfmrN/qe2ArIkPmZT534OEuHDkwVQcUiYK1JPMReT/I9XTeM20oGdTz2UCSBe1xFbK
	 6tYcITPwfUzxq1Dit5n9E4s8GHoKNBlYLMqEutPthurbLfcQqxoPNay+s6aXUYazKt
	 SV4uwxJday6lj/RwuUIDeams+Cw3oxBsd4f23/qTPD81DQjJqjGYyeaikB3ErE4+7R
	 ZQ8ZiCBwH/kMrCostxqQEF4WF1qLQAT0NwxdEYN7ufnJGZZwyAy39Gt/IX/WKqQgM1
	 +T9brn5188S+g==
Date: Wed, 11 Jun 2025 17:08:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kernel test robot <lkp@intel.com>, axboe@kernel.dk, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Jason Xing <kernelxing@tencent.com>,
 Yushan Zhou <katrinzhou@tencent.com>
Subject: Re: [PATCH v4 4/5] blktrace: use rbuf->stats.full as a drop
 indicator in relayfs
Message-Id: <20250611170845.8f88347e3cba51cf15a01b21@kernel.org>
In-Reply-To: <CAL+tcoARvQVgd68HGoXXiK=+RSH12WQ_rc47B4rgtt2Eb05c0w@mail.gmail.com>
References: <20250610004844.66688-5-kerneljasonxing@gmail.com>
	<202506102340.uo7QDaVk-lkp@intel.com>
	<CAL+tcoARvQVgd68HGoXXiK=+RSH12WQ_rc47B4rgtt2Eb05c0w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 11 Jun 2025 13:15:40 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

> On Wed, Jun 11, 2025 at 9:42 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Jason,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on axboe-block/for-next]
> > [also build test WARNING on drm-i915/for-linux-next drm-i915/for-linux-next-fixes akpm-mm/mm-everything linus/master v6.16-rc1 next-20250610]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Jason-Xing/relayfs-abolish-prev_padding/20250610-085150
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
> > patch link:    https://lore.kernel.org/r/20250610004844.66688-5-kerneljasonxing%40gmail.com
> > patch subject: [PATCH v4 4/5] blktrace: use rbuf->stats.full as a drop indicator in relayfs
> > config: arc-randconfig-001-20250610
> > compiler: arc-linux-gcc (GCC) 12.4.0
> > reproduce (this is a W=1 build):
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202506102340.uo7QDaVk-lkp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    kernel/trace/blktrace.c: In function 'blk_dropped_read':
> > >> kernel/trace/blktrace.c:421:39: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
> >      421 |         snprintf(buf, sizeof(buf), "%lu\n", dropped);
> >          |                                     ~~^     ~~~~~~~
> >          |                                       |     |
> >          |                                       |     size_t {aka unsigned int}
> >          |                                       long unsigned int
> >          |                                     %u
> 
> Well, I suppose I will fix it in the re-spin after receiving more
> comments so that I don't need to quickly respond to this minor issue.

Please update the patch and send series with my reviewed-by on 1/5.
BTW, size_t should use %zu.
Please check Documentation/core-api/printk-formats.rst

Thank you,

> 
> Thanks,
> Jason
> 
> >
> >
> > vim +421 kernel/trace/blktrace.c
> >
> >    413
> >    414  static ssize_t blk_dropped_read(struct file *filp, char __user *buffer,
> >    415                                  size_t count, loff_t *ppos)
> >    416  {
> >    417          struct blk_trace *bt = filp->private_data;
> >    418          size_t dropped = relay_stats(bt->rchan, RELAY_STATS_BUF_FULL);
> >    419          char buf[16];
> >    420
> >  > 421          snprintf(buf, sizeof(buf), "%lu\n", dropped);
> >    422
> >    423          return simple_read_from_buffer(buffer, count, ppos, buf, strlen(buf));
> >    424  }
> >    425
> >
> > --
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
