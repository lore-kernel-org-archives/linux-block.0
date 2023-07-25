Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FD8EB64DD
	for <linux-block@archiver.kernel.org>; Tue, 25 Jul 2023 01:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjGYBzg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Jul 2023 21:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGYBzf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Jul 2023 21:55:35 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A941B3
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 18:55:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6862d4a1376so1315849b3a.0
        for <linux-block@vger.kernel.org>; Mon, 24 Jul 2023 18:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1690250134; x=1690854934;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cBepQv2rYb+u+PtN89bpiMsnePTkqZHLxrrc/RMIDE=;
        b=h4+CnGyMb2DcLlUz2t1TQXHRikkkEjKtgHao96gjDQwfhlQsk8JEfp1fPmkcjWQJiG
         oruYQQrsB1XnTx7dX8EzWNhLezhmGq2k0l4UFtvzXXt/Ogjqoxg86e2gF2WLV34RKGLP
         5QZD2uAa4Hb3L6qAjq7f6g8TBpJdi9dHBtSdIpXtjLHXwKu81QYjWPqFByxCY50gnEdw
         Zmh2oQShNbRKRHcjsooKq44JlCyKkm/0JPm1SCtdEhIQqAK51qjrCXVk/9uAcHHYmHh4
         nGvT82uAhMC2BOJHbctL2UM7D4fjVzWdG9HoEF6BTpTTvFqbBzSWzm7wQklSQeKvBRy9
         6sOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690250134; x=1690854934;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cBepQv2rYb+u+PtN89bpiMsnePTkqZHLxrrc/RMIDE=;
        b=Nh6TVQaVrwyDcN5UKlCHMPxv2AO9BAXGE0ZtqloW/SCfHRemI6M+XqestcuBYPvUNO
         cC5cgREy/JWfiwzlFj/W9JPcyUzqO049grvczd0Yi97ghPl5VvF2zC5wenHLlyfsLHBq
         pOv5+pVytSfamBIs24+edw69PQOkA+FEjQ4yIw1Wp4Dtyd90sBmVHEjbKVisLd05mvCM
         ue2mtEGUtpkM6xudcnnL5qAX+xDhOdHcZW2hoqNnboLto9pqNmip+TpQegok69xRFg8a
         adiwKP9WAWUQKhu647d++W8qT2aupua6SLdxZ7dFZ9s7UecIBnZSIv/fsnhz9adgpfGC
         xruQ==
X-Gm-Message-State: ABy/qLYdK+YYdfTjuTCC6JBiIhEhpcS6+BJNhLRst5r5asT85Hc7r9p/
        Sxfh2HGiPGBjIxfyAl4LVlIInQ==
X-Google-Smtp-Source: APBJJlHhe4wdVKxIBHZfXJfyifsd5/u4IVcrnldQs8jNao2U7ThOL4AWQ/iy3otPHcXBzbhMljoA3g==
X-Received: by 2002:a05:6a00:a29:b0:681:9fe0:b543 with SMTP id p41-20020a056a000a2900b006819fe0b543mr13917969pfh.2.1690250133755;
        Mon, 24 Jul 2023 18:55:33 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q23-20020a62e117000000b00682af93093csm8318563pfh.80.2023.07.24.18.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 18:55:33 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20230724165433.117645-1-hch@lst.de>
References: <20230724165433.117645-1-hch@lst.de>
Subject: Re: rationalize the flow in bio_add_page and friends v2
Message-Id: <169025013296.651134.9648547388592226654.b4-ty@kernel.dk>
Date:   Mon, 24 Jul 2023 19:55:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 24 Jul 2023 09:54:25 -0700, Christoph Hellwig wrote:
> when reviewing v2 of Jinyoung's "Change the integrity configuration
> method in block" series I noticed that someone made a complete mess of
> the bio_add_page flow, so this untangles this to make the code better
> reusable for adding integrity payloads.  (I'll also have a word with
> younger me when I get the chance about this..)
> 
> Changes since v1:
>  - rebased against the current for-6.6/block tree
> 
> [...]

Applied, thanks!

[1/8] block: tidy up the bio full checks in bio_add_hw_page
      commit: cd1d83e24e689f25de7e34bea697971750138d5f
[2/8] block: use SECTOR_SHIFT bio_add_hw_page
      commit: 6850b2dd5c25f27f7b74414553f047d4c12dd66c
[3/8] block: move the BIO_CLONED checks out of __bio_try_merge_page
      commit: 939e1a370330841b2c0292a483d7b38f3ee45f88
[4/8] block: move the bi_vcnt check out of __bio_try_merge_page
      commit: 0eca8b6f97ac705c5806f7d062207379094fb114
[5/8] block: move the bi_size overflow check in __bio_try_merge_page
      commit: 613699050a49760f1d70c74f71bd0b013ca3c356
[6/8] block: downgrade a bio_full call in bio_add_page
      commit: 80232b520314214d846eb0a65faef8b51b702fa7
[7/8] block: move the bi_size update out of __bio_try_merge_page
      commit: 858c708d9efb7e8e5c6320793b778cc17cf8368a
[8/8] block: don't pass a bio to bio_try_merge_hw_seg
      commit: ae42f0b3bf65912e122fc2e8d5f6d94b51156dba

Best regards,
-- 
Jens Axboe



