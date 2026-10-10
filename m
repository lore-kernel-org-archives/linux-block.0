Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015491FF7C7;
	Sat, 10 Oct 2026 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791594856; cv=none; b=S9zvqg1jfbaQe5aBkrDu7JoPdTy8SSySybR0O8knx+kGIKSkeyo5WUFvTptIq7yZMxhVahYtrPHLv8ZBF2TzckLWCkZKt0c7YkLXf6gjFFIeTE/a/mQzGpKlITqBDnRRBQZxKjJ/i+zCACus/Oc0JoiZUkBPmNFHrY4iHHFe/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791594856; c=relaxed/simple;
	bh=wWi1fYkDfEMTATllQGmVnSdpixloEtWsRLbg8D3c0CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H557mdemHU/+HOsonLOX6s9X1kYDbp+CXRnYtOA1B9tVdxtqV44Buzu6Rh7qugHi+c8ohCDxfcy0c7FIvkN0LvQ0GY0Nz/xTMI9A79ggn/b0VC4BoKQVTCn6bNE+5jxKMis+rOpx27tvoTrYt6ml+tSf5MhljV6uq7vMiiEKR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDkqYl5O; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDkqYl5O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791594855; x=1823130855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wWi1fYkDfEMTATllQGmVnSdpixloEtWsRLbg8D3c0CA=;
  b=KDkqYl5OtatMRDaVq4Lia2DnC/aTrjO0jg+7VbA7Z7xRxyt+ku5sY0QI
   Ei9iCSmUKTbzAfTKI0j5DpvUXlIGuPZziG5kKuWup04VFGC3bhieym278
   fFE3R7A1xOcRKYRvEWk33rAu0oJBHtxHCVnvum4kh/ngZHJu/Ir0ygqs0
   znMM22yptgtPZL0vq3uX++mPEOO0MfciEUg5BQuH74JMY0az+9ZIkKVB2
   4yrsg6qosbJOVUnZsxHaovRs+UlLXont1+8UoIUyY6ZEZUGtZkpq9cB6m
   0lKerP/ZDLvKqQ5qy7U/ekEE/bEl7ERCHRfH/Tw8/hxIFY3H8GVfrat9Z
   g==;
X-CSE-ConnectionGUID: f3myjKmHTqGvmz4vG0XzLQ==
X-CSE-MsgGUID: f1cSIbHNSla6c768jP4qUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="405943"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="405943"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 18:14:14 -0700
X-CSE-ConnectionGUID: chpxsJ+ETrWnsIo+xkBV6g==
X-CSE-MsgGUID: Dau6AiOOQPuK5q7NyBoScg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="434275"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Oct 2026 18:14:11 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFLf6-000000006MY-3LSv;
	Sat, 10 Oct 2026 01:14:08 +0000
Date: Sat, 10 Oct 2026 09:13:29 +0800
From: kernel test robot <lkp@intel.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>, mst@redhat.com,
	jasowangio@gmail.com, axboe@kernel.dk, ebiggers@kernel.org,
	stefanha@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, pbonzini@redhat.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] virtio_blk: Add control virtqueue support
Message-ID: <202610100905.au1oY0vX-lkp@intel.com>
References: <20261009041727.3170811-2-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009041727.3170811-2-linlin.zhang@oss.qualcomm.com>

Hi Linlin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe/for-next]
[also build test WARNING on mst-vhost/linux-next linus/master v7.3-rc6 next-20261008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Linlin-Zhang/virtio_blk-Add-control-virtqueue-support/20261008-211713
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20261009041727.3170811-2-linlin.zhang%40oss.qualcomm.com
patch subject: [PATCH v4 1/2] virtio_blk: Add control virtqueue support
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20261010/202610100905.au1oY0vX-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610100905.au1oY0vX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610100905.au1oY0vX-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/block/virtio_blk.c:1000:12: warning: 'virtblk_ctrl_vq_request' defined but not used [-Wunused-function]
    1000 | static int virtblk_ctrl_vq_request(struct virtio_blk *vblk,
         |            ^~~~~~~~~~~~~~~~~~~~~~~


vim +/virtblk_ctrl_vq_request +1000 drivers/block/virtio_blk.c

   998	
   999	/* Submit a control-queue request and wait for completion. */
> 1000	static int virtblk_ctrl_vq_request(struct virtio_blk *vblk,
  1001					    struct virtblk_ctrl_request *creq,
  1002					    struct scatterlist *sgs[],
  1003					    unsigned int out_sgs, unsigned int in_sgs)
  1004	{
  1005		struct virtblk_ctrl_completion *comp;
  1006		unsigned long flags;
  1007		int err;
  1008	
  1009		/*
  1010		 * GFP_NOIO: this may be reached on the bio-submission path
  1011		 * (memory reclaim writing back dirty pages to this same device),
  1012		 * so GFP_KERNEL could self-deadlock.
  1013		 */
  1014		comp = kmalloc_obj(*comp, GFP_NOIO);
  1015		if (!comp)
  1016			return -ENOMEM;
  1017		init_completion(&comp->done);
  1018		comp->abandoned = false;
  1019	
  1020		mutex_lock(&vblk->ctrl_vq.mutex);
  1021		creq->compl = comp;
  1022	
  1023		spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
  1024		if (vblk->ctrl_vq.dead) {
  1025			spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
  1026			mutex_unlock(&vblk->ctrl_vq.mutex);
  1027			kfree(comp);
  1028			creq->compl = NULL;
  1029			return -ENODEV;
  1030		}
  1031		err = virtqueue_add_sgs(vblk->ctrl_vq.vq, sgs, out_sgs, in_sgs, creq, GFP_ATOMIC);
  1032		if (!err) {
  1033			vblk->ctrl_vq.inflight++;
  1034			virtqueue_kick(vblk->ctrl_vq.vq);
  1035		}
  1036		spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
  1037		if (err) {
  1038			mutex_unlock(&vblk->ctrl_vq.mutex);
  1039			kfree(comp);
  1040			creq->compl = NULL;
  1041			return err;
  1042		}
  1043	
  1044		if (wait_for_completion_timeout(&comp->done, VIRTBLK_CTRL_VQ_TIMEOUT)) {
  1045			mutex_unlock(&vblk->ctrl_vq.mutex);
  1046			kfree(comp);
  1047			creq->compl = NULL;
  1048			return 0;
  1049		}
  1050	
  1051		/*
  1052		 * The host hasn't responded within the timeout. @creq is still
  1053		 * owned by the device, so don't touch its DMA-target fields or
  1054		 * free it here. Mark it abandoned and hand ownership of both @creq
  1055		 * and @comp to whichever of virtblk_ctrlq_callback() or
  1056		 * virtblk_ctrl_vq_drain() retrieves the buffer later; unlock the
  1057		 * mutex so subsequent requests aren't serialized behind an
  1058		 * unresponsive host.
  1059		 */
  1060		spin_lock_irqsave(&vblk->ctrl_vq.lock, flags);
  1061		comp->abandoned = true;
  1062		spin_unlock_irqrestore(&vblk->ctrl_vq.lock, flags);
  1063		mutex_unlock(&vblk->ctrl_vq.mutex);
  1064	
  1065		dev_warn(&vblk->vdev->dev,
  1066			 "control queue request timed out, abandoning\n");
  1067		return -ETIMEDOUT;
  1068	}
  1069	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
