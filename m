Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9085C433B4
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1AF461027
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbhEGBtg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 21:49:36 -0400
Received: from regular1.263xmail.com ([211.150.70.195]:38524 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhEGBtg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 21:49:36 -0400
Received: from localhost (unknown [192.168.167.235])
        by regular1.263xmail.com (Postfix) with ESMTP id EB0821BD6;
        Fri,  7 May 2021 09:48:35 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P2749T140649028380416S1620352112258338_;
        Fri, 07 May 2021 09:48:34 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <3ec0d0c4447b4275db45ae7c2348390a>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <d16537da-8256-f7ed-677d-011654c62bd4@rock-chips.com>
Date:   Fri, 7 May 2021 09:48:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0) Gecko/20100101
 Thunderbird/87.0
Cc:     shawn.lin@rock-chips.com, Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] mmc: core: Re-structure some code in
 __mmc_poll_for_busy()
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
 <20210504161222.101536-4-ulf.hansson@linaro.org>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210504161222.101536-4-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/5/5 0:12, Ulf Hansson wrote:
> To make the code a bit more understandable, let's move the check about
> whether polling is allowed or not, out to the caller instead. In this way,
> we can also drop the send_status in-parameter, so let's do that.

Everytime I check the parameters for busy polling, I have to look very
closely to make sure what the true or false stands for. So reducing the
parameters here make sense.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/mmc/core/mmc_ops.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 66ae699a410f..ccaee1cb7ff5 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -465,8 +465,7 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
>   }
>   
>   static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
> -			       bool send_status, bool retry_crc_err,
> -			       enum mmc_busy_cmd busy_cmd)
> +			       bool retry_crc_err, enum mmc_busy_cmd busy_cmd)
>   {
>   	struct mmc_host *host = card->host;
>   	int err;
> @@ -475,16 +474,6 @@ static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>   	bool expired = false;
>   	bool busy = false;
>   
> -	/*
> -	 * In cases when not allowed to poll by using CMD13 or because we aren't
> -	 * capable of polling by using ->card_busy(), then rely on waiting the
> -	 * stated timeout to be sufficient.
> -	 */
> -	if (!send_status && !host->ops->card_busy) {
> -		mmc_delay(timeout_ms);
> -		return 0;
> -	}
> -
>   	timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
>   	do {
>   		/*
> @@ -518,7 +507,7 @@ static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>   int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>   		      enum mmc_busy_cmd busy_cmd)
>   {
> -	return __mmc_poll_for_busy(card, timeout_ms, true, false, busy_cmd);
> +	return __mmc_poll_for_busy(card, timeout_ms, false, busy_cmd);
>   }
>   
>   bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
> @@ -591,8 +580,18 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>   		mmc_host_is_spi(host))
>   		goto out_tim;
>   
> +	/*
> +	 * If the host doesn't support HW polling via the ->card_busy() ops and
> +	 * when it's not allowed to poll by using CMD13, then we need to rely on
> +	 * waiting the stated timeout to be sufficient.
> +	 */
> +	if (!send_status && !host->ops->card_busy) {
> +		mmc_delay(timeout_ms);
> +		goto out_tim;
> +	}
> +
>   	/* Let's try to poll to find out when the command is completed. */
> -	err = __mmc_poll_for_busy(card, timeout_ms, send_status, retry_crc_err,
> +	err = __mmc_poll_for_busy(card, timeout_ms, retry_crc_err,
>   				  MMC_BUSY_CMD6);
>   	if (err)
>   		goto out;
> 


