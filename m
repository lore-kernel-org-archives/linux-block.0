Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03395C433F5
	for <linux-block@archiver.kernel.org>; Thu,  5 May 2022 00:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiEEAeQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 May 2022 20:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbiEEAeL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 May 2022 20:34:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3933626542
        for <linux-block@vger.kernel.org>; Wed,  4 May 2022 17:30:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id k1so2945089pll.4
        for <linux-block@vger.kernel.org>; Wed, 04 May 2022 17:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=RcDR4isR1g1B75C+ge2gLuR1U3I8zdlTjgq5xpVQhKA=;
        b=HS3sAKjRUTNwGuoJshoICQI94tUaKf0k69F9lckoWuOGMsg1s1MpmKTCFjRh82UmuC
         +7J3MmBJh1kBCurUVRvbBCz8zNeDWGYjX3Fl+OjPc/hS0j0OV2XsDrQVxi+uq+IB2Oun
         NisnHdzbNyfEvchAg4aS/KszTkoZOKUMNnslK96LFkYBO13ei6rExM5bko4d9iRwqyYq
         dWJNlgRKiH+GkwFYxgGyGII6E+X3bjbA4HwCWfZpcK5fwi97Z/gA3Q6AtDliE3ZEs7Df
         DLjnVT7cH0wUdqzDWGeuKN5vNlngwZS4S3OEnll2I5bUi+O72ChEVDSMn/HbhCpuFm5x
         jQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=RcDR4isR1g1B75C+ge2gLuR1U3I8zdlTjgq5xpVQhKA=;
        b=E02hNchmjaXrt9vLld0KLc7KaOq0cszFKRcUeogAC5exG9MdoiXPc/5Gx8HRzGalv/
         LpfqD0O7Dwcc6pfNvOWAKpE/XfY2oy92EQukjMz/r5g09JrDqJtB2P4wQysU8xW51tTx
         1w83NgStYt04yr99NX6tzMbIqSVZakfv8KgbEcWDn3KMkW2Lks1UMeevfFr+oBwWPp3/
         ySEUSSS+hLsSNXtaunIeeAP7zUpc/IZUMZxlj4HLpCc9Jn7r/TWIv7BTR4dRBkvWN0+b
         W8lT5235hhiHoajgI8gPipNFfQf7NL+WZk7qCxGx5+Cbyu9GPYWAhcNhWtin9Csmmq8h
         x1nw==
X-Gm-Message-State: AOAM530/9JHkP14fIovSmK9L58wB5Ri24pCbV729pDVnX3ZrGaQ95ijG
        5yuYm+Wb+W7Psqonwf27oy++Nyv/Xae43g==
X-Google-Smtp-Source: ABdhPJzJ18ZT0x6sB7P8RgakHVHYH3BESqESsK0UxhgsUJpRvbgw8SEXEqJddnYCbjwpGHxHDOsO7A==
X-Received: by 2002:a17:90a:e2cb:b0:1da:35d6:3a08 with SMTP id fr11-20020a17090ae2cb00b001da35d63a08mr2689016pjb.223.1651710632470;
        Wed, 04 May 2022 17:30:32 -0700 (PDT)
Received: from [127.0.1.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b0050dc76281d4sm9077672pfi.174.2022.05.04.17.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 17:30:31 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, snitzer@kernel.org
In-Reply-To: <20220504142950.567582-2-hch@lst.de>
References: <20220504142950.567582-1-hch@lst.de> <20220504142950.567582-2-hch@lst.de>
Subject: Re: [PATCH 1/2] block: remove superfluous calls to blkcg_bio_issue_init
Message-Id: <165171063131.26309.15825043724277860543.b4-ty@kernel.dk>
Date:   Wed, 04 May 2022 18:30:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 4 May 2022 07:29:49 -0700, Christoph Hellwig wrote:
> blkcg_bio_issue_init is called in submit_bio.  There is no need to have
> extra calls that just get overriden in __bio_clone and the two places
> that copy and pasted from it.
> 
> 

Applied, thanks!

[1/2] block: remove superfluous calls to blkcg_bio_issue_init
      commit: 513616843d736fb7161b4460cdfe5aa825c5902c
[2/2] block: allow passing a NULL bdev to bio_alloc_clone/bio_init_clone
      commit: 7ecc56c62b27d93838ee67fc2c7a1c3c480aea04

Best regards,
-- 
Jens Axboe


