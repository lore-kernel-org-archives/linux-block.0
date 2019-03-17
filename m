Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEC3C43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 19:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5B221738
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 19:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="R9oIUcff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfCQTdo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:33:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44258 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfCQTdn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 15:33:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id h34so9822367pgh.11
        for <linux-block@vger.kernel.org>; Sun, 17 Mar 2019 12:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6jsVW0dWZXgtYKnFolSQtZDOIFZxfAv/gYm0wrfQkJA=;
        b=R9oIUcffJ7pwibBQpeA90CAqVdDvW0CjFT1sKaIVLNDpcV+/1yNrsakqyEvhr7RYyl
         sjEIu21qjfhETopzy8adsbJbyePJG+HtujZmt32B+fnKofL2PeDd/gLE5Ou08NYwIYea
         A3bZh0XcsLYhn74tcc54d8dq9T4KrECIaWKNLZ8J/wxzmiK3RYoG/on2cLg0WupnvMSC
         dX68DA+6A7oiZUwvj58fbihTPi3rnTZ2lPUQm+vz+wFGF1McZCIsrfXW1rvCa4MzpOq5
         MfXqhVurCBSZEGavrrsF3ko9SGJJsS/dQRFbj9wxoYVF5XcnETl/ady8OSJRc+vZeiAl
         lrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6jsVW0dWZXgtYKnFolSQtZDOIFZxfAv/gYm0wrfQkJA=;
        b=BtlY+kLhtVU/HZ4TA93uMSqz5OQ4dH0VePHeMaf/X0qW8nCDC3Po5LRyIl+FTa2omm
         tc225VvgF7LpSosPph0p0gXsTas9lOkO4LBi1+A0g6FV3TNYfqizGTubyZ5UP9bAtB/0
         lf9Ig1p0E94Wi0D4ntMh9YWVcww7PGH8CHY/TzhvuBA4xKJO+IjCWxiH4K1v6VDftglt
         qdM9QCim/NGbxpRdahOU7Em7dEPvimDlZSYz3wrDSuX+ZlvIqkRPRXrghyfWExM+M8Dl
         L5mZJkHzsOds/PRD8rHO0+HaTEitku6JYqaigZSBlgG4AdK+rY3J46FHXrlfzxObqqUG
         3n9g==
X-Gm-Message-State: APjAAAWIKm2Q7fUZ3Oh7I2M9yNE60DQa+n49di2PvY+204eJTsSunmLe
        1l0rEO9PAYZXXlgwy82sY47uOqFvPYGcmA==
X-Google-Smtp-Source: APXvYqx6eBmqoElxhi9EGbreU+oGdSgzS+pttjz2H8StDM+aor70LG6+u0+SRluqcgNPaULZ5YxTcg==
X-Received: by 2002:a63:455f:: with SMTP id u31mr14023007pgk.241.1552851222126;
        Sun, 17 Mar 2019 12:33:42 -0700 (PDT)
Received: from [10.111.76.104] (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id l63sm11349440pfc.89.2019.03.17.12.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:33:40 -0700 (PDT)
Subject: Re: [PATCH 07/18] lightnvm: pblk: wait for inflight IOs in recovery
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-8-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <00eb866a-d2aa-437b-e580-3b0649e657ce@lightnvm.io>
Date:   Sun, 17 Mar 2019 12:33:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190314160428.3559-8-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/19 9:04 AM, Igor Konopko wrote:
> This patch changes the behaviour of recovery padding in order to
> support a case, when some IOs were already submitted to the drive and
> some next one are not submitted due to error returned.
> 
> Currently in case of errors we simply exit the pad function without
> waiting for inflight IOs, which leads to panic on inflight IOs
> completion.
> 
> After the changes we always wait for all the inflight IOs before
> exiting the function.
> 
> Also, since NVMe has an internal timeout per IO, there is no need to
> introduce additonal one here.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/pblk-recovery.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index ba1691d..73d5ead 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -200,7 +200,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>   	rq_ppas = pblk_calc_secs(pblk, left_ppas, 0, false);
>   	if (rq_ppas < pblk->min_write_pgs) {
>   		pblk_err(pblk, "corrupted pad line %d\n", line->id);
> -		goto fail_free_pad;
> +		goto fail_complete;
>   	}
>   
>   	rq_len = rq_ppas * geo->csecs;
> @@ -209,7 +209,7 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>   						PBLK_VMALLOC_META, GFP_KERNEL);
>   	if (IS_ERR(bio)) {
>   		ret = PTR_ERR(bio);
> -		goto fail_free_pad;
> +		goto fail_complete;
>   	}
>   
>   	bio->bi_iter.bi_sector = 0; /* internal bio */
> @@ -218,8 +218,11 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>   	rqd = pblk_alloc_rqd(pblk, PBLK_WRITE_INT);
>   
>   	ret = pblk_alloc_rqd_meta(pblk, rqd);
> -	if (ret)
> -		goto fail_free_rqd;
> +	if (ret) {
> +		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
> +		bio_put(bio);
> +		goto fail_complete;
> +	}
>   
>   	rqd->bio = bio;
>   	rqd->opcode = NVM_OP_PWRITE;
> @@ -266,7 +269,10 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>   	if (ret) {
>   		pblk_err(pblk, "I/O submission failed: %d\n", ret);
>   		pblk_up_chunk(pblk, rqd->ppa_list[0]);
> -		goto fail_free_rqd;
> +		kref_put(&pad_rq->ref, pblk_recov_complete);
> +		pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
> +		bio_put(bio);
> +		goto fail_complete;
>   	}
>   
>   	left_line_ppas -= rq_ppas;
> @@ -274,13 +280,9 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>   	if (left_ppas && left_line_ppas)
>   		goto next_pad_rq;
>   
> +fail_complete:
>   	kref_put(&pad_rq->ref, pblk_recov_complete);
> -
> -	if (!wait_for_completion_io_timeout(&pad_rq->wait,
> -				msecs_to_jiffies(PBLK_COMMAND_TIMEOUT_MS))) {
> -		pblk_err(pblk, "pad write timed out\n");
> -		ret = -ETIME;
> -	}
> +	wait_for_completion(&pad_rq->wait);
>   
>   	if (!pblk_line_is_full(line))
>   		pblk_err(pblk, "corrupted padded line: %d\n", line->id);
> @@ -289,14 +291,6 @@ static int pblk_recov_pad_line(struct pblk *pblk, struct pblk_line *line,
>   free_rq:
>   	kfree(pad_rq);
>   	return ret;
> -
> -fail_free_rqd:
> -	pblk_free_rqd(pblk, rqd, PBLK_WRITE_INT);
> -	bio_put(bio);
> -fail_free_pad:
> -	kfree(pad_rq);
> -	vfree(data);
> -	return ret;
>   }
>   
>   static int pblk_pad_distance(struct pblk *pblk, struct pblk_line *line)
> 

Hi Igor,

Can you split this patch in two. One that removes the 
wait_for_completion_io_timeout (and constant), and another that makes 
sure it waits until all inflight IOs are completed?


