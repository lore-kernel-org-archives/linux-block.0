Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54A4C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 22:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42A460EE7
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 22:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbhITWQq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 18:16:46 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:46815 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbhITWOp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 18:14:45 -0400
Received: by mail-pj1-f50.google.com with SMTP id lb1-20020a17090b4a4100b001993f863df2so1033011pjb.5
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 15:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GNcH9n1n6985jmTpRW3zCpGYBALobjv8f2quy1A5vSE=;
        b=PV1tX98xskaF7kJjU+JPT/qLZPaTT4X6+fGNomtHxDrMnC5NE1bPTYhMubLz01ZhTY
         53fHC3CrmsHUKkzRFrkMU85MUGYwZHi9InvLZtA7iEHEbhhJc18jfscKMPUi1Yd2Qsc9
         sGuV/h6eawlEiSV0PVNEY4FQ+JUMwKsHYwQNH7pzrS54sTKisDvTOVde9RgHRYF4d2BF
         VYGJrSPBYwFSg8Ftb23xyLsgzbIYziSjJ5xC7qbuZ17H+PJBpmDSGOEe8bpKj8iIOAne
         tKMnP0Q1fJbvZ5TRG8kStIg48oY2a5Vb+NxYRbjbBSVP9mpz96IWsH1mivK1lNla3uQG
         rUdw==
X-Gm-Message-State: AOAM532WdGhQCKMUKPDHGIrQZQ204COHaxGdc09UTB3Ak519S+SiGYZt
        ZSajoaOCEXPhV5YIVXKVrmA=
X-Google-Smtp-Source: ABdhPJyBCSHvnuuMXNRi79UlwIKwDOKjiVEtUvRASHqIyGImGgZFQd9QJ9f/FzQ//pT+lnADw0tqsA==
X-Received: by 2002:a17:90a:428e:: with SMTP id p14mr1365262pjg.229.1632175998091;
        Mon, 20 Sep 2021 15:13:18 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:6e2a:d64:7d9d:bd4a])
        by smtp.gmail.com with ESMTPSA id q18sm2278262pfh.170.2021.09.20.15.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 15:13:17 -0700 (PDT)
Subject: Re: [PATCH 01/17] mm: don't include <linux/blk-cgroup.h> in
 <linux/writeback.h>
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
References: <20210920123328.1399408-1-hch@lst.de>
 <20210920123328.1399408-2-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <50b75915-b61f-d3aa-b8ab-bd790adc04af@acm.org>
Date:   Mon, 20 Sep 2021 15:13:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210920123328.1399408-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/20/21 5:33 AM, Christoph Hellwig wrote:
> -static inline struct cgroup_subsys_state *
> -wbc_blkcg_css(struct writeback_control *wbc)
> -{
>   #ifdef CONFIG_CGROUP_WRITEBACK
> -	if (wbc->wb)
> -		return wbc->wb->blkcg_css;
> -#endif
> -	return blkcg_root_css;
> -}
> +#define wbc_blkcg_css(wbc) \
> +	((wbc)->wb ? (wbc)->wb->blkcg_css : blkcg_root_css)
> +#else
> +#define wbc_blkcg_css(wbc)		(blkcg_root_css)
> +#endif /* CONFIG_CGROUP_WRITEBACK */

This change may introduce annoying set-but-not-used warnings
with CONFIG_CGROUP_WRITEBACK=n. How about changing (blkcg_root_css)
into ((wbc), blkcg_root_css) to prevent this?

Thanks,

Bart.
