Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061C8C352A3
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 04:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C752521734
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 04:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgBMEiZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:38:25 -0500
Received: from mga14.intel.com ([192.55.52.115]:13111 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbgBMEiY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Feb 2020 23:38:24 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2020 20:38:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,434,1574150400"; 
   d="gz'50?scan'50,208,50";a="222522298"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Feb 2020 20:38:21 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1j26Gb-0002I1-7f; Thu, 13 Feb 2020 12:38:21 +0800
Date:   Thu, 13 Feb 2020 12:38:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     yu kuai <yukuai3@huawei.com>
Cc:     kbuild-all@lists.01.org, axboe@kernel.dk, ming.lei@redhat.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, zhangxiaoxu5@huawei.com,
        luoshijie1@huawei.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: rename 'q->debugfs_dir' in blk_unregister_queue()
Message-ID: <202002131252.CCCKxfBv%lkp@intel.com>
References: <20200211035137.19454-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20200211035137.19454-1-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi yu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on block/for-next]
[also build test ERROR on v5.6-rc1 next-20200212]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/yu-kuai/block-rename-q-debugfs_dir-in-blk_unregister_queue/20200213-091022
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-4) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   block/blk-sysfs.c: In function 'blk_prepare_release_queue':
>> block/blk-sysfs.c:1030:22: error: 'struct request_queue' has no member named 'debugfs_dir'
     if (IS_ERR_OR_NULL(q->debugfs_dir))
                         ^~
   block/blk-sysfs.c:1031:11: error: 'struct request_queue' has no member named 'debugfs_dir'
      return q->debugfs_dir;
              ^~
>> block/blk-sysfs.c:1035:24: error: 'blk_debugfs_root' undeclared (first use in this function); did you mean 'blk_mq_debugfs_attr'?
      new = debugfs_rename(blk_debugfs_root, q->debugfs_dir,
                           ^~~~~~~~~~~~~~~~
                           blk_mq_debugfs_attr
   block/blk-sysfs.c:1035:24: note: each undeclared identifier is reported only once for each function it appears in
   block/blk-sysfs.c:1035:43: error: 'struct request_queue' has no member named 'debugfs_dir'
      new = debugfs_rename(blk_debugfs_root, q->debugfs_dir,
                                              ^~
   block/blk-sysfs.c: In function 'blk_unregister_queue':
   block/blk-sysfs.c:1070:3: error: 'struct request_queue' has no member named 'debugfs_dir'
     q->debugfs_dir = blk_prepare_release_queue(q);
      ^~

vim +1030 block/blk-sysfs.c

  1014	
  1015	/*
  1016	 * blk_prepare_release_queue - rename q->debugfs_dir
  1017	 * @q: request_queue of which the dir to be renamed belong to.
  1018	 *
  1019	 * Because the final release of request_queue is in a workqueue, the
  1020	 * cleanup might not been finished yet while the same device start to
  1021	 * create. It's not correct if q->debugfs_dir still exist while trying
  1022	 * to create a new one.
  1023	 */
  1024	static struct dentry *blk_prepare_release_queue(struct request_queue *q)
  1025	{
  1026		struct dentry *new = NULL;
  1027		char name[DNAME_INLINE_LEN];
  1028		int i = 0;
  1029	
> 1030		if (IS_ERR_OR_NULL(q->debugfs_dir))
  1031			return q->debugfs_dir;
  1032	
  1033		while (new == NULL) {
  1034			sprintf(name, "ready_to_remove_%d", i++);
> 1035			new = debugfs_rename(blk_debugfs_root, q->debugfs_dir,
  1036					     blk_debugfs_root, name);
  1037		}
  1038	
  1039		return new;
  1040	}
  1041	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--5mCyUwZo2JvN/JJP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--5mCyUwZo2JvN/JJP--
