Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C17C4363D
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 19:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858DE2396E
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 19:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xwxK5ECW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgIXTnQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 15:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgIXTnL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 15:43:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FC2C0613D3
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2020 12:43:11 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id z18so437499pfg.0
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2020 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0pg1j0ofJKNNpEt0mGcC2+CXyH96ithZ7yyocaMNDVs=;
        b=xwxK5ECWmDB6ICV7/eTNjmWNSMSeFEHWOY3cJpGFNy67B0STEoUtARZtWDPoWx35v5
         70+xKNICk3DBjDcr5mnHKhmdnwgbNxz9RBgKQWJ19a8d9aRAIPbIij3/K+Q546A0qn2M
         n0gz6fyga5pNw0jbWB6a/QOeKhoxbc8sOZTtRIfcYOvryEwH4yrUFz1RnwaUDX9+iYNt
         fPriPHGt34UW3M6QpRUBuenTXrb9jTxWZFt9XdIWfTZZ+JD8LkAmSRkcurWgJJsP7l51
         qfcRtL6sa/kfKdWJKD5tQ4WzwSPy2Plln3EU4bie0uRlexo2slzSUN7YWUQnDbWyMEUu
         vBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0pg1j0ofJKNNpEt0mGcC2+CXyH96ithZ7yyocaMNDVs=;
        b=Qaad3npxmapdh8Y7i2u+h8uQsdDlboteDTREMGo23jESLaN7MccFsE4iSOGr8NTmpc
         vWuCDDA8dgy6G2zMiO/Kffx9niNgWdzZUXx6xxkcDhfsKFpMXmuelIqqn8RH8UD3RXpD
         BBss/bYXJewXIEMGC2if+tYzte6BKPnEXGMct6PhxMLAFdPGAlqT7eCmqrBxTnOM4oLA
         MKPcTjk80Frj2qiFj6vWhkQXmtr3RpJv2pgA9jt3yqZPZFAzJw1n+4QTkRgTdf0U1IZl
         QvpBUkwnYF1/Z5TIiLU4lT+jEpi5k/N+oQcb8FgXWIFhL3VJ/YC9oe1M+f7ixhY62YHs
         iuqA==
X-Gm-Message-State: AOAM533VWlIh/JvJnJ5Qp9K12gIjt1XUO0jKWt6NTS6vxQ+q3Gim1ws5
        Hgrd+OpecIHaTceghst76YUc8Q==
X-Google-Smtp-Source: ABdhPJy9N9H9JEyJ0eiaM+CQUET9Yi9UTrzcy8DMxeCwem5GeknDHLYVRALggZa4bGcdlw9KxCOXng==
X-Received: by 2002:a17:902:9697:b029:d1:e598:4001 with SMTP id n23-20020a1709029697b02900d1e5984001mr721580plp.59.1600976590983;
        Thu, 24 Sep 2020 12:43:10 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21d6::1911? ([2620:10d:c090:400::5:d63d])
        by smtp.gmail.com with ESMTPSA id z4sm260011pfr.197.2020.09.24.12.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 12:43:10 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.9
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20200924134654.GA873840@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <930dee00-e995-cdbf-ff15-d91820572a28@kernel.dk>
Date:   Thu, 24 Sep 2020 13:43:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924134654.GA873840@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/24/20 7:46 AM, Christoph Hellwig wrote:
> The following changes since commit 4a2dd2c798522859811dd520a059f982278be9d9:
> 
>   Merge tag 'nvme-5.9-2020-09-17' of git://git.infradead.org/nvme into block-5.9 (2020-09-17 11:49:44 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.9-2020-09-24

Pulled, thanks.

-- 
Jens Axboe

