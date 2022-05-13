Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25082C433EF
	for <linux-block@archiver.kernel.org>; Fri, 13 May 2022 23:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiEMXD1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 May 2022 19:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiEMXDY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 May 2022 19:03:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1DF9C2D7
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 16:03:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so8727591pjb.1
        for <linux-block@vger.kernel.org>; Fri, 13 May 2022 16:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=6xaAu02FF7S11HYpek6hRqx+NCHUYDjPRfx4y0T8z3E=;
        b=V6xom6/0lgskip6JR2Evkg3tO7PLMpehl9J7oFzK9m5uaykyLW7e1r6bvNkPQuGl/H
         z926omi4RzBbZrGWdblsNQXcBltzEPWEyYqPeDmcQfxNbS3C7Jrru5Da/ZA34Zt2QqO2
         OWbaPH2MKVGj1956w5iRPuF/tV/t5M6n1tse4mPgSRmw5PG8fjWlKYMXJIQ0g18Nlsu6
         adfX+0rTF09LTsJx1KXVWws346iX5oeRnD6ibeUBmNi0sNgixx1nAavgkGvT2yBFvdb0
         RC2m2JX2EaLOmLElEyIo2IVCx3d2tDqZflTeGXH3BqlYkcIHEzMY+odkceu/UGe1dym7
         63ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=6xaAu02FF7S11HYpek6hRqx+NCHUYDjPRfx4y0T8z3E=;
        b=6Amdf9gNMCpJFurB84o7HIwNw85Z/sCYx2cZnbgxdmktjRZE+HRG5cB75XDuh5NntN
         y7WHdfDehjnZNcN6/kVmobFzdFsOd95gJAbOOCTJanqzfNo7D1dPGmMHFsTHviVmEKkA
         QHvwtwbVBcRMgozBG5aVJV54N1k2rdrqJsQ73s3pRPqYsg9E24L0NYNJ9uaRozD65/5o
         LBl9wKV2d10yMPBoP9JhGylE/x5WHQ8uuLgstrdhgQGHwmEZ24qrDe7illKwg+VNz2sy
         NmU7e4Egy51Xm//XeaKTueL6j4jni396THC6WDjs2iTx7djFMRgndUbciJ3NAWaDt+Rl
         dniQ==
X-Gm-Message-State: AOAM530mpN3FWnDlJDB/nTqcEU8Uw6g84D7eSQKlX2LTxmbAbgQIsP0v
        YZTN0DfM9cPY80FyFar/+GR3zSo7hG5okg==
X-Google-Smtp-Source: ABdhPJzuLANEqWJD0q1kRrim5pw3+aMsBidUbC9/1V+3qY1+2TDDxLw4wBY4Ko/n+ZlpLRmeCpFfiQ==
X-Received: by 2002:a17:90b:4a0f:b0:1dc:b062:da20 with SMTP id kk15-20020a17090b4a0f00b001dcb062da20mr6995287pjb.51.1652482983366;
        Fri, 13 May 2022 16:03:03 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id fz9-20020a17090b024900b001cd4989fec9sm4091026pjb.21.2022.05.13.16.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 16:03:02 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     bvanassche@acm.org
Cc:     jaegeuk@kernel.org, damien.lemoal@opensource.wdc.com,
        ming.lei@redhat.com, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
In-Reply-To: <20220513171307.32564-1-bvanassche@acm.org>
References: <20220513171307.32564-1-bvanassche@acm.org>
Subject: Re: [PATCH] block/mq-deadline: Set the fifo_time member also if inserting at head
Message-Id: <165248298241.316645.5558458299382840061.b4-ty@kernel.dk>
Date:   Fri, 13 May 2022 17:03:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 13 May 2022 10:13:07 -0700, Bart Van Assche wrote:
> Before commit 322cff70d46c the fifo_time member of requests on a dispatch
> list was not used. Commit 322cff70d46c introduces code that reads the
> fifo_time member of requests on dispatch lists. Hence this patch that sets
> the fifo_time member when adding a request to a dispatch list.
> 
> 

Applied, thanks!

[1/1] block/mq-deadline: Set the fifo_time member also if inserting at head
      commit: 725f22a1477c9c15aa67ad3af96fe28ec4fe72d2

Best regards,
-- 
Jens Axboe


