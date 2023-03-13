Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C947C6FD19
	for <linux-block@archiver.kernel.org>; Mon, 13 Mar 2023 01:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCMBAj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Mar 2023 21:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMBAi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Mar 2023 21:00:38 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7093629429
        for <linux-block@vger.kernel.org>; Sun, 12 Mar 2023 18:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678669234; x=1710205234;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TZ9hmTug9/+SbaIJsNlFxN8Yz88RN4hP0DPgXCVIw7w=;
  b=PZVbWhN1FP0t0egwN/wBisaIXjH3X5+vXcDZu+fGaAn2g1NAyaOmNTg8
   GjtpZi0U5OPTqsSi3R67Hj5WRn9+uQ/kaEKfd4SoiNkkUDwipfme65AGC
   /1gDa74xQnbbRsQvzli+bm2Oqg8jLbuzceYD8WCmYkde4jW91rZqy2PNb
   Ar4JPNUlILDWfIxWEDM4TYJSfuaPVi4nV0lRkaCl2tDnAZOgKeWT1mdNI
   PGd6zBJCM65mQ7hJuYqG2mSOm5Xz+IIgxZ0j0IbBwaLtufyEqwkmy0LcW
   pzPd8IVpyobcNefFeHamiExZ3kMg3ZvESJbj8tQa59K9RzTjh11hMDHE7
   g==;
X-IronPort-AV: E=Sophos;i="5.98,254,1673884800"; 
   d="scan'208";a="223744819"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Mar 2023 09:00:32 +0800
IronPort-SDR: lkmElhdSFoOuWKe5wRszNrg1x4WY2i9ALJ25J5wbM5EO51G0XYcqmJA9YHbJdbj0pOasyi02z0
 gDtPGmY8Lyp6aS7QDvQqElGeNuoxmmTp+DcoMsGYeyFGRlRHD0OAAxg9IYWG9JwDEigshC+wXF
 SOY6Kia0rvAmH9gs1LezMoFOD3MvZq9llaY5UMYrU+NHeFKdEMZRm4G81ts20HlAxNNlG3BJ1/
 qZxgzVjEYIKcaq39zjBDZEiyr4lERZAPR5oGuZps1Uw/ZNyk0hqu4hYZnad41xu8JO11MtyT91
 9EI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2023 17:17:02 -0700
IronPort-SDR: O+kodt8+oAEyci5OjD/oL3qOOUqhJB99TlA8hbRDnBphSgJj2VN7X7WjwPwdtRT/ZrIidgUo9w
 2SFNQiSQytv0/as7NecFveY11SWSNLYRcltonC6gnL7ta+QIsAO4FzIG3WMhxGp5QiToPiVtm5
 VoLN7vGKa3eZk2N0vfoMj83FdG9EmHQosl4zgSO8YDVqiIw184m0r1f2sawiSdtmMFndxwrEW2
 Me6FRob+XDYxjNml73RN0AKdm5dgtPNTz0kXM6CELrPDHYLCvVTNEov25tHbU9VFCPJX8N8ZpC
 UjI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Mar 2023 18:00:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PZdcc4H3Gz1RwqL
        for <linux-block@vger.kernel.org>; Sun, 12 Mar 2023 18:00:32 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678669232; x=1681261233; bh=TZ9hmTug9/+SbaIJsNlFxN8Yz88RN4hP0DP
        gXCVIw7w=; b=pdQUYpLzB30eRLiN5MDgqVMqq3C4uzPf6coqezhqoUXImnL5BvR
        O3eWuwAUKWOV/AcjoCQx9yo9eLdX0u4oKHIgJ1zkSSfTlgPJcwB/Ie0pNY9CQvPO
        4mwufoKR+93gNpU7JMcDOTUWoAVHJe0UTz1ejtWRUCprWj9M4mmE5tIxEAt8Sy5w
        h+bEUGmbzPq9cBH1WnIYTsRiB6F6AQ6qMTZTSJ2dNOGdaoVgydXKhwt1OUR4DTNd
        gt1RKs1kGPZ8MWRi7h9umKuZyDq+H4izm1iYw2vYF5F909KAGErHFr8ARgcHpYvS
        bxG2XJd1k7im0qhMRnKsU617M+7mPyiA76g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LepTz4BpBDdh for <linux-block@vger.kernel.org>;
        Sun, 12 Mar 2023 18:00:32 -0700 (PDT)
Received: from [10.225.163.79] (unknown [10.225.163.79])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PZdcb4gGzz1RvLy;
        Sun, 12 Mar 2023 18:00:31 -0700 (PDT)
Message-ID: <49cfce8b-042e-7248-928f-4a5c5f7d0e31@opensource.wdc.com>
Date:   Mon, 13 Mar 2023 10:00:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] null_blk: execute complete callback for fake timeout
 request
Content-Language: en-US
To:     Akinobu Mita <akinobu.mita@gmail.com>, linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
References: <20230312123556.12298-1-akinobu.mita@gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230312123556.12298-1-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/12/23 21:35, Akinobu Mita wrote:
> When injecting a fake timeout into the null_blk driver by fail_io_timeout,
> the request timeout handler doen't execute blk_mq_complete_request(), so
> the complete callback will never be executed for that timed out request.
> 
> The null_blk driver also has a driver-specific fake timeout mechanism and
> does not have the problem that occur when using the generic one.
> Fix the problem by doing similar to what the driver-specific one does.
> 
> Fixes: de3510e52b0a ("null_blk: fix command timeout completion handling")
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  drivers/block/null_blk/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 4c601ca9552a..69250b3cfecd 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1413,7 +1413,9 @@ static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
>  	case NULL_IRQ_SOFTIRQ:
>  		switch (cmd->nq->dev->queue_mode) {
>  		case NULL_Q_MQ:
> -			if (likely(!blk_should_fake_timeout(cmd->rq->q)))
> +			if (unlikely(blk_should_fake_timeout(cmd->rq->q)))
> +				cmd->fake_timeout = true;
> +			else
>  				blk_mq_complete_request(cmd->rq);
>  			break;
>  		case NULL_Q_BIO:

I have not checked, but does this work ?

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 4c601ca9552a..52d689aa3171 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1413,7 +1413,7 @@ static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
        case NULL_IRQ_SOFTIRQ:
                switch (cmd->nq->dev->queue_mode) {
                case NULL_Q_MQ:
-                       if (likely(!blk_should_fake_timeout(cmd->rq->q)))
+                       if (!cmd->fake_timeout)
                                blk_mq_complete_request(cmd->rq);
                        break;
                case NULL_Q_BIO:
@@ -1675,7 +1675,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
        cmd->rq = bd->rq;
        cmd->error = BLK_STS_OK;
        cmd->nq = nq;
-       cmd->fake_timeout = should_timeout_request(bd->rq);
+       cmd->fake_timeout = should_timeout_request(bd->rq) ||
+               blk_should_fake_timeout(bd->rq->q);

        blk_mq_start_request(bd->rq);


It is I think cleaner as it unifies the internal fake timeout and
blk_should_fake_timeout().

-- 
Damien Le Moal
Western Digital Research

