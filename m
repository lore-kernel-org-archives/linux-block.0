Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F95C48BE5
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D72961351
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 15:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbhFIPpH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 11:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237547AbhFIPom (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 11:44:42 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9CFC061574
        for <linux-block@vger.kernel.org>; Wed,  9 Jun 2021 08:42:47 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 27so19815993pgy.3
        for <linux-block@vger.kernel.org>; Wed, 09 Jun 2021 08:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NA+8v+xy91ArXchC+ivUU8mx/+yKALoBIL984U/ng8Q=;
        b=ri2kROF6gVCKUB2o6O2DD9vL9l5p4iWkjmQhKGsLcQoWUXYY4fFB51NifCuovhm4qu
         fpIbuRLgmPgemyZEcwzzdPmywBPb52yl6+I8COsxyF4URVZwemgl6ghiatrsl0UdqcC0
         /GMBQrI4lcJh1tjVaj3y2ty1pDKAJHlpTS/EVXuUf5eax04VWvSFLU/iEX7CfZ6XJMWI
         wBl2T6mRv8M9FNatWv1m25MKvB0EJjBbfucUxSR6a2waEZl6UaiOmmkMISb02V5l6j0S
         M4upZPaZ5QfpbrMLd6zeLcMdJgUmSSe93KRwU7seu/iDAR6gE1kZhAtaG2Zu09/YXEwx
         9DRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NA+8v+xy91ArXchC+ivUU8mx/+yKALoBIL984U/ng8Q=;
        b=jzL2Td2R5IQ1R53iAMkhYCGs6QsmAnw17uvqv3RKje1vyfcXFrhor3JDzNQQU91eOx
         03stp4bQD4UcUAXyMgZPRkl/M68wuvtr86s6khD5UYHBX0DX+KWzP5V5/QlVy5nv9teX
         7NpdCwjcVikagRaB/zG9VpA0bOWAh9WBcFnGgWBIAhXaIbois9Xs6PniKesBAhptv+hh
         v6pIqWTTGoDaN37sGuQvW2SGNAGXz/tdY0y4ZpInzDmQgjkZQCCfiHjvzeFKlGMbbkbb
         IIJK0/F4nAD7khfP3DSvR+8OV1p327I3R3n1BRndD0hvMqMkKT/23YxD4SgV4eZcm6fw
         p3/A==
X-Gm-Message-State: AOAM531YM7sU82vqXhzLK5h/zVaHnKx0PzRleo42rdg70Ob6D/xgrhJz
        r+QGv161yDQ83iQZoVpYGVpuj4Asl6WjvQ==
X-Google-Smtp-Source: ABdhPJyY3PDonMqUsCzRHtcF+0qPbX+IzO888xqOtT2VYP3UroLcxpWsOZt5affHvcs+NSjswdXK5w==
X-Received: by 2002:a05:6a00:c2:b029:2ee:9cfc:af85 with SMTP id e2-20020a056a0000c2b02902ee9cfcaf85mr375494pfj.78.1623253367140;
        Wed, 09 Jun 2021 08:42:47 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id f17sm192689pgm.37.2021.06.09.08.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 08:42:46 -0700 (PDT)
Subject: Re: [PATCH 1/1] mtip32xx: remove unnecessary oom message
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-block <linux-block@vger.kernel.org>
References: <20210609121958.13992-1-thunder.leizhen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e7fab4d2-c1b7-cc61-a278-ff063f01571c@kernel.dk>
Date:   Wed, 9 Jun 2021 09:42:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210609121958.13992-1-thunder.leizhen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/21 6:19 AM, Zhen Lei wrote:
> Fixes scripts/checkpatch.pl warning:
> WARNING: Possible unnecessary 'out of memory' message
> 
> Remove it can help us save a bit of memory.

Applied, thanks.

-- 
Jens Axboe

