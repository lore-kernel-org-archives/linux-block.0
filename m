Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:15928 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753867AbdIYGiq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Sep 2017 02:38:46 -0400
Subject: Re: [PATCH V9 14/15] mmc: cqhci: support for command queue enabled
 host
To: Bough Chen <haibo.chen@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
 <1506083824-4024-15-git-send-email-adrian.hunter@intel.com>
 <AM4PR0401MB23242EB93D53E48BD31C95F7907A0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <428d7c7a-4ace-5040-0f43-7254ff793ea0@intel.com>
Date: Mon, 25 Sep 2017 09:32:00 +0300
MIME-Version: 1.0
In-Reply-To: <AM4PR0401MB23242EB93D53E48BD31C95F7907A0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 25/09/17 05:39, Bough Chen wrote:
>> +static void cqhci_set_irqs(struct cqhci_host *cq_host, u32 set) {
>> +	u32 ier;
>> +
>> +	ier = cqhci_readl(cq_host, CQHCI_ISTE);
>> +	ier |= set;
> 
> I think operation ' |= ' is not correct, since we will also call cqhci_set_irqs(cq_host, 0),
> Which means to mask all cmdq irq,  so I think better to directly write the parameter
>  'set' to ISTE and ISGE.

True.  I will send a V10 of this patch.
