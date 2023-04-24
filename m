Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BF9C77B61
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 14:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjDXOu2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 10:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjDXOu1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 10:50:27 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA987DAC
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 07:50:09 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-760dff4b701so26519339f.0
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682347808; x=1684939808;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THiTJZR1ZJHaeSswDO25rgfFX2gU/J77P/LOkBULOtA=;
        b=ZtmSQXH0WWdsqDbmoZIMYKJ9JsL/MjOIfg9AuvSQXEC37HMfx0OP9wp9C2AlYkJ+H1
         fG5br/UFsCD6FWyoA2By2C3R36UcBbllfnBIexGFuBqN102YlP80Z42wqiXqy7tjjlcl
         Fc0tVbLo27LFQyIfpW7hPeDQKLqzVSyyjEnXOyMoY2IWT05v+XkE2Ul+Uxra2YlwVzi7
         Pjw9cpisEz5mPt2YRt3vHgNcvzd3RBXKSbqUmcz91KGh4phNawwTF74TfFlgoDiS+WwU
         cc9GcQRGHI4cFwEPDEoM3ddMGAc/hEPoS8+UWiRth5l870QbD1Pw+rmHfR5o/23lSBul
         iKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682347808; x=1684939808;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=THiTJZR1ZJHaeSswDO25rgfFX2gU/J77P/LOkBULOtA=;
        b=G6ltP+IIti797stGxKYl0Iy46uWqHVGSA+Nc2nti4DpI27nwV02s4W0ZWuh/7PdUyc
         ifQOL5+m9xdueX34BJM5NaOTEXjqN9TkP+bouFT1E3WgZ2cypMy/t/ee0MbrJhMFf1OQ
         Om9BQyP7UYtjDTQ94DMjNghMe9WZ4hoIaKlADLTvBDuREtt/3JdJ7et1+C6D0y7Y22A0
         DrdtvGox+J0fcaQqiUIGALi9BMXSyJMN79vw/Ue3U08I0IMU4j5W2Wv0RhYhmOBFi33T
         aDnbvKaUIHMzzZaWUZ8l+D7G8y1o+1QLpAOm1bYjiBPkMOv5wg/qHB+znK/KJxGjcGe8
         N3hA==
X-Gm-Message-State: AAQBX9f53U7EQfVB+k/89VLcbah5xcjJ7j/EIgzrDbWd7AXfp0UQfpkA
        +z8d05bTkho8DNPbZGNoNuq2D/H0KxBlkDvqv7g=
X-Google-Smtp-Source: AKy350bGnHQ6yL9k60LBdHxOb0AypwuB9DLTQ3FGkWgXseS4+GNig0RWrZIz/QH9fIrKmjFF29vNtQ==
X-Received: by 2002:a05:6e02:96a:b0:32c:a864:6eb3 with SMTP id q10-20020a056e02096a00b0032ca8646eb3mr6468989ilt.1.1682347807933;
        Mon, 24 Apr 2023 07:50:07 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id h26-20020a022b1a000000b0040fca811982sm3459719jaa.14.2023.04.24.07.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 07:50:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>
In-Reply-To: <20230424131318.79935-1-dlemoal@kernel.org>
References: <20230424131318.79935-1-dlemoal@kernel.org>
Subject: Re: [PATCH v2] block: Cleanup set_capacity()/bdev_set_nr_sectors()
Message-Id: <168234780717.28363.12415860299734946384.b4-ty@kernel.dk>
Date:   Mon, 24 Apr 2023 08:50:07 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Mon, 24 Apr 2023 22:13:18 +0900, Damien Le Moal wrote:
> The code for setting a block device capacity (bd_nr_sectors field of
> struct block_device) is duplicated in set_capacity() and
> bdev_set_nr_sectors(). Clean this up by making bdev_set_nr_sectors()
> a block layer internal function defined in block/bdev.c instead of
> having this function statically defined in block/partitions/core.c.
> With this change, set_capacity() implementation can be simplified to
> only calling bdev_set_nr_sectors().
> 
> [...]

Applied, thanks!

[1/1] block: Cleanup set_capacity()/bdev_set_nr_sectors()
      commit: 83794367dcc6749662b17a1e4b8ec085023fc53b

Best regards,
-- 
Jens Axboe



