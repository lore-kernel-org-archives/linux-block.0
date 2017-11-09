Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45492 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752725AbdKIH4p (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Nov 2017 02:56:45 -0500
Subject: Re: [PATCH V13 08/10] mmc: block: blk-mq: Separate card polling from
 recovery
To: Linus Walleij <linus.walleij@linaro.org>
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
        Shawn Lin <shawn.lin@rock-chips.com>,
        Christoph Hellwig <hch@lst.de>
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-9-git-send-email-adrian.hunter@intel.com>
 <CACRpkdb2_D3WZZp2f2o+f+zc7R-jU=wfs7Ec1rppim0mTd-sDw@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <afcf5ce3-2795-3f88-3544-d939d3513f4f@intel.com>
Date: Thu, 9 Nov 2017 09:56:30 +0200
MIME-Version: 1.0
In-Reply-To: <CACRpkdb2_D3WZZp2f2o+f+zc7R-jU=wfs7Ec1rppim0mTd-sDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/11/17 11:30, Linus Walleij wrote:
> On Fri, Nov 3, 2017 at 2:20 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> Recovery is simpler to understand if it is only used for errors. Create a
>> separate function for card polling.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> This looks good but I can't see why it's not folded into
> patch 3 already. This error handling is introduced there.

What are you on about?  If we're going to split up the patches (which I
argued against - the new code is all new, so it could be read independently
from the old mess) then this is a logically distinct step.  Polling and
error-recovery are conceptually different things and it is important to
separate them to make the code easier to understand.
