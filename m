Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396D5C433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 12:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1911260F93
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 12:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343628AbhJQNCG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Oct 2021 09:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245672AbhJQNCG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Oct 2021 09:02:06 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5926C061765
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 05:59:56 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id w11so12123513ilv.6
        for <linux-block@vger.kernel.org>; Sun, 17 Oct 2021 05:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lunQFRlncbllbXQWeil8QJ9NZRaIpK/43jLlPRnBMKo=;
        b=FJKg3uVq6GKz2851+RqGvDQtN1aJosoJYUWypacYSYMAPJe8kWfIHZOLM91V6HDSud
         3a+t4V8awzzC3O01IH3h1C+DmkAx+2l1dAtOiKg36DDACYzy8927a6meYoP+hpyakv9q
         L73ZCIBdhGKYniDHOQC+2y9DpKM5JsJdxipz/jMEAPY86VqGQHCIWhnyXYHL5t8Lnr9v
         GqjaE638YdUfL3Zr2AnzDU5B7CpFS8MAX9W+tTmeYEi9B202OtZdTfu6wYu1JGjxke/k
         FByrRNi9H5VKMztdmckKY/V3tpZqzAi6Ed2mr50qkxPTJTiblfrtD6/aH7Br8shh1ddm
         mA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lunQFRlncbllbXQWeil8QJ9NZRaIpK/43jLlPRnBMKo=;
        b=ZIuHpdrr5XkT33neC68p1A0dm70kjgI2ZniicGz9oTbq3F8meHV4ncPEllQiznSU2Q
         25eEib5/drZDTNHTeVteskZCbf7d2VVx52OPbM/pEepKqT+0l58TIn3zoE0Oysp1o1nG
         N5LN+/AVa8b5YYMvf1aOEZTHnmFscba0RdZ5Z7jGCMFS2FFTV9QqIQClhb4UwOPqp/4k
         lOP/2GmRXiFuY0H/mtskR67SLxjkb5aJ16TRLwozwH9iu4aPEI+rLNK9ctqzOoxzgY6o
         WEFqr24XxETRb1LuHluEnPjtZwuU80RYG3+O3WX298+RmEa37nhPXHRW4R59OOs2L//E
         Xy1g==
X-Gm-Message-State: AOAM533OC9OZHl2dh+6uuY8y/FjZwakP361SDbdnjxf6nUGD7hXrP6DK
        2Hc30sRg3FMJ4fFHIV4bUbKgbA==
X-Google-Smtp-Source: ABdhPJzb02HPbz5Jm2Yjt/GBE/FZYjKYwiKp+30dZkqTUiH5P5RIdQEm9MHxvidkTXqtosakWznXTg==
X-Received: by 2002:a05:6e02:120f:: with SMTP id a15mr3192090ilq.109.1634475596022;
        Sun, 17 Oct 2021 05:59:56 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id h5sm2534531ili.12.2021.10.17.05.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 05:59:55 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: warn when putting the final reference on a registered disk
Date:   Sun, 17 Oct 2021 06:59:51 -0600
Message-Id: <163447558819.89398.2379548063287854869.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211014130231.1468538-1-hch@lst.de>
References: <20211014130231.1468538-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Oct 2021 15:02:31 +0200, Christoph Hellwig wrote:
> Warn when the last reference on a live disk is put without calling
> del_gendisk first.  There are some BDI related bug reports that look
> like a case of this, so make sure we have the proper instrumentation
> to catch it.
> 
> 

Applied, thanks!

[1/1] block: warn when putting the final reference on a registered disk
      commit: a20417611b98e12a724e5c828c472ea16990b71f

Best regards,
-- 
Jens Axboe


