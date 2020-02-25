Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81500C35DF9
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 10:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2EA21744
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 10:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YmXZK+2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgBYKEi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:04:38 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16887 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbgBYKEi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 05:04:38 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e54f0e80000>; Tue, 25 Feb 2020 02:03:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 25 Feb 2020 02:04:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 25 Feb 2020 02:04:37 -0800
Received: from [10.21.133.51] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Feb
 2020 10:04:35 +0000
From:   Jon Hunter <jonathanh@nvidia.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Bitan Biswas <bbiswas@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        John Stultz <john.stultz@linaro.org>,
        Thierry Reding <treding@nvidia.com>
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
 <CAPDyKFqqhxC-pmV_j8PLY-D=AbqCAbiipAAHXLpJ4N_BiYYOFw@mail.gmail.com>
 <CA+G9fYugQuAERqp3VXUFG-3QxXoF8bz7OSMh6WGSZcrGkbfDSQ@mail.gmail.com>
 <CAPDyKFo-vEO7zN_F+NqcKtnKmAo_deOZx3gYNiks3yTAQAjv-Q@mail.gmail.com>
 <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com>
 <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
Message-ID: <6523119a-50ac-973a-d1cd-ab1569259411@nvidia.com>
Date:   Tue, 25 Feb 2020 10:04:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrXQgtHa4gLaKUi_F0rs4FMBai3Y_+TcHZR_zpkb0B4QQ@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582625001; bh=DXvf4j96l957ii5IgxSstqBFHLUsNWzdiL/4ribmGBQ=;
        h=X-PGP-Universal:From:Subject:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YmXZK+2Wxv4hJ3z1ofqFDa+CdPVumvTk7rk9zzFJ4nsH2sVpgrCIgkpLlbZmTbwwy
         KWJDi1uXeivi46vK7RPEy60oyQ2Igq5bJ3pAvcrxxbkdHRI5eOBSu06CO9CdnPCSo4
         uEx+TFt7QgwAT2UH14svOMSeb1vXqvuy6ZZx6rlm2WpnawaE0BqXhIj7eNHImOdaIb
         jsTeJGCWSKV+uAc2lG+mrupgiBxd6ZeDpvEg9OQY64KG6RD6J2sJZHPhn6E+pk4Byh
         lTmEvTxv0MbDlejw7aVjxEP0yBIbeqF5GmbvS+pmL43jkw3WEBTK0e3+n92/GsoZ1K
         rXu4T/sni80xg==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 24/02/2020 11:16, Ulf Hansson wrote:
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


Reverting all the above also fixes the problem for me.

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


I no longer see the issue on reverting the above hunk as Bitan suggested
but now I see the following (which is expected) ...

 WARNING KERN mmc1: unspecified timeout for CMD6 - use generic

> Just as a quick sanity test, please try the below patch, which
> restores the old cache flush timeout to 10min.
> 
> However, as I indicated above, this seems to be a problem that needs
> to be fixed at in the host driver side. For the sdhci driver, there is
> a bit of a tricky logic around how to deal with timeouts in
> sdhci_send_command(). My best guess is that's where we should look
> more closely (and I am doing that).
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

This does not fix the problem for me.

Jon

-- 
nvpublic
