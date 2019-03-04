Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29026C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34252075B
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 13:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="UACaay7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfCDNL4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 08:11:56 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38140 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfCDNLz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 08:11:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id h58so4199982edb.5
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 05:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=anJnSDIbDzEJ5YFL0PLzYZAcLfDhj3dd52haiFIHKXE=;
        b=UACaay7HP9T5Fh/GYgfOlHG+Frb0eeIpCrdangDBRCjJabEKHv0jkQtzfJrrsG2kHJ
         iR1NKzOqs7mnFjyvJOHpt84GnzVoTcG21+9d9a17a7hbKaMFBlOadhSyh29yJUti+DpY
         aNCmotmVSFbGRyqiWODQAfxnannTp8JhbjFIMls6Y60J8iaZ1U1NFRhwarE94VWHkTVn
         mvC7Dkt3Ct922UnD15uUQpY33zmEI/nxlG/gfrzcXOGUTPWSXBuBLXbVsAAz3BWKX/Ul
         g+rbn5YlEjqSJ82Rx6GlnKrL5STmDPXlqP6W648XIHATsMN8qwlYkDs1zgYGWri0Vkp+
         zIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=anJnSDIbDzEJ5YFL0PLzYZAcLfDhj3dd52haiFIHKXE=;
        b=KXPSLjFlBkHAkqVV2qhxNDT8mLDuH4W9eTdx3LwhkCMwHRp0KpB4jmqROA0OioT3Iu
         5uN5fqE904Cqy8d68FBdAhOivtmrpdqyZJIwNDLviMiNY7nAx+MNthpb/YtCxKt1L/3a
         3qHWXR+nH/aG2HsopBvTSKJlrhSg7Q1q4kTtoriZG9tWeS6ui7tDeMFiKaN7ke7RsiKE
         Wnk6UFSxvPZTyVnhf/mAbxO3aj+ICa7l9Ht21s+xD7x4+iAk75sXy1qnpCpVMeFTDdIo
         /sV0PnIIz0bRrqX6XE+4K8cTh2imabYnDyprW68zCGwkhwi2aHJqUWzlxgw05mjdxP1C
         M0dQ==
X-Gm-Message-State: APjAAAUeoo4wXrUz5JWoct1ZDKG0l3jBpxmTZceQTxOHHzyQXlRgRCm9
        Y3U8B9S3kdRRO/MO5u21gNEjwkqbRhI=
X-Google-Smtp-Source: APXvYqxEEDK6WkTQXBco9E/+tMxZaMjDFQjriQ/Zt+dR0Fa6ik4tP+bz9CGIPrIQS+++JLgZ0hLg8Q==
X-Received: by 2002:a17:906:4ec6:: with SMTP id i6mr12942894ejv.56.1551705113404;
        Mon, 04 Mar 2019 05:11:53 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id 41sm2093752edu.85.2019.03.04.05.11.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 05:11:52 -0800 (PST)
Subject: Re: [PATCH 10/13] lightnvm: pblk: Reduce L2P DRAM footprint
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190227171442.11853-1-igor.j.konopko@intel.com>
 <20190227171442.11853-11-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5cd7f073-fab0-e682-1e65-a5d2966b7c56@lightnvm.io>
Date:   Mon, 4 Mar 2019 14:11:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190227171442.11853-11-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/27/19 6:14 PM, Igor Konopko wrote:
> Currently L2P map size is calculated based on
> the total number of available sectors, which is
> redundant, since it contains some number of
> over provisioning (11% by default).
> 
> The goal of this patch is to change this size
> to the real capacity and thus reduce the DRAM
> footprint significantly - with default op value
> it is approx. 110MB of DRAM less for every 1TB
> of pblk drive.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/pblk-core.c     | 8 ++++----
>   drivers/lightnvm/pblk-init.c     | 7 +++----
>   drivers/lightnvm/pblk-read.c     | 2 +-
>   drivers/lightnvm/pblk-recovery.c | 2 +-
>   drivers/lightnvm/pblk.h          | 1 -
>   5 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index f48f2e77f770..2e424c0275c1 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -2024,7 +2024,7 @@ void pblk_update_map(struct pblk *pblk, sector_t lba, struct ppa_addr ppa)
>   	struct ppa_addr ppa_l2p;
>   
>   	/* logic error: lba out-of-bounds. Ignore update */
> -	if (!(lba < pblk->rl.nr_secs)) {
> +	if (!(lba < pblk->capacity)) {
>   		WARN(1, "pblk: corrupted L2P map request\n");
>   		return;
>   	}
> @@ -2064,7 +2064,7 @@ int pblk_update_map_gc(struct pblk *pblk, sector_t lba, struct ppa_addr ppa_new,
>   #endif
>   
>   	/* logic error: lba out-of-bounds. Ignore update */
> -	if (!(lba < pblk->rl.nr_secs)) {
> +	if (!(lba < pblk->capacity)) {
>   		WARN(1, "pblk: corrupted L2P map request\n");
>   		return 0;
>   	}
> @@ -2110,7 +2110,7 @@ void pblk_update_map_dev(struct pblk *pblk, sector_t lba,
>   	}
>   
>   	/* logic error: lba out-of-bounds. Ignore update */
> -	if (!(lba < pblk->rl.nr_secs)) {
> +	if (!(lba < pblk->capacity)) {
>   		WARN(1, "pblk: corrupted L2P map request\n");
>   		return;
>   	}
> @@ -2168,7 +2168,7 @@ void pblk_lookup_l2p_rand(struct pblk *pblk, struct ppa_addr *ppas,
>   		lba = lba_list[i];
>   		if (lba != ADDR_EMPTY) {
>   			/* logic error: lba out-of-bounds. Ignore update */
> -			if (!(lba < pblk->rl.nr_secs)) {
> +			if (!(lba < pblk->capacity)) {
>   				WARN(1, "pblk: corrupted L2P map request\n");
>   				continue;
>   			}
> diff --git a/drivers/lightnvm/pblk-init.c b/drivers/lightnvm/pblk-init.c
> index e553105b7ba1..9913a4514eb6 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -105,7 +105,7 @@ static size_t pblk_trans_map_size(struct pblk *pblk)
>   	if (pblk->addrf_len < 32)
>   		entry_size = 4;
>   
> -	return entry_size * pblk->rl.nr_secs;
> +	return entry_size * pblk->capacity;
>   }
>   
>   #ifdef CONFIG_NVM_PBLK_DEBUG
> @@ -175,7 +175,7 @@ static int pblk_l2p_init(struct pblk *pblk, bool factory_init)
>   
>   	pblk_ppa_set_empty(&ppa);
>   
> -	for (i = 0; i < pblk->rl.nr_secs; i++)
> +	for (i = 0; i < pblk->capacity; i++)
>   		pblk_trans_map_set(pblk, i, ppa);
>   
>   	ret = pblk_l2p_recover(pblk, factory_init);
> @@ -706,7 +706,6 @@ static int pblk_set_provision(struct pblk *pblk, int nr_free_chks)
>   	 * on user capacity consider only provisioned blocks
>   	 */
>   	pblk->rl.total_blocks = nr_free_chks;
> -	pblk->rl.nr_secs = nr_free_chks * geo->clba;
>   
>   	/* Consider sectors used for metadata */
>   	sec_meta = (lm->smeta_sec + lm->emeta_sec[0]) * l_mg->nr_free_lines;
> @@ -1289,7 +1288,7 @@ static void *pblk_init(struct nvm_tgt_dev *dev, struct gendisk *tdisk,
>   
>   	pblk_info(pblk, "luns:%u, lines:%d, secs:%llu, buf entries:%u\n",
>   			geo->all_luns, pblk->l_mg.nr_lines,
> -			(unsigned long long)pblk->rl.nr_secs,
> +			(unsigned long long)pblk->capacity,
>   			pblk->rwb.nr_entries);
>   
>   	wake_up_process(pblk->writer_ts);
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 39c1d6ccaedb..65697463def8 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -561,7 +561,7 @@ static int read_rq_gc(struct pblk *pblk, struct nvm_rq *rqd,
>   		goto out;
>   
>   	/* logic error: lba out-of-bounds */
> -	if (lba >= pblk->rl.nr_secs) {
> +	if (lba >= pblk->capacity) {
>   		WARN(1, "pblk: read lba out of bounds\n");
>   		goto out;
>   	}
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index d86f580036d3..83b467b5edc7 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -474,7 +474,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   
>   		lba_list[paddr++] = cpu_to_le64(lba);
>   
> -		if (lba == ADDR_EMPTY || lba > pblk->rl.nr_secs)
> +		if (lba == ADDR_EMPTY || lba >= pblk->capacity)
>   			continue;
>   
>   		line->nr_valid_lbas++;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index a6386d5acd73..a92377530930 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -305,7 +305,6 @@ struct pblk_rl {
>   
>   	struct timer_list u_timer;
>   
> -	unsigned long long nr_secs;
>   	unsigned long total_blocks;
>   
>   	atomic_t free_blocks;		/* Total number of free blocks (+ OP) */
> 

Thanks Igor. Applied for 5.2. I've also updated the text a bit.
