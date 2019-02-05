Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DA6C282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 09:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1266320821
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 09:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="utxcVN2y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfBEJPE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:15:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42502 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfBEJPE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Feb 2019 04:15:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so2218527lja.9
        for <linux-block@vger.kernel.org>; Tue, 05 Feb 2019 01:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wBjAkXS6AG0JXtwIUFRzSGrkzWivWXXHkmBnWk14Yzk=;
        b=utxcVN2ydwFpn9DQ5K92r7Yps74JUdoEMBxNYBJhud4rp7Cmg1zNRCs9E4KNo1xKBS
         eg83IBohNdaFp5bSGz55xLmQBUCnlQUZxhJOW9SmXK4+PudbIuoo13oDadYtT39yNo8p
         PIld7stTfMlO8Eqf4f5vytSmptjn49hn0diHkqW0iHjfbwGcGcZFFpLoviU6cMMaWZ3g
         devUN1xPRoBl/pXNiXbEJVKyWE0uFeDPbQ2fj0Lx32NusZNL/aU6pTA03XR/WgeNAqNU
         0yQQC0D8lCUMHztU5YTamhmNjHQhacaOqWtoU69At08quSbCXOerXr04g6LtXmCGF3Yz
         MmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wBjAkXS6AG0JXtwIUFRzSGrkzWivWXXHkmBnWk14Yzk=;
        b=jVP5AqjQ20APp/HNoyuyzti8larBrb1eS/xaoHqjf6+yUp4pnn+Op/6y3yzwQEGznF
         3EIrI0582d2L2JwURikNqjq2D+pXrsBZVnj+UDDdWvgVMbeSqhDgRGYAfRkT3DBD7xlq
         jA8VJMhwLQAEuRwyM/0NtNtTmvbbThwutFjv9tDepqKCvqPoykf/h1g/wyyolb0bkEo5
         SpWYIrpgEJQftKP/s7VC150MPGO6APkWzr9KL7aoPAU8Vq5JxVVPIfSfnJ0GtrbxiJPh
         Lc2TCiwyvJCbYk4y8yWXy6YM99jBr7btEYIv7kiLmYtOomVnsAsPZGmyuQH9grZ6sUV0
         S22g==
X-Gm-Message-State: AHQUAuZgbVTsrY1rbEfwQlC31+a4oRCNUu4nQ0gA/fJ2ah+55jpM23eK
        gdVmh+nUWw4C9pVWyiptdBqlczDW/kE=
X-Google-Smtp-Source: AHgI3Iae+ShramYTKT9g+uLC4g6HrWbPRTV546Y55/XzzsED2RiKHKe62PaokDsWOzCvxADguH3myA==
X-Received: by 2002:a2e:914b:: with SMTP id q11-v6mr2296773ljg.164.1549358101293;
        Tue, 05 Feb 2019 01:15:01 -0800 (PST)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id d5sm3602300lfi.65.2019.02.05.01.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 01:15:00 -0800 (PST)
Subject: Re: [PATCH V2] lightnvm: pblk: fix race condition on GC
To:     Heiner Litz <hlitz@ucsc.edu>
Cc:     javier@javigon.com, hans.holmberg@cnexlabs.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190201023806.39895-1-hlitz@ucsc.edu>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <79e30230-2af4-2fd4-f6ee-35e47c36291c@lightnvm.io>
Date:   Tue, 5 Feb 2019 10:14:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190201023806.39895-1-hlitz@ucsc.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/19 3:38 AM, Heiner Litz wrote:
> This patch fixes a race condition where a write is mapped to the last
> sectors of a line. The write is synced to the device but the L2P is not
> updated yet. When the line is garbage collected before the L2P update is
> performed, the sectors are ignored by the GC logic and the line is freed
> before all sectors are moved. When the L2P is finally updated, it contains
> a mapping to a freed line, subsequent reads of the corresponding LBAs fail.
> 
> This patch introduces a per line counter specifying the number of sectors
> that are synced to the device but have not been updated in the L2P. Lines
> with a counter of greater than zero will not be selected for GC.
> 
> Signed-off-by: Heiner Litz <hlitz@ucsc.edu>
> ---
> 
> v2: changed according to Javier's comment. Instead of performing check
> while holding the trans_lock, add an atomic per line counter
> 
>   drivers/lightnvm/pblk-core.c  |  1 +
>   drivers/lightnvm/pblk-gc.c    | 20 +++++++++++++-------
>   drivers/lightnvm/pblk-map.c   |  1 +
>   drivers/lightnvm/pblk-rb.c    |  1 +
>   drivers/lightnvm/pblk-write.c |  1 +
>   drivers/lightnvm/pblk.h       |  1 +
>   6 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index eabcbc119681..b7ed0502abef 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1278,6 +1278,7 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
>   	spin_unlock(&line->lock);
>   
>   	kref_init(&line->ref);
> +	atomic_set(&line->sec_to_update, 0);
>   
>   	return 0;
>   }
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index 2fa118c8eb71..26a52ea7ec45 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -365,16 +365,22 @@ static struct pblk_line *pblk_gc_get_victim_line(struct pblk *pblk,
>   						 struct list_head *group_list)
>   {
>   	struct pblk_line *line, *victim;
> -	int line_vsc, victim_vsc;
> +	unsigned int line_vsc = ~0x0L, victim_vsc = ~0x0L;
>   
>   	victim = list_first_entry(group_list, struct pblk_line, list);
> +
>   	list_for_each_entry(line, group_list, list) {
> -		line_vsc = le32_to_cpu(*line->vsc);
> -		victim_vsc = le32_to_cpu(*victim->vsc);
> -		if (line_vsc < victim_vsc)
> +		if (!atomic_read(&line->sec_to_update))
> +			line_vsc = le32_to_cpu(*line->vsc);
> +		if (line_vsc < victim_vsc) {
>   			victim = line;
> +			victim_vsc = le32_to_cpu(*victim->vsc);
> +		}
>   	}
>   
> +	if (victim_vsc == ~0x0)
> +		return NULL;
> +
>   	return victim;
>   }
>   
> @@ -448,13 +454,13 @@ static void pblk_gc_run(struct pblk *pblk)
>   
>   	do {
>   		spin_lock(&l_mg->gc_lock);
> -		if (list_empty(group_list)) {
> +
> +		line = pblk_gc_get_victim_line(pblk, group_list);
> +		if (!line) {
>   			spin_unlock(&l_mg->gc_lock);
>   			break;
>   		}
>   
> -		line = pblk_gc_get_victim_line(pblk, group_list);
> -
>   		spin_lock(&line->lock);
>   		WARN_ON(line->state != PBLK_LINESTATE_CLOSED);
>   		line->state = PBLK_LINESTATE_GC;
> diff --git a/drivers/lightnvm/pblk-map.c b/drivers/lightnvm/pblk-map.c
> index 79df583ea709..7fbc99b60cac 100644
> --- a/drivers/lightnvm/pblk-map.c
> +++ b/drivers/lightnvm/pblk-map.c
> @@ -73,6 +73,7 @@ static int pblk_map_page_data(struct pblk *pblk, unsigned int sentry,
>   		 */
>   		if (i < valid_secs) {
>   			kref_get(&line->ref);
> +			atomic_inc(&line->sec_to_update);
>   			w_ctx = pblk_rb_w_ctx(&pblk->rwb, sentry + i);
>   			w_ctx->ppa = ppa_list[i];
>   			meta->lba = cpu_to_le64(w_ctx->lba);
> diff --git a/drivers/lightnvm/pblk-rb.c b/drivers/lightnvm/pblk-rb.c
> index a6133b50ed9c..03c241b340ea 100644
> --- a/drivers/lightnvm/pblk-rb.c
> +++ b/drivers/lightnvm/pblk-rb.c
> @@ -260,6 +260,7 @@ static int __pblk_rb_update_l2p(struct pblk_rb *rb, unsigned int to_update)
>   							entry->cacheline);
>   
>   		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
> +		atomic_dec(&line->sec_to_update);
>   		kref_put(&line->ref, pblk_line_put);
>   		clean_wctx(w_ctx);
>   		rb->l2p_update = pblk_rb_ptr_wrap(rb, rb->l2p_update, 1);
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 06d56deb645d..6593deab52da 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -177,6 +177,7 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
>   		 * re-map these entries
>   		 */
>   		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
> +		atomic_dec(&line->sec_to_update);
>   		kref_put(&line->ref, pblk_line_put);
>   	}
>   	spin_unlock(&pblk->trans_lock);
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index a6386d5acd73..ac3ab778e976 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -487,6 +487,7 @@ struct pblk_line {
>   	__le32 *vsc;			/* Valid sector count in line */
>   
>   	struct kref ref;		/* Write buffer L2P references */
> +	atomic_t sec_to_update;         /* Outstanding L2P updates to ppa */
>   
>   	struct pblk_w_err_gc *w_err_gc;	/* Write error gc recovery metadata */
>   
> 

Thanks Heiner. Applied for 5.1.
