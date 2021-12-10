Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EA0C433F5
	for <linux-block@archiver.kernel.org>; Fri, 10 Dec 2021 04:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhLJEfj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Dec 2021 23:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbhLJEfj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Dec 2021 23:35:39 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BF7C061746
        for <linux-block@vger.kernel.org>; Thu,  9 Dec 2021 20:32:04 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id k64so7360811pfd.11
        for <linux-block@vger.kernel.org>; Thu, 09 Dec 2021 20:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=o4utMKsAD4+lDfqffsHB92w5ky25vFSj2x9h0rnJxbM=;
        b=ZQ6nUYUWj45WnZEBH9THy1ZOfYNF5uDb/Gm9U6epKXMzzFdmEaJpY7kIhEH3K8DqkF
         1E4507Fu/gfjs69Z1/QypmMmhS+RYuzVk9p9FghrixJpfaB6QBEeybRvq55/hVSG6EGh
         6iyynPPGlpX1FrxV38QuoVHyRNIxusE6lDNhW+3Xp4yorG/JZZ//MQWg0wdxAdV5ouuB
         Rj+zADu8Ns0Tqbje8pbyLVZirIFY/zlzLHfYv5ftm+24Dh5kj1JN2qybHHsjjiroOX+5
         gCePc2fprgLf56CbiF085YfxfKWn8ErJ+xJ4xpwy024hJV5aOIqitMacK/xyVsU7/6Y0
         S10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=o4utMKsAD4+lDfqffsHB92w5ky25vFSj2x9h0rnJxbM=;
        b=Ntw5FpYEo5BOiFXRQA2jFbLpvif669tBSOZ35kuXO6J2fPntOppMsOKTHFtw0dwlrk
         GbLfmLWe6UIhQ6Vh8awiVB8xOYrGMkBh5eL2+2/aMNX9BgAQdKImKyWnzi08lbCsjP96
         5x7ZyoxrtsQSLN9t86LJnWcKnKch0qguObNXr13NV5arPYQ+R8SxJ0OxvcNWyvFc5TS7
         2D2U24DE62dyAJxIVIIfTV5AWGde7cX6svhNo0Le1wA2epAfwiGAzrIPSlzrqV3EoEtS
         hesKjrDRoz7Wq6WPyNvnkGZhb6Gry36emWqWgDhBwJF+1cyEEmEQ38L7HCwh595vwdBG
         sqww==
X-Gm-Message-State: AOAM530YWoZ0vSXqQRtqQnpLNQs7kYEYEPWRRqpABwhur+zbx9Ra9uXp
        8HYXLBzPiA1HyXIGKoKEGMoo+CixHNfZ8g==
X-Google-Smtp-Source: ABdhPJwRsw58t/w5EjdSopIo9vKuV+6Q33Q979I1kPe56+/qs2GM2sv5T/WYGIiyv52awVgrruu0BQ==
X-Received: by 2002:a63:2c8c:: with SMTP id s134mr37414199pgs.221.1639110724158;
        Thu, 09 Dec 2021 20:32:04 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
        by smtp.gmail.com with ESMTPSA id q32sm1104068pja.4.2021.12.09.20.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 20:32:03 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, NeilBrown <neilb@suse.de>,
        Christoph Hellwig <hch@infradead.org>
In-Reply-To: <163910843527.9928.857338663717630212@noble.neil.brown.name>
References: <163712340344.13692.2840899631949534137@noble.neil.brown.name>, <YZTx/93/9cjYW4zI@infradead.org>, <163910839418.9928.16399258868028694519@noble.neil.brown.name> <163910843527.9928.857338663717630212@noble.neil.brown.name>
Subject: Re: [PATCH v3] pktdvd: stop using bdi congestion framework.
Message-Id: <163911072211.490552.3194609024939007082.b4-ty@kernel.dk>
Date:   Thu, 09 Dec 2021 21:32:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 10 Dec 2021 14:53:55 +1100, NeilBrown wrote:
> From afac2a88e6a256ffde7040c4191a2bae5df7f5f3 Mon Sep 17 00:00:00 2001
> From: NeilBrown <neilb@suse.de>
> Date: Wed, 29 Sep 2021 14:24:01 +1000
> Subject: [PATCH] pktdvd: stop using bdi congestion framework.
> 
> The bdi congestion framework isn't widely used and should be
> deprecated.
> 
> [...]

Applied, thanks!

[1/1] pktdvd: stop using bdi congestion framework.
      commit: db67097aa6f2587b44055f2e16db72a11e17faef

Best regards,
-- 
Jens Axboe


