Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA54C49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 14:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2A720650
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 14:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mKNgvD5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfIPO5W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:57:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36185 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfIPO5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 10:57:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id m29so159488pgc.3
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2019 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7WUNnN9yv61rt6RXUBjyfgyIhNh7aVIJr3pGT7+CnMg=;
        b=mKNgvD5so4AGdkx4mkBeWTYa3r8Fm5dmfCEXgKPu7EOkmrzxT7SeJixToGX/PDai4z
         PouMD+FWY+yLUMyOnetznsuFLfVrdDOHmf7OnhLqz+RCOE8ocHaVL1wk9omdhs9qr7Po
         vTaFA6I6q/F1r1UCPaXjijc0UxP1SDYt9G7vxE1QWGns0SHQYmPCjyJusHH8/UdoI7JK
         daPATNGa6VHYDv7y2HbTRIjiFtmfeezD8xkQjAAT5Q5ZuQs99DgswY33ufxkh9Dc3Sn8
         6e0wkKeYk+/j9ilKR5lmDxSC3zqXWP8LUPWmxqKMnb6XzYAUKz6XfQGSojk9MnLAFVc2
         DbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7WUNnN9yv61rt6RXUBjyfgyIhNh7aVIJr3pGT7+CnMg=;
        b=gN+ZybVGkOq5hRLO5sv2EbxSZ3QKvas6CE+58lYWD13jpqmlgNM5+zXkQH9rzF13ZV
         qzTzUCrn7mS6fckTCh0hdYhY4+fPjZpJ7OWbKzuUu/MqaWeL7uVw5050uccbxniCZt8F
         BCRyUwhjNo4QXrzXZNfbUftpmggrIxpjRu8dzOHCVzVs25xcTntqkrhST6W4cFJ/5KwI
         Yc7bh5G6vSX669m+R7uxcf41spJs/CXTs2YYUVgXs5HIf0ypWDnfp+lM3OS16Sb9yHce
         wtiYoxzJrgSrWn7XMIBpL343eh80FwnF5dS+45sJJ19nnQJnn+7sfyXhF+3pFueg7GIf
         l8Jw==
X-Gm-Message-State: APjAAAUStBe/nDwXve7Zjn5BNMlV2X7FtqUERkExgI6hPm7Gr2M1nhQy
        g52USk9MpPjmRde/bqlIh3ri2Fq9qL9cyg==
X-Google-Smtp-Source: APXvYqwNJ5iLvpSHH/8GfUPkCJnmc9k4dCLIT6kuDM0OHFDEjWpwYV02cv4diyjelI9+gIvh7UMqvQ==
X-Received: by 2002:a63:6d0:: with SMTP id 199mr25066981pgg.299.1568645841195;
        Mon, 16 Sep 2019 07:57:21 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:30f3:8cde:93f5:74f2? ([2605:e000:100e:83a1:30f3:8cde:93f5:74f2])
        by smtp.gmail.com with ESMTPSA id b3sm58303667pfp.65.2019.09.16.07.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 07:57:20 -0700 (PDT)
Subject: Re: [PATCH v6 1/2] block: use symbolic constants for t10_pi type
To:     Christoph Hellwig <hch@lst.de>, Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-block@vger.kernel.org, martin.petersen@oracle.com,
        linux-nvme@lists.infradead.org, keith.busch@intel.com,
        sagi@grimberg.me, shlomin@mellanox.com, israelr@mellanox.com
References: <1568493253-18142-1-git-send-email-maxg@mellanox.com>
 <20190916075151.GA25796@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7465169a-dc9d-ae72-99bd-204e7402c279@kernel.dk>
Date:   Mon, 16 Sep 2019 08:57:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190916075151.GA25796@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/16/19 1:51 AM, Christoph Hellwig wrote:
> On Sat, Sep 14, 2019 at 11:34:12PM +0300, Max Gurtovoy wrote:
>> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> 
> A little bit of a changelog would have been nice, but otherwise this
> looks fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Yeah, please always include a commit message. There's always some
possible explanation, even if you think the title covers it.

-- 
Jens Axboe

