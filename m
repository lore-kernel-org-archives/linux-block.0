Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674FCC433FE
	for <linux-block@archiver.kernel.org>; Wed, 22 Dec 2021 23:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344129AbhLVX5N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Dec 2021 18:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbhLVX5M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Dec 2021 18:57:12 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9D2C061574
        for <linux-block@vger.kernel.org>; Wed, 22 Dec 2021 15:57:12 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id f17so2961707ilj.11
        for <linux-block@vger.kernel.org>; Wed, 22 Dec 2021 15:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=ksIioGq7KyW4HwAMxNm7/fq+qcCFuMQvcVGncdn/2s4=;
        b=pcsJu2vYmhbnYQcIVbVfzEw6sWQdnId6qYrCPHKBGR5ZqJ44YKThy4HgESlQA/Nb02
         Do1mYpQspKLRarLrNJDKpiwGDNlPEMkjryuce9u7Nyhoj9tQr5/1b6cLPBvklqYEfiKv
         1t8kxLRMK95T+1Qb3BiFtrL3lE4raWdit7recWvbfnnFnopI4T50bPcEbThcccpRhTRO
         rokweafVy1ifc3xfcVYxDUG2BO6tSLzhb4TKaftQkLS/CxBxA+CT9CN0PZZ+gOj8TziN
         Y0SOE9jQSmlQwhSU58NWSywB9HbxUWzMvsgQwzwGNNmMpwmSHY5ICkv8MXr7Ly3ciFCu
         Ud4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ksIioGq7KyW4HwAMxNm7/fq+qcCFuMQvcVGncdn/2s4=;
        b=M0NgmJ0x5womLC6AnQv8E4Qrmyajuq5QTnDe7805b1aJ5ueXSz49klsjzXxoCW0jQ0
         VFdyf6+f3Ws85zuxozMG8pyQ5KUfVTAgU+YfRrXcm7IIb1LzWsIXvOzIAIvAcXDyQBO4
         93dS0G+uWF7ZVNxUk1zLfZra4MMqd2sdpUYyFGiPjIl5ZJ89ORSBxe0XOR7Vf9TKMMOJ
         b6msU/5mAaaiSebPY0USXK0WukfdXlotW+DybeFPor9yoPMe/i4xOhPrAaAiX6iEfkNu
         p1ziMdUPIoBSGOlwP63YSMiuAKwby8GdZKyExUY/QWKPzAIQ5YJ2IxQhKJUpLiCDtu33
         QhFQ==
X-Gm-Message-State: AOAM530qWz3zBr7D6Yz+fvYJG4unK4o2G+9drmPeBfUSkhlAp1jJG4lj
        HZkYqISTartaCETWnaNO0+acf2+7YNrgGQ==
X-Google-Smtp-Source: ABdhPJx5A7b6m3lJSbydW+/MUSx8fNdHy3qw+3Nkgy3uYTNjkyjH9fdWWejd1MzEUcJuRXp8i2tMeA==
X-Received: by 2002:a05:6e02:1b8b:: with SMTP id h11mr2561419ili.14.1640217431816;
        Wed, 22 Dec 2021 15:57:11 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id f11sm2151764ila.17.2021.12.22.15.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 15:57:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org
In-Reply-To: <20211222215239.1768164-1-kbusch@kernel.org>
References: <20211222215239.1768164-1-kbusch@kernel.org>
Subject: Re: [PATCH] block: remove unnecessary trailing '\'
Message-Id: <164021743111.720001.8149569508323760461.b4-ty@kernel.dk>
Date:   Wed, 22 Dec 2021 16:57:11 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 22 Dec 2021 13:52:39 -0800, Keith Busch wrote:
> While harmless, the blank line is certainly not intended to be part of
> the rq_list_for_each() macro. Remove it.
> 
> 

Applied, thanks!

[1/1] block: remove unnecessary trailing '\'
      commit: a16c7246368db8935652c805bc446928d0e1c0aa

Best regards,
-- 
Jens Axboe


