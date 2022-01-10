Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FAFC433EF
	for <linux-block@archiver.kernel.org>; Mon, 10 Jan 2022 01:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbiAJB7l (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Jan 2022 20:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiAJB7h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Jan 2022 20:59:37 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219EEC06173F
        for <linux-block@vger.kernel.org>; Sun,  9 Jan 2022 17:59:37 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id l3so15534222iol.10
        for <linux-block@vger.kernel.org>; Sun, 09 Jan 2022 17:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=a6Ek9dyuXiPX9gOzlmZBEgmaLL6o1m8Ko/BGrLRTNJI=;
        b=WHG4B/lJ2zfwyuaTb099MuiAIEwYdk5EZhDb42I60AryeceNnrT5IS6kF2xnYEcP5E
         DYZxh6pDX6Zz4uCTBfSu+GxjX1XSx60zZqUw095WMvRffqOQdAU2ZTDT+kBf7QgLiJzJ
         99jUsGdglX7CdMofCU8sWUtMXWm0S3kU25imHnQcXrcwZ78MvYdo3tliAv7DQDzVtJ0u
         BCy97b9hoBWpalqPWuKEIj5bh3B9lmcQp/EFHGFUgpcae+qqLq92fZatZClKvFSt9hY/
         IL7VqWzcGUMUgnrPkmwK1rNcvpHziqrB2WXatH3FL3mc64UulPeVtfv5laenZB+Lei4q
         QrxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=a6Ek9dyuXiPX9gOzlmZBEgmaLL6o1m8Ko/BGrLRTNJI=;
        b=rE33rZrFtjuH7k8Jf2ngLQN3eAFTRAOAWNuOwTsv57fY9SDVGubYy52G69LtnhrKk8
         +UGXV5Qki3b7+MyuVVAGSv2ZagIGRPRVxi68mwenw7vxjvboU42QHK7B+rVRCh15ritI
         WzqToMxhYQAuxhuJYWYoVquXdZd/IlLjZtM9BFa2XjpNb+uRmkbhOmquFn1dsczAL9Va
         5mP0itw1i3ME2mUZAAp0j1M2rxOWQV36PfV+eeQJ3Nu7LutmY1Gx3t45U0ZcjDBhOKss
         /vfR26mDEbsesfp1Y3wWkSi4PlSFrPzIg2qRxI44LlXzly1AB86gCh8FbzEg8XQ4eSqF
         lx2g==
X-Gm-Message-State: AOAM532LcCgHeIW4xBSjOwcMwiOEecM8ug29rqsRw+sDu8fkLSmmB+Hy
        kfjr+TZKoin24J8QbHtDkWI2Km/s6EwJNA==
X-Google-Smtp-Source: ABdhPJzvyAS+SbHTzwvdANcv2tltmDW3z7L6PNawVDtZAasgvt5bpmBfaAOn96RZ+JuHTyfidvYI1w==
X-Received: by 2002:a02:8810:: with SMTP id r16mr33622895jai.244.1641779976313;
        Sun, 09 Jan 2022 17:59:36 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id q20sm3720873iow.47.2022.01.09.17.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 17:59:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220104134223.590803-1-ming.lei@redhat.com>
References: <20220104134223.590803-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: don't protect submit_bio_checks by q_usage_counter
Message-Id: <164177997579.87082.6682898488605311594.b4-ty@kernel.dk>
Date:   Sun, 09 Jan 2022 18:59:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 4 Jan 2022 21:42:23 +0800, Ming Lei wrote:
> Commit cc9c884dd7f4 ("block: call submit_bio_checks under q_usage_counter")
> uses q_usage_counter to protect submit_bio_checks for avoiding IO after
> disk is deleted by del_gendisk().
> 
> Turns out the protection isn't necessary, because once
> blk_mq_freeze_queue_wait() in del_gendisk() returns:
> 
> [...]

Applied, thanks!

[1/1] block: don't protect submit_bio_checks by q_usage_counter
      commit: 9d497e2941c30a060ba62d5485b3bc9d91ffb09e

Best regards,
-- 
Jens Axboe


