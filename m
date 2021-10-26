Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24F0C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 23:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32ED610A0
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 23:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbhJZXcj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 19:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240288AbhJZXch (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 19:32:37 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78EBC061570
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 16:30:12 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id m184so1449819iof.1
        for <linux-block@vger.kernel.org>; Tue, 26 Oct 2021 16:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=cPhuy6ccl8STzBc0f2qhy7b7PzjyI+kqGNsRVjQZdwo=;
        b=KBkKbm1xg7w1DVUc/BhDxFoDtVAJnU6Z+t5fZXmcGAszatRUYuyVckrUYv29UHwnJu
         Vl7o5iINponKVyGDlWfX81QO3nqf8sUxi67Qfq3nBW115HMiyRRxmqgpybIUIVt0n955
         RtYC9D2OBS4a9/ct+RBorg9hQLoCxShIoi97jaZZ0Cgvp/rGwz5C6pPPQr77wCHICfsD
         zA8vh9PvnNrtpi/uINTgOOMDNwk4Ywtaw9FGNXM0YwoHHqqfZz1yefSuGchJ573JZYVc
         xCHZh67mDl3fkItC7qLUSEK0KfYC947xRTOr7InnyW2ZJqKYSWpCe9T7R8gis/49yNRu
         HCAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=cPhuy6ccl8STzBc0f2qhy7b7PzjyI+kqGNsRVjQZdwo=;
        b=MrEq8KYeMtcb1YM0N2+DnkmhhILwDszyX10dY31Hra+/wPO5zSsaeF6vlE7MX5wTOc
         LFFZ73e9KQ9+LVyDJuaNJWFyc/Y4uLfHLbMqGBXx3fqlh2nrYhPlHakBFtAgQaowJPeN
         Jls/oNfjFsbq7ephsnc3LWbc4u6lUkgu/ttO3oRJM+QONYxO2pIpFK6qcvYLbnfe860s
         e1MvK/XYLhgiTLmaXxzIHzA+8dAv1eJht/P6G4GWvH13JZnnv3PyIYJ5fjXqUDfxLJW9
         dXokmnSahM/rWk1eZDHwoPamEL/FcJhObCwlf4qtSbPW0rON76wFb/Exq/QazvwLh2UF
         jMJw==
X-Gm-Message-State: AOAM5308JcNe3KknNZVZIKuQu1DYb3qyk5giXXbPFvqhUpRt9n5b72pW
        lxxHT7SzJhPmJZ5Xpm+VWNAu6KEZUmop6g==
X-Google-Smtp-Source: ABdhPJyyud7Z2/kI186mkMW7ehjfiXd49L4/p524UdKtiNDdMnAYS+a4HaYgkGSTJ4NrerOjn8ltnw==
X-Received: by 2002:a5e:8f44:: with SMTP id x4mr14597iop.12.1635291012124;
        Tue, 26 Oct 2021 16:30:12 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id f4sm10843510ioc.15.2021.10.26.16.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:30:12 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@infradead.org>
In-Reply-To: <cover.1635006010.git.asml.silence@gmail.com>
References: <cover.1635006010.git.asml.silence@gmail.com>
Subject: Re: (subset) [PATCH 0/5] block optimisations
Message-Id: <163529101167.266518.2184030664699046343.b4-ty@kernel.dk>
Date:   Tue, 26 Oct 2021 17:30:11 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 23 Oct 2021 17:21:31 +0100, Pavel Begunkov wrote:
> Another split off from the "block optimisation round" series focusing
> on fops.c. It addresses Cristoph's review, the main change is
> setting bvec directly instead of passing a "hint"
> to bio_iov_iter_get_pages() in 3/5, and a prep patch 2/5.
> 
> I don't find a good way how to deduplicate __blkdev_direct_IO_async(),
> there are small differences in implementation. If that's fine I'd
> suggest to do it afterwards, anyway I want to brush up
> __blkdev_direct_IO(), e.g. remove effectively unnecessary DIO_MULTI_BIO
> flag.
> 
> [...]

Applied, thanks!

[1/5] block: add single bio async direct IO helper
      (no commit info)
[2/5] block: refactor bio_iov_bvec_set()
      (no commit info)

Best regards,
-- 
Jens Axboe


