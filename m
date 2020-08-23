Return-Path: <SRS0=Vt9R=CB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464E6C433E1
	for <linux-block@archiver.kernel.org>; Sun, 23 Aug 2020 19:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C39204FD
	for <linux-block@archiver.kernel.org>; Sun, 23 Aug 2020 19:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgHWTps (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 23 Aug 2020 15:45:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:28962 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbgHWTps (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 23 Aug 2020 15:45:48 -0400
IronPort-SDR: riXUOaDUJ9nzE07u8SaWZ+QXwG6nDhA3Jx0nC8oWgZGCCrKVKR9BPT9eMNsEueFm+aobvIUe7D
 EAEiUIPSSbHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="156863850"
X-IronPort-AV: E=Sophos;i="5.76,345,1592895600"; 
   d="gz'50?scan'50,208,50";a="156863850"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2020 12:45:42 -0700
IronPort-SDR: 7XtFeHHrtfNw8+rfVEfg6ge0yq9fX6DsL6Xb0q2h4HYAQUmLJ3STApIvgHrrEEeEwarSfuGxGo
 DcoJmo/ecCAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,345,1592895600"; 
   d="gz'50?scan'50,208,50";a="311948604"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Aug 2020 12:45:38 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k9vvo-0002FM-LE; Sun, 23 Aug 2020 19:45:32 +0000
Date:   Mon, 24 Aug 2020 03:44:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xianting Tian <tian.xianting@h3c.com>, axboe@kernel.dk,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org
Cc:     kbuild-all@lists.01.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] blk-mq: use BLK_MQ_NO_TAG for no tag
Message-ID: <202008240309.E7Tnz0nb%lkp@intel.com>
References: <20200823154459.40731-1-tian.xianting@h3c.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20200823154459.40731-1-tian.xianting@h3c.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Xianting,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on block/for-next]
[also build test ERROR on linux/master linus/master v5.9-rc1 next-20200821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Xianting-Tian/blk-mq-use-BLK_MQ_NO_TAG-for-no-tag/20200824-012255
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: alpha-randconfig-s031-20200824 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/lightnvm/pblk.h:25,
                    from drivers/lightnvm/pblk-init.c:22:
   include/linux/blk-mq.h: In function 'request_to_qc_t':
>> include/linux/blk-mq.h:572:17: error: 'BLK_MQ_NO_TAG' undeclared (first use in this function)
     572 |  if (rq->tag != BLK_MQ_NO_TAG)
         |                 ^~~~~~~~~~~~~
   include/linux/blk-mq.h:572:17: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from include/scsi/scsi_host.h:11,
                    from drivers/scsi/scsi_sysfs.c:19:
   include/linux/blk-mq.h: In function 'request_to_qc_t':
>> include/linux/blk-mq.h:572:17: error: 'BLK_MQ_NO_TAG' undeclared (first use in this function)
     572 |  if (rq->tag != BLK_MQ_NO_TAG)
         |                 ^~~~~~~~~~~~~
   include/linux/blk-mq.h:572:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/scsi/scsi_sysfs.c: At top level:
   drivers/scsi/scsi_sysfs.c:1027:10: fatal error: scsi_devinfo_tbl.c: No such file or directory
    1027 | #include "scsi_devinfo_tbl.c"
         |          ^~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from include/scsi/scsi_request.h:5,
                    from include/scsi/scsi_cmnd.h:13,
                    from drivers/scsi/BusLogic.c:46:
   include/linux/blk-mq.h: In function 'request_to_qc_t':
>> include/linux/blk-mq.h:572:17: error: 'BLK_MQ_NO_TAG' undeclared (first use in this function)
     572 |  if (rq->tag != BLK_MQ_NO_TAG)
         |                 ^~~~~~~~~~~~~
   include/linux/blk-mq.h:572:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/scsi/BusLogic.c: In function 'blogic_msg':
   drivers/scsi/BusLogic.c:3591:2: warning: function 'blogic_msg' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    3591 |  len = vsprintf(buf, fmt, args);
         |  ^~~
--
   In file included from include/scsi/scsi_request.h:5,
                    from include/scsi/scsi_cmnd.h:13,
                    from drivers/scsi/dpt_i2o.c:62:
   include/linux/blk-mq.h: In function 'request_to_qc_t':
>> include/linux/blk-mq.h:572:17: error: 'BLK_MQ_NO_TAG' undeclared (first use in this function)
     572 |  if (rq->tag != BLK_MQ_NO_TAG)
         |                 ^~~~~~~~~~~~~
   include/linux/blk-mq.h:572:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/scsi/dpt_i2o.c: In function 'adpt_slave_configure':
   drivers/scsi/dpt_i2o.c:411:12: warning: variable 'pHba' set but not used [-Wunused-but-set-variable]
     411 |  adpt_hba* pHba;
         |            ^~~~
--
   In file included from include/scsi/scsi_request.h:5,
                    from include/scsi/scsi_cmnd.h:13,
                    from drivers/scsi/aha1542.c:23:
   include/linux/blk-mq.h: In function 'request_to_qc_t':
>> include/linux/blk-mq.h:572:17: error: 'BLK_MQ_NO_TAG' undeclared (first use in this function)
     572 |  if (rq->tag != BLK_MQ_NO_TAG)
         |                 ^~~~~~~~~~~~~
   include/linux/blk-mq.h:572:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/scsi/aha1542.c: In function 'aha1542_test_port':
   drivers/scsi/aha1542.c:195:5: warning: variable 'inquiry_result' set but not used [-Wunused-but-set-variable]
     195 |  u8 inquiry_result[4];
         |     ^~~~~~~~~~~~~~
--
   In file included from include/scsi/scsi_request.h:5,
                    from include/scsi/scsi_cmnd.h:13,
                    from drivers/scsi/qla1280.c:355:
   include/linux/blk-mq.h: In function 'request_to_qc_t':
>> include/linux/blk-mq.h:572:17: error: 'BLK_MQ_NO_TAG' undeclared (first use in this function)
     572 |  if (rq->tag != BLK_MQ_NO_TAG)
         |                 ^~~~~~~~~~~~~
   include/linux/blk-mq.h:572:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/scsi/qla1280.c: In function 'qla1280_done':
   drivers/scsi/qla1280.c:1244:19: warning: variable 'lun' set but not used [-Wunused-but-set-variable]
    1244 |  int bus, target, lun;
         |                   ^~~
   drivers/scsi/qla1280.c: In function 'qla1280_nvram_config':
   drivers/scsi/qla1280.c:2188:36: warning: variable 'ddma_conf' set but not used [-Wunused-but-set-variable]
    2188 |   uint16_t hwrev, cfg1, cdma_conf, ddma_conf;
         |                                    ^~~~~~~~~
   drivers/scsi/qla1280.c: In function 'qla1280_mailbox_command':
   drivers/scsi/qla1280.c:2430:11: warning: variable 'data' set but not used [-Wunused-but-set-variable]
    2430 |  uint16_t data;
         |           ^~~~
   drivers/scsi/qla1280.c: In function 'qla1280_status_entry':
   drivers/scsi/qla1280.c:3607:28: warning: variable 'lun' set but not used [-Wunused-but-set-variable]
    3607 |  unsigned int bus, target, lun;
         |                            ^~~
   drivers/scsi/qla1280.c:3607:20: warning: variable 'target' set but not used [-Wunused-but-set-variable]
    3607 |  unsigned int bus, target, lun;
         |                    ^~~~~~
   drivers/scsi/qla1280.c:3607:15: warning: variable 'bus' set but not used [-Wunused-but-set-variable]
    3607 |  unsigned int bus, target, lun;
         |               ^~~
--
   In file included from include/scsi/scsi_request.h:5,
                    from include/scsi/scsi_cmnd.h:13,
                    from drivers/scsi/dc395x.c:64:
   include/linux/blk-mq.h: In function 'request_to_qc_t':
>> include/linux/blk-mq.h:572:17: error: 'BLK_MQ_NO_TAG' undeclared (first use in this function)
     572 |  if (rq->tag != BLK_MQ_NO_TAG)
         |                 ^~~~~~~~~~~~~
   include/linux/blk-mq.h:572:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/scsi/dc395x.c: In function 'start_scsi':
   drivers/scsi/dc395x.c:1359:6: warning: variable 's_stat2' set but not used [-Wunused-but-set-variable]
    1359 |  u16 s_stat2, return_code;
         |      ^~~~~~~
   drivers/scsi/dc395x.c: In function 'data_io_transfer':
   drivers/scsi/dc395x.c:2400:16: warning: variable 'data2' set but not used [-Wunused-but-set-variable]
    2400 |   u8 data = 0, data2 = 0;
         |                ^~~~~
   drivers/scsi/dc395x.c:2400:6: warning: variable 'data' set but not used [-Wunused-but-set-variable]
    2400 |   u8 data = 0, data2 = 0;
         |      ^~~~
   drivers/scsi/dc395x.c: In function 'reselect':
   drivers/scsi/dc395x.c:2992:5: warning: variable 'arblostflag' set but not used [-Wunused-but-set-variable]
    2992 |  u8 arblostflag = 0;
         |     ^~~~~~~~~~~
   drivers/scsi/dc395x.c: In function 'doing_srb_done':
   drivers/scsi/dc395x.c:3393:28: warning: variable 'dir' set but not used [-Wunused-but-set-variable]
    3393 |    enum dma_data_direction dir;
         |                            ^~~
--
   In file included from include/scsi/scsi_request.h:5,
                    from include/scsi/scsi_cmnd.h:13,
                    from drivers/scsi/a100u2w.c:78:
   include/linux/blk-mq.h: In function 'request_to_qc_t':
>> include/linux/blk-mq.h:572:17: error: 'BLK_MQ_NO_TAG' undeclared (first use in this function)
     572 |  if (rq->tag != BLK_MQ_NO_TAG)
         |                 ^~~~~~~~~~~~~
   include/linux/blk-mq.h:572:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/scsi/a100u2w.c: In function 'inia100_probe_one':
   drivers/scsi/a100u2w.c:1092:8: warning: variable 'bios_phys' set but not used [-Wunused-but-set-variable]
    1092 |  char *bios_phys;
         |        ^~~~~~~~~
--
   In file included from include/scsi/scsi_host.h:11,
                    from drivers/scsi/myrb.c:21:
   include/linux/blk-mq.h: In function 'request_to_qc_t':
>> include/linux/blk-mq.h:572:17: error: 'BLK_MQ_NO_TAG' undeclared (first use in this function)
     572 |  if (rq->tag != BLK_MQ_NO_TAG)
         |                 ^~~~~~~~~~~~~
   include/linux/blk-mq.h:572:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/scsi/myrb.c: At top level:
   drivers/scsi/myrb.c:2492:6: warning: no previous prototype for 'myrb_err_status' [-Wmissing-prototypes]
    2492 | bool myrb_err_status(struct myrb_hba *cb, unsigned char error,
         |      ^~~~~~~~~~~~~~~
--
   In file included from include/scsi/scsi_host.h:11,
                    from drivers/scsi/myrs.c:22:
   include/linux/blk-mq.h: In function 'request_to_qc_t':
>> include/linux/blk-mq.h:572:17: error: 'BLK_MQ_NO_TAG' undeclared (first use in this function)
     572 |  if (rq->tag != BLK_MQ_NO_TAG)
         |                 ^~~~~~~~~~~~~
   include/linux/blk-mq.h:572:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/scsi/myrs.c: In function 'consistency_check_show':
   drivers/scsi/myrs.c:1194:16: warning: variable 'status' set but not used [-Wunused-but-set-variable]
    1194 |  unsigned char status;
         |                ^~~~~~
   drivers/scsi/myrs.c: At top level:
   drivers/scsi/myrs.c:1532:5: warning: no previous prototype for 'myrs_host_reset' [-Wmissing-prototypes]
    1532 | int myrs_host_reset(struct scsi_cmnd *scmd)
         |     ^~~~~~~~~~~~~~~
   drivers/scsi/myrs.c: In function 'myrs_get_resync':
   drivers/scsi/myrs.c:1985:5: warning: variable 'status' set but not used [-Wunused-but-set-variable]
    1985 |  u8 status;
         |     ^~~~~~
   drivers/scsi/myrs.c: At top level:
   drivers/scsi/myrs.c:2046:6: warning: no previous prototype for 'myrs_flush_cache' [-Wmissing-prototypes]
    2046 | void myrs_flush_cache(struct myrs_hba *cs)
         |      ^~~~~~~~~~~~~~~~
--
   In file included from include/scsi/scsi_host.h:11,
                    from drivers/scsi/3w-9xxx.c:97:
   include/linux/blk-mq.h: In function 'request_to_qc_t':
>> include/linux/blk-mq.h:572:17: error: 'BLK_MQ_NO_TAG' undeclared (first use in this function)
     572 |  if (rq->tag != BLK_MQ_NO_TAG)
         |                 ^~~~~~~~~~~~~
   include/linux/blk-mq.h:572:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/scsi/3w-9xxx.c: In function 'twa_empty_response_queue':
   drivers/scsi/3w-9xxx.c:942:24: warning: variable 'response_que_value' set but not used [-Wunused-but-set-variable]
     942 |  u32 status_reg_value, response_que_value;
         |                        ^~~~~~~~~~~~~~~~~~
   drivers/scsi/3w-9xxx.c: In function 'twa_scsi_biosparam':
   drivers/scsi/3w-9xxx.c:1701:23: warning: variable 'tw_dev' set but not used [-Wunused-but-set-variable]
    1701 |  TW_Device_Extension *tw_dev;
         |                       ^~~~~~
   drivers/scsi/3w-9xxx.c: In function 'twa_scsiop_execute_scsi':
   drivers/scsi/3w-9xxx.c:1812:22: warning: variable 'sglist' set but not used [-Wunused-but-set-variable]
    1812 |  struct scatterlist *sglist = NULL, *sg;
         |                      ^~~~~~
..

# https://github.com/0day-ci/linux/commit/3f57d0952e89e23c6c5b65b816d3f0a9c9747583
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Xianting-Tian/blk-mq-use-BLK_MQ_NO_TAG-for-no-tag/20200824-012255
git checkout 3f57d0952e89e23c6c5b65b816d3f0a9c9747583
vim +/BLK_MQ_NO_TAG +572 include/linux/blk-mq.h

   560	
   561	#define queue_for_each_hw_ctx(q, hctx, i)				\
   562		for ((i) = 0; (i) < (q)->nr_hw_queues &&			\
   563		     ({ hctx = (q)->queue_hw_ctx[i]; 1; }); (i)++)
   564	
   565	#define hctx_for_each_ctx(hctx, ctx, i)					\
   566		for ((i) = 0; (i) < (hctx)->nr_ctx &&				\
   567		     ({ ctx = (hctx)->ctxs[(i)]; 1; }); (i)++)
   568	
   569	static inline blk_qc_t request_to_qc_t(struct blk_mq_hw_ctx *hctx,
   570			struct request *rq)
   571	{
 > 572		if (rq->tag != BLK_MQ_NO_TAG)
   573			return rq->tag | (hctx->queue_num << BLK_QC_T_SHIFT);
   574	
   575		return rq->internal_tag | (hctx->queue_num << BLK_QC_T_SHIFT) |
   576				BLK_QC_T_INTERNAL;
   577	}
   578	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--opJtzjQTFsWo+cga
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--opJtzjQTFsWo+cga--
