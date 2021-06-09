Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBD5C48BCF
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D16261375
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbhFIPp6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:45:58 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:36507 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhFIPp6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 11:45:58 -0400
Received: by mail-pg1-f175.google.com with SMTP id 27so19816630pgy.3
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=vsgtZmt0SOolZ6N4V133au8ZdTXayh0J3WrGJqW11PM=;
        b=twUkhtWhKPJvdNvOL3w3ANoEcVtMR2J2UNAfBgZX+JgGHWOL2Xgn2dD83dAzCFYT6Z
         ipTpEA8L7Jz5WEEICQtRDMEnkkg0uf7v2YjxbacGuZVUPHKt9UqVbkZN/NLQwUGHoyLs
         PZPTb+QhTnu5iL0HQcf0bTAe9ZpSMuMf6GUenLXbj7gwNyiXFHk19pezJKBKrqKqS27R
         ixGJH0Lvu8+hOrdNnDz4WkYigjHLPvtA3Ox/y0gN3Hy468nU+vFqTIwVdEAnQUs+K6Ny
         cEcH6MeTupZeBokf9MDlPNwo4jYPaIjzR5Uck6Q6CLnDuYZsZzEhDbI4xpbVyvu9s5d0
         3qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vsgtZmt0SOolZ6N4V133au8ZdTXayh0J3WrGJqW11PM=;
        b=kbDLUR+g8ROP9PDwQeZYu2z6+bvELWO1oMccZiwEDpDgH5yBnvL6/Vsm2sj+naw+J0
         JSwps9FmZRSVoo2mZ0ht0pIlbwSxiQgPv8SYV7+crWl7LXFCfsyGWLwB81sWgKTgjWrZ
         602qLtdP5/nViaQkdyobMAZtLJTC5SpWTYPbZfBq2fwX4oxNP40+E6A3N9nE/V1rRefZ
         YAOkiR+9UUaY9ANyKvGMonf9TcA9pmG5B6HfC4y9QZW2cdrV34j9OGAXsJ8EJJcP6931
         LYIh9a7pY4BBGLtqn0nC8HCyX1kv98uONChVOmWQMw2RJSkGGo7lEr7yc+p9VvH7phvw
         5ruw==
X-Gm-Message-State: AOAM533HQx9CqNXccraRMCqufyqugc83TchiBH1LBFRrj7YnaSfKTWam
        jK8Rn/CL2SAUrK2BUUZC1Cy6FbiQ//Z04Q==
X-Google-Smtp-Source: ABdhPJw9f2oysp7IDb/hakBUoTxIn25AxEnaAijWYsXQb1rfNbwaPiKD/dqt55ZvzLMR9ONDyemtyA==
X-Received: by 2002:a63:9515:: with SMTP id p21mr284681pgd.333.1623253383540;
        Wed, 09 Jun 2021 08:43:03 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 203sm44668pfw.124.2021.06.09.08.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:43:03 -0700 (PDT)
Subject: Re: [PATCH 1/1] sx8: remove unnecessary oom message
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
References: <20210609122450.14098-1-thunder.leizhen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e1caa71d-8e01-11e8-691c-b61d21655a38@kernel.dk>
Date:   Wed, 9 Jun 2021 09:43:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210609122450.14098-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 6:24 AM, Zhen Lei wrote:
> Fixes scripts/checkpatch.pl warning:
> WARNING: Possible unnecessary 'out of memory' message
> 
> Remove it can help us save a bit of memory.

Applied, thanks.

-- 
Jens Axboe

