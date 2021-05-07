Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCB4C433B4
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4093F6113E
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhEGB71 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 21:59:27 -0400
Received: from regular1.263xmail.com ([211.150.70.204]:40998 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbhEGB70 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 21:59:26 -0400
Received: from localhost (unknown [192.168.167.223])
        by regular1.263xmail.com (Postfix) with ESMTP id B58175B1;
        Fri,  7 May 2021 09:58:25 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P22002T139994497025792S1620352704320007_;
        Fri, 07 May 2021 09:58:25 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4ca702759911cd48c330db2a6c072e83>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <3590da3a-046d-3fd4-42e2-238fcb6751ab@rock-chips.com>
Date:   Fri, 7 May 2021 09:58:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0) Gecko/20100101
 Thunderbird/87.0
Cc:     shawn.lin@rock-chips.com, Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/11] mmc: core: Parse the SD SCR register for support of
 CMD48/49 and CMD58/59
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
 <20210504161222.101536-9-ulf.hansson@linaro.org>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210504161222.101536-9-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 2021/5/5 0:12, Ulf Hansson wrote:
> In SD spec v4.x the support for CMD48/49 and CMD58/59 were introduced as
> optional features. To let the card announce whether it supports the
> commands, the SCR register has been extended with corresponding support
> bits. Let's parse and store this information for later use.
> 

Just check v4.0 spec, and it says

"Table 4-32 is added in Version 4.00. These commands are reserved for
future extenstion". So,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/mmc/core/sd.c    | 4 +++-
>   include/linux/mmc/card.h | 2 ++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 2c48d6504101..de7b5f8df550 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -222,7 +222,9 @@ static int mmc_decode_scr(struct mmc_card *card)
>   	else
>   		card->erased_byte = 0x0;
>   
> -	if (scr->sda_spec3)
> +	if (scr->sda_spec4)
> +		scr->cmds = UNSTUFF_BITS(resp, 32, 4);
> +	else if (scr->sda_spec3)
>   		scr->cmds = UNSTUFF_BITS(resp, 32, 2);
>   
>   	/* SD Spec says: any SD Card shall set at least bits 0 and 2 */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index f9ad35dd6012..858fc4d11240 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -139,6 +139,8 @@ struct sd_scr {
>   	unsigned char		cmds;
>   #define SD_SCR_CMD20_SUPPORT   (1<<0)
>   #define SD_SCR_CMD23_SUPPORT   (1<<1)
> +#define SD_SCR_CMD48_SUPPORT   (1<<2)
> +#define SD_SCR_CMD58_SUPPORT   (1<<3)
>   };
>   
>   struct sd_ssr {
> 


