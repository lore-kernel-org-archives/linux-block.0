Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24504C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 20:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56E420700
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 20:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="IM03fd9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbfC0UZy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:25:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33569 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbfC0UZy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 16:25:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id q3so15255590edg.0
        for <linux-block@vger.kernel.org>; Wed, 27 Mar 2019 13:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kSMzQACcQXCF59sFa/85M2ZknQeJriEPP4jWD62ljjg=;
        b=IM03fd9T50MDRVfSFF8GCgN8op64s1qaXzeV5X/Zew/EElTf1OOyOPwcFKq10BCZ02
         VnHBH6oyaotouq0bpnAEm4+J9RPGp5VJ4jEv0lgl4ViWfeiCK+yuGNlfpgSJuHbZc536
         Zesl7mVy6upFGJj5s4fDgpqWmsl+4RG3ZpkWle8IRGop4OfIThKHGN4G1FDs/oLR9Re4
         Iw+abq35f+j0fQbTD1CvLxMQyrM6cKGmiW2iTWrViMkpZ3Vj9KWi9/GH3b+2vvpIzf5j
         mUKEppoY0hsAQu25nyDCIGwZH0qDPWdwFFiYkpZAlI1pWB5ry4Duusadf1o2HM0dFJ1z
         PRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kSMzQACcQXCF59sFa/85M2ZknQeJriEPP4jWD62ljjg=;
        b=I8O9ahwr0x7P7yWOgJske4BpgrIVm5eKok+xKSUIaj4AGXycmsemJQjrGtNjJ27HkC
         VtvLKbH+DsFf4ImfEUSBjaEq9QjiacMY0kAHbTKv5KFT+Fb1SWJHkS5dQ1+Autfuq0ds
         fTQ0QQxK1W/1qjuMTgIW1CnaZbN5mWj800zKssxK1z1KkDtIkAMApvctchkDhFs+jwpu
         bHpwLz8g2Cf0QogvYhKxvpPyfcm/EViJ/xzwkkbVK1tzC9rFXEWii21IWlOj9WIQteJt
         6b9QER/5V6oV0wHui4ZoCZ+4F4rgxRixLMpGTr+YnMCdepsjcqt54lzIvN0sorqnc2QB
         Ncbg==
X-Gm-Message-State: APjAAAUXeZ7ukRgDT4XGI43tK+YkbYdb3PVoZLksSFV//Q4Kt7LIcAaf
        BMql/iAsRMs8hFuRchaBpQA7Pz7D2ls=
X-Google-Smtp-Source: APXvYqw+HzNaY2OAproGUJNtVpeVQ0ut2OjteI9Hge139+7WPpyB+Yknjh3QtNBL8SvnqPWd06Gb0Q==
X-Received: by 2002:a05:6402:28f:: with SMTP id l15mr25721040edv.10.1553718352432;
        Wed, 27 Mar 2019 13:25:52 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id t9sm2908163ejg.54.2019.03.27.13.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 13:25:51 -0700 (PDT)
Subject: Re: [PATCH v3 03/10] lightnvm: pblk: propagate errors when reading
 meta
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190327123901.12323-1-igor.j.konopko@intel.com>
 <20190327123901.12323-4-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <276a0fd6-69f7-87ee-6e25-fe79b35ce503@lightnvm.io>
Date:   Wed, 27 Mar 2019 21:25:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190327123901.12323-4-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/19 1:38 PM, Igor Konopko wrote:
> Currently when smeta/emeta/oob is read errors are not always propagated
> correctly. This patch changes that behaviour and propagates all the
> error codes except of high ecc read warning status.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> Reviewed-by: Javier González <javier@javigon.com>
> Reviewed-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
>   drivers/lightnvm/pblk-core.c     | 9 +++++++--
>   drivers/lightnvm/pblk-recovery.c | 2 +-
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index f2edec6..06ac3f0 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -761,8 +761,10 @@ int pblk_line_smeta_read(struct pblk *pblk, struct pblk_line *line)
>   
>   	atomic_dec(&pblk->inflight_io);
>   
> -	if (rqd.error)
> +	if (rqd.error && rqd.error != NVM_RSP_WARN_HIGHECC) {
>   		pblk_log_read_err(pblk, &rqd);
> +		ret = -EIO;
> +	}
>   
>   clear_rqd:
>   	pblk_free_rqd_meta(pblk, &rqd);
> @@ -916,8 +918,11 @@ int pblk_line_emeta_read(struct pblk *pblk, struct pblk_line *line,
>   
>   	atomic_dec(&pblk->inflight_io);
>   
> -	if (rqd.error)
> +	if (rqd.error && rqd.error != NVM_RSP_WARN_HIGHECC) {
>   		pblk_log_read_err(pblk, &rqd);
> +		ret = -EIO;
> +		goto free_rqd_dma;
> +	}
>   
>   	emeta_buf += rq_len;
>   	left_ppas -= rq_ppas;
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 357e529..124d817 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -458,7 +458,7 @@ static int pblk_recov_scan_oob(struct pblk *pblk, struct pblk_line *line,
>   	atomic_dec(&pblk->inflight_io);
>   
>   	/* If a read fails, do a best effort by padding the line and retrying */
> -	if (rqd->error) {
> +	if (rqd->error && rqd->error != NVM_RSP_WARN_HIGHECC) {
>   		int pad_distance, ret;
>   
>   		if (padded) {
> 

Thanks, applied. I've updated the wording a bit.
