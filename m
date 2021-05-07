Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D37BC433ED
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123F8610C8
	for <linux-block@archiver.kernel.org>; Fri,  7 May 2021 01:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhEGBwP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 May 2021 21:52:15 -0400
Received: from regular1.263xmail.com ([211.150.70.203]:56422 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbhEGBwP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 May 2021 21:52:15 -0400
Received: from localhost (unknown [192.168.167.13])
        by regular1.263xmail.com (Postfix) with ESMTP id 80401891;
        Fri,  7 May 2021 09:51:14 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.64] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1748T140588877858560S1620352273131891_;
        Fri, 07 May 2021 09:51:14 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a98d836b75d532a29c9602ab032c5f6c>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 10
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Message-ID: <fd7bf481-dfc2-4124-cbc3-4d55ec3b803b@rock-chips.com>
Date:   Fri, 7 May 2021 09:51:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:87.0) Gecko/20100101
 Thunderbird/87.0
Cc:     shawn.lin@rock-chips.com, Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] mmc: core: Extend re-use of __mmc_poll_for_busy()
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
 <20210504161222.101536-5-ulf.hansson@linaro.org>
From:   Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20210504161222.101536-5-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/5/5 0:12, Ulf Hansson wrote:
> Via __mmc_poll_for_busy() we end up polling with the ->card_busy() host ops
> or by sending the CMD13. To allow polling of different types, which is
> needed to support a few new SD card features, let's rework the code around
> __mmc_poll_for_busy() to make it more generic.
> 
> More precisely, let __mmc_poll_for_busy() take a pointer to a callback
> function as in-parameter, which it calls to poll for busy state completion.
> Additionally, let's share __mmc_poll_for_busy() to allow it to be re-used
> outside of mmc_ops.c. Subsequent changes will make use of it.
> 

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   drivers/mmc/core/core.c    |  2 +-
>   drivers/mmc/core/mmc_ops.c | 42 ++++++++++++++++++++++++--------------
>   drivers/mmc/core/mmc_ops.h |  5 ++++-
>   3 files changed, 32 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index b00c84ea8441..b039dcff17f8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1671,7 +1671,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>   		goto out;
>   
>   	/* Let's poll to find out when the erase operation completes. */
> -	err = mmc_poll_for_busy(card, busy_timeout, MMC_BUSY_ERASE);
> +	err = mmc_poll_for_busy(card, busy_timeout, false, MMC_BUSY_ERASE);
>   
>   out:
>   	mmc_retune_release(card->host);
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index ccaee1cb7ff5..653627fe02a3 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -53,6 +53,12 @@ static const u8 tuning_blk_pattern_8bit[] = {
>   	0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
>   };
>   
> +struct mmc_busy_data {
> +	struct mmc_card *card;
> +	bool retry_crc_err;
> +	enum mmc_busy_cmd busy_cmd;
> +};
> +
>   int __mmc_send_status(struct mmc_card *card, u32 *status, unsigned int retries)
>   {
>   	int err;
> @@ -424,10 +430,10 @@ int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal)
>   	return mmc_switch_status_error(card->host, status);
>   }
>   
> -static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
> -			   enum mmc_busy_cmd busy_cmd, bool *busy)
> +static int mmc_busy_cb(void *cb_data, bool *busy)
>   {
> -	struct mmc_host *host = card->host;
> +	struct mmc_busy_data *data = cb_data;
> +	struct mmc_host *host = data->card->host;
>   	u32 status = 0;
>   	int err;
>   
> @@ -436,17 +442,17 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
>   		return 0;
>   	}
>   
> -	err = mmc_send_status(card, &status);
> -	if (retry_crc_err && err == -EILSEQ) {
> +	err = mmc_send_status(data->card, &status);
> +	if (data->retry_crc_err && err == -EILSEQ) {
>   		*busy = true;
>   		return 0;
>   	}
>   	if (err)
>   		return err;
>   
> -	switch (busy_cmd) {
> +	switch (data->busy_cmd) {
>   	case MMC_BUSY_CMD6:
> -		err = mmc_switch_status_error(card->host, status);
> +		err = mmc_switch_status_error(host, status);
>   		break;
>   	case MMC_BUSY_ERASE:
>   		err = R1_STATUS(status) ? -EIO : 0;
> @@ -464,8 +470,9 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
>   	return 0;
>   }
>   
> -static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
> -			       bool retry_crc_err, enum mmc_busy_cmd busy_cmd)
> +int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
> +			int (*busy_cb)(void *cb_data, bool *busy),
> +			void *cb_data)
>   {
>   	struct mmc_host *host = card->host;
>   	int err;
> @@ -482,7 +489,7 @@ static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>   		 */
>   		expired = time_after(jiffies, timeout);
>   
> -		err = mmc_busy_status(card, retry_crc_err, busy_cmd, &busy);
> +		err = (*busy_cb)(cb_data, &busy);
>   		if (err)
>   			return err;
>   
> @@ -505,9 +512,15 @@ static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
>   }
>   
>   int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
> -		      enum mmc_busy_cmd busy_cmd)
> +		      bool retry_crc_err, enum mmc_busy_cmd busy_cmd)
>   {
> -	return __mmc_poll_for_busy(card, timeout_ms, false, busy_cmd);
> +	struct mmc_busy_data cb_data;
> +
> +	cb_data.card = card;
> +	cb_data.retry_crc_err = retry_crc_err;
> +	cb_data.busy_cmd = busy_cmd;
> +
> +	return __mmc_poll_for_busy(card, timeout_ms, &mmc_busy_cb, &cb_data);
>   }
>   
>   bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
> @@ -591,8 +604,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>   	}
>   
>   	/* Let's try to poll to find out when the command is completed. */
> -	err = __mmc_poll_for_busy(card, timeout_ms, retry_crc_err,
> -				  MMC_BUSY_CMD6);
> +	err = mmc_poll_for_busy(card, timeout_ms, retry_crc_err, MMC_BUSY_CMD6);
>   	if (err)
>   		goto out;
>   
> @@ -840,7 +852,7 @@ static int mmc_send_hpi_cmd(struct mmc_card *card)
>   		return 0;
>   
>   	/* Let's poll to find out when the HPI request completes. */
> -	return mmc_poll_for_busy(card, busy_timeout_ms, MMC_BUSY_HPI);
> +	return mmc_poll_for_busy(card, busy_timeout_ms, false, MMC_BUSY_HPI);
>   }
>   
>   /**
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index ba898c435658..aca66c128804 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -38,8 +38,11 @@ int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
>   int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
>   bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
>   			  unsigned int timeout_ms);
> +int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
> +			int (*busy_cb)(void *cb_data, bool *busy),
> +			void *cb_data);
>   int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
> -		      enum mmc_busy_cmd busy_cmd);
> +		      bool retry_crc_err, enum mmc_busy_cmd busy_cmd);
>   int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>   		unsigned int timeout_ms, unsigned char timing,
>   		bool send_status, bool retry_crc_err, unsigned int retries);
> 


