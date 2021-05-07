Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230FBC43461
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 07:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC588610A7
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 07:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhEGHtq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 May 2021 03:49:46 -0400
Received: from regular1.263xmail.com ([211.150.70.200]:45966 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbhEGHtq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 May 2021 03:49:46 -0400
Received: from localhost (unknown [192.168.167.223])
        by regular1.263xmail.com (Postfix) with ESMTP id EC5921DB0;
        Fri,  7 May 2021 15:48:12 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P22002T139994528495360S1620373687641165_;
        Fri, 07 May 2021 15:48:08 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <57d47a615c0b9b3e5d279cb0b2b78764>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <dc1d03ed-c8ab-468c-e602-938e92322fa8@rock-chips.com>
Date:   Fri, 7 May 2021 15:48:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0) Gecko/20100101
 Thunderbird/87.0
Cc:     shawn.lin@rock-chips.com, linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/11] mmc: core: Read the SD function extension registers
 for power management
To:     Ulf Hansson <ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
 <20210504161222.101536-10-ulf.hansson@linaro.org>
 <1a4227c1-4d55-b55f-2fc6-9f9562ef02e5@rock-chips.com>
 <CAPDyKFqVuuVnntRHQ-8hWjyJ5Kzj9DzkjQ=mknQxzRTH1og+xw@mail.gmail.com>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAPDyKFqVuuVnntRHQ-8hWjyJ5Kzj9DzkjQ=mknQxzRTH1og+xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/5/7 15:27, Ulf Hansson wrote:
> On Fri, 7 May 2021 at 04:06, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>>
>>
>> On 2021/5/5 0:12, Ulf Hansson wrote:
>>> In SD spec v4.x the SD function extension registers were introduced. A
>>
>> I have a v4.0 spec and it doesn't state that v4.0 suppports reading
>> extension registers but just says TBD instead.  So I guess v4.x doesn't
>> include v4.0 ?
> 
> Good question. The v4.0 spec introduces the CMD48/49 and CMD58/59,
> while in v4.10 the spec adds the power management extensions.
> 
> I can update the commit message to better reflect this, if you prefer!?

It would be better.

And I downloaded the latest v8.00 spec, checked carefully with the new
features there to make sure we don't make any misinterpretations at
first.

For patch 9 -11 as well,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.con>

> 
> Thanks a lot for reviewing!
> 
> Kind regards
> Uffe
> 
>>
>>> specific function register were added to let the card announce support for
>>> optional features in regards to power management. The features that were
>>> added are "Power Off Notification", "Power Down Mode" and "Power
>>> Sustenance".
>>>
>>> As a first step, let's read and parse this register for power management
>>> during the SD card initialization and store the information about the
>>> supported features in the struct mmc_card. In this way, we prepare for
>>> subsequent changes to implement the complete support for the new features.
>>>
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> ---
>>>    drivers/mmc/core/sd.c    | 178 +++++++++++++++++++++++++++++++++++++++
>>>    include/linux/mmc/card.h |  13 +++
>>>    include/linux/mmc/sd.h   |   3 +
>>>    3 files changed, 194 insertions(+)
>>>
>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>> index de7b5f8df550..cb5e8b2fc32f 100644
>>> --- a/drivers/mmc/core/sd.c
>>> +++ b/drivers/mmc/core/sd.c
>>> @@ -996,6 +996,177 @@ static bool mmc_sd_card_using_v18(struct mmc_card *card)
>>>               (SD_MODE_UHS_SDR50 | SD_MODE_UHS_SDR104 | SD_MODE_UHS_DDR50);
>>>    }
>>>
>>> +static int sd_read_ext_reg(struct mmc_card *card, u8 fno, u8 page,
>>> +                        u16 offset, u16 len, u8 *reg_buf)
>>> +{
>>> +     u32 cmd_args;
>>> +
>>> +     /*
>>> +      * Command arguments of CMD48:
>>> +      * [31:31] MIO (0 = memory).
>>> +      * [30:27] FNO (function number).
>>> +      * [26:26] reserved (0).
>>> +      * [25:18] page number.
>>> +      * [17:9] offset address.
>>> +      * [8:0] length (0 = 1 byte, 1ff = 512 bytes).
>>> +      */
>>> +     cmd_args = fno << 27 | page << 18 | offset << 9 | (len -1);
>>> +
>>> +     return mmc_send_adtc_data(card, card->host, SD_READ_EXTR_SINGLE,
>>> +                               cmd_args, reg_buf, 512);
>>> +}
>>> +
>>> +static int sd_parse_ext_reg_power(struct mmc_card *card, u8 fno, u8 page,
>>> +                               u16 offset)
>>> +{
>>> +     int err;
>>> +     u8 *reg_buf;
>>> +
>>> +     reg_buf = kzalloc(512, GFP_KERNEL);
>>> +     if (!reg_buf)
>>> +             return -ENOMEM;
>>> +
>>> +     /* Read the extension register for power management function. */
>>> +     err = sd_read_ext_reg(card, fno, page, offset, 512, reg_buf);
>>> +     if (err) {
>>> +             pr_warn("%s: error %d reading PM func of ext reg\n",
>>> +                     mmc_hostname(card->host), err);
>>> +             goto out;
>>> +     }
>>> +
>>> +     /* PM revision consists of 4 bits. */
>>> +     card->ext_power.rev = reg_buf[0] & 0xf;
>>> +
>>> +     /* Power Off Notification support at bit 4. */
>>> +     if (reg_buf[1] & 0x10)
>>> +             card->ext_power.feature_support |= SD_EXT_POWER_OFF_NOTIFY;
>>> +
>>> +     /* Power Sustenance support at bit 5. */
>>> +     if (reg_buf[1] & 0x20)
>>> +             card->ext_power.feature_support |= SD_EXT_POWER_SUSTENANCE;
>>> +
>>> +     /* Power Down Mode support at bit 6. */
>>> +     if (reg_buf[1] & 0x40)
>>> +             card->ext_power.feature_support |= SD_EXT_POWER_DOWN_MODE;
>>> +
>>> +     card->ext_power.fno = fno;
>>> +     card->ext_power.page = page;
>>> +     card->ext_power.offset = offset;
>>> +
>>> +out:
>>> +     kfree(reg_buf);
>>> +     return err;
>>> +}
>>> +
>>> +static int sd_parse_ext_reg(struct mmc_card *card, u8 *gen_info_buf,
>>> +                         u16 *next_ext_addr)
>>> +{
>>> +     u8 num_regs, fno, page;
>>> +     u16 sfc, offset, ext = *next_ext_addr;
>>> +     u32 reg_addr;
>>> +
>>> +     /*
>>> +      * Parse only one register set per extension, as that is sufficient to
>>> +      * support the standard functions. This means another 48 bytes in the
>>> +      * buffer must be available.
>>> +      */
>>> +     if (ext + 48 > 512)
>>> +             return -EFAULT;
>>> +
>>> +     /* Standard Function Code */
>>> +     memcpy(&sfc, &gen_info_buf[ext], 2);
>>> +
>>> +     /* Address to the next extension. */
>>> +     memcpy(next_ext_addr, &gen_info_buf[ext + 40], 2);
>>> +
>>> +     /* Number of registers for this extension. */
>>> +     num_regs = gen_info_buf[ext + 42];
>>> +
>>> +     /* We support only one register per extension. */
>>> +     if (num_regs != 1)
>>> +             return 0;
>>> +
>>> +     /* Extension register address. */
>>> +     memcpy(&reg_addr, &gen_info_buf[ext + 44], 4);
>>> +
>>> +     /* 9 bits (0 to 8) contains the offset address. */
>>> +     offset = reg_addr & 0x1ff;
>>> +
>>> +     /* 8 bits (9 to 16) contains the page number. */
>>> +     page = reg_addr >> 9 & 0xff ;
>>> +
>>> +     /* 4 bits (18 to 21) contains the function number. */
>>> +     fno = reg_addr >> 18 & 0xf;
>>> +
>>> +     /* Standard Function Code for power management. */
>>> +     if (sfc == 0x1)
>>> +             return sd_parse_ext_reg_power(card, fno, page, offset);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int sd_read_ext_regs(struct mmc_card *card)
>>> +{
>>> +     int err, i;
>>> +     u8 num_ext, *gen_info_buf;
>>> +     u16 rev, len, next_ext_addr;
>>> +
>>> +     if (mmc_host_is_spi(card->host))
>>> +             return 0;
>>> +
>>> +     if (!(card->scr.cmds & SD_SCR_CMD48_SUPPORT))
>>> +             return 0;
>>> +
>>> +     gen_info_buf = kzalloc(512, GFP_KERNEL);
>>> +     if (!gen_info_buf)
>>> +             return -ENOMEM;
>>> +
>>> +     /*
>>> +      * Read 512 bytes of general info, which is found at function number 0,
>>> +      * at page 0 and with no offset.
>>> +      */
>>> +     err = sd_read_ext_reg(card, 0, 0, 0, 512, gen_info_buf);
>>> +     if (err) {
>>> +             pr_warn("%s: error %d reading general info of SD ext reg\n",
>>> +                     mmc_hostname(card->host), err);
>>> +             goto out;
>>> +     }
>>> +
>>> +     /* General info structure revision. */
>>> +     memcpy(&rev, &gen_info_buf[0], 2);
>>> +
>>> +     /* Length of general info in bytes. */
>>> +     memcpy(&len, &gen_info_buf[2], 2);
>>> +
>>> +     /* Number of extensions to be find. */
>>> +     num_ext = gen_info_buf[4];
>>> +
>>> +     /* We support revision 0, but limit it to 512 bytes for simplicity. */
>>> +     if (rev != 0 || len > 512) {
>>> +             pr_warn("%s: non-supported SD ext reg layout\n",
>>> +                     mmc_hostname(card->host));
>>> +             goto out;
>>> +     }
>>> +
>>> +     /*
>>> +      * Parse the extension registers. The first extension should start
>>> +      * immediately after the general info header (16 bytes).
>>> +      */
>>> +     next_ext_addr = 16;
>>> +     for (i = 0; i < num_ext; i++) {
>>> +             err = sd_parse_ext_reg(card, gen_info_buf, &next_ext_addr);
>>> +             if (err) {
>>> +                     pr_warn("%s: error %d parsing SD ext reg\n",
>>> +                             mmc_hostname(card->host), err);
>>> +                     goto out;
>>> +             }
>>> +     }
>>> +
>>> +out:
>>> +     kfree(gen_info_buf);
>>> +     return err;
>>> +}
>>> +
>>>    /*
>>>     * Handle the detection and initialisation of a card.
>>>     *
>>> @@ -1144,6 +1315,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>>>                }
>>>        }
>>>
>>> +     if (!oldcard) {
>>> +             /* Read/parse the extension registers. */
>>> +             err = sd_read_ext_regs(card);
>>> +             if (err)
>>> +                     goto free_card;
>>> +     }
>>> +
>>>        if (host->cqe_ops && !host->cqe_enabled) {
>>>                err = host->cqe_ops->cqe_enable(host, card);
>>>                if (!err) {
>>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
>>> index 858fc4d11240..03a862e93594 100644
>>> --- a/include/linux/mmc/card.h
>>> +++ b/include/linux/mmc/card.h
>>> @@ -191,6 +191,18 @@ struct sd_switch_caps {
>>>    #define SD_MAX_CURRENT_800  (1 << SD_SET_CURRENT_LIMIT_800)
>>>    };
>>>
>>> +struct sd_ext_reg {
>>> +     u8                      fno;
>>> +     u8                      page;
>>> +     u16                     offset;
>>> +     u8                      rev;
>>> +     u8                      feature_support;
>>> +/* Power Management Function. */
>>> +#define SD_EXT_POWER_OFF_NOTIFY      (1<<0)
>>> +#define SD_EXT_POWER_SUSTENANCE      (1<<1)
>>> +#define SD_EXT_POWER_DOWN_MODE       (1<<2)
>>> +};
>>> +
>>>    struct sdio_cccr {
>>>        unsigned int            sdio_vsn;
>>>        unsigned int            sd_vsn;
>>> @@ -292,6 +304,7 @@ struct mmc_card {
>>>        struct sd_scr           scr;            /* extra SD information */
>>>        struct sd_ssr           ssr;            /* yet more SD information */
>>>        struct sd_switch_caps   sw_caps;        /* switch (CMD6) caps */
>>> +     struct sd_ext_reg       ext_power;      /* SD extension reg for PM */
>>>
>>>        unsigned int            sdio_funcs;     /* number of SDIO functions */
>>>        atomic_t                sdio_funcs_probed; /* number of probed SDIO funcs */
>>> diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
>>> index 2236aa540faa..43bfc5c39ad4 100644
>>> --- a/include/linux/mmc/sd.h
>>> +++ b/include/linux/mmc/sd.h
>>> @@ -29,6 +29,9 @@
>>>    #define SD_APP_OP_COND           41   /* bcr  [31:0] OCR         R3  */
>>>    #define SD_APP_SEND_SCR          51   /* adtc                    R1  */
>>>
>>> +  /* class 11 */
>>> +#define SD_READ_EXTR_SINGLE      48   /* adtc [31:0]             R1  */
>>> +
>>>    /* OCR bit definitions */
>>>    #define SD_OCR_S18R         (1 << 24)    /* 1.8V switching request */
>>>    #define SD_ROCR_S18A                SD_OCR_S18R  /* 1.8V switching accepted by card */
>>>
>>
>>
> 
> 
> 


