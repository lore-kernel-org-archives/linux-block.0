Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C67DC433EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Jun 2022 21:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiFQVNN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jun 2022 17:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383555AbiFQVNM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jun 2022 17:13:12 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096EC1FCD6
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 14:13:12 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t2so4863884pld.4
        for <linux-block@vger.kernel.org>; Fri, 17 Jun 2022 14:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=1Cew+TpbKK/oD9AM+6MIsJdRcO04Uqx6AjbgYt7M0/g=;
        b=ji75y3guWq4o2yO59Jqtd1g5RGlkH1d2lWkxuv5W0l75U/DCR1jrp1lxN+ES/Hr2vc
         TtWIa0W0At0zGpNnXMLjzy8yWSIJNJjpaHMY5GErrIYuGJjEqQdzyzlXUyO+cRYLlJGp
         naMeAVQ+vQV3y+E36E+9AGzkuG4tfWHU9hVs+2ziF8Dm2loj53UbTKC6s/6A+uoSgejD
         wPC0Bg9z3zo9utcAC7nuv+3KBtBZRGz1Ue9UROYtuwWhuOD4pL7TzO0+yKIVqGP3zI1F
         Gl5uE6z/fQ2s6AFVaPWIyHgq99KQgUVnvVp3VOiP9OBcyqqDoTnoKBCd+11Z/Wk/AgMD
         8TNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=1Cew+TpbKK/oD9AM+6MIsJdRcO04Uqx6AjbgYt7M0/g=;
        b=0YbJ9QaLivn8YK3rAVzd5FmrHbXwMfw7J6e3EvLbcWPVvnu9XIRXTyD56t8G6wSxN+
         Qid9Ho2WsOC5wZrrCdyEMojV6KXIPQK8Aal0+VGbTitlrLVGChMPMa4L7NOnub+1KdZK
         4QIk3zZIuhWByQimZllB8sW9q5BVP6v9QG3lmQRYplAnNiZOznjmYjJ5xLemfJvjvrd+
         HoFi3pfuhXfHGf7EP+HugT7LvaIYyVBuGPHNhxkh38pEblHak80yoRFdxIXDaWaLMKZO
         K9JLjuMrYnroFcNR06Pj/97l597hbcVLtLRfkv1yKlkNIdoj7lRBuT7feEyLOi/Ucfq9
         R3cg==
X-Gm-Message-State: AJIora+FSZWziVMpPMfRDfUhabvHcIBjec9Kh38kj0+GMRnLQKLPuA4H
        VH+kjqhWkpG9bjALt5rYnRUwww==
X-Google-Smtp-Source: AGRyM1tkOkSWSGpWlPpdw0LXFsVljASY1v5dvaWMVfnMvvMFRGbfSf0hevZivQBsSr3UQ82wfpb2IQ==
X-Received: by 2002:a17:90a:e7c8:b0:1e6:92fe:84c2 with SMTP id kb8-20020a17090ae7c800b001e692fe84c2mr23831589pjb.194.1655500391501;
        Fri, 17 Jun 2022 14:13:11 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id g4-20020a17090a578400b001eafa265869sm2857758pji.56.2022.06.17.14.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 14:13:11 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     bvanassche@acm.org
Cc:     jack@suse.cz, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
In-Reply-To: <20220617210859.106623-1-bvanassche@acm.org>
References: <20220617210859.106623-1-bvanassche@acm.org>
Subject: Re: [PATCH v2] block: bfq: Fix kernel-doc headers
Message-Id: <165550039054.548034.7920414138619504282.b4-ty@kernel.dk>
Date:   Fri, 17 Jun 2022 15:13:10 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 17 Jun 2022 14:08:59 -0700, Bart Van Assche wrote:
> Fix the following warnings:
> 
> block/bfq-cgroup.c:721: warning: Function parameter or member 'bfqg' not described in '__bfq_bic_change_cgroup'
> block/bfq-cgroup.c:721: warning: Excess function parameter 'blkcg' description in '__bfq_bic_change_cgroup'
> block/bfq-cgroup.c:870: warning: Function parameter or member 'ioprio_class' not described in 'bfq_reparent_leaf_entity'
> block/bfq-cgroup.c:900: warning: Function parameter or member 'ioprio_class' not described in 'bfq_reparent_active_queues'
> 
> [...]

Applied, thanks!

[1/1] block: bfq: Fix kernel-doc headers
      commit: 93742d43240263ae23ab976717b8d65b4e26b657

Best regards,
-- 
Jens Axboe


