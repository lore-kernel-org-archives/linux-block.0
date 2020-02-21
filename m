Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC613C35646
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 19:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A088C208C4
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 19:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="a7VTt7wp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgBUTox (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:44:53 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4544 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBUTow (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Feb 2020 14:44:52 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5033120000>; Fri, 21 Feb 2020 11:44:18 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 21 Feb 2020 11:44:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 21 Feb 2020 11:44:51 -0800
Received: from [10.19.66.63] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Feb
 2020 19:44:48 +0000
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
CC:     Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov <ast@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        <lkft-triage@lists.linaro.org>,
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
From:   Bitan Biswas <bbiswas@nvidia.com>
Message-ID: <a602a27a-b960-ce56-c541-3b4b95f5dce2@nvidia.com>
Date:   Fri, 21 Feb 2020 11:44:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo-vEO7zN_F+NqcKtnKmAo_deOZx3gYNiks3yTAQAjv-Q@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1582314258; bh=7shXhAKVgprX3db7vtD29I37u9MzanrNF1PL2vZ849Q=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=a7VTt7wpU5aNVkKuGK6qVz4fq2LyufFJxJgeavB2kNlKkNGb8XQPD7gs/iIZIipLF
         v6HdKUZHce4DkLZnOeRNRanlML/DlWI2rQA446bSGXlIA+b6+kHxc2WBiXj+aiWP1r
         w/qijGjZO12R9ATf6TMQvgUUVIrD8T45ixk1XzVYGVzRAN/tdYXR9Eqn0a5THPu4+f
         pT3kuZ9YeogIrWF+0iypHoYCeM1JloARB7oGBU5qZA+aTS/+zKVxeaW+gyc+jRfGxl
         B9WnyAv/H29QAbFHaGP/zmD9x50NwX99MFc+s3WUqHURHxk2teovD4YHgchxIuAK8I
         2NRGr48pndxkw==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/20 1:48 AM, Ulf Hansson wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Thu, 20 Feb 2020 at 18:54, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> On Wed, 19 Feb 2020 at 21:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>>
>>> On Thu, 13 Feb 2020 at 16:43, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>>>
>>>
>>> Try to restore the value for the cache flush timeout, by updating the
>>> define MMC_CACHE_FLUSH_TIMEOUT_MS to 10 * 60 * 1000".
>>
>> I have increased the timeout to 10 minutes but it did not help.
>> Same error found.
>> [  608.679353] mmc1: Card stuck being busy! mmc_poll_for_busy
>> [  608.684964] mmc1: cache flush error -110
>> [  608.689005] blk_update_request: I/O error, dev mmcblk1, sector
>> 4302400 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
>>
>> OTOH, What best i could do for my own experiment to revert all three patches and
>> now the reported error gone and device mount successfully [1].
>>
>> List of patches reverted,
>>    mmc: core: Specify timeouts for BKOPS and CACHE_FLUSH for eMMC
>>    mmc: block: Use generic_cmd6_time when modifying
>>      INAND_CMD38_ARG_EXT_CSD
>>    mmc: core: Default to generic_cmd6_time as timeout in __mmc_switch()
>>
>> [1] https://lkft.validation.linaro.org/scheduler/job/1238275#L4346
>>
>> - Naresh
> 
> Thanks for testing!
> 
> This sounds a bit weird, I must say. Also, while looking into the
> logs, it seems like you are comparing a v5.5 kernel with v5.6-rc2, but
> maybe I didn't read the logs carefully enough.
> 
>   In any case, I am looking into creating a debug patch so we can
> narrow down the problem a bit further.
> 
> Kind regards
> Uffe
> 

Hi Ulf,

  I see that Jetson-TX2 / Jetson-Xavier suspend test is aborted and 
below error is seen due to the commit 
24ed3bd01d6a844fd5e8a75f48d0a3d10ed71bf9  ("mmc: core: Specify timeouts 
for BKOPS and CACHE_FLUSH for eMMC"):

##
[  268.976197] Freezing user space processes ... (elapsed 0.001 seconds) 
done.
[  268.984414] OOM killer disabled.
[  268.987635] Freezing remaining freezable tasks ... (elapsed 0.000 
seconds) done.
[  269.217471] PM: dpm_run_callback(): mmc_bus_suspend+0x0/0x58 returns -110
[  269.224255] PM: Device mmc1:0001 failed to suspend: error -110
[  269.230080] PM: Some devices failed to suspend, or early wake event 
detected
##

  I find that from the commit the changes in mmc_flush_cache below is 
the cause.

##
@@ -961,7 +963,8 @@ int mmc_flush_cache(struct mmc_card *card)
                         (card->ext_csd.cache_size > 0) &&
                         (card->ext_csd.cache_ctrl & 1)) {
                 err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-                               EXT_CSD_FLUSH_CACHE, 1, 0);
+                                EXT_CSD_FLUSH_CACHE, 1,
+                                MMC_CACHE_FLUSH_TIMEOUT_MS);

##

  Do you have suggestion to try for the suspend errors ?

-regards,
  Bitan

