Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF050C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C755207DD
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 11:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="YFWbMMoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbfCYLSN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:18:13 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33927 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYLSM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 07:18:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id x14so4501906eds.1
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 04:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CfHiDSCbhDclldj+3gjUeVZ3bwjQu7IGG/BwLfIyDao=;
        b=YFWbMMoFrh673p34icxhvcOwRSnzcLW14PEwG6Cz79VUF0mUjcjIL6/brXPVBZjFfK
         nW1QecHpVIyZfSZvtJnFNsadVYuHUPdUkGrgsTL6QxaIeaa7qdh6eD8phZ5A7b6b7E1c
         v1kgZS6sDw6VINdHbwd4O9TOSxNiMfvJ0kP8ul1mjHdxWJkw4XksVbQUx4qRaWM2buta
         QwUtU61W6kUJtEivDIvypQ9aQ4vctU73NOAIBjEOWp4uSy2fi2vyIVSmENOeMsDSHzhz
         FXcmRU0CPvnz5jdHmxOZrU8ctcgMKR9MUvmCqbc7tnXEfAgjlG0XHNbL0R7z8fY+thpk
         t/rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CfHiDSCbhDclldj+3gjUeVZ3bwjQu7IGG/BwLfIyDao=;
        b=Kyr9j68KX2EEnBViX/mRxLRUyZlHkX6EF4roYCvkaqUZvoSByDaC06JIi8qGr+TYdS
         J+UJoLF49Ku+UV1jqKGvPGU6P6Li9J/kNYHGqJD3xvmzXgvCYU1YwtcjDfwCJtjyaF4R
         8+YN1UV04w5I+oVG1xDoBfShL4YvpxdE1B0myoJZzk92gNDIKaFLIKRTN8xEuHNeoaml
         Q66WeCy90wqnGrGtVxnxVhSkyyPn8TOOLOVI7wMW7rHPTdWr0qTOarzKK45fPEiK7vnp
         WtbEXP6YqFx3Wr2zMDM0NI7E2qCjN+MSYN4sK1k4XjCCz5UTXGQkx/69/Jp17J3SmMBU
         uy4Q==
X-Gm-Message-State: APjAAAUKodeudZ3k7c1N87MKnuGHNV6cUjL1nh5LJAu3LRAfyMOj5PZ4
        6ieu65AlKUAmX9d2p03mHWR8SAnC8kw=
X-Google-Smtp-Source: APXvYqybcoGQ4VEVzaB7eRJxTdraItOsWNeots0ul27OVBh8WVHgKYEuDvO4XflzXQ5YsuNOqAQzRw==
X-Received: by 2002:a50:94d6:: with SMTP id t22mr16487052eda.32.1553512690660;
        Mon, 25 Mar 2019 04:18:10 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id i14sm3456767ejy.41.2019.03.25.04.18.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 04:18:10 -0700 (PDT)
Subject: Re: [PATCH v2 11/16] lightnvm: pblk: fix update line wp in OOB
 recovery
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190322144843.9602-1-igor.j.konopko@intel.com>
 <20190322144843.9602-12-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <43bbf356-571e-0a34-f9fe-2ed6b4706e94@lightnvm.io>
Date:   Mon, 25 Mar 2019 12:18:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190322144843.9602-12-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 3:48 PM, Igor Konopko wrote:
> In case of OOB recovery, we can hit the scenario when all the data in
> line were written and some part of emeta was written too. In such
> a case pblk_update_line_wp() function will call pblk_alloc_page()
> function which will case to set left_msecs to value below zero
> (since this field does not track emeta region) and thus will lead to
> multiple kernel warnings. This patch fixes that issue.
> 
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> Reviewed-by: Javier González <javier@javigon.com>
> ---
>   drivers/lightnvm/pblk-recovery.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 65916f0..4e8f382 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -93,10 +93,24 @@ static int pblk_recov_l2p_from_emeta(struct pblk *pblk, struct pblk_line *line)
>   static void pblk_update_line_wp(struct pblk *pblk, struct pblk_line *line,
>   				u64 written_secs)
>   {
> +	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
>   	int i;
>   
>   	for (i = 0; i < written_secs; i += pblk->min_write_pgs)
> -		pblk_alloc_page(pblk, line, pblk->min_write_pgs);
> +		__pblk_alloc_page(pblk, line, pblk->min_write_pgs);
> +
> +	spin_lock(&l_mg->free_lock);
> +	if (written_secs > line->left_msecs) {
> +		/*
> +		 * We have all data sectors written
> +		 * and some emeta sectors written too.
> +		 */
> +		line->left_msecs = 0;
> +	} else {
> +		/* We have only some data sectors written. */
> +		line->left_msecs -= written_secs;
> +	}
> +	spin_unlock(&l_mg->free_lock);
>   }
>   
>   static u64 pblk_sec_in_open_line(struct pblk *pblk, struct pblk_line *line)
> 

Thanks, applied.
