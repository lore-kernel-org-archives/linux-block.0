Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D89C433FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE5561038
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbhJSMKw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbhJSMKv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 08:10:51 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645C4C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:08:39 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n7so20078435iod.0
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VnBT4T51rT1/Ndkf1TD0GrzKIDCY6Qis2+1G41JDvCc=;
        b=IgeYKsonDy3OOfm+olD/FzdXTf+VQwDe52QpNUPrVADfvTb/qq+MHjFjTM/EfxCoNL
         o2u3tnQItyhHuqCVnmpC/d6/GCFj8K7vZy4c0+Ylsjb9Gi7N+mXJKiQF+GoC1giNjyyu
         chPfVm/S5g/aeIL4HgXNTO4cN0pmu2dzwsFtVELWP6GFgGkgLwt9tC/tJ0T7lK8Rq5r9
         6OahLIztMXHPVc6hSw1STyxs9+Js+yHgex9SUX6mvezXDVlPQIOEnOcBvis4hbZAFxo3
         +aifWqY+/HRHbKQhDn+CMRW3vRDSO8a54e0i/VOEkTXRX6KJ70aFzdvtw+GF9CDNWKe6
         5Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VnBT4T51rT1/Ndkf1TD0GrzKIDCY6Qis2+1G41JDvCc=;
        b=QD84t905pTf+mAah/Rv5HHBlwflsr+2iUDul0gd/WiwnXClBSN0JUSpNeDchgkSosr
         ykkKVQrrhM52P+AiPCqvTTGiIc4i4/cM3Z3hlhSIQm210TW8aaXWDEMB5qvuRuF4Or0w
         radlTC1Pi75SmJAQ23KHRmlELZ+Vb6oBeDhiypb4KfDykqlhf+ucrMrJiiTH3aLbkcBq
         Q7/yfKzSKATrQPLZcC3y0P2fRxvqvdFvurF3uoUfsLH7diHL/KV/3SgcqGCIGoleJnwB
         lxd6vlyX2IoEj6uWCZHfiyEfxjaSpV8LT4UommM1GWeFdVzCk9gZpqZSzv51GIDEyrac
         QNVw==
X-Gm-Message-State: AOAM531IujQ7/KYLG3wwyj0db46eGpVKipobbJy82wa7n0dx5NMIFwDc
        Uq5tFAboKf/qtLIOlMzqJEdsRzxaZfkOQQ==
X-Google-Smtp-Source: ABdhPJzMvTvZsSEBpga1SOenn0SEaQS6Vwnzr3ugr4wPfoXVdY3nLwdwsr5bDWLmOr8ECMlFM0VX6Q==
X-Received: by 2002:a02:2b08:: with SMTP id h8mr3908825jaa.137.1634645318291;
        Tue, 19 Oct 2021 05:08:38 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id m10sm8622544ila.13.2021.10.19.05.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:08:37 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     hch@lst.de
Subject: [PATCHSET v2] Improve plugging
Date:   Tue, 19 Oct 2021 06:08:32 -0600
Message-Id: <20211019120834.595160-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Split this into two patches - one that implements the singly linked
list as directly as possible, and one that adds direct issue of the
plug list. The sum of the two patches are the same, but they do look
nicer split like this.

-- 
Jens Axboe


