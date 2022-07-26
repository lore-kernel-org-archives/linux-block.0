Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3B7C43334
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 12:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiGZMyQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jul 2022 08:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiGZMyN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jul 2022 08:54:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A881EAF1;
        Tue, 26 Jul 2022 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658840052; x=1690376052;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XTPxGAICxEWFhnYWflofvTlfguVuwOZweDno0+oKceE=;
  b=YzU/s78boRoqoVCWzkJGGc+onhvDf4nHCbHDKFeNF8tCq1lbNkHsT3Jm
   J4mdsXgXSe7zhSJ3GGBZloCzMjHUXvma45rXILabvDUgVn3+9vmAvDRaZ
   kK0rif2uXCo+XH7Cnag5MTzxG7GQxAMlNkOIj9CrSjqzc2+aaCDFznGqD
   WhGFzYap8tomqNvonel5eLuJIRDr4Ckl2aA2ImG2XB69XYGosds3EfdCG
   FcSqgYY2TZzk5Sm3s3rf/sRIhDAjEkuja6uMcEAIqyrLJR4veTIRXPbDW
   IU+ElkEu4h7dLHSNzOTA63G2p3WtG7nm0yqNaqvhw7UBg/47ODuwsJwil
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="351937734"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="351937734"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 05:54:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="627887764"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2022 05:54:10 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGK4f-0006oy-2d;
        Tue, 26 Jul 2022 12:54:09 +0000
Date:   Tue, 26 Jul 2022 20:53:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     kbuild-all@lists.01.org, linux-m68k@vger.kernel.org,
        geert@linux-m68k.org, Michael Schmitz <schmitzmic@gmail.com>
Subject: Re: [PATCH v8 2/2] block: add overflow checks for Amiga partition
 support
Message-ID: <202207262047.yRImNV4v-lkp@intel.com>
References: <20220726045747.4779-3-schmitzmic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726045747.4779-3-schmitzmic@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Michael,

I love your patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v5.19-rc8 next-20220725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Schmitz/Amiga-RDB-partition-support-fixes/20220726-125830
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: sparc-randconfig-s041-20220724 (https://download.01.org/0day-ci/archive/20220726/202207262047.yRImNV4v-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/ccbc09d2b458d51ac395c4f8ea7cf703f6e83fdf
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Michael-Schmitz/Amiga-RDB-partition-support-fixes/20220726-125830
        git checkout ccbc09d2b458d51ac395c4f8ea7cf703f6e83fdf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash block/partitions/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> block/partitions/amiga.c:132:30: sparse: sparse: cast to restricted __be32
   block/partitions/amiga.c:133:25: sparse: sparse: cast to restricted __be32

vim +132 block/partitions/amiga.c

    35	
    36	int amiga_partition(struct parsed_partitions *state)
    37	{
    38		Sector sect;
    39		unsigned char *data;
    40		struct RigidDiskBlock *rdb;
    41		struct PartitionBlock *pb;
    42		u64 start_sect, nr_sects;
    43		sector_t blk, end_sect;
    44		u32 cylblk;		/* rdb_CylBlocks = nr_heads*sect_per_track */
    45		u32 nr_hd, nr_sect, lo_cyl, hi_cyl;
    46		int part, res = 0;
    47		unsigned int blksize = 1;	/* Multiplier for disk block size */
    48		int slot = 1;
    49	
    50		for (blk = 0; ; blk++, put_dev_sector(sect)) {
    51			if (blk == RDB_ALLOCATION_LIMIT)
    52				goto rdb_done;
    53			data = read_part_sector(state, blk, &sect);
    54			if (!data) {
    55				pr_err("Dev %s: unable to read RDB block %llu\n",
    56				       state->disk->disk_name, (u64) blk);
    57				res = -1;
    58				goto rdb_done;
    59			}
    60			if (*(__be32 *)data != cpu_to_be32(IDNAME_RIGIDDISK))
    61				continue;
    62	
    63			rdb = (struct RigidDiskBlock *)data;
    64			if (checksum_block((__be32 *)data, be32_to_cpu(rdb->rdb_SummedLongs) & 0x7F) == 0)
    65				break;
    66			/* Try again with 0xdc..0xdf zeroed, Windows might have
    67			 * trashed it.
    68			 */
    69			*(__be32 *)(data+0xdc) = 0;
    70			if (checksum_block((__be32 *)data,
    71					be32_to_cpu(rdb->rdb_SummedLongs) & 0x7F)==0) {
    72				pr_err("Trashed word at 0xd0 in block %llu ignored in checksum calculation\n",
    73				       (u64) blk);
    74				break;
    75			}
    76	
    77			pr_err("Dev %s: RDB in block %llu has bad checksum\n",
    78			       state->disk->disk_name, (u64) blk);
    79		}
    80	
    81		/* blksize is blocks per 512 byte standard block */
    82		blksize = be32_to_cpu( rdb->rdb_BlockBytes ) / 512;
    83	
    84		{
    85			char tmp[7 + 10 + 1 + 1];
    86	
    87			/* Be more informative */
    88			snprintf(tmp, sizeof(tmp), " RDSK (%d)", blksize * 512);
    89			strlcat(state->pp_buf, tmp, PAGE_SIZE);
    90		}
    91		blk = be32_to_cpu(rdb->rdb_PartitionList);
    92		put_dev_sector(sect);
    93		for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
    94			/* Read in terms partition table understands */
    95			if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
    96				pr_err("Dev %s: overflow calculating partition block %llu! Skipping partitions %u and beyond\n",
    97					state->disk->disk_name, (u64) blk, part);
    98				break;
    99			}
   100			data = read_part_sector(state, blk, &sect);
   101			if (!data) {
   102				pr_err("Dev %s: unable to read partition block %llu\n",
   103				       state->disk->disk_name, (u64) blk);
   104				res = -1;
   105				goto rdb_done;
   106			}
   107			pb  = (struct PartitionBlock *)data;
   108			blk = be32_to_cpu(pb->pb_Next);
   109			if (pb->pb_ID != cpu_to_be32(IDNAME_PARTITION))
   110				continue;
   111			if (checksum_block((__be32 *)pb, be32_to_cpu(pb->pb_SummedLongs) & 0x7F) != 0 )
   112				continue;
   113	
   114			/* RDB gives us more than enough rope to hang ourselves with,
   115			 * many times over (2^128 bytes if all fields max out).
   116			 * Some careful checks are in order, so check for potential
   117			 * overflows.
   118			 * We are multiplying four 32 bit numbers to one sector_t!
   119			 */
   120	
   121			nr_hd   = be32_to_cpu(pb->pb_Environment[NR_HD]);
   122			nr_sect = be32_to_cpu(pb->pb_Environment[NR_SECT]);
   123	
   124			/* CylBlocks is total number of blocks per cylinder */
   125			if (check_mul_overflow(nr_hd, nr_sect, &cylblk)) {
   126				pr_err("Dev %s: heads*sects %u overflows u32, skipping partition!\n",
   127					state->disk->disk_name, cylblk);
   128				continue;
   129			}
   130	
   131			/* check for consistency with RDB defined CylBlocks */
 > 132			if (cylblk > be32_to_cpu(rdb->rdb_CylBlocks)) {

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
