Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:52923 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750990AbdHaMHD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2017 08:07:03 -0400
Subject: Re: [PATCH V5 11/13] mmc: block: Add CQE support
To: Christoph Hellwig <hch@infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: linux-block@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
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
 <1502366898-23691-12-git-send-email-adrian.hunter@intel.com>
 <CACRpkdZ2=D2tLD0L0M1T_z0_5gMhiPKqUHuOcMgdA72PHLHG8A@mail.gmail.com>
 <20170831102324.GA6757@infradead.org>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <745aa441-81c8-04e1-0b0c-13e072110255@intel.com>
Date: Thu, 31 Aug 2017 15:00:26 +0300
MIME-Version: 1.0
In-Reply-To: <20170831102324.GA6757@infradead.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 31/08/17 13:23, Christoph Hellwig wrote:
> On Sun, Aug 20, 2017 at 02:13:03PM +0200, Linus Walleij wrote:
>> So adding a new (in effect) invasive block driver needs to at least
>> be CC:ed to the block maintainers so we don't sneak anything like
>> that in under the radar.
> 
> Yes.
> 
>> And this semaphoring and threading is just as confusing as ever and now
>> we have two of them. (Sorry, I'm grumpy.)
> 
> But your are grumpy for a good reason.  The MMC driver is a pain
> to understand for even a seasons block layer developer.
> 
>> What we need is an MMC stack where it is clear where blocks come in
>> and out and how they are processed by the block layer, but now we
>> already have a scary Rube Goldberg-machine and it is not getting better.
>> If people have different feelings they can tell me off right now.
> 
> Agreed.
> 
>>
>> I have my hopes up that we can get the code lesser and more readable
>> with MQ, as I tried to illustrate in my attempts, which are indeed lame
>> because they don't work because of misc and SDIO use cases, but
>> I'm honestly doing my best. Currently with other clean-ups to get a
>> clean surface to do that.
>>
>> As it stands, the MQ migration work size is in some spots doubled or
>> more than doubled after this commit :(
> 
> I don't think we should merge this.
> 

OK, let's merge the blk-mq version then.  Here it is in V7:

	https://marc.info/?l=linux-mmc&m=150418101630159&w=2
