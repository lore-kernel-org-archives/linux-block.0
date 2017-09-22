Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:20648 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751877AbdIVNhU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Sep 2017 09:37:20 -0400
Subject: Re: [PATCH V8 08/14] mmc: core: Add parameter use_blk_mq
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
References: <1505302814-19313-1-git-send-email-adrian.hunter@intel.com>
 <1505302814-19313-9-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFqvE3YUnmLFUoU36jwYh6kKG89mj5pOy82zW6=EdWRN+g@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Message-ID: <032894b4-8575-9d93-bf74-c96e7b778d9b@intel.com>
Date: Fri, 22 Sep 2017 16:30:35 +0300
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqvE3YUnmLFUoU36jwYh6kKG89mj5pOy82zW6=EdWRN+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 21/09/17 12:47, Ulf Hansson wrote:
> On 13 September 2017 at 13:40, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Until mmc has blk-mq support fully implemented and tested, add a
>> parameter use_blk_mq, default to false unless config option MMC_MQ_DEFAULT
>> is selected.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/Kconfig      | 11 +++++++++++
>>  drivers/mmc/core/core.c  |  7 +++++++
>>  drivers/mmc/core/core.h  |  2 ++
>>  drivers/mmc/core/host.c  |  2 ++
>>  drivers/mmc/core/host.h  |  4 ++++
>>  include/linux/mmc/host.h |  1 +
>>  6 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
>> index ec21388311db..98202934bd29 100644
>> --- a/drivers/mmc/Kconfig
>> +++ b/drivers/mmc/Kconfig
>> @@ -12,6 +12,17 @@ menuconfig MMC
>>           If you want MMC/SD/SDIO support, you should say Y here and
>>           also to your specific host controller driver.
>>
>> +config MMC_MQ_DEFAULT
>> +       bool "MMC: use blk-mq I/O path by default"
>> +       depends on MMC && BLOCK
>> +       ---help---
>> +         This option enables the new blk-mq based I/O path for MMC block
>> +         devices by default.  With the option the mmc_core.use_blk_mq
>> +         module/boot option defaults to Y, without it to N, but it can
>> +         still be overridden either way.
>> +
>> +         If unsure say N.
>> +
>>  if MMC
> 
> I asume the goal of adding this option is to enable us to move slowly
> forward. In general that might be a good idea, however for this
> particular case I am not sure.
> 
> The main reason is simply that I find it unlikely that people and
> distributions will actually go in and change the default value, so in
> the end we will just be adding new code, which isn't really going to
> be much tested. That's what happened in scsi case.

The argument that no one is going to test anyway so we shouldn't give them
the opportunity, is not a sustainable vision for the future.  Instead we
should reach out to relevant stakeholders and get them to do their testing
with blk-mq first.

> 
> As I also stated earlier, I do worry about the maintenance of the mmc
> block device code, and this approach make it worse, at least short
> term.

What maintenance?

> 
> To me, the scsi case is also different, because the mq support was
> added long time ago and at that point one could worry a bit of
> maturity of the blkmq in general, that I assume have been sorted out
> by know.

But blk-mq still isn't fully ready for all of scsi, so you seem to be
contradicting yourself.

> 
>>
>>  source "drivers/mmc/core/Kconfig"
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index ef2d8aa1e7d2..3638ed4f0f9e 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -66,6 +66,13 @@
>>  bool use_spi_crc = 1;
>>  module_param(use_spi_crc, bool, 0);
>>
>> +#ifdef CONFIG_MMC_MQ_DEFAULT
>> +bool mmc_use_blk_mq = true;
>> +#else
>> +bool mmc_use_blk_mq = false;
>> +#endif
>> +module_param_named(use_blk_mq, mmc_use_blk_mq, bool, S_IWUSR | S_IRUGO);
>> +
>>  static int mmc_schedule_delayed_work(struct delayed_work *work,
>>                                      unsigned long delay)
>>  {
>> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
>> index e941342ed450..535539a9e7eb 100644
>> --- a/drivers/mmc/core/core.h
>> +++ b/drivers/mmc/core/core.h
>> @@ -35,6 +35,8 @@ struct mmc_bus_ops {
>>         int (*reset)(struct mmc_host *);
>>  };
>>
>> +extern bool mmc_use_blk_mq;
>> +
>>  void mmc_attach_bus(struct mmc_host *host, const struct mmc_bus_ops *ops);
>>  void mmc_detach_bus(struct mmc_host *host);
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index ad88deb2e8f3..b624dbb6cd15 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -398,6 +398,8 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>>         host->max_blk_size = 512;
>>         host->max_blk_count = PAGE_SIZE / 512;
>>
>> +       host->use_blk_mq = mmc_use_blk_mq;
>> +
>>         return host;
>>  }
>>
>> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
>> index 77d6f60d1bf9..170fe5947087 100644
>> --- a/drivers/mmc/core/host.h
>> +++ b/drivers/mmc/core/host.h
>> @@ -69,6 +69,10 @@ static inline bool mmc_card_hs400es(struct mmc_card *card)
>>         return card->host->ios.enhanced_strobe;
>>  }
>>
>> +static inline bool mmc_host_use_blk_mq(struct mmc_host *host)
>> +{
>> +       return host->use_blk_mq;
>> +}
>>
>>  #endif
>>
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 54b0463443bd..5d1bd10991f7 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -378,6 +378,7 @@ struct mmc_host {
>>         unsigned int            doing_retune:1; /* re-tuning in progress */
>>         unsigned int            retune_now:1;   /* do re-tuning at next req */
>>         unsigned int            retune_paused:1; /* re-tuning is temporarily disabled */
>> +       unsigned int            use_blk_mq:1;   /* use blk-mq */
>>
>>         int                     rescan_disable; /* disable card detection */
>>         int                     rescan_entered; /* used with nonremovable devices */
>> --
>> 1.9.1
>>
> 
> Kind regards
> Uffe
> 
