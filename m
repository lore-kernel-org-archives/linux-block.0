Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564ACC433B4
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F7F610C8
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhEGBtB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 21:49:01 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:54670 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhEGBtA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 21:49:00 -0400
X-Greylist: delayed 319 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 May 2021 21:49:00 EDT
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 90558776;
        Fri,  7 May 2021 09:44:31 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31917T139684137133824S1620351870407100_;
        Fri, 07 May 2021 09:44:31 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <418bceb8c99b1cc94bbf797774860f9e>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <6d528e02-dd27-65d3-0cd3-e764cc780a81@rock-chips.com>
Date:   Fri, 7 May 2021 09:44:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0) Gecko/20100101
 Thunderbird/87.0
Cc:     shawn.lin@rock-chips.com, Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] mmc: core: Take into account MMC_CAP_NEED_RSP_BUSY
 for eMMC HPI commands
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
 <20210504161222.101536-3-ulf.hansson@linaro.org>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210504161222.101536-3-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/5/5 0:12, Ulf Hansson wrote:
> In mmc_send_hpi_cmd() the host->max_busy_timeout is being validated towards
> the timeout for the eMMC HPI command, as to decide whether an R1 or R1B
> response should be used.
> 
> Although, it has turned out the some host can't cope with that conversion,
> but needs R1B, which means MMC_CAP_NEED_RSP_BUSY is set for them. Let's
> take this into account, via using the common mmc_prepare_busy_cmd() when
> doing the validation, which also avoids some open coding.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/mmc/core/mmc_ops.c | 21 +++++----------------
>   1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 025a4134d5c7..66ae699a410f 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -817,28 +817,17 @@ static int mmc_send_hpi_cmd(struct mmc_card *card)
>   {
>   	unsigned int busy_timeout_ms = card->ext_csd.out_of_int_time;
>   	struct mmc_host *host = card->host;
> -	bool use_r1b_resp = true;
> +	bool use_r1b_resp = false;
>   	struct mmc_command cmd = {};
>   	int err;
>   
>   	cmd.opcode = card->ext_csd.hpi_cmd;
>   	cmd.arg = card->rca << 16 | 1;
> +	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
>   
> -	/*
> -	 * Make sure the host's max_busy_timeout fit the needed timeout for HPI.
> -	 * In case it doesn't, let's instruct the host to avoid HW busy
> -	 * detection, by using a R1 response instead of R1B.
> -	 */
> -	if (host->max_busy_timeout && busy_timeout_ms > host->max_busy_timeout)
> -		use_r1b_resp = false;
> -
> -	if (cmd.opcode == MMC_STOP_TRANSMISSION && use_r1b_resp) {
> -		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
> -		cmd.busy_timeout = busy_timeout_ms;
> -	} else {
> -		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> -		use_r1b_resp = false;
> -	}
> +	if (cmd.opcode == MMC_STOP_TRANSMISSION)
> +		use_r1b_resp = mmc_prepare_busy_cmd(host, &cmd,
> +						    busy_timeout_ms);
>   
>   	err = mmc_wait_for_cmd(host, &cmd, 0);
>   	if (err) {
> 


