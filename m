Return-Path: <fengguang.wu@intel.com>
Date: Sat, 2 Jul 2016 18:17:41 +0800
From: kbuild test robot <lkp@intel.com>
To: Tahsin Erdogan <tahsin@google.com>
Cc: kbuild-all@01.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tahsin Erdogan <tahsin@google.com>
Subject: Re: [PATCH] block: do not merge requests without consulting with io
 scheduler
Message-ID: <201607021803.JUE6Gs7g%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467429991-18469-1-git-send-email-tahsin@google.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

[auto build test WARNING on v4.7-rc5]
[also build test WARNING on next-20160701]
[cannot apply to block/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tahsin-Erdogan/block-do-not-merge-requests-without-consulting-with-io-scheduler/20160702-130833


coccinelle warnings: (new ones prefixed by >>)

>> block/elevator.c:73:9-10: WARNING: return of 0/1 in function 'elv_bio_merge_ok' with return type bool

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
