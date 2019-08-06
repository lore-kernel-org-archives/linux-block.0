Return-Path: <SRS0=0w4s=WC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE672C433FF
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 15:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F53C20717
	for <linux-block@archiver.kernel.org>; Tue,  6 Aug 2019 15:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731407AbfHFPnG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Aug 2019 11:43:06 -0400
Received: from ale.deltatee.com ([207.54.116.67]:41866 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbfHFPnF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Aug 2019 11:43:05 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hv1c6-0008Qc-3v; Tue, 06 Aug 2019 09:43:03 -0600
To:     Bart Van Assche <bvanassche@acm.org>,
        Omar Sandoval <osandov@fb.com>
Cc:     linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190805232512.50992-1-bvanassche@acm.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <dccabead-a290-ff2f-976a-c1dcdc4ea2c2@deltatee.com>
Date:   Tue, 6 Aug 2019 09:43:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190805232512.50992-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jthumshirn@suse.de, chaitanya.kulkarni@wdc.com, linux-block@vger.kernel.org, osandov@fb.com, bvanassche@acm.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests] Make the NVMe tests more reliable
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2019-08-05 5:25 p.m., Bart Van Assche wrote:
> When running blktests with kernel debugging enabled it can happen that
> _find_nvme_loop_dev() returns before the NVMe block device has appeared
> in sysfs. This patch avoids that the NVMe tests fail as follows:
> 
> +cat: /sys/block/nvme1n1/uuid: No such file or directory
> +cat: /sys/block/nvme1n1/wwid: No such file or directory
> 
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Cc: Johannes Thumshirn <jthumshirn@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Makes sense to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>  tests/nvme/rc | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 348b4a3c2cbc..05dfc5915a13 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -169,8 +169,16 @@ _find_nvme_loop_dev() {
>  		transport="$(cat "/sys/class/nvme/${dev}/transport")"
>  		if [[ "$transport" == "loop" ]]; then
>  			echo "$dev"
> +			for ((i=0;i<10;i++)); do
> +				[ -e /sys/block/$dev/uuid ] &&
> +					[ -e /sys/block/$dev/wwid ] &&
> +					return 0
> +				sleep .1
> +			done
> +			return 1
>  		fi
>  	done
> +	return 1
>  }
>  
>  _filter_discovery() {
> 
