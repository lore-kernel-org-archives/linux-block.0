Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57838C77B7A
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 01:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjETBxZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 21:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjETBxY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 21:53:24 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EE318C
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 18:53:23 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-645cfeead3cso97658b3a.1
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 18:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684547602; x=1687139602;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zeWDzdvLlJlJh+LBXLeD1t9tCcNz6nlRTApfldWWSzQ=;
        b=ATPxlUaXGIbnbUDSpNWF+gd+enRNFJ7tDpjKaUoFx00wq5nLWfNG7P4MYOoKgTT12E
         pYczE/9gsLuukAhUD7eiPAgPv9RSZqqxMQPn4Q3ZVWrYLmaxELQeTdXfzEyPnJ4Wewd+
         fqyET/PaKTjqG2XZwiQs+h4FRM7RebO8hXiQI/D+b1S1FcCX5tpefxMu/pGNJT8p7KAR
         clQsnLw2OZasdtX+bZv8bkT3jqvQ+h8k87QZt6KBESrMgtC3wtM86mvNgV0VtbhW8g9Q
         pFClb0vbkCcRrQB7sOKGSzTbw4E1CORckOtlQwPZqhy0rClgTogocSTlpY2C9FH49kNW
         6ZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684547602; x=1687139602;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zeWDzdvLlJlJh+LBXLeD1t9tCcNz6nlRTApfldWWSzQ=;
        b=DsEciYIvFwBHThxYcldDcp38MIvCdtd0gb5LWE6ll1hVtn/dfTiI3G26AJcj0OhqEW
         gwgWLzvKEqOK5tYlkGTgJtZpGEtAOBW85Bd3RaHQccz4vFLIfJFCIVjamrJRSbsMdgzR
         OCAklJxmoT5VhgwgV+2eIuQ+1/x6nqDt9n2cS1ZlRNsQqBcJGzFt+3966Qsw+IfkfPLx
         K3ROBzlsv6DDva4lVGwWOAa/VL6VMPHoTpJTPDl+aVehPY7fLWiPavAlraAacKFWmDIj
         p046Lovd4BNEcOsfYw30G+HD95KlVlFQ3vxlczNhnY20Qxb98yDRUcmUTnzWUgxqdRsI
         7NjA==
X-Gm-Message-State: AC+VfDwVWSt1pKD+4PKpJ+tZ6n6VoGT2vOVu3Xg07AVoNW5d98tvyARj
        KWE40JJVYx2qHr24FKzOmSSWerLQB7PviVJ/1Vk=
X-Google-Smtp-Source: ACHHUZ6MP0vD/aMgE1d/RanNaFMJ2d+CfcUXq25RHzvp/WKoUvPjiZAl0Lf0refAUi+ktd0cT9rIvQ==
X-Received: by 2002:a05:6a20:8f0c:b0:101:37b2:62eb with SMTP id b12-20020a056a208f0c00b0010137b262ebmr4211975pzk.5.1684547602153;
        Fri, 19 May 2023 18:53:22 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h22-20020a632116000000b00519c3475f21sm351083pgh.46.2023.05.19.18.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 18:53:21 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
In-Reply-To: <20230519044050.107790-1-hch@lst.de>
References: <20230519044050.107790-1-hch@lst.de>
Subject: Re: less special casing for flush requests v2
Message-Id: <168454760093.381513.16957186339132169067.b4-ty@kernel.dk>
Date:   Fri, 19 May 2023 19:53:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 19 May 2023 06:40:43 +0200, Christoph Hellwig wrote:
> inspired by Barts quest for less reording during requeues, this series
> aims to limit the scope of requeues.  This is mostly done by simply
> sending down more than we currently do down the normal submission path
> with the help of Bart's patch to allow requests that are in the flush
> state machine to still be seen by the I/O schedulers.
> 
> Changes since v1:
>  - rebased
>  - fix a bug in the blk state machine insertation order
> 
> [...]

Applied, thanks!

[1/7] blk-mq: factor out a blk_rq_init_flush helper
      commit: 0b573692f19501dfe2aeaf37b272ec07f60c70b9
[2/7] blk-mq: reflow blk_insert_flush
      commit: c1075e548ce6e6b5c7b71f2b05d344164ebc52bb
[3/7] blk-mq: defer to the normal submission path for non-flush flush commands
      commit: 360f264834e34d08530c2fb9b67e3ffa65318761
[4/7] blk-mq: use the I/O scheduler for writes from the flush state machine
      commit: be4c427809b0a746aff54dbb8ef663f0184291d0
[5/7] blk-mq: defer to the normal submission path for post-flush requests
      commit: 615939a2ae734e3e68c816d6749d1f5f79c62ab7
[6/7] blk-mq: do not do head insertions post-pre-flush commands
      commit: 1e82fadfc6b96ca79f69d0bcf938d31032bb43d2
[7/7] blk-mq: don't use the requeue list to queue flush commands
      commit: 9a67aa52a42b31ad44220cc218df3b75a5cd5d05

Best regards,
-- 
Jens Axboe



