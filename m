Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:41493 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbdHaKZv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 06:25:51 -0400
Date: Thu, 31 Aug 2017 03:25:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        linux-block@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
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
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH V5 11/13] mmc: block: Add CQE support
Message-ID: <20170831102550.GB6757@infradead.org>
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
 <1502366898-23691-12-git-send-email-adrian.hunter@intel.com>
 <CACRpkdZ2=D2tLD0L0M1T_z0_5gMhiPKqUHuOcMgdA72PHLHG8A@mail.gmail.com>
 <b7d28123-ecc1-8b24-28bd-18e87c475fc5@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b7d28123-ecc1-8b24-28bd-18e87c475fc5@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 21, 2017 at 12:27:30PM +0300, Adrian Hunter wrote:
> We need to start with a legacy API because people want to backport CQ to
> earlier kernels (we really need to get features upstream more quickly), but
> blk-mq has been evolving a lot (e.g. elevator support), so backporters face
> having either something quite different from upstream or trying to backport
> great chunks of the block layer.

Hell no - the point of Linux mainline development is to move forward.
We'll need to do the right thing for long term Linux development FIRST
and then worry about backporting SECOND.

Stop thinking about all kernels while you wear your mainline kernel
developer hat.  Yes, occasionally we can do smaller amount of reordering
to keep a small fix first for stable backports, but not to this extent
of using obsolete infrastructure and making an already messy driver
worse just to please backports to long obsolete kernels.
