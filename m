Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC05C433EF
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 00:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B106109D
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 00:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhJ0AX6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 20:23:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:5464 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhJ0AX6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 20:23:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="210826738"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="gz'50?scan'50,208,50";a="210826738"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 17:21:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="gz'50?scan'50,208,50";a="446987996"
Received: from lkp-server01.sh.intel.com (HELO 072b454ebba8) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Oct 2021 17:21:19 -0700
Received: from kbuild by 072b454ebba8 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mfWgw-0000fM-DX; Wed, 27 Oct 2021 00:21:18 +0000
Date:   Wed, 27 Oct 2021 08:20:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 6/8] loop: relax loop dio use condition
Message-ID: <202110270857.3pvIHsi1-lkp@intel.com>
References: <20211025094437.2837701-7-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211025094437.2837701-7-ming.lei@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Ming,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.15-rc6]
[cannot apply to axboe-block/for-next next-20211026]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ming-Lei/loop-improve-dio-on-backing-file/20211025-174819
base:    519d81956ee277b4419c723adfb154603c2565ba
config: parisc-buildonly-randconfig-r002-20211026 (attached as .config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f98a33d68a04634ba8f8314e9da480abc332b1f4
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ming-Lei/loop-improve-dio-on-backing-file/20211025-174819
        git checkout f98a33d68a04634ba8f8314e9da480abc332b1f4
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/block/loop.c: In function 'loop_configure':
>> drivers/block/loop.c:1133:23: error: variable 'inode' set but not used [-Werror=unused-but-set-variable]
    1133 |         struct inode *inode;
         |                       ^~~~~
   cc1: all warnings being treated as errors


vim +/inode +1133 drivers/block/loop.c

62ab466ca881fe2 Martijn Coenen      2020-05-13  1127  
3448914e8cc550b Martijn Coenen      2020-05-13  1128  static int loop_configure(struct loop_device *lo, fmode_t mode,
3448914e8cc550b Martijn Coenen      2020-05-13  1129  			  struct block_device *bdev,
3448914e8cc550b Martijn Coenen      2020-05-13  1130  			  const struct loop_config *config)
^1da177e4c3f415 Linus Torvalds      2005-04-16  1131  {
3ce6e1f662a9109 Tetsuo Handa        2021-07-06  1132  	struct file *file = fget(config->fd);
^1da177e4c3f415 Linus Torvalds      2005-04-16 @1133  	struct inode *inode;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1134  	struct address_space *mapping;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1135  	int error;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1136  	loff_t size;
85b0a54a82e4fbc Jan Kara            2018-11-08  1137  	bool partscan;
3448914e8cc550b Martijn Coenen      2020-05-13  1138  	unsigned short bsize;
3ce6e1f662a9109 Tetsuo Handa        2021-07-06  1139  	bool is_loop;
3ce6e1f662a9109 Tetsuo Handa        2021-07-06  1140  
3ce6e1f662a9109 Tetsuo Handa        2021-07-06  1141  	if (!file)
3ce6e1f662a9109 Tetsuo Handa        2021-07-06  1142  		return -EBADF;
3ce6e1f662a9109 Tetsuo Handa        2021-07-06  1143  	is_loop = is_loop_device(file);
^1da177e4c3f415 Linus Torvalds      2005-04-16  1144  
^1da177e4c3f415 Linus Torvalds      2005-04-16  1145  	/* This is safe, since we have a reference from open(). */
^1da177e4c3f415 Linus Torvalds      2005-04-16  1146  	__module_get(THIS_MODULE);
^1da177e4c3f415 Linus Torvalds      2005-04-16  1147  
33ec3e53e7b1869 Jan Kara            2019-05-16  1148  	/*
33ec3e53e7b1869 Jan Kara            2019-05-16  1149  	 * If we don't hold exclusive handle for the device, upgrade to it
33ec3e53e7b1869 Jan Kara            2019-05-16  1150  	 * here to avoid changing device under exclusive owner.
33ec3e53e7b1869 Jan Kara            2019-05-16  1151  	 */
33ec3e53e7b1869 Jan Kara            2019-05-16  1152  	if (!(mode & FMODE_EXCL)) {
37c3fc9abb25cd7 Christoph Hellwig   2020-11-25  1153  		error = bd_prepare_to_claim(bdev, loop_configure);
ecbe6bc0003bfd5 Christoph Hellwig   2020-07-16  1154  		if (error)
757ecf40b7e0295 Jan Kara            2018-11-08  1155  			goto out_putf;
33ec3e53e7b1869 Jan Kara            2019-05-16  1156  	}
33ec3e53e7b1869 Jan Kara            2019-05-16  1157  
3ce6e1f662a9109 Tetsuo Handa        2021-07-06  1158  	error = loop_global_lock_killable(lo, is_loop);
33ec3e53e7b1869 Jan Kara            2019-05-16  1159  	if (error)
33ec3e53e7b1869 Jan Kara            2019-05-16  1160  		goto out_bdev;
757ecf40b7e0295 Jan Kara            2018-11-08  1161  
^1da177e4c3f415 Linus Torvalds      2005-04-16  1162  	error = -EBUSY;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1163  	if (lo->lo_state != Lo_unbound)
757ecf40b7e0295 Jan Kara            2018-11-08  1164  		goto out_unlock;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1165  
d2ac838e4cd7e5e Theodore Ts'o       2018-05-07  1166  	error = loop_validate_file(file, bdev);
d2ac838e4cd7e5e Theodore Ts'o       2018-05-07  1167  	if (error)
757ecf40b7e0295 Jan Kara            2018-11-08  1168  		goto out_unlock;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1169  
^1da177e4c3f415 Linus Torvalds      2005-04-16  1170  	mapping = file->f_mapping;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1171  	inode = mapping->host;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1172  
3448914e8cc550b Martijn Coenen      2020-05-13  1173  	if ((config->info.lo_flags & ~LOOP_CONFIGURE_SETTABLE_FLAGS) != 0) {
3448914e8cc550b Martijn Coenen      2020-05-13  1174  		error = -EINVAL;
3448914e8cc550b Martijn Coenen      2020-05-13  1175  		goto out_unlock;
3448914e8cc550b Martijn Coenen      2020-05-13  1176  	}
3448914e8cc550b Martijn Coenen      2020-05-13  1177  
3448914e8cc550b Martijn Coenen      2020-05-13  1178  	if (config->block_size) {
3448914e8cc550b Martijn Coenen      2020-05-13  1179  		error = loop_validate_block_size(config->block_size);
3448914e8cc550b Martijn Coenen      2020-05-13  1180  		if (error)
3448914e8cc550b Martijn Coenen      2020-05-13  1181  			goto out_unlock;
3448914e8cc550b Martijn Coenen      2020-05-13  1182  	}
3448914e8cc550b Martijn Coenen      2020-05-13  1183  
3448914e8cc550b Martijn Coenen      2020-05-13  1184  	error = loop_set_status_from_info(lo, &config->info);
3448914e8cc550b Martijn Coenen      2020-05-13  1185  	if (error)
3448914e8cc550b Martijn Coenen      2020-05-13  1186  		goto out_unlock;
3448914e8cc550b Martijn Coenen      2020-05-13  1187  
456be1484ffc72a Christoph Hellwig   2011-10-17  1188  	if (!(file->f_mode & FMODE_WRITE) || !(mode & FMODE_WRITE) ||
283e7e5d249f486 Al Viro             2015-04-03  1189  	    !file->f_op->write_iter)
3448914e8cc550b Martijn Coenen      2020-05-13  1190  		lo->lo_flags |= LO_FLAGS_READ_ONLY;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1191  
87579e9b7d8dc36 Dan Schatzberg      2021-06-28  1192  	lo->workqueue = alloc_workqueue("loop%d",
87579e9b7d8dc36 Dan Schatzberg      2021-06-28  1193  					WQ_UNBOUND | WQ_FREEZABLE,
87579e9b7d8dc36 Dan Schatzberg      2021-06-28  1194  					0,
87579e9b7d8dc36 Dan Schatzberg      2021-06-28  1195  					lo->lo_number);
87579e9b7d8dc36 Dan Schatzberg      2021-06-28  1196  	if (!lo->workqueue) {
87579e9b7d8dc36 Dan Schatzberg      2021-06-28  1197  		error = -ENOMEM;
757ecf40b7e0295 Jan Kara            2018-11-08  1198  		goto out_unlock;
87579e9b7d8dc36 Dan Schatzberg      2021-06-28  1199  	}
^1da177e4c3f415 Linus Torvalds      2005-04-16  1200  
9f65c489b68d424 Matteo Croce        2021-07-13  1201  	disk_force_media_change(lo->lo_disk, DISK_EVENT_MEDIA_CHANGE);
7a2f0ce19f2e2ed Christoph Hellwig   2020-11-03  1202  	set_disk_ro(lo->lo_disk, (lo->lo_flags & LO_FLAGS_READ_ONLY) != 0);
^1da177e4c3f415 Linus Torvalds      2005-04-16  1203  
87579e9b7d8dc36 Dan Schatzberg      2021-06-28  1204  	INIT_WORK(&lo->rootcg_work, loop_rootcg_workfn);
87579e9b7d8dc36 Dan Schatzberg      2021-06-28  1205  	INIT_LIST_HEAD(&lo->rootcg_cmd_list);
87579e9b7d8dc36 Dan Schatzberg      2021-06-28  1206  	INIT_LIST_HEAD(&lo->idle_worker_list);
87579e9b7d8dc36 Dan Schatzberg      2021-06-28  1207  	lo->worker_tree = RB_ROOT;
87579e9b7d8dc36 Dan Schatzberg      2021-06-28  1208  	timer_setup(&lo->timer, loop_free_idle_workers,
87579e9b7d8dc36 Dan Schatzberg      2021-06-28  1209  		TIMER_DEFERRABLE);
3448914e8cc550b Martijn Coenen      2020-05-13  1210  	lo->use_dio = lo->lo_flags & LO_FLAGS_DIRECT_IO;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1211  	lo->lo_device = bdev;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1212  	lo->lo_backing_file = file;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1213  	lo->old_gfp_mask = mapping_gfp_mask(mapping);
^1da177e4c3f415 Linus Torvalds      2005-04-16  1214  	mapping_set_gfp_mask(mapping, lo->old_gfp_mask & ~(__GFP_IO|__GFP_FS));
^1da177e4c3f415 Linus Torvalds      2005-04-16  1215  
3448914e8cc550b Martijn Coenen      2020-05-13  1216  	if (!(lo->lo_flags & LO_FLAGS_READ_ONLY) && file->f_op->fsync)
21d0727f639e4ba Jens Axboe          2016-03-30  1217  		blk_queue_write_cache(lo->lo_queue, true, false);
68db1961bbf4e16 Nikanth Karthikesan 2009-03-24  1218  
3448914e8cc550b Martijn Coenen      2020-05-13  1219  	if (config->block_size)
3448914e8cc550b Martijn Coenen      2020-05-13  1220  		bsize = config->block_size;
3448914e8cc550b Martijn Coenen      2020-05-13  1221  	else
3448914e8cc550b Martijn Coenen      2020-05-13  1222  		bsize = 512;
85560117d00f5d5 Martijn Coenen      2019-09-04  1223  
85560117d00f5d5 Martijn Coenen      2019-09-04  1224  	blk_queue_logical_block_size(lo->lo_queue, bsize);
85560117d00f5d5 Martijn Coenen      2019-09-04  1225  	blk_queue_physical_block_size(lo->lo_queue, bsize);
85560117d00f5d5 Martijn Coenen      2019-09-04  1226  	blk_queue_io_min(lo->lo_queue, bsize);
85560117d00f5d5 Martijn Coenen      2019-09-04  1227  
2b9ac22b12a266e Kristian Klausen    2021-06-18  1228  	loop_config_discard(lo);
56a85fd8376ef32 Holger Hoffstätte   2019-02-12  1229  	loop_update_rotational(lo);
2e5ab5f379f96a6 Ming Lei            2015-08-17  1230  	loop_update_dio(lo);
ee86273062cbb31 Milan Broz          2010-08-23  1231  	loop_sysfs_init(lo);
79e5dc59e2974a4 Martijn Coenen      2020-08-25  1232  
79e5dc59e2974a4 Martijn Coenen      2020-08-25  1233  	size = get_loop_size(lo, file);
5795b6f5607f7e4 Martijn Coenen      2020-05-13  1234  	loop_set_size(lo, size);
^1da177e4c3f415 Linus Torvalds      2005-04-16  1235  
3ce6e1f662a9109 Tetsuo Handa        2021-07-06  1236  	/* Order wrt reading lo_state in loop_validate_file(). */
3ce6e1f662a9109 Tetsuo Handa        2021-07-06  1237  	wmb();
3ce6e1f662a9109 Tetsuo Handa        2021-07-06  1238  
6c9979185c7ef4f Serge E. Hallyn     2006-09-29  1239  	lo->lo_state = Lo_bound;
e03c8dd14915fab Kay Sievers         2011-08-23  1240  	if (part_shift)
e03c8dd14915fab Kay Sievers         2011-08-23  1241  		lo->lo_flags |= LO_FLAGS_PARTSCAN;
85b0a54a82e4fbc Jan Kara            2018-11-08  1242  	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN;
fe6a8fc5ed2f008 Lennart Poettering  2020-08-10  1243  	if (partscan)
fe6a8fc5ed2f008 Lennart Poettering  2020-08-10  1244  		lo->lo_disk->flags &= ~GENHD_FL_NO_PART_SCAN;
c1681bf8a7b1b98 Anatol Pomozov      2013-04-01  1245  
3ce6e1f662a9109 Tetsuo Handa        2021-07-06  1246  	loop_global_unlock(lo, is_loop);
85b0a54a82e4fbc Jan Kara            2018-11-08  1247  	if (partscan)
0384264ea8a39bd Christoph Hellwig   2021-06-24  1248  		loop_reread_partitions(lo);
37c3fc9abb25cd7 Christoph Hellwig   2020-11-25  1249  	if (!(mode & FMODE_EXCL))
37c3fc9abb25cd7 Christoph Hellwig   2020-11-25  1250  		bd_abort_claiming(bdev, loop_configure);
^1da177e4c3f415 Linus Torvalds      2005-04-16  1251  	return 0;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1252  
757ecf40b7e0295 Jan Kara            2018-11-08  1253  out_unlock:
3ce6e1f662a9109 Tetsuo Handa        2021-07-06  1254  	loop_global_unlock(lo, is_loop);
33ec3e53e7b1869 Jan Kara            2019-05-16  1255  out_bdev:
37c3fc9abb25cd7 Christoph Hellwig   2020-11-25  1256  	if (!(mode & FMODE_EXCL))
37c3fc9abb25cd7 Christoph Hellwig   2020-11-25  1257  		bd_abort_claiming(bdev, loop_configure);
^1da177e4c3f415 Linus Torvalds      2005-04-16  1258  out_putf:
^1da177e4c3f415 Linus Torvalds      2005-04-16  1259  	fput(file);
^1da177e4c3f415 Linus Torvalds      2005-04-16  1260  	/* This is safe: open() is still holding a reference. */
^1da177e4c3f415 Linus Torvalds      2005-04-16  1261  	module_put(THIS_MODULE);
^1da177e4c3f415 Linus Torvalds      2005-04-16  1262  	return error;
^1da177e4c3f415 Linus Torvalds      2005-04-16  1263  }
^1da177e4c3f415 Linus Torvalds      2005-04-16  1264  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--sdtB3X0nJg68CQEu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ZiYdMANTXGmzOmlSWDq82eh06fYfBzmuvJkYAgA=

--sdtB3X0nJg68CQEu--
