Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC40C04A95
	for <linux-block@archiver.kernel.org>; Sun, 25 Sep 2022 22:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiIYW4M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Sep 2022 18:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIYW4L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Sep 2022 18:56:11 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F46522504
        for <linux-block@vger.kernel.org>; Sun, 25 Sep 2022 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664146570; x=1695682570;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UgHJh+ok8CCh9xusULGjiP1dQTG7T5R5Ci742jjScI4=;
  b=SN3DULGrQkuGVr23QIIhwZw7eXS+pHyPbSDwn2pxtZtmt2MLl0xVgvuM
   MIrLJwNcdUhsk34MqAFQ3U4Y/nSo6IcWq7sEDvfQzBd1P62gA0LgmlFXq
   7QJ/4rZTTAiLmgxp9Tl/PYS+u4XAbM16sJIHQfBDsk+CkIfynzteYMzLa
   fXW37azhEqdsb+ghaQE5jIirF1BbR7Llu8t5G2yem4j3+pGSnPuqyWiP7
   drVs0Gz83xOPLl6wch+S78SQTkTuXRPlUpJt6X372XGq95cjBWHs1Aayj
   ybZZCcWhbHuufTTiyro7YV9Ot/QHrAJqgDRdWEas4P2yTLUuPCK0Q6h4R
   g==;
X-IronPort-AV: E=Sophos;i="5.93,345,1654531200"; 
   d="scan'208";a="210603276"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Sep 2022 06:56:09 +0800
IronPort-SDR: oxdBZOK4SmXbG5awMCR7GzkZSjca50qqlsJ1Ev6vb7ZGktvTcOJQI3eUBg6hbInhzAuPLnm0Ry
 BD/+bZW8V22QnwWL3cnO6Cj9byNWMG+kLQEVdeJ7t3pzly7cBe5M/p5uQ70TpXTUSUAd25bLj3
 N/sluoCzEaSzWdgflXs7wwEsGgep6Y1pyL6nI2nyl6rjDeoO/Tw+lOLTAU/KtlzDE2RBDQraZF
 oJeA0IG7eYcucwB91uCFS9Rze0h8bGLadtAjmTiVmQEW2upgmg2J0iOhR0PNnA+DWIG4P7kmDV
 6FxgJQg15gpRIbwVcAxZDA6i
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2022 15:10:37 -0700
IronPort-SDR: rNacWbMl5UCJs61ebYKQyLcCbdZUvc/OsDsmNYWh1wCnUZfxaU59CAWd6r+R7uRHCEH877WK5x
 m8RI9FU0iyH1FPMAawuHYDukhj+qA/a9PBEt8elk8h190l8ISpsu2co3mUg3eisFJYw3jfq/wl
 deJIRE8zOdCUgBhBBrthp5PS2SHUGZzMRrqqjlcSucb7OfDPNQmAfXtORo5Jyox7lFRPx/ePPL
 jym1jR2DlBlffjzvpftw3Z6/hZZiHHlpcnpBCZQmk7mI0NZ6otjo5CdL7XxCCVfADS9CiyTknJ
 EqI=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Sep 2022 15:56:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MbLpd1llxz1RvTr
        for <linux-block@vger.kernel.org>; Sun, 25 Sep 2022 15:56:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664146568; x=1666738569; bh=UgHJh+ok8CCh9xusULGjiP1dQTG7T5R5Ci7
        42jjScI4=; b=fCqHgf5UA8mpBq3FxwB4/0YdNbYiUWbq1ClQGM7uOcFEldFhO3K
        VvrztxuWNdLSuJj56rHHgTn5JaPxJe+ZjS3R5D840JVKhVviQ4dAhmQmm9kvEXSd
        SS28CZdls8mW6TTv4ni/hCexYSDMIXPDtOGLgXvXI/9rn4zwoEL1Nktk2FSdcAQ/
        lkyVUfhnxo87GTGZeebb9uS7+1lsq/3FZJdUNKymFYBJ0h1Vm9cWGpceb1+7QMdI
        DEirJ+S8jQ9xqg2fowNcfORl7thTHoae4hg72sJh25kWPgNbLAsJkyG78WC2Gden
        CC6OLHp7M1+IlA9TKSnR3S6XurIFhND4mQw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Z5bgtAfOA18E for <linux-block@vger.kernel.org>;
        Sun, 25 Sep 2022 15:56:08 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MbLpb6WTWz1RvLy;
        Sun, 25 Sep 2022 15:56:07 -0700 (PDT)
Message-ID: <03da4b87-4c58-322b-0939-976ebec79b64@opensource.wdc.com>
Date:   Mon, 26 Sep 2022 07:56:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] block: use blk_mq_plug() in blk_execute_rq_nowait()
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     gost.dev@samsung.com
References: <20220925185348.120964-1-p.raghav@samsung.com>
 <CGME20220925185351eucas1p1e0c37396c09611509c0b18bdcdeddfe1@eucas1p1.samsung.com>
 <20220925185348.120964-3-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220925185348.120964-3-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/26/22 03:53, Pankaj Raghav wrote:
> blk_execute_rq_nowait() function mainly was used by low-level drivers
> such as NVMe to submit one-off passthrough requests. However, recently
> introduced uring-cmd based io-passthrough also uses the same function to
> submit io requests.
> 
> As the plugging support is coming to io-passthrough[1], use the
> blk_mq_plug() helper to ensure plugging is not used in all scenarios.
> 
> [1]
> https://lore.kernel.org/linux-block/20220922182805.96173-1-axboe@kernel.dk/
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>   block/blk-mq.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index c11949d66163..840541c1ab40 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1213,7 +1213,7 @@ void blk_execute_rq_nowait(struct request *rq, bool at_head)
>   	WARN_ON(!blk_rq_is_passthrough(rq));
>   
>   	blk_account_io_start(rq);
> -	if (current->plug)
> +	if (blk_mq_plug(rq->bio))
>   		blk_add_rq_to_plug(current->plug, rq);
>   	else
>   		blk_mq_sched_insert_request(rq, at_head, true, false);

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

