Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54182EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 30 Jun 2023 04:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjF3EpS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Jun 2023 00:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjF3EpR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2023 00:45:17 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E85C210E
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 21:45:16 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso1303187276.1
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2023 21:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688100315; x=1690692315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jy+2wKbAO2OzvWqyWD+QWcNE+oPQupQFExebUvFAsfo=;
        b=ghKITAnwxQw7NSpKuygbhDmD94YR1hQb/uj1vFbMFql9/u2srmFuIb/W+cpESRyn2h
         RU2ekTuMlvo+X/7imkCNMwaY0eaVILkxILRPxdVXxIjMqlexjHp80UreyYCm+L9uA3jv
         ak3kNZVMP4GbGf0F5UUNXKlQ9m+gtUBvj4F8rHZ6y3ebA6SmdgKl/1RsW30IXqHugBvD
         o/RpcO0uAIXSUdfkh1vwPHohMbc6zkwAH9AMJsQnxlhGenXhlLObnnS9u7EPtXZHf3/f
         UlhW4mX2roxz4dKaPfR5lJG6Z947ZQD3gMOYAgvsp6sGFGRK80VHiEOY3Ihq7EMmNoos
         79dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688100315; x=1690692315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jy+2wKbAO2OzvWqyWD+QWcNE+oPQupQFExebUvFAsfo=;
        b=Ck2QMEJiBjL5o6m8x1q56NPbDV6zbSXxdhumgsfxNVwxWDtBMJlidddMxffVlcM3zj
         +8g3qgtThq8mwBpCi0xBF0wK0zJtR44H3LKlIdorPsbbOk61cqccowa0ZZy/H1/9pl38
         nJ+M5BNQYb6LoCTgWcuo9o4tsW3+/MWr65FtzP2x8pmnUbVY7/I9f+AbOaX0C0/S1d0s
         zNsbIq+FSIuAKeEhHi+FDAsqfZDCqr+mq/Jlkaaxsiil1LErED5BTxEuROTTp+S7AqR+
         Yl5vUXQS3Psagf1xzGIrCr84MbAXQhbJ87jB0bKvp/iCBTMksDbT160awgwXcCJgLuot
         QtEQ==
X-Gm-Message-State: ABy/qLbTj/CMz4rNKAgicOeJS4XSrvskuaGliobwZ+8emAOUkuxk/U5L
        ivtxmwQ3Ou1zUVybDQI79WrEM3CAzF8UHPRhlwA=
X-Google-Smtp-Source: APBJJlGjtUStSn0IYr/tNUDx8CYFb9y2ynomg5kQwyGnJPZ+JRYhx2RhsFRJ3+ShB+zXUszAflU79OvOlJyuT/eXags=
X-Received: by 2002:a25:a489:0:b0:c16:a8f7:7afd with SMTP id
 g9-20020a25a489000000b00c16a8f77afdmr1607987ybi.45.1688100315563; Thu, 29 Jun
 2023 21:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <ZJLpYMC8FgtZ0k2k@infradead.org> <20230621134340.878461-1-houtao@huaweicloud.com>
 <CAM9Jb+j8-DWdRMsXJNiHm_UK5Nx6L2=a2PnRL=m3sMyQz4cXLw@mail.gmail.com> <d484a89f-8aaf-c0ae-5c12-f9a87b62384c@huaweicloud.com>
In-Reply-To: <d484a89f-8aaf-c0ae-5c12-f9a87b62384c@huaweicloud.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Fri, 30 Jun 2023 06:45:03 +0200
Message-ID: <CAM9Jb+i6qGVNRMJHG_=_NLkrzcnjn=Sa=YZJsJeA3K19ib__Zw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_pmem: add the missing REQ_OP_WRITE for flush bio
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        virtualization@lists.linux-foundation.org, houtao1@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> > Yes, [0] needs to be completed. Curious to know if you guys using
> > virtio-pmem device?
> Sorry about missing the question. We are plan to use DAX to do page
> cache offload and now we are just do experiment with virtio-pmem and
> nd-pmem.

Sounds good. Thank you for answering!

Best regards,
Pankaj
