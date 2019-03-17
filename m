Return-Path: <SRS0=Zyuh=RU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C967C43381
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 19:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3243D20872
	for <linux-block@archiver.kernel.org>; Sun, 17 Mar 2019 19:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="Qz1Vt9U6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfCQToE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:44:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34022 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfCQToE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Mar 2019 15:44:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id v64so9764999pfb.1
        for <linux-block@vger.kernel.org>; Sun, 17 Mar 2019 12:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FA+SdDuWoaXw7DnI4fArYiTytHGb+lEa+Y9k83wDRNM=;
        b=Qz1Vt9U63KSZyESqjeamiSg9WKWmcoYqhvdOAH9p8sO7kW1e2g+E2IHMibLNwlKOJw
         zj5eDfSHIhlyNwzk13/HVTM3827ce+m3wfJKgu94Q0hQ75wI+LHfAtxFWEk17PC+Lx+v
         i81egRHzjSe4diwQqBpQGmZOJyYZODsxteIPHLR6KYj5iNeiOPJhXuHvfg/Ca0dqRpUl
         XH7eciUkzDhYijWPrEwYdaEzkLwE5SSnyF48oA3ZD/Etj+0xxw5Q9jH1KPg1UWmIuxMP
         q8+ipjzVtQEOWWF3D2+zSVz3iRaqzErIJDGpkhHo7BaWJfuDey6k9zhPnW1eijdDl8N+
         AjYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FA+SdDuWoaXw7DnI4fArYiTytHGb+lEa+Y9k83wDRNM=;
        b=pU0ffDkkt5UPnxaeFE+/MFD4IkI6PxFnPWoOJj4xOINfnzZwhdH8XWP7DGYyW7Q75P
         FvusTFfJBWav4RtHkEs/NqpQpXoMP8W78Sk9nhhQSdBW6q+5LWtxZ8Wh4ARFoyS9cWOK
         pxw6eeeco9FhdZ87Sm/XvZzTINF8xCCQwGEHVdoy5D1BCrKScBhttFrGdXZuBH2UUmDL
         9GpWq9MbvZzNc3PEXtRy4yrllYgrx84Dvlomk7prnVTeiCWtWISb3CKU3uSkLeA9LQsA
         e2rtgRK1daDxGXG2en8ZRSyakgRyUHGFVODjh+++2dfAh/xgRVGYFDe0Tmbau4FkZhxB
         EE7w==
X-Gm-Message-State: APjAAAWm6HuGC1zzjQd3dEBFrWeQzJVBwHyLnj9CQrfT4M0Jwey+iif7
        3Oh6o0bqw4IOn2nRSqjXFUhMeCK8MlZZug==
X-Google-Smtp-Source: APXvYqzyMyuTH4hVxXSYIo5iJf5LiH5XDhRBmUQEjABEL/le7xRuIKJOSMkzFYxISPL5WA4VaSs+hA==
X-Received: by 2002:a62:5e46:: with SMTP id s67mr15421451pfb.126.1552851843115;
        Sun, 17 Mar 2019 12:44:03 -0700 (PDT)
Received: from [10.111.76.104] (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id h11sm8772360pgq.57.2019.03.17.12.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 12:44:02 -0700 (PDT)
Subject: Re: [PATCH 10/18] lightnvm: pblk: ensure that emeta is written
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190314160428.3559-1-igor.j.konopko@intel.com>
 <20190314160428.3559-11-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <6766e0ae-ec44-3ebd-0015-aeb7cb9029e5@lightnvm.io>
Date:   Sun, 17 Mar 2019 12:44:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190314160428.3559-11-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/19 9:04 AM, Igor Konopko wrote:
> When we are trying to switch to the new line, we need to ensure that
> emeta for n-2 line is already written. In other case we can end with
> deadlock scenario, when the writer has no more requests to write and
> thus there is no way to trigger emeta writes from writer thread. This
> is a corner case scenario which occurs in a case of multiple writes
> error and thus kind of early line close due to lack of line space.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> ---
>   drivers/lightnvm/pblk-core.c  |  2 ++
>   drivers/lightnvm/pblk-write.c | 24 ++++++++++++++++++++++++
>   drivers/lightnvm/pblk.h       |  1 +
>   3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
> index 38e26fe..a683d1f 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -1001,6 +1001,7 @@ static void pblk_line_setup_metadata(struct pblk_line *line,
>   				     struct pblk_line_mgmt *l_mg,
>   				     struct pblk_line_meta *lm)
>   {
> +	struct pblk *pblk = container_of(l_mg, struct pblk, l_mg);
>   	int meta_line;
>   
>   	lockdep_assert_held(&l_mg->free_lock);
> @@ -1009,6 +1010,7 @@ static void pblk_line_setup_metadata(struct pblk_line *line,
>   	meta_line = find_first_zero_bit(&l_mg->meta_bitmap, PBLK_DATA_LINES);
>   	if (meta_line == PBLK_DATA_LINES) {
>   		spin_unlock(&l_mg->free_lock);
> +		pblk_write_emeta_force(pblk);
>   		io_schedule();
>   		spin_lock(&l_mg->free_lock);
>   		goto retry_meta;
> diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
> index 4e63f9b..4fbb9b2 100644
> --- a/drivers/lightnvm/pblk-write.c
> +++ b/drivers/lightnvm/pblk-write.c
> @@ -505,6 +505,30 @@ static struct pblk_line *pblk_should_submit_meta_io(struct pblk *pblk,
>   	return meta_line;
>   }
>   
> +void pblk_write_emeta_force(struct pblk *pblk)
> +{
> +	struct pblk_line_meta *lm = &pblk->lm;
> +	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
> +	struct pblk_line *meta_line;
> +
> +	while (true) {
> +		spin_lock(&l_mg->close_lock);
> +		if (list_empty(&l_mg->emeta_list)) {
> +			spin_unlock(&l_mg->close_lock);
> +			break;
> +		}
> +		meta_line = list_first_entry(&l_mg->emeta_list,
> +						struct pblk_line, list);
> +		if (meta_line->emeta->mem >= lm->emeta_len[0]) {
> +			spin_unlock(&l_mg->close_lock);
> +			io_schedule();
> +			continue;
> +		}
> +		spin_unlock(&l_mg->close_lock);
> +		pblk_submit_meta_io(pblk, meta_line);
> +	}
> +}
> +
>   static int pblk_submit_io_set(struct pblk *pblk, struct nvm_rq *rqd)
>   {
>   	struct ppa_addr erase_ppa;
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index 0a85990..a42bbfb 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -877,6 +877,7 @@ int pblk_write_ts(void *data);
>   void pblk_write_timer_fn(struct timer_list *t);
>   void pblk_write_should_kick(struct pblk *pblk);
>   void pblk_write_kick(struct pblk *pblk);
> +void pblk_write_emeta_force(struct pblk *pblk);
>   
>   /*
>    * pblk read path
> 

Hi Igor,

Is this an error that qemu can force pblk to expose? Can you provide a 
specific example on what is needed to force the error?
