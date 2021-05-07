Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87CFDC433B4
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E2A61157
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhEGBy7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 21:54:59 -0400
Received: from regular1.263xmail.com ([211.150.70.199]:50498 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhEGBy7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 21:54:59 -0400
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id 3E85012DF;
        Fri,  7 May 2021 09:53:57 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18566T140528041588480S1620352435686475_;
        Fri, 07 May 2021 09:53:56 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f54244c580b7fec20edceece475b7d61>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <def9bf7e-27c6-db08-d4f6-37d1f5205514@rock-chips.com>
Date:   Fri, 7 May 2021 09:53:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0) Gecko/20100101
 Thunderbird/87.0
Cc:     shawn.lin@rock-chips.com, Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] mmc: core: Prepare mmc_send_cxd_data() to be
 re-used for additional cmds
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
 <20210504161222.101536-7-ulf.hansson@linaro.org>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210504161222.101536-7-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/5/5 0:12, Ulf Hansson wrote:
> The function mmc_send_cxd_data() sends a data read command of ADTC type and
> prepares to receive an R1 response. To make it even more re-usable, let's
> extend it with another in-parameter for the command argument. While at it,
> let's also rename the function to mmc_send_adtc_data() as it better
> describes its purpose.
> 
> Note that, this change doesn't add any new users of the function. Instead
> that is done from subsequent changes.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/mmc/core/mmc_ops.c | 11 +++++------
>   drivers/mmc/core/mmc_ops.h |  2 ++
>   2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 653627fe02a3..b1da8f1950ee 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -252,9 +252,8 @@ mmc_send_cxd_native(struct mmc_host *host, u32 arg, u32 *cxd, int opcode)
>    * NOTE: void *buf, caller for the buf is required to use DMA-capable
>    * buffer or on-stack buffer (with some overhead in callee).
>    */
> -static int
> -mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
> -		u32 opcode, void *buf, unsigned len)
> +int mmc_send_adtc_data(struct mmc_card *card, struct mmc_host *host, u32 opcode,
> +		       u32 args, void *buf, unsigned len)
>   {
>   	struct mmc_request mrq = {};
>   	struct mmc_command cmd = {};
> @@ -265,7 +264,7 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
>   	mrq.data = &data;
>   
>   	cmd.opcode = opcode;
> -	cmd.arg = 0;
> +	cmd.arg = args;
>   
>   	/* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but we
>   	 * rely on callers to never use this with "native" calls for reading
> @@ -311,7 +310,7 @@ static int mmc_spi_send_cxd(struct mmc_host *host, u32 *cxd, u32 opcode)
>   	if (!cxd_tmp)
>   		return -ENOMEM;
>   
> -	ret = mmc_send_cxd_data(NULL, host, opcode, cxd_tmp, 16);
> +	ret = mmc_send_adtc_data(NULL, host, opcode, 0, cxd_tmp, 16);
>   	if (ret)
>   		goto err;
>   
> @@ -359,7 +358,7 @@ int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
>   	if (!ext_csd)
>   		return -ENOMEM;
>   
> -	err = mmc_send_cxd_data(card, card->host, MMC_SEND_EXT_CSD, ext_csd,
> +	err = mmc_send_adtc_data(card, card->host, MMC_SEND_EXT_CSD, 0, ext_csd,
>   				512);
>   	if (err)
>   		kfree(ext_csd);
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index aca66c128804..2b1d730e56bf 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -26,6 +26,8 @@ int mmc_set_dsr(struct mmc_host *host);
>   int mmc_go_idle(struct mmc_host *host);
>   int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
>   int mmc_set_relative_addr(struct mmc_card *card);
> +int mmc_send_adtc_data(struct mmc_card *card, struct mmc_host *host, u32 opcode,
> +		       u32 args, void *buf, unsigned len);
>   int mmc_send_csd(struct mmc_card *card, u32 *csd);
>   int __mmc_send_status(struct mmc_card *card, u32 *status, unsigned int retries);
>   int mmc_send_status(struct mmc_card *card, u32 *status);
> 


