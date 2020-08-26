Return-Path: <SRS0=3AMJ=CE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC0CC433E1
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 17:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B52206FA
	for <linux-block@archiver.kernel.org>; Wed, 26 Aug 2020 17:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WYmR55yG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHZRUA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgHZRT7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Aug 2020 13:19:59 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA20C061574
        for <linux-block@vger.kernel.org>; Wed, 26 Aug 2020 10:19:59 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t4so2474565iln.1
        for <linux-block@vger.kernel.org>; Wed, 26 Aug 2020 10:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nPOpArgg8BEM4WcAMaAY8n7kJiGGBOMjfsuVZ0rNYVU=;
        b=WYmR55yGgoc6ihgD8E60IbpgFHVhbbB0/Bt1rIPhbFcPL2ppwFTBRCXdakdkb3+IDU
         CP9uNi/rSVZjuebpC2sCtI5Kk76FfbZlNfdXpIX1RE5pGZi3iw/B+3UbICAQXV26MfhC
         up51gJ9yQaQq+FSaZubap+bjemi5s8h5nHoaDVaxEASv5OGlY0QO0zWwAmO2Mm1sfgfB
         5kSQInRJdGNmy0pq2WREguylnMXq+3U66zcXZQWMw8ABuSyq7vPcp+LoWGjnH9NVEgoT
         1Mf4sfb166MUaGVJx2oqC2v6VJ9ZpRI3MCG4YYzKaKSWS2dlccm17rvv/DcIdTVutf4K
         TYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nPOpArgg8BEM4WcAMaAY8n7kJiGGBOMjfsuVZ0rNYVU=;
        b=GuI7x46Ene14ITssl+gAphDcqfCFEasht3jooQHMyFIhAr2DpHQaGJV5EGqqRUMO+6
         RSEvlQsqUqadXWKEakOX1gN5VnvPm+7HzkY+ZWKiJONVqM+M+wqJLcJZ8402cLLFfcPw
         hS5IvsGWpwOHhanW/blSHpMqYWd4JlmCE8NSA1cAg6ntuR3vzEE4a1zrk3Z+CsWhL8iW
         ClHqxNqzD8kZTddaFsSambIF59Qauso+XfXX+Ha70z01n7ulr7XYu0aVid0GqHBMmpGo
         jKmqDZcZng9MqCNBfkZEANkpPZpImepe/SgefCcGQs2LKEThiGe4XhUqH1zFM8/DxZn4
         sD8g==
X-Gm-Message-State: AOAM533EUDPDyeTx3Fhsvw8mUr9h4ba8cVuHlhZ9+t4WTinpYQ1Fhuno
        DY/GfCzD2VcN3WSBl/fwtzV05w==
X-Google-Smtp-Source: ABdhPJzau4gHHMab25lEvZr7EVyfDPq1GjNHEbUznteT2aJDamP7msj0jUzhBxblJvY56KwojrD7ew==
X-Received: by 2002:a05:6e02:670:: with SMTP id l16mr14300123ilt.52.1598462398400;
        Wed, 26 Aug 2020 10:19:58 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m18sm1660885iln.80.2020.08.26.10.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 10:19:57 -0700 (PDT)
Subject: Re: [PATCH 1/2] block: Return blk_status_t instead of errno codes
To:     Ritika Srivastava <RITIKA.SRIVASTAVA@ORACLE.COM>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
References: <1596062878-4238-1-git-send-email-ritika.srivastava@oracle.com>
 <1596062878-4238-2-git-send-email-ritika.srivastava@oracle.com>
 <20200814062620.GA24167@infradead.org>
 <C6F86C38-BE29-422A-8A57-5144E26C4569@ORACLE.COM>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <de5c94ec-9079-22b7-bbcd-667f3b0fe94e@kernel.dk>
Date:   Wed, 26 Aug 2020 11:19:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <C6F86C38-BE29-422A-8A57-5144E26C4569@ORACLE.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/26/20 11:03 AM, Ritika Srivastava wrote:
> Hi Jens,
> 
> Can the following patches please be applied.
> 
> [PATCH 1/2] block: Return blk_status_t instead of errno codes
> [PATCH v4 2/2] block: better deal with the delayed not supported case in blk_cloned_rq_check_limits

Can you resend them against the current tree? They don't apply.

-- 
Jens Axboe

