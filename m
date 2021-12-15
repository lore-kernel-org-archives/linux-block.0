Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0163C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Dec 2021 00:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbhLOATC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Dec 2021 19:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbhLOATC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Dec 2021 19:19:02 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9A9C061574
        for <linux-block@vger.kernel.org>; Tue, 14 Dec 2021 16:19:02 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id z6so19184160pfe.7
        for <linux-block@vger.kernel.org>; Tue, 14 Dec 2021 16:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1x03oaPkUEduYaXP+6bEK8BjeUoTKOnQMJBdvsxFtdY=;
        b=s7iTYnBsewcvXMzdvbRLsHNhEmWSah4Gqr4XiaG3Cjy7cdydp4STbKHy/YOXlDJKZv
         0wOeaKsLQ4pL36ocqatv6gcOJPeSonnf+cOw3S3MDFNbV9tum8jESNtM8FWIa3sD+z83
         xnY2hKPofDetZ84WKxPlr6i+jIrR4+QEzPahs3IUQrb/MrwVWqHhExi0oXtwlE/ePpES
         NhqiRRzkXsHzKi9mhPYWloqaECm4KrAd11eXJJKxP3w9/O+9D1p5nt/Pv1pgXDrQorta
         dIzPSd+LRp4TlFcu4wzM5pbmDJ1WpKnwd+FKRmCuzlBC+TOiuRyjOoAbHtGXJA1YroAW
         rhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1x03oaPkUEduYaXP+6bEK8BjeUoTKOnQMJBdvsxFtdY=;
        b=iaY+pOeQBv6EK9YZUtPW3u99QuLJ3Uz71BzYnvr1qTFPYxRPiytEdantF2lR73lGFK
         nohD8cnjqdPnqIbDvTwzS7jNMhKJxvfyQtLNd7yww6Q4VRe6Yr1Zf5JwIfjvY8Gops2f
         ZP3/dojsTZu+1BE9urJEppCUdnmsrZL/kHVW/OGJMCNtlXaIFrzaKgdIaeWwyQrsCoUE
         wGn41Spncyvt0Tm12+Kma9qo7WMUT60kQRP139DTy3y2nhXN0IqTPApRzrRhwfCp79UP
         Y4d5BBpLeP36PtP184E7HR175NHcowNm4wzbjqvO3JJwee3F3K61nRsYY58XAFfqjWdr
         4a9Q==
X-Gm-Message-State: AOAM5334BWcwsEgiz2BSaMdJeljT9PxX97qManH1sqZEYnCMmlpFSSkm
        G5lFs84PM28PngTMPvnzwAXPZ3WzVYrn2w==
X-Google-Smtp-Source: ABdhPJz3ZUnsHO86J6u4dpSR38i8MNEcmkgBcWmCTtminySn9DRzazSyBGCPj8W0InoXlLrMeH9jJQ==
X-Received: by 2002:a65:684e:: with SMTP id q14mr5850724pgt.378.1639527541546;
        Tue, 14 Dec 2021 16:19:01 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:9af0])
        by smtp.gmail.com with ESMTPSA id on5sm125883pjb.23.2021.12.14.16.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:19:01 -0800 (PST)
Date:   Tue, 14 Dec 2021 16:18:59 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: make queue stat accounting a reference
Message-ID: <Ybk0c4KT3JAj/h9h@relinquished.localdomain>
References: <d6819554-8632-e707-3037-773a6ee904cb@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6819554-8632-e707-3037-773a6ee904cb@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 14, 2021 at 05:02:57PM -0700, Jens Axboe wrote:
> kyber turns on IO statistics when it is loaded on a queue, which means
> that even if kyber is then later unloaded, we're still stuck with stats
> enabled on the queue.
> 
> Change the account enabled from a bool to an int, and pair the enable call
> with the equivalent disable call. This ensures that stats gets turned off
> again appropriately.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Omar Sandoval <osandov@fb.com>
