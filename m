Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BADC433F5
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 05:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJEFGg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 01:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiJEFGA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 01:06:00 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80A3753A5
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 22:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664946263; x=1696482263;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uFJBTYsaMBZYY3AXnBMf5pwuXPfgYExf5gPkj72Rc1U=;
  b=kvLA/aBXgTpsSNCWLg5m4NqEiju13pm7ouBzu/ckoZ8Dce9W2ocBIsSv
   8omTm+9g+q5O6tJfZTmRCiUodpE4dF+CqHnwKJorHunbXUGCIbOXNm/KC
   3p7UhNK8JDizleTTP0eDRs/ba0DZPeA80aQBowdAhbA7tsuWmSOE38Rgf
   vkIvaB+s3mYeoDkYPuE/2ztHTLPqtb6hY44aaVFeo62nqdz+xLxWHeG0k
   jfm0JxCMd1aCKU75EWLKlxBW+ZTudeWQJcw7/GOTpqImqi/HdpRpb0+Fa
   GtLJ1ep0xrENhhXs3fI0NRgmhi1kbexVKWFyhwGBSm4oeI9Ze2UITTmCs
   w==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="317307260"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 13:04:22 +0800
IronPort-SDR: /4xAI+Mt8hJt1/MHpJh4V0IT43qP6JemEWa86xcRMAxzB6ZCeDrKJ8CntjGLaF+E3Vjaca3ebj
 z/zv/coDeOX+HEdsBg1Fqp8Qaxi+6dgRQ1SED+LneNOLlq7zPLjOuzPnpZn9zbGHgva5PmF+kD
 Z1lTbGZeNMfayOopOu/yqdfHbQFvPgW6gXfc2NavBGEpe6SiO0NXLgnro6QDYNuE8vkccxwvOk
 W5ZJvZ7yKYz5r1NyKICWgbR1LXXbdYyKBEKEzKauroeRML41dnFYxZmmXZKVEvMGEFOIvtHv1V
 rSoeGR3oWDGaW6ORwn8A2h9J
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 21:24:10 -0700
IronPort-SDR: T5SbC4St22G/tjKlKBB4ppCvJ6N2Ejh2LzRJUzWOT9wWe5mdMyM1tuChJgtpKkCWrzne9yXRXz
 9/SAYosVtxEw/8Ht/7Uq3ycWN8hvfXNUgwmM9nWrdlsBIEcJ5z72b/K9cr6tjzjSauoUmitSkE
 xxHp30vt3agpqnGguvmqLzzDd/E/tn8FIdAsqeoh0FBkWQE0qK04C0lkBR+v7ORkJkBBPQkVq8
 1xnPILBNbAMxH4tO3fdTJsDUWyQ+ekZhDjphBiHk7+ZXvpph4mTJjTmtXvPh5BEgff78ZKFJxq
 +2A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:04:23 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mj2YK6GhDz1RvTr
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 22:04:21 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664946261; x=1667538262; bh=uFJBTYsaMBZYY3AXnBMf5pwuXPfgYExf5gP
        kj72Rc1U=; b=gVsj93DwWdgMnF7DCLWcZQEKVFELmQMR+/yvEKgZ9dZeXAjAuXo
        h5/1IUAnUHxCM2yky/MyEI/znUM/OwdGwe0XtJ33336PTFR5uvlhP8Vj3NNdXI3i
        YLh+Y/KOM+4SqAXst0/+z20ZkhYM2qkmcVU7AixPqeaHGD30sIHY+frL9BjFiYwo
        j4ORy6Vy614d/6AXKE6337DkTwyL89YSbsaZZEVWMoOD55pYoMEDEt5Xdbwecmc6
        NB9hdV7cgwpGgQIlEe0DOuxZmVOTkvHWNt5bcyhhRpf4ZnFI39eYltil8QZRGNGV
        zaZQDjoCzO0JwFpiGsgB1giPEoqsrdHmyDg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OMxqn0hZrFEc for <linux-block@vger.kernel.org>;
        Tue,  4 Oct 2022 22:04:21 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mj2YH5h3mz1RvLy;
        Tue,  4 Oct 2022 22:04:19 -0700 (PDT)
Message-ID: <64c8beb8-ddb1-c86c-c6c6-aea93776f619@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 14:04:18 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 4/6] null_blk: initialize cmd->bio in __alloc_cmd()
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com, yukuai3@huawei.com
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-5-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221005031701.79077-5-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/5/22 12:16, Chaitanya Kulkarni wrote:
> The function __alloc_cmd() is responsible to allocate tag and
> initializae the different members of the null_cmd structure e.g.
> cmd->tag, cmd->error, and cmd->nq, Move only member bio that is initialized
> from alloc_cmd() into __alloc_cmd().
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/block/null_blk/main.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index b82c2ffeb086..765c1ca0edf5 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -743,7 +743,7 @@ static void free_cmd(struct nullb_cmd *cmd)
>  
>  static enum hrtimer_restart null_cmd_timer_expired(struct hrtimer *timer);
>  
> -static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
> +static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq, struct bio *bio)
>  {
>  	struct nullb_cmd *cmd;
>  	unsigned int tag;
> @@ -754,6 +754,7 @@ static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
>  		cmd->tag = tag;
>  		cmd->error = BLK_STS_OK;
>  		cmd->nq = nq;
> +		cmd->bio = bio;
>  		if (nq->dev->irqmode == NULL_IRQ_TIMER) {
>  			hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
>  				     HRTIMER_MODE_REL);
> @@ -775,11 +776,9 @@ static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, struct bio *bio)
>  		 * This avoids multiple return statements, multiple calls to
>  		 * __alloc_cmd() and a fast path call to prepare_to_wait().
>  		 */
> -		cmd = __alloc_cmd(nq);
> -		if (cmd) {
> -			cmd->bio = bio;
> +		cmd = __alloc_cmd(nq, bio);
> +		if (cmd)
>  			return cmd;
> -		}
>  		prepare_to_wait(&nq->wait, &wait, TASK_UNINTERRUPTIBLE);
>  		io_schedule();
>  		finish_wait(&nq->wait, &wait);

-- 
Damien Le Moal
Western Digital Research

