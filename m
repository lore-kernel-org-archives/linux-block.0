Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9F6C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 14:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE9160E90
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 14:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbhIOOm4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 10:42:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:43947 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233745AbhIOOmz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 10:42:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="201840636"
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="gz'50?scan'50,208,50";a="201840636"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 07:41:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,295,1624345200"; 
   d="gz'50?scan'50,208,50";a="529506231"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 Sep 2021 07:41:32 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mQW6N-0000Dp-UU; Wed, 15 Sep 2021 14:41:31 +0000
Date:   Wed, 15 Sep 2021 22:41:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] block: hold ->invalidate_lock in blkdev_fallocate
Message-ID: <202109152226.ob8m5TxP-lkp@intel.com>
References: <20210915123545.1000534-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
In-Reply-To: <20210915123545.1000534-1-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Ming,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.14-rc7]
[cannot apply to v5.15-rc1 next-20210915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ming-Lei/block-hold-invalidate_lock-in-blkdev_fallocate/20210915-203759
base:    e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/802c451a54927267d87a707d2a5fe3e47bc4ca1c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ming-Lei/block-hold-invalidate_lock-in-blkdev_fallocate/20210915-203759
        git checkout 802c451a54927267d87a707d2a5fe3e47bc4ca1c
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/block_dev.c: In function 'blkdev_fallocate':
>> fs/block_dev.c:1730:9: error: implicit declaration of function 'filemap_invalidate_lock' [-Werror=implicit-function-declaration]
    1730 |         filemap_invalidate_lock(inode->i_mapping);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
>> fs/block_dev.c:1762:9: error: implicit declaration of function 'filemap_invalidate_unlock' [-Werror=implicit-function-declaration]
    1762 |         filemap_invalidate_unlock(inode->i_mapping);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/filemap_invalidate_lock +1730 fs/block_dev.c

  1694	
  1695	#define	BLKDEV_FALLOC_FL_SUPPORTED					\
  1696			(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |		\
  1697			 FALLOC_FL_ZERO_RANGE | FALLOC_FL_NO_HIDE_STALE)
  1698	
  1699	static long blkdev_fallocate(struct file *file, int mode, loff_t start,
  1700				     loff_t len)
  1701	{
  1702		struct inode *inode = bdev_file_inode(file);
  1703		struct block_device *bdev = I_BDEV(inode);
  1704		loff_t end = start + len - 1;
  1705		loff_t isize;
  1706		int error;
  1707	
  1708		/* Fail if we don't recognize the flags. */
  1709		if (mode & ~BLKDEV_FALLOC_FL_SUPPORTED)
  1710			return -EOPNOTSUPP;
  1711	
  1712		/* Don't go off the end of the device. */
  1713		isize = i_size_read(bdev->bd_inode);
  1714		if (start >= isize)
  1715			return -EINVAL;
  1716		if (end >= isize) {
  1717			if (mode & FALLOC_FL_KEEP_SIZE) {
  1718				len = isize - start;
  1719				end = start + len - 1;
  1720			} else
  1721				return -EINVAL;
  1722		}
  1723	
  1724		/*
  1725		 * Don't allow IO that isn't aligned to logical block size.
  1726		 */
  1727		if ((start | len) & (bdev_logical_block_size(bdev) - 1))
  1728			return -EINVAL;
  1729	
> 1730		filemap_invalidate_lock(inode->i_mapping);
  1731	
  1732		/* Invalidate the page cache, including dirty pages. */
  1733		error = truncate_bdev_range(bdev, file->f_mode, start, end);
  1734		if (error)
  1735			goto fail;
  1736	
  1737		switch (mode) {
  1738		case FALLOC_FL_ZERO_RANGE:
  1739		case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE:
  1740			error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
  1741						    GFP_KERNEL, BLKDEV_ZERO_NOUNMAP);
  1742			break;
  1743		case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE:
  1744			error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
  1745						     GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
  1746			break;
  1747		case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
  1748			error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
  1749						     GFP_KERNEL, 0);
  1750			break;
  1751		default:
  1752			error = -EOPNOTSUPP;
  1753		}
  1754		/*
  1755		 * Invalidate the page cache again; if someone wandered in and dirtied
  1756		 * a page, we just discard it - userspace has no way of knowing whether
  1757		 * the write happened before or after discard completing...
  1758		 */
  1759		if (!error)
  1760			error = truncate_bdev_range(bdev, file->f_mode, start, end);
  1761	 fail:
> 1762		filemap_invalidate_unlock(inode->i_mapping);
  1763		return error;
  1764	}
  1765	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--rwEMma7ioTxnRzrJ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
zxjOpo2HCygl5e0NbR4gW6bV4Ymon1L3MAK6rdLw6ozYKUnsZcuntQKGKLoL4hSrwtldv2wP
67fddkUdTTHIp8RAAdpwTDysKn172T+R9WVx0UgaukbjSeuoPxXE7W4BbftnjQqWvvb8583b
v3p73Fv/bCOH9g1Qn/fya/sExcXWp5zSKLIy5Oy2y8fV9oV7kKSrK7NZ9ke4W6/3qyV0/f12
J+65Sk6xSt7N53jGVdCh6WbxaHNYK2r/ffPrEU0tTScRA4XXdjP0q0QDDmjTUedWpAkjObt2
Wf39+/IX9BPbkSRdnwYIXN6ZAzPEq/qbq5OitkrYWbPn2AAJdTYJ84CJA5qhxz+nY6WMIUUw
0jCbEp5d+X1vBa0kvLrye9vJHG8B7TO6Bg5v1KM1B2E/2Ks0eUHBzAp1hTOaU8jdTagfkA2I
kdEcI4mVd4MfsBGKfT9ejNPEQx33Cp+ie0zWJoMC4PSQ50HC3KVofINzKiu8iDmoIBdetYp4
dhffY/NYthg2vwj+ZsL90mzmLa7ukhhvzliX3CMX9gg5xuZIaE+jdcNnPPhiM35CDakGmPuy
fd0ctjtKA3OxaRPI6+ru3uvjbrt51CUQHBjyVNAXzQ27pnwzJ3UM8OsuotEUY9JWGPROeS8w
OBPSvXZhG4qbA1u3yuOTMrSNqjJkrkYLkTLOCZGIuZUpfXx9FavK6GESxpge9tTWGptTi+kW
WcdLg8hX08rYNSZeJAYI9BsWBIBa+82o2XhmNMysvFqE9GcB7XpBBnoD5caAc5QFCK2IeORY
p0XCZkmgcM+PuqQi8CtEj7MadsP6c//oD650ZvzNMsML4v4xnruVpgKBtQvu43/wpBlPGoYF
252p7yD2S0dbEhE5Hg2v+CcRR9+jVFxuQFDjDQtzIFSZAhBcpGSSAZl1B+mGB1uMLiclJnSh
6WGhQfExxYhBZcIkyMxEltGjpSk7gnZXZhcIVbCo0e6P1XoOE8R9lTLRoehYFxY3XP8rMr2I
QrleTIANznRdmwi4maWiwS2ykg/L1bN1l1oQaG7NiUlxK/bBpzyN/xhMBlLqEEJHFOm329sL
rlXVIOyQmvfQdStrUlr8EXrlH8EM/4IaYb69HS4TT1bhLuolE5sFfzeQUX46CBBI7vvN9VeK
LuBwiWK0/P5hs9/e3X359ulSx5vQWKsyvGPEp2oBvaRLYtE2gt/VA0ot2K/fH7cSk7DTM3hm
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
qgAA

--rwEMma7ioTxnRzrJ--
