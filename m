Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9775 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753868AbdKIOVP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Nov 2017 09:21:15 -0500
Subject: Re: [PATCH V13 05/10] mmc: cqhci: support for command queue enabled
 host
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>,
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
References: <1509715220-31885-1-git-send-email-adrian.hunter@intel.com>
 <1509715220-31885-6-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFq-CYwO207iqAmtXwGmouFXxna0zRPW-53CvknsRC1toQ@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <bb2943ec-0aa6-6dfe-dfdc-7c659644a101@intel.com>
Date: Thu, 9 Nov 2017 16:20:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq-CYwO207iqAmtXwGmouFXxna0zRPW-53CvknsRC1toQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/11/17 15:41, Ulf Hansson wrote:
> On 3 November 2017 at 14:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>>
>> This patch adds CMDQ support for command-queue compatible
>> hosts.
>>
>> Command queue is added in eMMC-5.1 specification. This
>> enables the controller to process upto 32 requests at
>> a time.
>>
>> Adrian Hunter contributed renaming to cqhci, recovery, suspend
>> and resume, cqhci_off, cqhci_wait_for_idle, and external timeout
>> handling.
>>
>> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
>> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
>> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
>> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Overall this looks good to me.
> 
> However, I didn't see MAINTAINERS being updated. Is anybody above
> volunteering to maintain cqhci.*?

I have hardware that I can use for testing so I can maintain it if no one
else wants to, however if anyone else is keen please feel free to offer too.
