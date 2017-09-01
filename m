Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:8243 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751499AbdIALtL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 1 Sep 2017 07:49:11 -0400
Subject: Re: [PATCH V7 00/10] mmc: Add Command Queue support
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Bough Chen <haibo.chen@nxp.com>,
        Alex Lemberg <alex.lemberg@sandisk.com>,
        Mateusz Nowak <mateusz.nowak@intel.com>,
        Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Dong Aisheng <dongas86@gmail.com>,
        Das Asutosh <asutoshd@codeaurora.org>,
        Zhangfei Gao <zhangfei.gao@gmail.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Harjani Ritesh <riteshh@codeaurora.org>,
        Venu Byravarasu <vbyravarasu@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>
References: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <ff9eeab1-199a-3ab3-9fa8-cc2f08d52a54@intel.com>
Date: Fri, 1 Sep 2017 14:42:34 +0300
MIME-Version: 1.0
In-Reply-To: <1504180616-14514-1-git-send-email-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 31/08/17 14:56, Adrian Hunter wrote:
> Here is V7 of the hardware command queue patches without the software
> command queue patches, now using blk-mq.
> 
> HW CMDQ offers 25% - 50% better random multi-threaded I/O.  I see a slight
> 2% drop in sequential read speed but no change to sequential write.

Any comments?
