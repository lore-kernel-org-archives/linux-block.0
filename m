Return-Path: <SRS0=14Po=UQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D121C31E5B
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 15:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BAA2084A
	for <linux-block@archiver.kernel.org>; Mon, 17 Jun 2019 15:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SHsRbr67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbfFQPjB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:39:01 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:38208 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbfFQPjB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jun 2019 11:39:01 -0400
Received: by mail-yb1-f193.google.com with SMTP id x7so4639809ybg.5
        for <linux-block@vger.kernel.org>; Mon, 17 Jun 2019 08:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+IOqVhnkjpm9RzMd4aZH4v84yZFIc29QIZke3idWUTY=;
        b=SHsRbr67bgYcim0xfNbgTGOdM6IF8DcqX2il5zqhQ6MBEOAydVdoXspCTBGRRRluVi
         xzKr1Q0d3spPbFf0uk+DQT4gBd/rEX1JI/pCF/W9LxuZP/V9DEwOXoTnFb0+iACAVMuU
         JV4bXXPgAVdYZGRVdNj83hZztzIasw37IQocG+Bo2nFcXUZMKfS+k4bDuiIBWREVbxax
         PrI4IKKe+bkaiy8whuMNgT4CobO363JxeNbQOTv4akJJ2etoOWGIgVpNh5QDiA8s+77A
         NTD3D5gLH4xpZoXDmjmz361HP/Gk2o0X/BfzsrD9nBGHiXQAwAStW4dGBabH5Msz6i0I
         4gOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+IOqVhnkjpm9RzMd4aZH4v84yZFIc29QIZke3idWUTY=;
        b=FNOmC4eR/iKXECXjTeoN41jwc0f9z7IG54cTsPz99lxTgXFE/eXNEOv/BBdw0pFnI1
         p9bJ/9oRSOHCIghwwmH9HefjCGyEJL4DQCLbZQOd+EsbT2goMN0VZSTnP9jZS+imSXNP
         91uqjV7wVSEH/2ryl7qdKcLAxsmTPOK4IDFUPXOKewDhlxlwXid9nOJ5fbvxo9SCNBYT
         wppqof2yi04CkVh3GHWYAhOb5LLI6gBrsk11xnHyNmqKFRQtkDRuJC1wDvQN13T85yQF
         q/R1lZ6QFHBwvgISM8g4jUNhIN8cMNxkST/QZsBWuQKenjtWkwKUs6+5QmMduyi0sumo
         aKtw==
X-Gm-Message-State: APjAAAW2FSLFQDQr7mC0rp3BSakEtXoeQg8K+ntlcquHzwgI9f8UreeP
        82g/5kHUzirqMuisIUjTycavMYakr3onQQ==
X-Google-Smtp-Source: APXvYqwUW+vJR8duC/JZEEHFTmIxa3VLX09rbIbYfJn4MoB+E+XYoQXbSW37fY0q85544eY4RMo5sw==
X-Received: by 2002:a25:374a:: with SMTP id e71mr17573298yba.214.1560785940007;
        Mon, 17 Jun 2019 08:39:00 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-172-57-228.mycingular.net. [166.172.57.228])
        by smtp.gmail.com with ESMTPSA id k20sm3315858ywm.106.2019.06.17.08.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:38:59 -0700 (PDT)
Subject: Re: [PATCH] block: use req_op() to maintain consistency
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
References: <20190613141421.2698-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ee840e6-078f-ebbb-f97a-0ffae36de5fb@kernel.dk>
Date:   Mon, 17 Jun 2019 09:34:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613141421.2698-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/13/19 8:14 AM, Chaitanya Kulkarni wrote:
> This is a pure code cleanup patch and doesn't change any functionality.
> In block layer to identify the request operation req_op() macro is
> used, so change the open coding the req_op() in the blk-mq-debugfs.c.

Applied, thanks.

-- 
Jens Axboe

