Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2252AC0502F
	for <linux-block@archiver.kernel.org>; Mon, 29 Aug 2022 00:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiH2ASs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Aug 2022 20:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiH2ASr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Aug 2022 20:18:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D212A96F;
        Sun, 28 Aug 2022 17:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661732325; x=1693268325;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mk5UPQJPubSdANz7LkgFR4Rv6GSap6ZQud459DTNGWU=;
  b=mFCVdaO6l0yaIMSftGLkmfKZvtqW2c70EcWwoXPKTXLYhO6jvBK5n1Fn
   ysG1F8M3j2i7+kAq0CZVCWDz1sn6UCkxzeUJGBlX1nWPLhlpFw9BUrx55
   ZcBrB1hM6rooKcR9ezK1kR3HggMAUzNzfFORHsHyct7YzQtDVvTZFoL5p
   KR9kDXhM0OW6RFtPcTuZ967mRJkLUzan+HOTOuyRbdMiNn6H5MEoaPet1
   uu9AAVDPdlXIEmDSgG8G1gjxC1fIpt7ShJIENaGum+rJkgluJpB0o7kx1
   Hqb/YdBzC379ybSAc/04BllzA9KtJCdqYrAAjNcYN6wP9Ezj52qHsdkxg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="296053861"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="296053861"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 17:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="753445007"
Received: from lkp-server01.sh.intel.com (HELO fc16deae1c42) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Aug 2022 17:18:42 -0700
Received: from kbuild by fc16deae1c42 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oSSUD-0001lh-1Y;
        Mon, 29 Aug 2022 00:18:41 +0000
Date:   Mon, 29 Aug 2022 08:18:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Richard W . M . Jones" <rjones@redhat.com>,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: Re: [PATCH] Docs: ublk: add ublk document
Message-ID: <202208290807.1BIaKsuK-lkp@intel.com>
References: <20220828045003.537131-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828045003.537131-1-ming.lei@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

I love your patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on lwn-2.6/docs-next linus/master v6.0-rc2 next-20220826]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ming-Lei/Docs-ublk-add-ublk-document/20220828-125214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/4cd40d237bac08efb23668766ba39b36a0b1632a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ming-Lei/Docs-ublk-add-ublk-document/20220828-125214
        git checkout 4cd40d237bac08efb23668766ba39b36a0b1632a
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/block/ublk.rst: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
