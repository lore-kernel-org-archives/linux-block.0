Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8484C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 01:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiCVB6H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 21:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbiCVB6G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 21:58:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B54037BFB
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 18:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647914200; x=1679450200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ulc+oGET9j6DNlpWj/HczbXJfqJE/opE8gnWWtf+C1Y=;
  b=ieJHwQPoeQuko778Bpd9LlEqoOYzy06cZVvNtsc7Vj1JucErs1excKAk
   CVi5LQ296ChTQWZ8tVJvLz4VzV/rgmwxTlBe99Z6f7pt+u9C2cwcfTreS
   A3KmICh3VWYxLyaxuXqlakVfhWiSX2kI4teuVo128u3xjkvRLLmBGCufT
   Xh3K00Sdrhag7JXXl4ijVFEPJwnv9qc1CiQ42qx9EA6jiGbsuQon+g698
   OaPxvwxXvEqXlAawRwj0FjxogLwstZsKML6l75YmEhQ9rWnKeILG4lOB8
   qYCVbvy5o8JRCbfBI9giIP1rPbc0jFS9ptcA6cxOL1Dt1NrgEDiRlvPP3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="239855254"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="239855254"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 18:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="716723862"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Mar 2022 18:56:37 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWTlE-000ILI-LX; Tue, 22 Mar 2022 01:56:36 +0000
Date:   Tue, 22 Mar 2022 09:56:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suwan Kim <suwan.kim027@gmail.com>, mst@redhat.com,
        jasowang@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
        mgurtovoy@nvidia.com
Cc:     kbuild-all@lists.01.org, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH v2 1/2] virtio-blk: support polling I/O
Message-ID: <202203220946.YKj9GuI8-lkp@intel.com>
References: <20220321142441.132888-2-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321142441.132888-2-suwan.kim027@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Suwan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.17]
[also build test WARNING on next-20220321]
[cannot apply to axboe-block/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Suwan-Kim/virtio-blk-support-polling-I-O-and-mq_ops-queue_rqs/20220321-223027
base:    f443e374ae131c168a065ea1748feac6b2e76613
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220322/202203220946.YKj9GuI8-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/5388c0729248236712cf865643a2190989dabbb5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Suwan-Kim/virtio-blk-support-polling-I-O-and-mq_ops-queue_rqs/20220321-223027
        git checkout 5388c0729248236712cf865643a2190989dabbb5
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/block/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/block/virtio_blk.c:803:66: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected int ioerror @@     got restricted blk_status_t @@
   drivers/block/virtio_blk.c:803:66: sparse:     expected int ioerror
   drivers/block/virtio_blk.c:803:66: sparse:     got restricted blk_status_t

vim +803 drivers/block/virtio_blk.c

   788	
   789	static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
   790	{
   791		struct virtio_blk_vq *vq = hctx->driver_data;
   792		struct virtblk_req *vbr;
   793		unsigned long flags;
   794		unsigned int len;
   795		int found = 0;
   796	
   797		spin_lock_irqsave(&vq->lock, flags);
   798	
   799		while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
   800			struct request *req = blk_mq_rq_from_pdu(vbr);
   801	
   802			found++;
 > 803			if (!blk_mq_add_to_batch(req, iob, virtblk_result(vbr),
   804							virtblk_complete_batch))
   805				blk_mq_complete_request(req);
   806		}
   807	
   808		spin_unlock_irqrestore(&vq->lock, flags);
   809	
   810		return found;
   811	}
   812	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
