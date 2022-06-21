Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAADC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 00:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245355AbiFUACM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 20:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244334AbiFUACL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 20:02:11 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C17713D4A
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 17:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655769729; x=1687305729;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ya/zJpT+VwFOZHDGwNPdMzoHveI6VOJnzkUngy3az/Q=;
  b=CFjKta8QvUoTxcCcJwZltsZCuOlgwbl1RkT/lzqJREdHIBEcBrNmNx4W
   iRGjoGbVI0J5fUu3JwBvij2bAXJ2OlBQ9GNt9zStZQ8QUap/6y+ZTD8I5
   Yc1AnLRXHqFDOiEs105YIJ0S60nEvIykhalj7cRh9CGSYVqH1V5xuUaQM
   fEU6P7olO61dtPGo6TThBovnajVoJdcr4z9YxQNCetKJUMyo8wD+A04SU
   iXOdNYrpG+hhR8L5Wss0INTkrloBDx/oJ9ZmBh9Ja+H9fj4IOBmP8nylD
   cYz2Doqf5zVwPchG6EO4gF5FdlCaYSg1saUHYuWUQdZ8hlBKfs/c6Tmic
   A==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650902400"; 
   d="scan'208";a="208524487"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 08:02:09 +0800
IronPort-SDR: fsUIXDijuyAkIS+i4NjyECu1mxVXUyX04J9aoRQJdr+TnZ0kFAtOrpJSEnitSNuJtFov05FFem
 6B/J445lGe/8IOp1WGAj37GEoB4Q3A5uci0fCjlMAyWikvDlbBea0KIIYNJAZhQ1mF5eBA369K
 z1DnuGdpjeRR/TjydEXGQgRpxFmSC/UWv4VIyxg90MM+tv4d4q0QBGrqddjVvX+2tVeqwLrTqM
 nKAfAgUfvoEb/MLWekm7SQDEGC808Uc1BBre8sy+EHJy0XMTl0Ho6grOfP44ELLIWFIljOmtM5
 RTyU3QyqbilTXHPYTEXJCf3Y
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:20:17 -0700
IronPort-SDR: aDZtfChpJAkvGeqja91h8wl9Dyq8SN39QcoPjZF9MR35qR0VkzAVkIBo7ZEGjvyCzZKADPS3Pt
 4b9IkRHDzBhi9642JK8UtNLE36pBK8+gh+tGVBpGl1CBHr1FVtAaM0lOZKISbGzRx1JeWSQD0h
 eDSVJhpNs3iH0eiiARS4uRHWpHFJCQEpBVQWJObhNRXxNi6I68UOsMvy6eiPSiJ7LhO0DJVa71
 bek1apoGWB4Ntixm8BnhSZ3MjUziCEC8nnKoQexvGHDk2UvaRAkrpxtEkTBTvNpt1RuNetCEtx
 THY=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 17:02:09 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRmsY2FJTz1SVnx
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 17:02:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655769728; x=1658361729; bh=ya/zJpT+VwFOZHDGwNPdMzoHveI6VOJnzkU
        ngy3az/Q=; b=YpYZif8F+b/bEQvKDxu+8i/ail/ehri7aBQeT1KeH459+4Rrdec
        gw0R1ml9p3tuzAc/5CA1sKyiHyFxxL/YhSGkFbOJrz600YqpADMR8y2ShPFKOsfC
        Mm52MabuWt/JQ8Jr5faDQ46bbxxAwxrTk2rx06+9GAXxgZxPeR4RKKnbbfHO6J3z
        jt9rMIQokwy+Iv/SNNgD7qKS2kvUwIjCuSSMI9+SBNF3S9x7/Eb8wcTPXAYyoO8J
        5y7/CDP/JQgdS1nYKKKNfJkYqOHyQrUhbJMrZDDUf8Iv/il3KSdHMojKL1syxuzx
        g71T/sZ02Bo6Ui1d1MUG9tZrqXo4/XpF/Yw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sH_srHItrU2Z for <linux-block@vger.kernel.org>;
        Mon, 20 Jun 2022 17:02:08 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRmsX1D34z1Rvlc;
        Mon, 20 Jun 2022 17:02:08 -0700 (PDT)
Message-ID: <bffcca6d-eeb6-1fbd-9585-22d20b8a36df@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 09:02:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 8/8] block: Always initialize bio IO priority on submit
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220620160726.19798-1-jack@suse.cz>
 <20220620161153.11741-8-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220620161153.11741-8-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/22 01:11, Jan Kara wrote:
> Currently, IO priority set in task's IO context is not reflected in the
> bio->bi_ioprio for most IO (only io_uring and direct IO set it). This
> results in odd results where process is submitting some bios with one
> priority and other bios with a different (unset) priority and due to
> differing priorities bios cannot be merged. Make sure bio->bi_ioprio is
> always set on bio submission.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/blk-mq.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index e17d822e6051..7548f8aebea8 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2793,6 +2793,9 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
>  
>  static void bio_set_ioprio(struct bio *bio)
>  {
> +	/* Nobody set ioprio so far? Initialize it based on task's nice value */
> +	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
> +		bio->bi_ioprio = get_current_ioprio();
>  	blkcg_set_ioprio(bio);
>  }
>  

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
