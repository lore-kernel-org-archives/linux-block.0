Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFEEC48BD6
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 13:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2FB208CB
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 13:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="clNJWqZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfF0Nez (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 09:34:55 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:37713 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfF0Nex (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 09:34:53 -0400
Received: by mail-io1-f41.google.com with SMTP id e5so4761705iok.4
        for <linux-block@vger.kernel.org>; Thu, 27 Jun 2019 06:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xW7kEJ6eT2Wxe47UXOLsr1YciNDdGtLCt/6Oq+zqrRg=;
        b=clNJWqZoXHKhHqVZySJspZGOTfLzXgRpNvYGhQKDmeLde6TUjQtsEkYj4aMw516lcB
         4lkKGRptkb96iAL9brl0ES9JSmUx+AGBy6T0RsBCCLx3o0JiX6fxdBs7B+dziuF9TAoo
         wYB7yJHUQDazHKed1xGt+2dZbtBm0xBBmKgin6d+4784MLXJ0FKagXtv57pYNviq1b5b
         TTXjig6l75mncSgpQL5iOVMEVghWb/MpWCZyDjN7B13lszgu3F511GizHICZtn3tc/si
         dUjE4kltgWRvIfC2Fk3Vd8xnYyhV7wgAZOOp0wIv+vF3C4bpLXpc5O6PPYSYEcQeyQQK
         q1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xW7kEJ6eT2Wxe47UXOLsr1YciNDdGtLCt/6Oq+zqrRg=;
        b=F50RGhb99EpMCR4LlGLlD8TmvejH9IMSLw78UYi6r+amLXbjOMfPkDQJFW8NRW+UGn
         1aJSiyETGeKlhuPNQiC/HpCqMGNxty/UYyfOAd27uonrwRKq+9pffuMET/bZAREGgHTw
         rPa2DncmOSEBiyGE/h3RSrjfLuqZ2W3qB/Ktbg4RsP1wsjD64GY0yhf70pNxJnbMnedQ
         eJm47RIl835aoHhL+n/+Am/Y9jsg5itoZgoCDCXi9UODCrCOWAhzRsv2PpoG6aD2iGjw
         3t+HevJz3dGrQ11PEj4yPGpgtoOnq9Thz6PODCe25/gmlUtL7x98Igz04srycp37bPOc
         07Kg==
X-Gm-Message-State: APjAAAUrerVqvNpgyB1Gae80+ZenEpbMkg1TFM1oUennz81NwKxB7qVW
        SB/rRAo3d4faD9e7X9RNjG+2S5nfgEaVUQ==
X-Google-Smtp-Source: APXvYqwQGj74K0xo6LU+MBgt9J8Fsa9tkgcV+GoqkLyt9NUirjRpbXU5uv44Z4U0xyexAN1Uget+OQ==
X-Received: by 2002:a02:54c1:: with SMTP id t184mr4922209jaa.10.1561642492295;
        Thu, 27 Jun 2019 06:34:52 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b6sm1550660iok.71.2019.06.27.06.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 06:34:51 -0700 (PDT)
Subject: Re: [PATCH] block: Remove unused code
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
References: <20190627025941.32262-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ca822c86-7b2c-0737-40aa-13effd161f8a@kernel.dk>
Date:   Thu, 27 Jun 2019 07:34:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190627025941.32262-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/26/19 8:59 PM, Damien Le Moal wrote:
> bio_flush_dcache_pages() is unused. Remove it.

Applied, thanks.

-- 
Jens Axboe

