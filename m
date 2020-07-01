Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FA8C433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 15:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 203E220702
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 15:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kezLch5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731711AbgGAPDG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731253AbgGAPDF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 11:03:05 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F32C08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 08:03:05 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id m9so859511pfh.0
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 08:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DLRduH9xJNt7ZS9P5WDmrk008CJ1C+7CjcjdXETEcJI=;
        b=kezLch5rrUi60jG33nK70y7LUB9APA6FNV9IRRpYujLnZiD6cgah+HbUs5mxIVB3Iv
         UCsyTT8ewKxA4aQ9WmcpJAEAqnKr+qbPdFyQPM1BZ8cimAYPwHUxO9C6q1YELSe4Mq8Y
         7aeGcm+RhHCl3kkvvdrMo7qf3qV0xpDO1KcOzmkzLVmwIQWZmdaTfsayNwujOipjjnbD
         EyQQWqC7onLnNpw6QJYDBSyn6hKRt/Lsi59zDlXC3VjXhnBKJy/LrRCr8FhIfendn6Uc
         loSWUSrzx0B+45R4DZNJERZhlrS97WEWdTSzmW4IxKxa87GBpg2vsViicTE5LNVGB1RP
         g82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DLRduH9xJNt7ZS9P5WDmrk008CJ1C+7CjcjdXETEcJI=;
        b=NZhBT4dYGLwCXooAFR5EI/UghGfErGmODc8McYDiMnTjcbpMVEGFwkyuFTP1k2DruG
         e39PIrfOfqbBH5gxHdaMdhhq2sNHU/KFNszav15Cq0LfT9/FSjAay82fnaLbwYnGW94k
         1tofcLvsO9b1HFDKXluZrmoYAfYnrFWpfzsBuPDt/zMkVVDd8P7rP0covKa+KbM5J83K
         H0seq3GrfVP4kYsFiaHN4LrCxcGQzXqIY4dRn6VLsEU1MOqSSM5Pb0FHl5WLTCjUl0Qw
         aQPSYc3F0PxlE8P5v/vjWHJwWOF4L2Ao6rW5L349zWPzDnlPEEeoPUuQfcC141tS9rj1
         nM8Q==
X-Gm-Message-State: AOAM533XDPBSKBIf9vINq2EedDg8LEdDIn0JWF5IIv0Axq7Y2osu0kIz
        YDJ6/8xUV4drjxHNKRm7LekHhg==
X-Google-Smtp-Source: ABdhPJyEMQjmd4pVZ5/DiX5oXot2zrsoeDUo/MeGVueczQlp+jKJnQA3AfgeveMKyiC+Dq6CQ0urmA==
X-Received: by 2002:a65:46c9:: with SMTP id n9mr19427865pgr.89.1593615785237;
        Wed, 01 Jul 2020 08:03:05 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:b704:bacd:526c:5cf6? ([2605:e000:100e:8c61:b704:bacd:526c:5cf6])
        by smtp.gmail.com with ESMTPSA id e5sm5355655pjv.18.2020.07.01.08.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 08:03:04 -0700 (PDT)
Subject: Re: remove not needed fields from struct block_device
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200626080158.1998621-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2ac39125-7b19-c692-24eb-6810d78c94e8@kernel.dk>
Date:   Wed, 1 Jul 2020 09:03:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626080158.1998621-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/26/20 2:01 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series put struct block_device on a bit of a diet by removing
> fields that are unused or rather pointless.

Applied, thanks.

-- 
Jens Axboe

