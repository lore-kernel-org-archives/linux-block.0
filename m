Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59CDC3A5A7
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 08:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A237820870
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 08:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfIDIkd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:40:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbfIDIkc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Sep 2019 04:40:32 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 23DBB8759E719CA73CB5;
        Wed,  4 Sep 2019 16:40:31 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Sep 2019
 16:40:20 +0800
Subject: Re: [PATCH] paride/pcd: need to check if cd->disk is null in
 pcd_detect
To:     <tim@cyberelk.net>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>
CC:     <yi.zhang@huawei.com>
References: <1565695392-140970-1-git-send-email-zhengbin13@huawei.com>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <7d6ed196-8a4e-3eff-cf89-09f2a8081c38@huawei.com>
Date:   Wed, 4 Sep 2019 16:40:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <1565695392-140970-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping

On 2019/8/13 19:23, zhengbin wrote:
> If alloc_disk fails in pcd_init_units, cd->disk & pi are empty, we need
> to check if cd->disk is null in pcd_detect.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---
>  drivers/block/paride/pcd.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
> index bfca80d..636bfea 100644
> --- a/drivers/block/paride/pcd.c
> +++ b/drivers/block/paride/pcd.c
> @@ -723,9 +723,9 @@ static int pcd_detect(void)
>  	k = 0;
>  	if (pcd_drive_count == 0) { /* nothing spec'd - so autoprobe for 1 */
>  		cd = pcd;
> -		if (pi_init(cd->pi, 1, -1, -1, -1, -1, -1, pcd_buffer,
> -			    PI_PCD, verbose, cd->name)) {
> -			if (!pcd_probe(cd, -1, id) && cd->disk) {
> +		if (cd->disk && pi_init(cd->pi, 1, -1, -1, -1, -1, -1,
> +			    pcd_buffer, PI_PCD, verbose, cd->name)) {
> +			if (!pcd_probe(cd, -1, id)) {
>  				cd->present = 1;
>  				k++;
>  			} else
> @@ -736,11 +736,13 @@ static int pcd_detect(void)
>  			int *conf = *drives[unit];
>  			if (!conf[D_PRT])
>  				continue;
> +			if (!cd->disk)
> +				continue;
>  			if (!pi_init(cd->pi, 0, conf[D_PRT], conf[D_MOD],
>  				     conf[D_UNI], conf[D_PRO], conf[D_DLY],
>  				     pcd_buffer, PI_PCD, verbose, cd->name))
>  				continue;
> -			if (!pcd_probe(cd, conf[D_SLV], id) && cd->disk) {
> +			if (!pcd_probe(cd, conf[D_SLV], id)) {
>  				cd->present = 1;
>  				k++;
>  			} else
> --
> 2.7.4
>
>
> .
>

