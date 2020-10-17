Return-Path: <SRS0=uz0K=DY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D447C433DF
	for <linux-block@archiver.kernel.org>; Sat, 17 Oct 2020 14:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C214820756
	for <linux-block@archiver.kernel.org>; Sat, 17 Oct 2020 14:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="T1tIoroi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438281AbgJQOL2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 17 Oct 2020 10:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438243AbgJQOL1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Oct 2020 10:11:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5683C061755
        for <linux-block@vger.kernel.org>; Sat, 17 Oct 2020 07:11:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n9so3166231pgf.9
        for <linux-block@vger.kernel.org>; Sat, 17 Oct 2020 07:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=12Ji5Bjg6Q6+5eR/BATj6e1cUfsvLG8jGphkcoZtqEs=;
        b=T1tIoroiskrApvot4qmdEcSv676E9+PsPQrL8UIy19cwwPYy7m9Wf4CjAzcOuw/528
         9SDZFrfwYhXT1Gk/ps3UXn0i0esdabOCGTOHxBJCS13qdW7GnmcjzD/S6WZ9x74WNsEd
         hZ8Amf2RKauFD7DqiPnNFslTR6ox0JGb6NKieB9W+DKm5J7Wjm/OX5dCcpCzpkGJHHAi
         4XJVYurZoFmEH5krNbqD4q9y+Scw3K1SqJlACTSFUgAJ36+sFqdBcBGhvQPcsswnLxJW
         5lY1rV8czhvnffMOBV7hFLtzOSwykhvBPooA+cllVvAzI65cgogdBnvXxn1F/Mg/22py
         jmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=12Ji5Bjg6Q6+5eR/BATj6e1cUfsvLG8jGphkcoZtqEs=;
        b=uLTouT+uG6nL0z+jMZLV6VfqN5TgVX+HXntS58Qz7dMDzu2RbfStxJeW1Wj1s9jt9n
         LHnGbFJPq20a4zApIkupeLDUdjxHYNHJrhAMkG+ZHQnVkXukovRl1JFABNIbLYNBITc+
         2+ko/WGCAG5pT86Cw1L41Fuv07CDLMMwj/OMdU6RtiZZKQsYxNOcwL2+pjPRaVPQh6ro
         qZNv1B+MMu/PMekJ+UmLK4HeQigWTQ56Fk1jDGAtJm0TiVNvB9778AvYCooDhymffPm7
         ieRW7dBPTxnz7ivoqnWl28FmPKvyYPeTf9LHa+BEpfq6mB/Ipr0OFWKFSj9+NQ5Jw13f
         cl1Q==
X-Gm-Message-State: AOAM531HjXf870yxG1KTD0fXc8+eMe2hUXp4sFClZyPJ5dqH0r/yFAFf
        Xu44y1WRvZDV5wOGX0ZOoqazDA==
X-Google-Smtp-Source: ABdhPJwCzxxjLR6d5+9u+pKVZ98sOcfRf9TTR3qMd2Wvz49D6bWNcprTvFqEZf2k1myQVqjVb6PZcg==
X-Received: by 2002:a62:878f:0:b029:155:ec80:9658 with SMTP id i137-20020a62878f0000b0290155ec809658mr8501357pfe.57.1602943886134;
        Sat, 17 Oct 2020 07:11:26 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f7sm6170615pfd.111.2020.10.17.07.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Oct 2020 07:11:25 -0700 (PDT)
Subject: Re: [PATCH] skd_main: remove unused including <linux/version.h>
To:     Tian Tao <tiantao6@hisilicon.com>, Damien.LeMoal@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1602899549-8241-1-git-send-email-tiantao6@hisilicon.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c57d8f33-30d8-61b6-36c7-037211ad9900@kernel.dk>
Date:   Sat, 17 Oct 2020 08:11:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1602899549-8241-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/16/20 7:52 PM, Tian Tao wrote:
> Remove including <linux/version.h> that don't need it.

Applied, thanks.

-- 
Jens Axboe

