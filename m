Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2D5C77B73
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 05:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjEXFPv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 01:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237857AbjEXFPu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 01:15:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB35186
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 22:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684905349; x=1716441349;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8tyAadZVtVHCvWr+c1D1fED4YdsdDmM7CmPnc7sTvkk=;
  b=F58ftQLlW4uU5W5y0jJCY8FThDReUvA8Wkk7lvsufkmvvnfLBXjRLEWu
   wgeKG/Ql19KqaQCOn8MUzEGCHHfaRkZyjtg0o/zhPizW5VdDEfXgM07/S
   LhMViyGLReJhiP5mwrznWR9IvGcNB4XYReUZm2WO7c3p7M7C5IH5Vx4/D
   /BdQTGGXzgwu++7+iYIjs0mOXfQ6p5LgobfD8K/YVBc6KOB8veo4tWrr8
   YzU4jSUtIAxa6Z9um4P7Rdq/JT5YADrqg0MMuiUhd9xAjIr9vmoy9ea2w
   +Xt0ZPJ810yUe5bINvt5kseCYfPffj+rHyDAawBwkWAzTAImueij9C7We
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="381705662"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="381705662"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2023 22:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10719"; a="774110182"
X-IronPort-AV: E=Sophos;i="6.00,188,1681196400"; 
   d="scan'208";a="774110182"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 May 2023 22:15:47 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q1gqg-000EQJ-2f;
        Wed, 24 May 2023 05:15:46 +0000
Date:   Wed, 24 May 2023 13:15:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "J. corwin Coburn" <corwin@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, vdo-devel@redhat.com,
        "J. corwin Coburn" <corwin@redhat.com>
Subject: Re: [PATCH v2 06/39] Add thread and synchronization utilities.
Message-ID: <202305241234.Tl4aMNJ0-lkp@intel.com>
References: <20230523214539.226387-7-corwin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523214539.226387-7-corwin@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi corwin,

kernel test robot noticed the following build warnings:

[auto build test WARNING on device-mapper-dm/for-next]
[also build test WARNING on song-md/md-next linus/master v6.4-rc3 next-20230523]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/J-corwin-Coburn/Add-documentation-for-dm-vdo/20230524-062342
base:   https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git for-next
patch link:    https://lore.kernel.org/r/20230523214539.226387-7-corwin%40redhat.com
patch subject: [PATCH v2 06/39] Add thread and synchronization utilities.
reproduce:
        make versioncheck

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305241234.Tl4aMNJ0-lkp@intel.com/

versioncheck warnings: (new ones prefixed by >>)
   INFO PATH=/opt/cross/clang/bin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   /usr/bin/timeout -k 100 3h /usr/bin/make W=1 --keep-going HOSTCC=gcc-11 CC=gcc-11 -j32 ARCH=x86_64 versioncheck
   find ./* \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o \
   	-name '*.[hcS]' -type f -print | sort \
   	| xargs perl -w ./scripts/checkversion.pl
   ./drivers/accessibility/speakup/genmap.c: 13 linux/version.h not needed.
   ./drivers/accessibility/speakup/makemapdata.c: 13 linux/version.h not needed.
>> ./drivers/md/dm-vdo/uds-threads.c: 13 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede.h: 10 linux/version.h not needed.
   ./drivers/net/ethernet/qlogic/qede/qede_ethtool.c: 7 linux/version.h not needed.
   ./drivers/soc/tegra/cbb/tegra-cbb.c: 19 linux/version.h not needed.
   ./drivers/soc/tegra/cbb/tegra194-cbb.c: 26 linux/version.h not needed.
   ./drivers/soc/tegra/cbb/tegra234-cbb.c: 27 linux/version.h not needed.
   ./drivers/staging/media/atomisp/include/linux/atomisp.h: 23 linux/version.h not needed.
   ./samples/trace_events/trace_custom_sched.c: 11 linux/version.h not needed.
   ./sound/soc/codecs/cs42l42.c: 14 linux/version.h not needed.
   ./tools/lib/bpf/bpf_helpers.h: 289: need linux/version.h
   ./tools/perf/tests/bpf-script-example.c: 60: need linux/version.h
   ./tools/perf/tests/bpf-script-test-kbuild.c: 21: need linux/version.h
   ./tools/perf/tests/bpf-script-test-prologue.c: 49: need linux/version.h
   ./tools/perf/tests/bpf-script-test-relocation.c: 51: need linux/version.h
   ./tools/testing/selftests/bpf/progs/dev_cgroup.c: 9 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/netcnt_prog.c: 3 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_map_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_send_signal_kern.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_spin_lock.c: 4 linux/version.h not needed.
   ./tools/testing/selftests/bpf/progs/test_tcp_estats.c: 37 linux/version.h not needed.
   ./tools/testing/selftests/wireguard/qemu/init.c: 27 linux/version.h not needed.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
