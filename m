Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53807 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752098AbdI0MJm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Sep 2017 08:09:42 -0400
Subject: Re: [PATCH V9 09/15] mmc: core: Add parameter use_blk_mq
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
References: <1506083824-4024-1-git-send-email-adrian.hunter@intel.com>
 <1506083824-4024-10-git-send-email-adrian.hunter@intel.com>
 <CACRpkdZWtSHxQfkgZZDvzX562Jy_KenP__ruszLoeKKn+AkKig@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <43632dd9-65ac-8186-3c24-0a2121950872@intel.com>
Date: Wed, 27 Sep 2017 15:02:52 +0300
MIME-Version: 1.0
In-Reply-To: <CACRpkdZWtSHxQfkgZZDvzX562Jy_KenP__ruszLoeKKn+AkKig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 27/09/17 02:42, Linus Walleij wrote:
> On Fri, Sep 22, 2017 at 2:36 PM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> 
>> Until mmc has blk-mq support fully implemented and tested, add a
>> parameter use_blk_mq, default to false unless config option MMC_MQ_DEFAULT
>> is selected.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> 
>> +config MMC_MQ_DEFAULT
>> +       bool "MMC: use blk-mq I/O path by default"
>> +       depends on MMC && BLOCK
> 
> I would say:
> default y
> 
> Why not. SCSI is starting to enable this by default so IMO we should

SCSI didn't manage it yet.

> not take the
> intermediate step of having this as optional. Otherwise it never gets tested.

The argument that we don't have to take any responsibility for getting
things tested is a poor one.

Anyway, you can always send a patch later to change the default, so why the
hurry to do it now?

> 
> Set it to default y and after two kernel releases, if nothing happens, we simply
> delete the old block layer path.
> 
>> +#ifdef CONFIG_MMC_MQ_DEFAULT
>> +bool mmc_use_blk_mq = true;
>> +#else
>> +bool mmc_use_blk_mq = false;
>> +#endif
>> +module_param_named(use_blk_mq, mmc_use_blk_mq, bool, S_IWUSR | S_IRUGO);
> 
> Are people really modprobing this so it needs to be a module parameter?

Irrespective of modprobe, the parameter can be changed without re-compiling.

> 
> Maybe I'm the only developer stupid enough to just recompile and reboot

Just change the parameter and unbind and rebind the host controller.
