Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6699BC433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 14:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC526109F
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 14:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhJVOh1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 10:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbhJVOh1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 10:37:27 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD99FC061764
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 07:35:09 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id d21-20020a9d4f15000000b0054e677e0ac5so4556197otl.11
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=MhFIicf4hBbVXGf2puWRTH1/975rt+kR8f/fEdnXsYw=;
        b=WeuYVgrPtH7+xkAmdmmrOReXgY+XtjwolBWISfXVZmLlCG7Y9kY8w0QHv/G0p162yP
         mvqJzT7T/ge3EoMoZXVAA3MLYgBgJ0wq19bB4zA72cshlfujUz5s4i3RchqekH/IftYY
         fwpgr/etZ4k9V5sDCv/dCm+yd72d2pC6xt73L5w3CIX5wE1C1x8gln+9MjQXG+iirb1d
         icpHPSWVkcAi/PCe4G6DhEBOqes+iKzADWeBFN5DESxhEzAkO5ppBE63pkX4+eVaguEE
         kljP2862kmvsd/uxMnGm5PCwnbMRLIypwunpky/JVCtQZWh/eQeFZ8pn/opAhg63zJJV
         7hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=MhFIicf4hBbVXGf2puWRTH1/975rt+kR8f/fEdnXsYw=;
        b=5LE64EomLCdvmiwYrTRExKZ2PhdpWyWACQmD/lKhWKZfZE/yU6jQ1jutQvUB8ZXJLJ
         W8uxH9p2b3A3oUYw3SeNMYTgZkPA9Cg27jPubBehhMV1Ah5ep3QLRDMUXzP1WoaZq98I
         rc5SQn4erKGoF9ROEF9+52Q6barJ+ygkIc5RRnbHM3rknvnPwPBAdLHu88WgV64VTuct
         E0uL7DmbEMSNtDRO/gc1zAZ+h1vb6IfMyFQaW02DGiTv2bHMTg5+EY7wEnyvDxqE8As8
         AnboKERo7ZZtHks53pqTIhTbMXHVyY1IGK+mf3DEwScTH1uyhiB9KKjEiHbwMt7ly5jc
         Ht6Q==
X-Gm-Message-State: AOAM533YYj21YDZSbVihT1z2gYb2aYadrY9JtG05bV0cznBjtnmiwFzX
        FYfD2sWOpwXKvNrz6iMV4L18aQ==
X-Google-Smtp-Source: ABdhPJxNWcBh6jolazTx5kP/qJNERvtW34hg8tTiHnof32aGHjblboOJs+dDettmz4QWFEijB+Hfaw==
X-Received: by 2002:a9d:17cd:: with SMTP id j71mr196668otj.169.1634913307835;
        Fri, 22 Oct 2021 07:35:07 -0700 (PDT)
Received: from [127.0.1.1] (rrcs-24-173-18-66.sw.biz.rr.com. [24.173.18.66])
        by smtp.gmail.com with ESMTPSA id m4sm1672217otp.1.2021.10.22.07.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:35:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Milan Broz <gmazyland@gmail.com>
In-Reply-To: <20211019075639.2333969-1-hch@lst.de>
References: <20211019075639.2333969-1-hch@lst.de>
Subject: Re: [PATCH] block: remove support for cryptoloop and the xor transfer
Message-Id: <163491330518.83632.1250946626170046689.b4-ty@kernel.dk>
Date:   Fri, 22 Oct 2021 08:35:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 19 Oct 2021 09:56:39 +0200, Christoph Hellwig wrote:
> Support for cyrptoloop has been officially marked broken and deprecated
> in favor of dm-crypt (which supports the same broken algorithms if
> needed) in Linux 2.6.4 (released in March 2004), and support for it has
> been entirely removed from losetup in util-linux 2.23 (released in April
> 2013).  The XOR transfer has never been more than a toy to demonstrate
> the transfer in the bad old times of crypto export restrictions.
> Remove them as they have some nasty interactions with loop device life
> times due to the iteration over all loop devices in
> loop_unregister_transfer.
> 
> [...]

Applied, thanks!

[1/1] block: remove support for cryptoloop and the xor transfer
      commit: 47e9624616c80c9879feda536c48c6a3a0ed9835

Best regards,
-- 
Jens Axboe


