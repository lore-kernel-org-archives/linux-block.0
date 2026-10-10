Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB46372EDD;
	Sat, 10 Oct 2026 04:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791608333; cv=none; b=Ti5qpcTZUFwvjdX2LOECJi8GdJurPt3yBmL+yCXkH8RnFXuO7N5kfHnoFGSVhDel4a+6lQhPQUDBue3rKUGD/Ntbcb1fDnagNEN30cOYigdToUhD1MxnCB2LHgnmiuQ49Ww1R0dEGoLwB6lGYiREXYce4WBarcsSLzMvtEyzHuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791608333; c=relaxed/simple;
	bh=wPLfCe6T+S/gCrFoE2GfzPMLJXw739UlhNUlKDcz5Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sCcCBfFfrV4AjFLkILJkVVLz9l6k90RrsVGeIi9gaC+yLecNiTHC2Utp9MJ+8fhxEkLIHnn+no+06dk3dhY225TnXL9Rm3B0R6+CYLJM5KAsZgoV2EHJyxTubUFt8BYechaTq2UOBb7carCH8IAyt3JzFUJYMX+5KULmyrydFW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xouw0ooQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xouw0ooQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791608332; x=1823144332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wPLfCe6T+S/gCrFoE2GfzPMLJXw739UlhNUlKDcz5Qo=;
  b=Xouw0ooQCD+gpCVToIy+q3e30HTH9N2Hj8qucDomCrC9pxk+XteEbd/I
   Nrvc65CUFWCDIcX2E/iS214ZCtqwnrRidpgH0W6rapi6OA3Y1TO+ToKL/
   c382H5TYXyLoginOJxaOcDi7jEb3KSujc9A1BCpdZG6ydt/NYT4u6UK9n
   fIyBgOTE2fmUlU4oUUFS5dJctffPKz4GigICsGPa0YP2tz04gV1FrGz5t
   8/h5HosaGXSkaAMZUYmQ+pRnkLwfotSd6mWa1gqVeRK+y9YkLxJIvbkCm
   bc8FryfJ3wS/0ecQG2hBOEF/zejBOtpb9+CEVEO0ONO2jn3mUG5k4Ei4q
   g==;
X-CSE-ConnectionGUID: Z0ac+qITQ0CSAT+x85JzCg==
X-CSE-MsgGUID: Ts70k95VSa2Bye8vnaTldQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="419635"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="419635"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 21:58:51 -0700
X-CSE-ConnectionGUID: aNlxjUvIR1K9yDLAbMhm9A==
X-CSE-MsgGUID: ob+7cjSZQbqK+04lE0pgWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="926771"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 09 Oct 2026 21:58:49 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFPAT-000000006VZ-2EwS;
	Sat, 10 Oct 2026 04:58:45 +0000
Date: Sat, 10 Oct 2026 12:58:11 +0800
From: kernel test robot <lkp@intel.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>, mst@redhat.com,
	jasowangio@gmail.com, axboe@kernel.dk, ebiggers@kernel.org,
	stefanha@redhat.com
Cc: oe-kbuild-all@lists.linux.dev, pbonzini@redhat.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] virtio_blk: add inline encryption support
Message-ID: <202610101218.PA25qZJG-lkp@intel.com>
References: <20261009041727.3170811-3-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009041727.3170811-3-linlin.zhang@oss.qualcomm.com>

Hi Linlin,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe/for-next]
[also build test ERROR on mst-vhost/linux-next linus/master v7.3-rc6 next-20261008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Linlin-Zhang/virtio_blk-Add-control-virtqueue-support/20261008-211713
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git for-next
patch link:    https://lore.kernel.org/r/20261009041727.3170811-3-linlin.zhang%40oss.qualcomm.com
patch subject: [PATCH v4 2/2] virtio_blk: add inline encryption support
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20261010/202610101218.PA25qZJG-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610101218.PA25qZJG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610101218.PA25qZJG-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/block/virtio_blk.c: In function 'virtblk_setup_cmd':
>> drivers/block/virtio_blk.c:414:61: error: 'struct request' has no member named 'crypt_keyslot'
     414 |                                 blk_crypto_keyslot_index(req->crypt_keyslot));
         |                                                             ^~
>> drivers/block/virtio_blk.c:417:58: error: 'struct request' has no member named 'crypt_ctx'
     417 |                                 cpu_to_virtio64(vdev, req->crypt_ctx->bc_dun[i]);
         |                                                          ^~
   drivers/block/virtio_blk.c: At top level:
   drivers/block/virtio_blk.c:1066:12: warning: 'virtblk_ctrl_vq_request' defined but not used [-Wunused-function]
    1066 | static int virtblk_ctrl_vq_request(struct virtio_blk *vblk,
         |            ^~~~~~~~~~~~~~~~~~~~~~~


vim +414 drivers/block/virtio_blk.c

   318	
   319	static blk_status_t virtblk_setup_cmd(struct virtio_device *vdev,
   320					      struct request *req,
   321					      struct virtblk_req *vbr)
   322	{
   323		size_t in_hdr_len = sizeof(vbr->in_hdr.status);
   324		bool unmap = false;
   325		u32 type;
   326		u64 sector = 0;
   327		int i;
   328	
   329		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED) && op_is_zone_mgmt(req_op(req)))
   330			return BLK_STS_NOTSUPP;
   331	
   332		/* Set fields for all request types */
   333		vbr->out_hdr.base.ioprio = cpu_to_virtio32(vdev, req_get_ioprio(req));
   334	
   335		switch (req_op(req)) {
   336		case REQ_OP_READ:
   337			if (is_crypto_request(req))
   338				type = VIRTIO_BLK_T_CRYPTO_IN;
   339			else
   340				type = VIRTIO_BLK_T_IN;
   341			sector = blk_rq_pos(req);
   342			break;
   343		case REQ_OP_WRITE:
   344			if (is_crypto_request(req))
   345				type = VIRTIO_BLK_T_CRYPTO_OUT;
   346			else
   347				type = VIRTIO_BLK_T_OUT;
   348			sector = blk_rq_pos(req);
   349			break;
   350		case REQ_OP_FLUSH:
   351			type = VIRTIO_BLK_T_FLUSH;
   352			break;
   353		case REQ_OP_DISCARD:
   354			type = VIRTIO_BLK_T_DISCARD;
   355			break;
   356		case REQ_OP_WRITE_ZEROES:
   357			type = VIRTIO_BLK_T_WRITE_ZEROES;
   358			unmap = !(req->cmd_flags & REQ_NOUNMAP);
   359			break;
   360		case REQ_OP_SECURE_ERASE:
   361			type = VIRTIO_BLK_T_SECURE_ERASE;
   362			break;
   363		case REQ_OP_ZONE_OPEN:
   364			type = VIRTIO_BLK_T_ZONE_OPEN;
   365			sector = blk_rq_pos(req);
   366			break;
   367		case REQ_OP_ZONE_CLOSE:
   368			type = VIRTIO_BLK_T_ZONE_CLOSE;
   369			sector = blk_rq_pos(req);
   370			break;
   371		case REQ_OP_ZONE_FINISH:
   372			type = VIRTIO_BLK_T_ZONE_FINISH;
   373			sector = blk_rq_pos(req);
   374			break;
   375		case REQ_OP_ZONE_APPEND:
   376			type = VIRTIO_BLK_T_ZONE_APPEND;
   377			sector = blk_rq_pos(req);
   378			in_hdr_len = sizeof(vbr->in_hdr.zone_append);
   379			break;
   380		case REQ_OP_ZONE_RESET:
   381			type = VIRTIO_BLK_T_ZONE_RESET;
   382			sector = blk_rq_pos(req);
   383			break;
   384		case REQ_OP_ZONE_RESET_ALL:
   385			type = VIRTIO_BLK_T_ZONE_RESET_ALL;
   386			break;
   387		case REQ_OP_DRV_IN:
   388			/*
   389			 * Out header has already been prepared by the caller (virtblk_get_id()
   390			 * or virtblk_submit_zone_report()), nothing to do here.
   391			 */
   392			return 0;
   393		default:
   394			WARN_ON_ONCE(1);
   395			return BLK_STS_IOERR;
   396		}
   397	
   398		/* Set fields for non-REQ_OP_DRV_IN request types */
   399		vbr->in_hdr_len = in_hdr_len;
   400		vbr->out_hdr.base.type = cpu_to_virtio32(vdev, type);
   401		vbr->out_hdr.base.sector = cpu_to_virtio64(vdev, sector);
   402	
   403		if (type == VIRTIO_BLK_T_DISCARD || type == VIRTIO_BLK_T_WRITE_ZEROES ||
   404		    type == VIRTIO_BLK_T_SECURE_ERASE) {
   405			if (virtblk_setup_discard_write_zeroes_erase(req, unmap))
   406				return BLK_STS_RESOURCE;
   407		}
   408	
   409		if (type == VIRTIO_BLK_T_CRYPTO_IN || type == VIRTIO_BLK_T_CRYPTO_OUT) {
   410			memset(&vbr->out_hdr.crypto_append.msg, 0,
   411				sizeof(vbr->out_hdr.crypto_append.msg));
   412			vbr->out_hdr.crypto_append.msg.slot =
   413				cpu_to_virtio32(vdev,
 > 414					blk_crypto_keyslot_index(req->crypt_keyslot));
   415			for (i = 0; i < ARRAY_SIZE(vbr->out_hdr.crypto_append.msg.dun); i++) {
   416				vbr->out_hdr.crypto_append.msg.dun[i] =
 > 417					cpu_to_virtio64(vdev, req->crypt_ctx->bc_dun[i]);
   418			}
   419		}
   420	
   421		return 0;
   422	}
   423	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
