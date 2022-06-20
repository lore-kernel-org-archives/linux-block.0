Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F43C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 23:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244383AbiFTX6j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 19:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244334AbiFTX6i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 19:58:38 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6BD13D4A
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 16:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655769517; x=1687305517;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Wxn/306f8w62XNPHjrhNE8rtsMgFf0NOv5AIUrAcYhs=;
  b=Rutm6D7bWQNdN9XXtgk7C6EHkRJDg0q3iSkWNE/yz44jY0+sp+QTNMuq
   3tFi8lhpV3pdF84J5IgKPC3jH797uab3unGkM0phUbb45TEhZrtI+BUMg
   AvcN1LwVHWqN3jSW6K7aiDgvpW7dMz6s8GWEVytvL0iqyBzONsyyKmgjs
   g8JrF0xTkfAeNhOQP+Ai2lDJIje+eTALRHbWzD7kja7YFjiyT4tA4erIn
   AMRHA/7qa5wRXS6WNdajCtZaYKhmXPd8Q7N4CoTZojU6HZ4v9/72iiBwV
   PS/tV0WeFloK4gbH1O+tNmpmReNaYBnNLckJA6BaQlD6coyn2fKUJJ2vh
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650902400"; 
   d="scan'208";a="307983996"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 07:58:36 +0800
IronPort-SDR: QtpYR752+iU+pMzU0XlqOzEkJ7b64ccOOiH8Ri7umhl6SyI2UBgVCunxDjvi0FbqWq/JtuidU7
 SokYJm+oCJMon86UnFH68625cSdv+uZozTQDq5SW41iabyZr5TvfK56ZT10/jbg4PM9WSyHCRY
 bd8iC+TVOYenBDfLXOzazgpkpmWE14T/v9nJpiZ+PYppH9yZCRV1Krhbm+ie2297AhIz/WiEiq
 B/XUMwwbGxF1Ezk/nXQffTPiVHfLWMkoklxMOJyqbe+tRW2Hve+U3nKswEmgo1Unr3zmR45HEm
 4tmdQEe6cP6K978ugI3+ru/I
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:16:44 -0700
IronPort-SDR: tEc85ILvE0AG+YN1Dzerr11P842d0eEUX74lx2IcFiOpApsWocB11cIH7Y/GARsIXe5TmBnkZK
 iGtDgShihC/4u6y4vtEjH0r9oJeB1x6f+ODCwKd2FKzaU7hIKE6p+gn6GSj0bjUPtJ0Go7io+y
 n9JrmGZQdytGbzXGgieB3KwgdjTazQ1ZGyuqdCzKFJJchz1cjc5Vh7z16d0AhaFk1ICz+I8Y5K
 GydvjPfvsjhkP1UgISvOszBfgq11R34dccGYQ5UBgwKCsdqxzwOY/xWYTME9r9G/wO0tamOKjg
 4bU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:58:37 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRmnS2SNyz1Rwrw
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 16:58:36 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655769515; x=1658361516; bh=Wxn/306f8w62XNPHjrhNE8rtsMgFf0NOv5A
        IUrAcYhs=; b=BXevdqWTWlkHTscEvEGfj5iCG2wS1e5MQcq0LqIgexpHr+vvdk9
        uCVXpC523oav4iAVmhda+MGvgH+8Qp6vdE5gRCClw2BPdj5LSS7gzWYEd5b1war5
        3MxPF6nzNh5/5dN11MJu/Ow8Qz3O7upJhz90+Kb0iTF9ENA6/mhMTWd0en2qRQn3
        4zD1ZhvBNkzcdBFcI1JCGJCeXrGtyM/kjd6n5J09Gl8IaDvnv5pkiTyrtizQePho
        H0rQiAchO/G2XLTzewhZONgDWwz8QjHRWGljHXPzInyJZBh9KriTn405q4ZRXVX4
        gnPkLzEh8+4hC5PIfhdEcAjiLeMDnf8YO4Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2sNJJI0A0H5A for <linux-block@vger.kernel.org>;
        Mon, 20 Jun 2022 16:58:35 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRmnR16tHz1Rvlc;
        Mon, 20 Jun 2022 16:58:34 -0700 (PDT)
Message-ID: <a444e578-4712-77bf-6462-7779ee146501@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 08:58:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/8] blk-ioprio: Remove unneeded field
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220620160726.19798-1-jack@suse.cz>
 <20220620161153.11741-5-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220620161153.11741-5-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/22 01:11, Jan Kara wrote:
> blkcg->ioprio_set field is not really useful except for avoiding
> possibly more expensive checks inside blkcg_ioprio_track(). The check
> for blkcg->prio_policy being equal to POLICY_NO_CHANGE does the same
> service so just remove the ioprio_set field and replace the check.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-ioprio.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-ioprio.c b/block/blk-ioprio.c
> index 79e797f5d194..3f605583598b 100644
> --- a/block/blk-ioprio.c
> +++ b/block/blk-ioprio.c
> @@ -62,7 +62,6 @@ struct ioprio_blkg {
>  struct ioprio_blkcg {
>  	struct blkcg_policy_data cpd;
>  	enum prio_policy	 prio_policy;
> -	bool			 prio_set;
>  };
>  
>  static inline struct ioprio_blkg *pd_to_ioprio(struct blkg_policy_data *pd)
> @@ -113,7 +112,6 @@ static ssize_t ioprio_set_prio_policy(struct kernfs_open_file *of, char *buf,
>  	if (ret < 0)
>  		return ret;
>  	blkcg->prio_policy = ret;
> -	blkcg->prio_set = true;
>  	return nbytes;
>  }
>  
> @@ -193,16 +191,15 @@ static void blkcg_ioprio_track(struct rq_qos *rqos, struct request *rq,
>  	struct ioprio_blkcg *blkcg = ioprio_blkcg_from_bio(bio);
>  	u16 prio;
>  
> -	if (!blkcg->prio_set)
> +	if (blkcg->prio_policy == POLICY_NO_CHANGE)
>  		return;
>  
>  	/*
>  	 * Except for IOPRIO_CLASS_NONE, higher I/O priority numbers
>  	 * correspond to a lower priority. Hence, the max_t() below selects
>  	 * the lower priority of bi_ioprio and the cgroup I/O priority class.
> -	 * If the cgroup policy has been set to POLICY_NO_CHANGE == 0, the
> -	 * bio I/O priority is not modified. If the bio I/O priority equals
> -	 * IOPRIO_CLASS_NONE, the cgroup I/O priority is assigned to the bio.
> +	 * If the bio I/O priority equals IOPRIO_CLASS_NONE, the cgroup I/O
> +	 * priority is assigned to the bio.
>  	 */
>  	prio = max_t(u16, bio->bi_ioprio,
>  			IOPRIO_PRIO_VALUE(blkcg->prio_policy, 0));


-- 
Damien Le Moal
Western Digital Research
