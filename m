Return-Path: <ming.lei@redhat.com>
Date: Thu, 8 Mar 2018 18:05:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V2 3/5] genirq/affinity: move actual irq vector spread
 into one helper
Message-ID: <20180308100454.GA31062@ming.t460p>
References: <20180305031357.23950-4-ming.lei@redhat.com>
 <201803060052.L1IpJHee%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201803060052.L1IpJHee%fengguang.wu@intel.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 06, 2018 at 12:28:32AM +0800, kbuild test robot wrote:
> Hi Ming,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on tip/irq/core]
> [also build test WARNING on v4.16-rc4 next-20180305]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Ming-Lei/genirq-affinity-irq-vector-spread-among-online-CPUs-as-far-as-possible/20180305-184912
> config: i386-randconfig-a1-201809 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All warnings (new ones prefixed by >>):
> 
>    kernel/irq/affinity.c: In function 'irq_create_affinity_masks':
> >> kernel/irq/affinity.c:201:50: warning: passing argument 3 of 'irq_build_affinity_masks' from incompatible pointer type
>      curvec += irq_build_affinity_masks(nvecs, affd, node_to_cpumask,
>                                                      ^
>    kernel/irq/affinity.c:97:12: note: expected 'const struct cpumask (*)[1]' but argument is of type 'struct cpumask (*)[1]'
>     static int irq_build_affinity_masks(int nvecs, const struct irq_affinity *affd,

Looks this warning can only be triggered on ARCH=i386 with gcc-4.X.

Can't reproduce it when building on other ARCHs, and can't reproduce
it with gcc-6 too.


Thanks,
Ming
