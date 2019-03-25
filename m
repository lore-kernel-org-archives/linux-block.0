Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31375C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A052082C
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="l2tsFeUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfCYL3I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:29:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44888 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfCYL3I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 07:29:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id x10so7141984edh.11
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 04:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kl3DbXvaAg6jw4jNx/jNC1bRYN2IMReBNCkTmcDBt+8=;
        b=l2tsFeUUhL3p/ZUqgNw9N/x7af3eZMYa855QyXHiRHKK3OIMykVZ4OzlrZBxdn4Lxs
         1vgPhiKwxsKUSgCya36SWZAWF+/s11vpyxTx7HeguqNmJzBJfAqcNsbSnPu6twRSoLfj
         CYinHLW3a81tkIA8wjfl5+n/e06X4hh+ziCQjrqhznk+uo91CMbFwQsDkkRT0/qNl1bu
         +hnnzQNrZclhSw65VjoGjxUHrVCPHjdJ0PcyPi04TVC6hHs8v5sgEQRVhofbtcHakwgQ
         IvOE8otzMbJY1mVBHpvr6+9dNO4A+jhMRNUQQZy9mRGS5tYpfiwp+e2oNHgvw8AB6Mgh
         MS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kl3DbXvaAg6jw4jNx/jNC1bRYN2IMReBNCkTmcDBt+8=;
        b=qyLpRH/5pbwtWYOHikPDVSzjamAL0J6BhSZyGiH9YhDRL4rRz0h8DySbdjEDwJ1CgL
         upAmLYDmgwyrbMYpF/VSfPlwIF7SHDtbBuHDgPncO2OFIG6fHzq7L1WH3zblV6BmanXh
         gCHvq6Aovmihy+UHrYdFjsS27zN1WYW7WTSx88PtSSPuJlDF5//12/k3c9997u9e7aGJ
         1KEAEXYzy9xUH8wZk6qrEWwk1rocRbdSkb4Fm3fy9hqtBN95eKpiqBs4O9dH8vGEmZaM
         8gQ5mP54lFFR37vtaEhBlWJ+1yR8zKaW+MGtDv3ThdmxMIWp9KdqwkKTwFF7tAFRyKoQ
         vxMA==
X-Gm-Message-State: APjAAAXLmyBQtA0BVMEcUrscZi143FolyHABucdYgU7Vx+8xsYQK2yAd
        4j+HIoBTzIT21TWwK4q4ARg6G0SCaFo=
X-Google-Smtp-Source: APXvYqziuLA2iiP5Z8Sf45jC71BwcFRshLTsaZBaamFU2HwlhkkRFyvQjEvslZdg32TJSWq4WdKVXQ==
X-Received: by 2002:a50:eac9:: with SMTP id u9mr5534630edp.159.1553513345673;
        Mon, 25 Mar 2019 04:29:05 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id o12sm5159585edt.58.2019.03.25.04.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:29:05 -0700 (PDT)
Subject: Re: [PATCH v2 14/16] lightnvm: pblk: GC error handling
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
 <20190322144843.9602-15-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <229e19ab-a661-fbad-9771-f0c62a0ca73c@lightnvm.io>
Date:   Mon, 25 Mar 2019 12:29:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190322144843.9602-15-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 3:48 PM, Igor Konopko wrote:
> Currently when there is an IO error (or similar) on GC read path, pblk
> still moves this line to free state

What those "this" line refer to?

, what leads to data mismatch issue.

what -> which leads to a data mismatch.
> 
> This patch adds a handling for such an error - after that changes this
> line will be returned to closed state so it can be still in use
> for reading - at least we will be able to return error status to user
> when user tries to read such a data.

Could you update the description. It is hard for me to parse.

> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> Reviewed-by: Javier González <javier@javigon.com>
> Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c | 8 ++++++++
>   drivers/lightnvm/pblk-gc.c   | 5 ++---
>   drivers/lightnvm/pblk-read.c | 1 -
>   drivers/lightnvm/pblk.h      | 2 ++
>   4 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 9d9a9e2..1b88e5e 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1799,6 +1799,14 @@ static void __pblk_line_put(struct pblk *pblk, struct pblk_line *line)
>   
>   	spin_lock(&line->lock);
>   	WARN_ON(line->state != PBLK_LINESTATE_GC);
> +	if (line->w_err_gc->has_gc_err) {
> +		spin_unlock(&line->lock);
> +		pblk_err(pblk, "line %d had errors during GC\n", line->id);
> +		pblk_put_line_back(pblk, line);
> +		line->w_err_gc->has_gc_err = 0;
> +		return;
> +	}
> +
>   	line->state = PBLK_LINESTATE_FREE;
>   	trace_pblk_line_state(pblk_disk_name(pblk), line->id,
>   					line->state);
> diff --git a/drivers/lightnvm/pblk-gc.c b/drivers/lightnvm/pblk-gc.c
> index e23b192..63ee205 100644
> --- a/drivers/lightnvm/pblk-gc.c
> +++ b/drivers/lightnvm/pblk-gc.c
> @@ -59,7 +59,7 @@ static void pblk_gc_writer_kick(struct pblk_gc *gc)
>   	wake_up_process(gc->gc_writer_ts);
>   }
>   
> -static void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
> +void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line)
>   {
>   	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>   	struct list_head *move_list;
> @@ -98,8 +98,7 @@ static void pblk_gc_line_ws(struct work_struct *work)
>   	/* Read from GC victim block */
>   	ret = pblk_submit_read_gc(pblk, gc_rq);
>   	if (ret) {
> -		pblk_err(pblk, "failed GC read in line:%d (err:%d)\n",
> -								line->id, ret);
> +		line->w_err_gc->has_gc_err = 1;
>   		goto out;
>   	}
>   
> diff --git a/drivers/lightnvm/pblk-read.c b/drivers/lightnvm/pblk-read.c
> index 264d1d7..5481dfa 100644
> --- a/drivers/lightnvm/pblk-read.c
> +++ b/drivers/lightnvm/pblk-read.c
> @@ -494,7 +494,6 @@ int pblk_submit_read_gc(struct pblk *pblk, struct pblk_gc_rq *gc_rq)
>   
>   	if (pblk_submit_io_sync(pblk, &rqd)) {
>   		ret = -EIO;
> -		pblk_err(pblk, "GC read request failed\n");
>   		goto err_free_bio;
>   	}
>   
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 0999245..0bc4255 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -425,6 +425,7 @@ struct pblk_smeta {
>   
>   struct pblk_w_err_gc {
>   	int has_write_err;
> +	int has_gc_err;
>   	__le64 *lba_list;
>   };
>   
> @@ -916,6 +917,7 @@ void pblk_gc_free_full_lines(struct pblk *pblk);
>   void pblk_gc_sysfs_state_show(struct pblk *pblk, int *gc_enabled,
>   			      int *gc_active);
>   int pblk_gc_sysfs_force(struct pblk *pblk, int force);
> +void pblk_put_line_back(struct pblk *pblk, struct pblk_line *line);
>   
>   /*
>    * pblk rate limiter
> 

