Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE42C83F10
	for <linux-block@archiver.kernel.org>; Thu, 31 Aug 2023 15:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243656AbjHaPXe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Aug 2023 11:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345737AbjHaPXd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Aug 2023 11:23:33 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC0710FA
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2023 08:22:55 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-77dcff76e35so5317739f.1
        for <linux-block@vger.kernel.org>; Thu, 31 Aug 2023 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1693495365; x=1694100165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5C7bZj6DRvPSz+2BteKqdV7Xyxd2iM2tZ4rkhSxcBY=;
        b=MVm7GVAoik7fPY+TNLruNbP53H35XIODCAKONxPyW1geMT2hRJMu+//M485PH5lI6N
         R8L/fagF14YC1UBf4xky6NQM96CGSJkuBsVFFSgLM6yPXrMArcpkLOUJktx4vdq0ot7e
         fxWcoiIAYzGj3CWLkcthFKmPhvEcG7SDQtndGJbg1BCEoGu8sloF2/YLGWJ1ICr6z4OV
         l8cm2BwBklTDjRtHvBKCywDm6io3ySSkQrTC5E8vRebPowSBGoIuOtBBqp7p8vOque4J
         u8LkJs397dpmJNYHj45JvjE6C3mRxtKAY3Pne3Y0nTrSruGtyf38GtcnbRDIq00oOncP
         9P6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693495365; x=1694100165;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5C7bZj6DRvPSz+2BteKqdV7Xyxd2iM2tZ4rkhSxcBY=;
        b=ehuV6WSZ3bph9HvG0YrZ/1usoWILLzW0Ev7Ug1JpmSMC7StjZx654s59W6m2GMh34q
         BZdqjU/sEgaS3zVY7Zr03e0U+ygqpFLuSC0uWKmyFazhPAH59fpPIITbtWSrv+rlHvrN
         1aqKSDDFpE/14PbDSBoYRdzjsEpRFl/nUkzU3IcSDiK/4gZ3DOUSoeNA6qR3/uwdUMMD
         uiOn+Y+nu6wcXl769rKyw/TBiLBUHvTTHwiDemRjD/K3ezkbp6BkXtJWruEK/zUS8mZo
         SxjS7vPGvCbVLmJ2qyXHUz+/5+dACYTGFoST9mpe6EuigVTYY6QfhI/5A5+Q1+KLQm0J
         NkNw==
X-Gm-Message-State: AOJu0YxVOXxX1kpWOMaUuBrh6hix95wdjp7OZumH56qUgQlTdorBhfjv
        IvmBv1kMU0e9uFDq5O+zWgkdnQ==
X-Google-Smtp-Source: AGHT+IHsWsc1MztJVW5Z//e3ooVP1ZglZTo3Cemt8WRU3hy7hrBSUSu+e+Q5U2ffdmKmxsyn1uLUNQ==
X-Received: by 2002:a92:2802:0:b0:341:c98a:529 with SMTP id l2-20020a922802000000b00341c98a0529mr5263234ilf.0.1693495364818;
        Thu, 31 Aug 2023 08:22:44 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y3-20020a92d803000000b0034cc253a78esm472472ilm.51.2023.08.31.08.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 08:22:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Li Lingfeng <lilingfeng@huaweicloud.com>
Cc:     hch@lst.de, tj@kernel.org, yukuai1@huaweicloud.com,
        houtao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230831075900.1725842-1-lilingfeng@huaweicloud.com>
References: <20230831075900.1725842-1-lilingfeng@huaweicloud.com>
Subject: Re: [PATCH] block: don't add or resize partition on the disk with
 GENHD_FL_NO_PART
Message-Id: <169349536296.200662.14369106851119250963.b4-ty@kernel.dk>
Date:   Thu, 31 Aug 2023 09:22:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 31 Aug 2023 15:59:00 +0800, Li Lingfeng wrote:
> Commit a33df75c6328 ("block: use an xarray for disk->part_tbl") remove
> disk_expand_part_tbl() in add_partition(), which means all kinds of
> devices will support extended dynamic `dev_t`.
> However, some devices with GENHD_FL_NO_PART are not expected to add or
> resize partition.
> Fix this by adding check of GENHD_FL_NO_PART before add or resize
> partition.
> 
> [...]

Applied, thanks!

[1/1] block: don't add or resize partition on the disk with GENHD_FL_NO_PART
      (no commit info)

Best regards,
-- 
Jens Axboe



