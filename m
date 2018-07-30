Return-Path: <prvs=7421cc28f=Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"jin.xiao@intel.com" <jin.xiao@intel.com>, "axboe@kernel.dk"
	<axboe@kernel.dk>
CC: "yanmin.zhang@intel.com" <yanmin.zhang@intel.com>
Subject: Re: [PATCH] blk_init_allocated_queue() set q->fq as NULL in the fail
 case
Date: Mon, 30 Jul 2018 05:11:58 +0000
Message-ID: <901c4465be0d37b3b8d8e751dc15607c70fab19b.camel@wdc.com>
References: <1532916197-14950-1-git-send-email-jin.xiao@intel.com>
In-Reply-To: <1532916197-14950-1-git-send-email-jin.xiao@intel.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2018-07-30 at 10:03 +-0800, xiao jin wrote:
+AD4- We find the memory use-after-free issue in +AF8AXw-blk+AF8-drain+AF8-=
queue()
+AD4- on the kernel 4.14. After read the latest kernel 4.18-rc6 we
+AD4- think it has the same problem.
+AD4-=20
+AD4- Memory is allocated for q-+AD4-fq in the blk+AF8-init+AF8-allocated+A=
F8-queue().
+AD4- If the elevator init function called with error return, it will
+AD4- run into the fail case to free the q-+AD4-fq.
+AD4-=20
+AD4- Then the +AF8AXw-blk+AF8-drain+AF8-queue() uses the same memory after=
 the free
+AD4- of the q-+AD4-fq, it will lead to the unpredictable event.
+AD4-=20
+AD4- The patch is to set q-+AD4-fq as NULL in the fail case of
+AD4- blk+AF8-init+AF8-allocated+AF8-queue().

Please add +ACI-Fixes:+ACI- and +ACI-Cc: stable+ACI- tags to this patch.

Thanks,

Bart.
