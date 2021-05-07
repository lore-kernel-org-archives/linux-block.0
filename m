Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DB7C433B4
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5434661132
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhEGBvB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 21:51:01 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:33292 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhEGBvB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 21:51:01 -0400
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id 51C0A694;
        Fri,  7 May 2021 09:42:21 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18566T140528133846784S1620351738235284_;
        Fri, 07 May 2021 09:42:19 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a10d003676044a432ba5bce4c0d3867d>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <64729494-6a61-99f9-db08-ab9d5f6af4cf@rock-chips.com>
Date:   Fri, 7 May 2021 09:42:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0) Gecko/20100101
 Thunderbird/87.0
Cc:     shawn.lin@rock-chips.com, Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] mmc: core: Drop open coding when preparing commands
 with busy signaling
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
 <20210504161222.101536-2-ulf.hansson@linaro.org>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210504161222.101536-2-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/5/5 0:12, Ulf Hansson wrote:
> Similar code for validating the host->max_busy_timeout towards the current
> command's busy timeout, exists in mmc_do_erase(), mmc_sleep() and
> __mmc_switch(). Let's move the common code into a helper function.

Looks nice.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/mmc/core/core.c    | 20 ++----------------
>   drivers/mmc/core/mmc.c     | 20 +++---------------
>   drivers/mmc/core/mmc_ops.c | 42 +++++++++++++++++++++-----------------
>   drivers/mmc/core/mmc_ops.h |  3 +++
>   4 files changed, 31 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index f194940c5974..b00c84ea8441 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1582,7 +1582,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>   {
>   	struct mmc_command cmd = {};
>   	unsigned int qty = 0, busy_timeout = 0;
> -	bool use_r1b_resp = false;
> +	bool use_r1b_resp;
>   	int err;
>   
>   	mmc_retune_hold(card->host);
> @@ -1650,23 +1650,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>   	cmd.opcode = MMC_ERASE;
>   	cmd.arg = arg;
>   	busy_timeout = mmc_erase_timeout(card, arg, qty);
> -	/*
> -	 * If the host controller supports busy signalling and the timeout for
> -	 * the erase operation does not exceed the max_busy_timeout, we should
> -	 * use R1B response. Or we need to prevent the host from doing hw busy
> -	 * detection, which is done by converting to a R1 response instead.
> -	 * Note, some hosts requires R1B, which also means they are on their own
> -	 * when it comes to deal with the busy timeout.
> -	 */
> -	if (!(card->host->caps & MMC_CAP_NEED_RSP_BUSY) &&
> -	    card->host->max_busy_timeout &&
> -	    busy_timeout > card->host->max_busy_timeout) {
> -		cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
> -	} else {
> -		cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
> -		cmd.busy_timeout = busy_timeout;
> -		use_r1b_resp = true;
> -	}
> +	use_r1b_resp = mmc_prepare_busy_cmd(card->host, &cmd, busy_timeout);
>   
>   	err = mmc_wait_for_cmd(card->host, &cmd, 0);
>   	if (err) {
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 8674c3e0c02c..63a7bd0b239c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1910,6 +1910,7 @@ static int mmc_sleep(struct mmc_host *host)
>   	struct mmc_command cmd = {};
>   	struct mmc_card *card = host->card;
>   	unsigned int timeout_ms = DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000);
> +	bool use_r1b_resp;
>   	int err;
>   
>   	/* Re-tuning can't be done once the card is deselected */
> @@ -1922,22 +1923,7 @@ static int mmc_sleep(struct mmc_host *host)
>   	cmd.opcode = MMC_SLEEP_AWAKE;
>   	cmd.arg = card->rca << 16;
>   	cmd.arg |= 1 << 15;
> -
> -	/*
> -	 * If the max_busy_timeout of the host is specified, validate it against
> -	 * the sleep cmd timeout. A failure means we need to prevent the host
> -	 * from doing hw busy detection, which is done by converting to a R1
> -	 * response instead of a R1B. Note, some hosts requires R1B, which also
> -	 * means they are on their own when it comes to deal with the busy
> -	 * timeout.
> -	 */
> -	if (!(host->caps & MMC_CAP_NEED_RSP_BUSY) && host->max_busy_timeout &&
> -	    (timeout_ms > host->max_busy_timeout)) {
> -		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> -	} else {
> -		cmd.flags = MMC_RSP_R1B | MMC_CMD_AC;
> -		cmd.busy_timeout = timeout_ms;
> -	}
> +	use_r1b_resp = mmc_prepare_busy_cmd(host, &cmd, timeout_ms);
>   
>   	err = mmc_wait_for_cmd(host, &cmd, 0);
>   	if (err)
> @@ -1949,7 +1935,7 @@ static int mmc_sleep(struct mmc_host *host)
>   	 * SEND_STATUS command to poll the status because that command (and most
>   	 * others) is invalid while the card sleeps.
>   	 */
> -	if (!cmd.busy_timeout || !(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
> +	if (!use_r1b_resp || !(host->caps & MMC_CAP_WAIT_WHILE_BUSY))
>   		mmc_delay(timeout_ms);
>   
>   out_release:
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 5756781fef37..025a4134d5c7 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -521,6 +521,27 @@ int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>   	return __mmc_poll_for_busy(card, timeout_ms, true, false, busy_cmd);
>   }
>   
> +bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
> +			  unsigned int timeout_ms)
> +{
> +	/*
> +	 * If the max_busy_timeout of the host is specified, make sure it's
> +	 * enough to fit the used timeout_ms. In case it's not, let's instruct
> +	 * the host to avoid HW busy detection, by converting to a R1 response
> +	 * instead of a R1B. Note, some hosts requires R1B, which also means
> +	 * they are on their own when it comes to deal with the busy timeout.
> +	 */
> +	if (!(host->caps & MMC_CAP_NEED_RSP_BUSY) && host->max_busy_timeout &&
> +	    (timeout_ms > host->max_busy_timeout)) {
> +		cmd->flags = MMC_CMD_AC | MMC_RSP_SPI_R1 | MMC_RSP_R1;
> +		return false;
> +	}
> +
> +	cmd->flags = MMC_CMD_AC | MMC_RSP_SPI_R1B | MMC_RSP_R1B;
> +	cmd->busy_timeout = timeout_ms;
> +	return true;
> +}
> +
>   /**
>    *	__mmc_switch - modify EXT_CSD register
>    *	@card: the MMC card associated with the data transfer
> @@ -543,7 +564,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>   	struct mmc_host *host = card->host;
>   	int err;
>   	struct mmc_command cmd = {};
> -	bool use_r1b_resp = true;
> +	bool use_r1b_resp;
>   	unsigned char old_timing = host->ios.timing;
>   
>   	mmc_retune_hold(host);
> @@ -554,29 +575,12 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>   		timeout_ms = card->ext_csd.generic_cmd6_time;
>   	}
>   
> -	/*
> -	 * If the max_busy_timeout of the host is specified, make sure it's
> -	 * enough to fit the used timeout_ms. In case it's not, let's instruct
> -	 * the host to avoid HW busy detection, by converting to a R1 response
> -	 * instead of a R1B. Note, some hosts requires R1B, which also means
> -	 * they are on their own when it comes to deal with the busy timeout.
> -	 */
> -	if (!(host->caps & MMC_CAP_NEED_RSP_BUSY) && host->max_busy_timeout &&
> -	    (timeout_ms > host->max_busy_timeout))
> -		use_r1b_resp = false;
> -
>   	cmd.opcode = MMC_SWITCH;
>   	cmd.arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
>   		  (index << 16) |
>   		  (value << 8) |
>   		  set;
> -	cmd.flags = MMC_CMD_AC;
> -	if (use_r1b_resp) {
> -		cmd.flags |= MMC_RSP_SPI_R1B | MMC_RSP_R1B;
> -		cmd.busy_timeout = timeout_ms;
> -	} else {
> -		cmd.flags |= MMC_RSP_SPI_R1 | MMC_RSP_R1;
> -	}
> +	use_r1b_resp = mmc_prepare_busy_cmd(host, &cmd, timeout_ms);
>   
>   	err = mmc_wait_for_cmd(host, &cmd, retries);
>   	if (err)
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 7bc1cfb0654c..ba898c435658 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -18,6 +18,7 @@ enum mmc_busy_cmd {
>   
>   struct mmc_host;
>   struct mmc_card;
> +struct mmc_command;
>   
>   int mmc_select_card(struct mmc_card *card);
>   int mmc_deselect_cards(struct mmc_host *host);
> @@ -35,6 +36,8 @@ int mmc_bus_test(struct mmc_card *card, u8 bus_width);
>   int mmc_can_ext_csd(struct mmc_card *card);
>   int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
>   int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
> +bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
> +			  unsigned int timeout_ms);
>   int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>   		      enum mmc_busy_cmd busy_cmd);
>   int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
> 


