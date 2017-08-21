Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15550 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751172AbdHUJcx (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2017 05:32:53 -0400
Subject: Re: [PATCH V5 02/13] mmc: core: Add members to mmc_request and
 mmc_data for CQE's
To: Linus Walleij <linus.walleij@linaro.org>,
        linux-block@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
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
References: <1502366898-23691-1-git-send-email-adrian.hunter@intel.com>
 <1502366898-23691-3-git-send-email-adrian.hunter@intel.com>
 <CACRpkda=q=9UhKnvK5Z2PF+kqa1L4CSdTzcr=xuiOUgG7z6sww@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <9143f524-13ba-94a6-ec80-0b2a9275f95e@intel.com>
Date: Mon, 21 Aug 2017 12:26:19 +0300
MIME-Version: 1.0
In-Reply-To: <CACRpkda=q=9UhKnvK5Z2PF+kqa1L4CSdTzcr=xuiOUgG7z6sww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 20/08/17 14:29, Linus Walleij wrote:
> On Thu, Aug 10, 2017 at 2:08 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> Most of the information needed to issue requests to a CQE is already in
>> struct mmc_request and struct mmc_data. Add data block address, some flags,
>> and the task id (tag), and allow for cmd being NULL which it is for CQE
>> tasks.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
>> +       int                     tag;
> 
> Is this consistent with the block layer idea of "tag"?

It is named "tag" because it is the block layer tag.

> 
> I am asking because I get confused.
> 
> I thought the block layers idea of a "tag" was some metadata
> associated with a request. Not that I am a block layer expert.

The block layer tag is a unique number to identify the task to the hardware
queue.  It is typically a number from 0 up to queue depth - 1.

> Why can't we just name this "task_id" if that is what it is in
> Linux terms? Does the specification call it "tag"?

The eMMC specification calls it "task id" but the block layer calls it
"tag".  I went with "tag" to be easier for block layer people to understand.
