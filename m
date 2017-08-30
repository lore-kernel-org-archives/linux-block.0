Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:50539 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750941AbdH3HBe (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Aug 2017 03:01:34 -0400
Subject: Re: [PATCH V6 00/12] mmc: Add Command Queue support
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
References: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <713feb73-e7c6-1e3c-f591-17fa16002384@intel.com>
Date: Wed, 30 Aug 2017 09:54:55 +0300
MIME-Version: 1.0
In-Reply-To: <1503665035-16231-1-git-send-email-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 25/08/17 15:43, Adrian Hunter wrote:
> Here is V6 of the hardware command queue patches without the software
> command queue patches.  Patches "mmc: host: Add CQE interface" and
> "mmc: core: Turn off CQE before sending commands" have been applied to Ulf's
> next branch.  "mmc: host: Add CQE interface" needs to be dropped in favour
> of the new version.

Any comments?
