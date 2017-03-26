Return-Path: <julia.lawall@lip6.fr>
Date: Sun, 26 Mar 2017 12:54:23 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Tahsin Erdogan <tahsin@google.com>
cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
    linux-block@vger.kernel.org, David Rientjes <rientjes@google.com>,
    linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
    David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blkcg: allocate struct blkcg_gq outside request queue
 spinlock
Message-ID: <alpine.DEB.2.20.1703261252310.2204@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-block@vger.kernel.org>

Is an unlock needed before line 848?  Or does blkg_lookup_check take care
of it?

julia

---------- Forwarded message ----------
Date: Sun, 26 Mar 2017 07:50:17 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] blkcg: allocate struct blkcg_gq outside request queue
    spinlock

CC: kbuild-all@01.org
In-Reply-To: <20170324215627.12831-1-tahsin@google.com>
TO: Tahsin Erdogan <tahsin@google.com>
CC: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org, Tahsin Erdogan <tahsin@google.com>
CC: linux-block@vger.kernel.org, David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org, Tahsin Erdogan <tahsin@google.com>

Hi Tahsin,

[auto build test WARNING on block/for-next]
[also build test WARNING on v4.11-rc3 next-20170324]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tahsin-Erdogan/blkcg-allocate-struct-blkcg_gq-outside-request-queue-spinlock/20170326-020755
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
:::::: branch date: 6 hours ago
:::::: commit date: 6 hours ago

>> block/blk-cgroup.c:901:1-7: preceding lock on line 839
   block/blk-cgroup.c:901:1-7: preceding lock on line 876

git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout d6344a76907e470f483dcb19998d438d19f6432d
vim +901 block/blk-cgroup.c

d6344a76 Tahsin Erdogan 2017-03-24  833  		goto fail;
5f6c2d2b Tejun Heo      2015-07-22  834  	}
e56da7e2 Tejun Heo      2012-03-05  835
d6344a76 Tahsin Erdogan 2017-03-24  836  	q = disk->queue;
d6344a76 Tahsin Erdogan 2017-03-24  837
e56da7e2 Tejun Heo      2012-03-05  838  	rcu_read_lock();
d6344a76 Tahsin Erdogan 2017-03-24 @839  	spin_lock_irq(q->queue_lock);
da8b0662 Tejun Heo      2012-04-13  840
d6344a76 Tahsin Erdogan 2017-03-24  841  	blkg = blkg_lookup_check(blkcg, pol, q);
d6344a76 Tahsin Erdogan 2017-03-24  842  	if (IS_ERR(blkg)) {
d6344a76 Tahsin Erdogan 2017-03-24  843  		ret = PTR_ERR(blkg);
d6344a76 Tahsin Erdogan 2017-03-24  844  		goto fail_unlock;
d6344a76 Tahsin Erdogan 2017-03-24  845  	}
d6344a76 Tahsin Erdogan 2017-03-24  846
d6344a76 Tahsin Erdogan 2017-03-24  847  	if (blkg)
d6344a76 Tahsin Erdogan 2017-03-24  848  		goto success;
d6344a76 Tahsin Erdogan 2017-03-24  849
d6344a76 Tahsin Erdogan 2017-03-24  850  	/*
d6344a76 Tahsin Erdogan 2017-03-24  851  	 * Create blkgs walking down from blkcg_root to @blkcg, so that all
d6344a76 Tahsin Erdogan 2017-03-24  852  	 * non-root blkgs have access to their parents.
d6344a76 Tahsin Erdogan 2017-03-24  853  	 */
d6344a76 Tahsin Erdogan 2017-03-24  854  	while (true) {
d6344a76 Tahsin Erdogan 2017-03-24  855  		struct blkcg *pos = blkcg;
d6344a76 Tahsin Erdogan 2017-03-24  856  		struct blkcg *parent;
d6344a76 Tahsin Erdogan 2017-03-24  857  		struct blkcg_gq *new_blkg;
e56da7e2 Tejun Heo      2012-03-05  858
d6344a76 Tahsin Erdogan 2017-03-24  859  		parent = blkcg_parent(blkcg);
d6344a76 Tahsin Erdogan 2017-03-24  860  		while (parent && !__blkg_lookup(parent, q, false)) {
d6344a76 Tahsin Erdogan 2017-03-24  861  			pos = parent;
d6344a76 Tahsin Erdogan 2017-03-24  862  			parent = blkcg_parent(parent);
d6344a76 Tahsin Erdogan 2017-03-24  863  		}
d6344a76 Tahsin Erdogan 2017-03-24  864
d6344a76 Tahsin Erdogan 2017-03-24  865  		/* Drop locks to do new blkg allocation with GFP_KERNEL. */
d6344a76 Tahsin Erdogan 2017-03-24  866  		spin_unlock_irq(q->queue_lock);
d6344a76 Tahsin Erdogan 2017-03-24  867  		rcu_read_unlock();
d6344a76 Tahsin Erdogan 2017-03-24  868
d6344a76 Tahsin Erdogan 2017-03-24  869  		new_blkg = blkg_alloc(pos, q, GFP_KERNEL);
d6344a76 Tahsin Erdogan 2017-03-24  870  		if (unlikely(!new_blkg)) {
d6344a76 Tahsin Erdogan 2017-03-24  871  			ret = -ENOMEM;
d6344a76 Tahsin Erdogan 2017-03-24  872  			goto fail;
d6344a76 Tahsin Erdogan 2017-03-24  873  		}
d6344a76 Tahsin Erdogan 2017-03-24  874
d6344a76 Tahsin Erdogan 2017-03-24  875  		rcu_read_lock();
d6344a76 Tahsin Erdogan 2017-03-24  876  		spin_lock_irq(q->queue_lock);
d6344a76 Tahsin Erdogan 2017-03-24  877
d6344a76 Tahsin Erdogan 2017-03-24  878  		blkg = blkg_lookup_check(pos, pol, q);
e56da7e2 Tejun Heo      2012-03-05  879  		if (IS_ERR(blkg)) {
e56da7e2 Tejun Heo      2012-03-05  880  			ret = PTR_ERR(blkg);
d6344a76 Tahsin Erdogan 2017-03-24  881  			goto fail_unlock;
d6344a76 Tahsin Erdogan 2017-03-24  882  		}
d6344a76 Tahsin Erdogan 2017-03-24  883
d6344a76 Tahsin Erdogan 2017-03-24  884  		if (blkg) {
d6344a76 Tahsin Erdogan 2017-03-24  885  			blkg_free(new_blkg);
d6344a76 Tahsin Erdogan 2017-03-24  886  		} else {
d6344a76 Tahsin Erdogan 2017-03-24  887  			blkg = blkg_create(pos, q, new_blkg);
d6344a76 Tahsin Erdogan 2017-03-24  888  			if (unlikely(IS_ERR(blkg))) {
d6344a76 Tahsin Erdogan 2017-03-24  889  				ret = PTR_ERR(blkg);
d6344a76 Tahsin Erdogan 2017-03-24  890  				goto fail_unlock;
d6344a76 Tahsin Erdogan 2017-03-24  891  			}
d6344a76 Tahsin Erdogan 2017-03-24  892  		}
d6344a76 Tahsin Erdogan 2017-03-24  893
d6344a76 Tahsin Erdogan 2017-03-24  894  		if (pos == blkcg)
d6344a76 Tahsin Erdogan 2017-03-24  895  			goto success;
d6344a76 Tahsin Erdogan 2017-03-24  896  	}
d6344a76 Tahsin Erdogan 2017-03-24  897  success:
d6344a76 Tahsin Erdogan 2017-03-24  898  	ctx->disk = disk;
d6344a76 Tahsin Erdogan 2017-03-24  899  	ctx->blkg = blkg;
d6344a76 Tahsin Erdogan 2017-03-24  900  	ctx->body = body;
d6344a76 Tahsin Erdogan 2017-03-24 @901  	return 0;
d6344a76 Tahsin Erdogan 2017-03-24  902
d6344a76 Tahsin Erdogan 2017-03-24  903  fail_unlock:
d6344a76 Tahsin Erdogan 2017-03-24  904  	spin_unlock_irq(q->queue_lock);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
