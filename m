Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FC5C433B4
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F66761157
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhEGBzs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 21:55:48 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:35606 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbhEGBzr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 21:55:47 -0400
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 771EB759;
        Fri,  7 May 2021 09:54:46 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1748T140588898838272S1620352485330873_;
        Fri, 07 May 2021 09:54:46 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <682ca65d72ffff6087cea56925b65435>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <6e212f07-7732-cf5f-0c63-5693e48f87e2@rock-chips.com>
Date:   Fri, 7 May 2021 09:54:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0) Gecko/20100101
 Thunderbird/87.0
Cc:     shawn.lin@rock-chips.com, Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] mmc: core: Drop open coding in mmc_sd_switch()
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
 <20210504161222.101536-8-ulf.hansson@linaro.org>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210504161222.101536-8-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/5/5 0:12, Ulf Hansson wrote:
> The SD_SWITCH (CMD6) is an ADTC type of command with an R1 response, which
> can be sent by using the mmc_send_adtc_data(). Let's do that and drop the
> open coding in mmc_sd_switch().

Nice cleanup.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/mmc/core/sd_ops.c | 38 +++++++-------------------------------
>   1 file changed, 7 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index d61ff811218c..ef8d1dce5af1 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -17,6 +17,7 @@
>   
>   #include "core.h"
>   #include "sd_ops.h"
> +#include "mmc_ops.h"
>   
>   int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
>   {
> @@ -309,43 +310,18 @@ int mmc_app_send_scr(struct mmc_card *card)
>   int mmc_sd_switch(struct mmc_card *card, int mode, int group,
>   	u8 value, u8 *resp)
>   {
> -	struct mmc_request mrq = {};
> -	struct mmc_command cmd = {};
> -	struct mmc_data data = {};
> -	struct scatterlist sg;
> +	u32 cmd_args;
>   
>   	/* NOTE: caller guarantees resp is heap-allocated */
>   
>   	mode = !!mode;
>   	value &= 0xF;
> +	cmd_args = mode << 31 | 0x00FFFFFF;
> +	cmd_args &= ~(0xF << (group * 4));
> +	cmd_args |= value << (group * 4);
>   
> -	mrq.cmd = &cmd;
> -	mrq.data = &data;
> -
> -	cmd.opcode = SD_SWITCH;
> -	cmd.arg = mode << 31 | 0x00FFFFFF;
> -	cmd.arg &= ~(0xF << (group * 4));
> -	cmd.arg |= value << (group * 4);
> -	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> -
> -	data.blksz = 64;
> -	data.blocks = 1;
> -	data.flags = MMC_DATA_READ;
> -	data.sg = &sg;
> -	data.sg_len = 1;
> -
> -	sg_init_one(&sg, resp, 64);
> -
> -	mmc_set_data_timeout(&data, card);
> -
> -	mmc_wait_for_req(card->host, &mrq);
> -
> -	if (cmd.error)
> -		return cmd.error;
> -	if (data.error)
> -		return data.error;
> -
> -	return 0;
> +	return mmc_send_adtc_data(card, card->host, SD_SWITCH, cmd_args, resp,
> +				  64);
>   }
>   
>   int mmc_app_sd_status(struct mmc_card *card, void *ssr)
> 


