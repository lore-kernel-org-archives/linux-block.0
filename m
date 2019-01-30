Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E003C282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 13:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAF01218A3
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 13:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="IvQ/madw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfA3NdY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:33:24 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42814 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3NdY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 08:33:24 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so11061364plp.9
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 05:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MWOHj8i9VGFnozURvSgdoAGxbNrdHu0U7DXiOt979AI=;
        b=IvQ/madwRTrRb9HueMOLTd4fGcNH1NgZWXvdQVVrunQcOlMR2Tb/mEXxcPJcGW+CzJ
         RlGuBO+kmjexKCWipsEFo6iDtxDGdzJ/JaPrMq0W2hDG6cDrSBiFMyLCPTSzcQyfOmv/
         HMO36GdEYVcy5bh3XAS2DTT4UktmR1hLLzXmxT4nUQk70kFozYVf+uTMp4u610jBectL
         rN3K/IE76sYq+ySLhfBPjfA5E/Ez1X1Fw2kOqhj9plJUj3Vc865x4b+PdkrZKfaIjo5J
         FkDRlmMNXySbV7h1FSnw3xHI92RKzV6lDCi2Tn5NTREtkLVV+uScAVgNmXLG7zdzMDVC
         UOeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MWOHj8i9VGFnozURvSgdoAGxbNrdHu0U7DXiOt979AI=;
        b=LqHHaqXmMyH2sjJdfOxnUzihrSieqpeHA2NlFZl8JYOYSKC1bvnlaYm+CZzUzrl6sc
         654Y0pTFH2FlqOLOI906ZIw2+JD4aQ5YYLjxtIpaSZ5YI9QE7YkXMP8XAUbtMq8lj6Ev
         cXErmwi0DsAXOluCEaiwHG/RCKkD8D/Pl2L0indcnoYS8MlpMiNOIJC8V79SoNgYSVUe
         YFGcBYmR6KswWiyH8EgqAw3X+tp1WPwlwNJQhHl/pUeGxNEi/Mz7V2jYnm6wX4evQcO/
         4FLFlKKK9ic4a/BhGZ4UWPZari7zDVuUvUElaCrmOpv4srX9dJZsRp7LPC1I9Iw9GTXA
         DDQQ==
X-Gm-Message-State: AJcUukdMHiEWK9xlVrod8qb5J73cDiw/3pm9KuzcjI4uIrL1gwCx7uAL
        AIPuX50MwKdQBVUz8nmaJv4lIA==
X-Google-Smtp-Source: ALg8bN5qVeRnN/CoDiqVnICpTq/rt4L+i4kdHmAoYoaHimEVtF1+f6CyXJaGcgPOmsH+f3lt1P+Eqg==
X-Received: by 2002:a17:902:780a:: with SMTP id p10mr31103181pll.54.1548855203207;
        Wed, 30 Jan 2019 05:33:23 -0800 (PST)
Received: from [192.168.15.224] (71-6-111-190.static-ip.telepacific.net. [71.6.111.190])
        by smtp.gmail.com with ESMTPSA id y89sm3331224pfa.136.2019.01.30.05.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 05:33:22 -0800 (PST)
Subject: Re: [PATCH V2] lightnvm: pblk: extend line wp balance check
To:     hans@owltronix.com
Cc:     javier@javigon.com, Zhoujie Wu <zjwu@marvell.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
References: <20190130081857.6779-1-hans@owltronix.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <b653e741-27ec-1a79-0375-3d5f375cbbe4@lightnvm.io>
Date:   Wed, 30 Jan 2019 14:33:19 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130081857.6779-1-hans@owltronix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/19 9:18 AM, hans@owltronix.com wrote:
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
> 
> pblk stripes writes of minimal write size across all non-offline chunks
> in a line, which means that the maximum write pointer delta should not
> exceed the minimal write size.
> 
> Extend the line write pointer balance check to cover this case, and
> ignore the offline chunk wps.
> 
> This will render us a warning during recovery if something unexpected
> has happened to the chunk write pointers (i.e. powerloss,  a spurious
> chunk reset, ..).
> 
> Reported-by: Zhoujie Wu <zjwu@marvell.com>
> Tested-by: Zhoujie Wu <zjwu@marvell.com>
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> 
> Changes since V1:
> 
> 	* Squashed with Zhoujie's:
> 	 "lightnvm: pblk: ignore bad block wp for pblk_line_wp_is_unbalanced"
> 	* Clarified commit message based on Javier's comments.
> 		
> 
>   drivers/lightnvm/pblk-recovery.c | 56 ++++++++++++++++++++++----------
>   1 file changed, 38 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 6761d2afa4d0..d86f580036d3 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -302,35 +302,55 @@ static int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
>   	return (distance > line->left_msecs) ? line->left_msecs : distance;
>   }
>   
> -static int pblk_line_wp_is_unbalanced(struct pblk *pblk,
> -				      struct pblk_line *line)
> +/* Return a chunk belonging to a line by stripe(write order) index */
> +static struct nvm_chk_meta *pblk_get_stripe_chunk(struct pblk *pblk,
> +						  struct pblk_line *line,
> +						  int index)
>   {
>   	struct nvm_tgt_dev *dev = pblk->dev;
>   	struct nvm_geo *geo = &dev->geo;
> -	struct pblk_line_meta *lm = &pblk->lm;
>   	struct pblk_lun *rlun;
> -	struct nvm_chk_meta *chunk;
>   	struct ppa_addr ppa;
> -	u64 line_wp;
> -	int pos, i;
> +	int pos;
>   
> -	rlun = &pblk->luns[0];
> +	rlun = &pblk->luns[index];
>   	ppa = rlun->bppa;
>   	pos = pblk_ppa_to_pos(geo, ppa);
> -	chunk = &line->chks[pos];
>   
> -	line_wp = chunk->wp;
> +	return &line->chks[pos];
> +}
>   
> -	for (i = 1; i < lm->blk_per_line; i++) {
> -		rlun = &pblk->luns[i];
> -		ppa = rlun->bppa;
> -		pos = pblk_ppa_to_pos(geo, ppa);
> -		chunk = &line->chks[pos];
> +static int pblk_line_wps_are_unbalanced(struct pblk *pblk,
> +				      struct pblk_line *line)
> +{
> +	struct pblk_line_meta *lm = &pblk->lm;
> +	int blk_in_line = lm->blk_per_line;
> +	struct nvm_chk_meta *chunk;
> +	u64 max_wp, min_wp;
> +	int i;
> +
> +	i = find_first_zero_bit(line->blk_bitmap, blk_in_line);
>   
> -		if (chunk->wp > line_wp)
> +	/* If there is one or zero good chunks in the line,
> +	 * the write pointers can't be unbalanced.
> +	 */
> +	if (i >= (blk_in_line - 1))
> +		return 0;
> +
> +	chunk = pblk_get_stripe_chunk(pblk, line, i);
> +	max_wp = chunk->wp;
> +	if (max_wp > pblk->max_write_pgs)
> +		min_wp = max_wp - pblk->max_write_pgs;
> +	else
> +		min_wp = 0;
> +
> +	i = find_next_zero_bit(line->blk_bitmap, blk_in_line, i + 1);
> +	while (i < blk_in_line) {
> +		chunk = pblk_get_stripe_chunk(pblk, line, i);
> +		if (chunk->wp > max_wp || chunk->wp < min_wp)
>   			return 1;
> -		else if (chunk->wp < line_wp)
> -			line_wp = chunk->wp;
> +
> +		i = find_next_zero_bit(line->blk_bitmap, blk_in_line, i + 1);
>   	}
>   
>   	return 0;
> @@ -356,7 +376,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   	int ret;
>   	u64 left_ppas = pblk_sec_in_open_line(pblk, line) - lm->smeta_sec;
>   
> -	if (pblk_line_wp_is_unbalanced(pblk, line))
> +	if (pblk_line_wps_are_unbalanced(pblk, line))
>   		pblk_warn(pblk, "recovering unbalanced line (%d)\n", line->id);
>   
>   	ppa_list = p.ppa_list;
> 

Thanks Hans and Zhoujie. I've applied it for 5.1.
