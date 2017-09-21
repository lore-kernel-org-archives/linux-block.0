Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:50437 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751881AbdIUOHb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Sep 2017 10:07:31 -0400
Date: Thu, 21 Sep 2017 16:07:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V8 00/14] mmc: Add Command Queue support
Message-ID: <20170921140729.GA17333@lst.de>
References: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Sep 13, 2017 at 02:40:00PM +0300, Adrian Hunter wrote:
> Non-CQE blk-mq showed a 3% decrease in sequential read performance.  This
> seemed to be coming from the inferior latency of running work items compared
> with a dedicated thread.  Hacking blk-mq workqueue to be unbound reduced the
> performance degradation from 3% to 1%.

Can you start a discussion on just this on the linux-block lists?
