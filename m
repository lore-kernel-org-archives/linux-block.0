Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8EAC35671
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 13:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3732080D
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 13:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgBXNAT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:00:19 -0500
Received: from mga18.intel.com ([134.134.136.126]:41866 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727405AbgBXNAS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 08:00:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Feb 2020 05:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,480,1574150400"; 
   d="scan'208";a="409867954"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga005.jf.intel.com with ESMTP; 24 Feb 2020 05:00:14 -0800
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bitan Biswas <bbiswas@nvidia.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
 <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
 <CAPDyKFo-vEO7zN_F+NqcKtnKmAo_deOZx3gYNiks3yTAQAjv-Q@mail.gmail.com>
 <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com>
 <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <728e1782-74d7-7238-2b34-0410523c2160@intel.com>
Date:   Mon, 24 Feb 2020 14:59:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/02/20 1:16 pm, Ulf Hansson wrote:
> + Adrian
> 
> On Fri, 21 Feb 2020 at 20:44, Bitan Biswas <bbiswas@nvidia.com> wrote:
>>
>> On 2/21/20 1:48 AM, Ulf Hansson wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Thu, 20 Feb 2020 at 18:54, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>>>
>>>> On Wed, 19 Feb 2020 at 21:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>>>
>>>>> On Thu, 13 Feb 2020 at 16:43, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>>>>>
>>>>>
>>>>> Try to restore the value for the cache flush timeout, by updating the
>>>>> define MMC_CACHE_FLUSH_TIMEOUT_MS to 10 * 60 * 1000".
>>>>
>>>> I have increased the timeout to 10 minutes but it did not help.
>>>> Same error found.
>>>> [  608.679353] mmc1: Card stuck being busy! mmc_poll_for_busy
>>>> [  608.684964] mmc1: cache flush error -110
>>>> [  608.689005] blk_update_request: I/O error, dev mmcblk1, sector
>>>> 4302400 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
>>>>
>>>> OTOH, What best i could do for my own experiment to revert all three patches and
>>>> now the reported error gone and device mount successfully [1].
>>>>
>>>> List of patches reverted,
>>>>    mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
>>>>    mmc: block: Use generic_cmd6_time when modifying
>>>>      INAND_CMD38_ARG_EXT_CSD
>>>>    mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()
>>>>
>>>> [1] https://lkft.validation.linaro.org/scheduler/job/1238275#L4346
>>>>
>>>> - Naresh
>>>
>>> Thanks for testing!
>>>
>>> This sounds a bit weird, I must say. Also, while looking into the
>>> logs, it seems like you are comparing a v5.5 kernel with v5.6-rc2, but
>>> maybe I didn't read the logs carefully enough.
>>>
>>>   In any case, I am looking into creating a debug patch so we can
>>> narrow down the problem a bit further.
>>>
>>> Kind regards
>>> Uffe
>>>
>>
>> Hi Ulf,
>>
>>   I see that Jetson-TX2 / Jetson-Xavier suspend test is aborted and
>> below error is seen due to the commit
>> 24ed3bd01d6a844fd5e8a75f48d0a3d10ed71bf9  ("mmc: core: Specify timeouts
>> for BKOPS and CACHE_FLUSH for eMMC"):
>>
>> ##
>> [  268.976197] Freezing user space processes ... (elapsed 0.001 seconds)
>> done.
>> [  268.984414] OOM killer disabled.
>> [  268.987635] Freezing remaining freezable tasks ... (elapsed 0.000
>> seconds) done.
>> [  269.217471] PM: dpm_run_callback(): mmc_bus_suspend+0x0/0x58 returns -110
>> [  269.224255] PM: Device mmc1:0001 failed to suspend: error -110
>> [  269.230080] PM: Some devices failed to suspend, or early wake event
>> detected
> 
> Is there also a print in the log about "Card stuck being busy!"?
> 
> In any case, it seems like the timeout error (-110) is happening way
> too soon. The cache flush timeout is now 30s, but the timeout seems to
> fire only a few hundred ms (at most) after the cache flush command has
> been sent.
> 
>> ##
>>
>>   I find that from the commit the changes in mmc_flush_cache below is
>> the cause.
>>
>> ##
>> @@ -961,7 +963,8 @@ int mmc_flush_cache(struct mmc_card *card)
>>                          (card->ext_csd.cache_size > 0) &&
>>                          (card->ext_csd.cache_ctrl & 1)) {
>>                  err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>> -                               EXT_CSD_FLUSH_CACHE, 1, 0);
>> +                                EXT_CSD_FLUSH_CACHE, 1,
>> +                                MMC_CACHE_FLUSH_TIMEOUT_MS);
>>
>> ##
>>
>>   Do you have suggestion to try for the suspend errors ?
> 
> Just as a quick sanity test, please try the below patch, which
> restores the old cache flush timeout to 10min.
> 
> However, as I indicated above, this seems to be a problem that needs
> to be fixed at in the host driver side. For the sdhci driver, there is
> a bit of a tricky logic around how to deal with timeouts in
> sdhci_send_command(). My best guess is that's where we should look
> more closely (and I am doing that).

Could be, but hard to narrow down without more debug.  I would enable
dynamic debug and mmc messages e.g.

kernel config

	CONFIG_DYNAMIC_DEBUG=y

kernel command line option

	dyndbg="file drivers/mmc/core/* +p;file drivers/mmc/host/* +p"

But that might lead to a very large number of messages.


> 
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Mon, 24 Feb 2020 11:43:33 +0100
> Subject: [PATCH] mmc: core: Restore busy timeout for eMMC cache flushing
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/mmc_ops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index da425ee2d9bf..713e7dd6d028 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -21,7 +21,7 @@
> 
>  #define MMC_OPS_TIMEOUT_MS             (10 * 60 * 1000) /* 10min*/
>  #define MMC_BKOPS_TIMEOUT_MS           (120 * 1000) /* 120s */
> -#define MMC_CACHE_FLUSH_TIMEOUT_MS     (30 * 1000) /* 30s */
> +#define MMC_CACHE_FLUSH_TIMEOUT_MS     (10 * 60 * 1000) /* 10min */
> 
>  static const u8 tuning_blk_pattern_4bit[] = {
>         0xff, 0x0f, 0xff, 0x00, 0xff, 0xcc, 0xc3, 0xcc,
> 

