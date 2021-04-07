Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86954C43462
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 20:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5104E611C1
	for <linux-block@archiver.kernel.org>; Wed,  7 Apr 2021 20:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236495AbhDGUcZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbhDGUcS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Apr 2021 16:32:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65449C061760
        for <linux-block@vger.kernel.org>; Wed,  7 Apr 2021 13:32:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bg21so7380276pjb.0
        for <linux-block@vger.kernel.org>; Wed, 07 Apr 2021 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hl/lLyxm6rxWaz/G9UA2v5YPGvpzojGnVyHieycFy70=;
        b=oxi45btY6HmmfgzDeXg7HrVXe+dDnqlj8aAXB8dRsFje7CQ79cJPBdYkpQZDMzA75v
         c8ME+UqBbVlno5Yt7656aKqLoo5zg7Py8UcALqy1VEm6fMewlOIMI7afpSnxfhX8RaR4
         uSEPFlG8guyD4GyYGjVcK+Ov0RrXp/vXqjooIp+ElPUbzuor00YKs6zKJsyadUtHMpb0
         p/6UZsITNvJb9hQU79G7eKG7V017bYKntYIfRdRwC9/+uo05Fuj7pfsdljNgopoOLfjj
         ks76ttjOKvFKU2afT9DnRSkeaa8q+Rxfs9BJfLaXh/iQUJLWwrfBwwIdkN7srDXO2aBP
         CX2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hl/lLyxm6rxWaz/G9UA2v5YPGvpzojGnVyHieycFy70=;
        b=DVNiAjTOotBnNSlwTcwk2zcLcxrMU7k/pH/nyv4vkNZqT1eGfAHJP4fgfQzMnFID9v
         7RhUoEnr7X4ZZFmsAVdt3KKooO9gn2DeyOQlbR/oyAjXtj2Q7furSkRWya1PLAvWr43o
         shSYK0Vv3oMUQbXlcWEK7ZY/tpvgGhiiyR/g+9Na8YtR3DQZUuJPUMI34JQW2mCnt9uj
         navU+uy/qvbHHsxUOtmE9ILMUuGbUxhmw9NKJSHC3KmV4vB2DS6RNssXvEvczPDOvpt+
         dffGZYD/gxL13JahMaoD+d/xkleqUtM23Trh6Q+EwMGsfkGl9Zzhm2vLxl+z6dbgoUaP
         rbdA==
X-Gm-Message-State: AOAM532USmn28lROuJaBqQNmgXlCQUWXBn6txeR7cO7JRgNPK22Vt1Yb
        caSRfB/NMmG/hL1yVHp9jAhBeCjYaUTb2A==
X-Google-Smtp-Source: ABdhPJxdHETm1/j2vPy+m1UTY1CzCcM/NYPx1/tI/6lYqv2XBjLv9TsIM5gG1CZMqRuJceDfQgL3pQ==
X-Received: by 2002:a17:902:d508:b029:e9:5f8a:c739 with SMTP id b8-20020a170902d508b02900e95f8ac739mr4561980plg.3.1617827527948;
        Wed, 07 Apr 2021 13:32:07 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id h16sm21623813pfc.194.2021.04.07.13.32.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Apr 2021 13:32:07 -0700 (PDT)
Subject: Re: [PATCH] blk-zoned: Remove the definition of blk_zone_start()
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20210406200820.15180-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d775eb95-438c-c70d-c5d4-889615d1d62c@kernel.dk>
Date:   Wed, 7 Apr 2021 14:32:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406200820.15180-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/21 2:08 PM, Bart Van Assche wrote:
> Commit e76239a3748c ("block: add a report_zones method") removed the last
> blk_zone_start() call. Hence also remove the definition of this function.

Applied, thanks.

-- 
Jens Axboe

