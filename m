Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAC2C4338F
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B98960BD3
	for <linux-block@archiver.kernel.org>; Mon, 16 Aug 2021 16:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhHPQu3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhHPQu3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Aug 2021 12:50:29 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE68C061764
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:49:55 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id r5so27580597oiw.7
        for <linux-block@vger.kernel.org>; Mon, 16 Aug 2021 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KT3fXKUUqCzl4dK6VaRt06FYoHrVvZPxKX5O2en+OEc=;
        b=O+7k3qVGOyNXUaqgzmL71X90fmswWMFdSuqEMJNd73YUdTPkWHIStRC9N8/hts21v2
         3+6BUfMBPmfOCnOR2BVBmsUFH+rhZdziCvAMZ1CWLBouFf18u9yKwitnD/zo/1X1jcct
         /lIie8NKK8Kfse9D/Q9kgKlCKoh97+TBpeN0SsL0npHnogSP/I3KxLh2nz8O/OCkBATH
         2OxPrtyGUCVz2upaE4U37x/yEkMsjSePR2T9+6YSWUgjX2KiHOGnOJIlfJSoxvR/FMnG
         2uSbWWTalhIMkbHWzpm93QAFtCrlS2E7GLaLWWJ3EVxrWSl+UpqI+ViZfNvMQ2sP8pPb
         xYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KT3fXKUUqCzl4dK6VaRt06FYoHrVvZPxKX5O2en+OEc=;
        b=b+RjcO6VOo2/pyNXUDuxohrNlUf6GtgiaplHWeZ/ad/AjJDK/cQELN+0wgYvfp9pfC
         SU3TFMgrngABpy1ANy2DhJxMwgN9aa0CII7Yp2t5CxitI3tIOSxIBkLQZ9u+FNeN9z60
         CLPcrlSHOFN20ducyahOYs3FN1OrlrMqHwNToaeU1qZnNTfA0qGxqgho/O0BFFony7U9
         38K9MoFwJMksj1XwtCbIl26X9OVrqkyzG3SLsuqi0jqFwvPiT17TEnJ1BB6ucarrI19S
         chl4mE57KfP4HFGeJn6vPuCoGV5Hxzl9Xui15zZ905CcSIEkzI4mw/JCZwkH7HpDiIMF
         7xOQ==
X-Gm-Message-State: AOAM532Bw6ltDAb70Z6Shlwe4yjSLSRH1fyJvXotjXaZVdE/+CVSgIh8
        9bHTtcRdZWNOCymB2r2NMjq1W+Et6+iE93Ok
X-Google-Smtp-Source: ABdhPJxTJy3C7F89ZhurqH28p6jHyIFxrjq1VSeBkYgtLQgztExqH5DogzzlgHez0E+xby2fpnVfIQ==
X-Received: by 2002:aca:3857:: with SMTP id f84mr57988oia.96.1629132594665;
        Mon, 16 Aug 2021 09:49:54 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k13sm2163861oik.40.2021.08.16.09.49.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 09:49:54 -0700 (PDT)
Subject: Re: bdi lifetime fix
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qian Cai <quic_qiancai@quicinc.com>, linux-block@vger.kernel.org
References: <20210816122614.601358-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87175a7a-2008-2062-3996-8e4443dfa53b@kernel.dk>
Date:   Mon, 16 Aug 2021 10:49:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210816122614.601358-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/21 6:26 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series fixes a bdi lifetime issue.  The bug report was triggered
> by the move of the bdi to the gendisk, but the underlying issue is much
> older.
> 
> This supersedes the ealier "block: ensure the bdi is freed after
> inode_detach_wb" patch.

Applied, thanks.

-- 
Jens Axboe

