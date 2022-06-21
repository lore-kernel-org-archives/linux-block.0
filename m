Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1DE0C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 00:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245285AbiFUABd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 20:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244334AbiFUABb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 20:01:31 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290F613D4A
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 17:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655769691; x=1687305691;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UMggjTpH1UaTLJvBbpkClCEcWs6SJCkCwgw1sPh74PA=;
  b=HHnOVI1pB/OBO6/dFvkC7R7uU0+H4oh8HCiuSeRNG8N44bUzVtCAn7xE
   nQRYUuwfiMAnSjodFHOr02Z01e0UG7XE9oYF+ccb6aCNt/6Isn98evWHc
   BREYAfgD6QiByYU05mSB7YMJm4ckY4vRc2ZWey7K3gV2Ua/db5AlKr943
   IkKoLMVlIuy4QzjaQxnnSBeUNBoTZy4zZhj2c+b4dq1NkznTPPDWiUSKX
   PnFXfOmnuKOgPf/Kwi9Z/IXReMH5nQHK+DSSQ6NfPIJi3LncxCzgyhpHc
   8tlm1KjHGZ5ww0iCbep5Av2PkGsrFeTVtPZTnif/DabjkHxevYFqv2RIC
   A==;
X-IronPort-AV: E=Sophos;i="5.92,207,1650902400"; 
   d="scan'208";a="202364665"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2022 08:01:30 +0800
IronPort-SDR: uVBOlPG2C0QHoR0YMBQS4THInom1HQVssa7zbaFcSoQZBDK7g2SgCZoa1P47dnMHCZ0SvGlAwt
 u82gZrMpF8WLt3r/LSQaq71x8IlVl69VYy4iWXDaBKlpN5bCPkFKwlAfkZW/0YlQqt5gdF+AfX
 43Bj5eMN8qGNJVHTjVKxDdoJOPI63RNcgYxYKMhA04t1QYMXs11mMuw7xqdKwIQ9iVCE+lm7ZT
 LKxVRpd+nw+AuVpqIfuuWjPAY/uSRpaljBnDyj84QdYQ4Jhw+mXMJ4ww3mpDTpW0CVnAUPXr6z
 ZAuDyEDCaBrtwennxKiW7O2n
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 16:24:01 -0700
IronPort-SDR: LbwEG+7PMlx6FrzcSUuzBZ8rTui4AbrYJGW7CUwSC8vkFykdUku/xDIDND8IVMrU+gMGGvsB/v
 u35Sf1GE9dO/2+d0ld+ozFfTkHwsyRCVYyfw/FHYLl3EHDNbOWjQ7R2AGpXP1xS1qGVvSTjNuN
 GaFT6iYd7iC9kHgDMH0+VF0L8PNP/gW4DcZzvVf/vXD5lH/pTpczvEKTUimLypJdsrTSIJwIVu
 ZBjydlt3FfyjH/9bdYMzpGBKogpnpS/he69nPEHAcyaugv7PGvWyIHbn95hG1CPu6+4BAstpx2
 Q+k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2022 17:01:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LRmrp29j8z1SVny
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 17:01:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655769689; x=1658361690; bh=UMggjTpH1UaTLJvBbpkClCEcWs6SJCkCwgw
        1sPh74PA=; b=lkQ7Dy/k6vjUdZkT/Z3MnG/ZK2L9YzR7s+Fq5wszlJuVckxN4nm
        wFan6Tjh7zQM7tfufqKC4h6Hi7EeD5t0kmXVvd107scUy4TawVJtI7/P/OoszUiq
        IkvfPPy74IN3c2a6GTIzhSl9gcXa6/6CBwxW/hg9f4/d4jTNu8CA4DiJYQZOw9nv
        zoJupvJEt1cimqtyYmcNQguZWti0+iPe83n1bu0+wCeVqSfcs9+Uvrnwar8fcdVu
        M8LcU/IzVpTnBVWy5mqmOoNHnIphVvgZ4PnBR4R6QxjQ6JJ5ffF2ZSJpIraHsNy1
        rEpS2I8jkMebW38HgjTKM6AiEapm2AzZ96g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GVakqXuFZwMs for <linux-block@vger.kernel.org>;
        Mon, 20 Jun 2022 17:01:29 -0700 (PDT)
Received: from [10.225.163.87] (unknown [10.225.163.87])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LRmrn16t6z1Rvlc;
        Mon, 20 Jun 2022 17:01:28 -0700 (PDT)
Message-ID: <028ad811-1727-fba2-f1d8-ebe18eabe63a@opensource.wdc.com>
Date:   Tue, 21 Jun 2022 09:01:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 7/8] block: Initialize bio priority earlier
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
References: <20220620160726.19798-1-jack@suse.cz>
 <20220620161153.11741-7-jack@suse.cz>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220620161153.11741-7-jack@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/22 01:11, Jan Kara wrote:
> Bio's IO priority needs to be initialized before we try to merge the bio
> with other bios. Otherwise we could merge bios which would otherwise
> receive different IO priorities leading to possible QoS issues.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  block/blk-mq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 67a7bfa58b7c..e17d822e6051 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2825,6 +2825,8 @@ void blk_mq_submit_bio(struct bio *bio)
>  	if (!bio_integrity_prep(bio))
>  		return;
>  
> +	bio_set_ioprio(bio);
> +
>  	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
>  	if (!rq) {
>  		if (!bio)
> @@ -2836,8 +2838,6 @@ void blk_mq_submit_bio(struct bio *bio)
>  
>  	trace_block_getrq(bio);
>  
> -	bio_set_ioprio(bio);
> -
>  	rq_qos_track(q, rq, bio);
>  
>  	blk_mq_bio_to_request(rq, bio, nr_segs);

Looks good to me.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research
