Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5F1C0015E
	for <linux-block@archiver.kernel.org>; Sat, 15 Jul 2023 15:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGOPwH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Jul 2023 11:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGOPwG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Jul 2023 11:52:06 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C3EBA
        for <linux-block@vger.kernel.org>; Sat, 15 Jul 2023 08:52:05 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-682ae5d4184so745032b3a.1
        for <linux-block@vger.kernel.org>; Sat, 15 Jul 2023 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689436324; x=1692028324;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6VZacD3QHpDd5zi6payfLzqNm3fEdR7LMv9zL08Th4=;
        b=Xemtnd18PGuB9H1uO0zsIPKbeR4zoGymWOZdBbiDl/ZJeVdo0SY7mhOKSHwd5vnmDs
         7o6ksnisZF48tr8gZyT6W9EQ/P67Mdp91AMk/5batkdaDaarHBd2b57joqMtrJQLJr5l
         n5mjo5PagQQwIi/l2NQvYk5lCRjFgbN8wDjrx/gw7vATdd9ITW3ef/GMZIw8fg+Vh0TU
         z3D8vGUK0p017UP/dzT0Av20YsLcESSeNrpfxN3qNjZXY8/6DwJghjxFla546C1xNInK
         zjCtinVPvZZKrCSELUCqGntYo1vTiDXkvq43eQG0NH1V8Nr6ylJa/y3733TcKMzk8tJ9
         9jAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689436324; x=1692028324;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6VZacD3QHpDd5zi6payfLzqNm3fEdR7LMv9zL08Th4=;
        b=KJYcoruZycD60BTBZbUazBbyB6TEAtAa69OTbg1pbq0dybV7m0BXUKUqw6TS74zmQm
         f0V2tKFtxhpYj8ZMBjl7YppF/Wtu6nv19LCFsGrPIUN9+F3RgeoC1lTqFRmSipvKJkrN
         vzug7Ic4bOjneY+V3wd1sMhLYOSsVNG7++FW46yJwMjDjqaarVSgE68L2jvpw4VnLOi6
         /f8jaC6e8ttqPdfgp7eRSYpII7DJ6xtFuqvb8TvhdxoGkHK8wWW2NtRzh+lOWfVHp8O4
         GQxR0zEgSLuGT/Me2rNnVqg5nXsD/bmTakyd/pvozPph4urBMfQiIDLfwhrjeHHxUlW2
         FZVg==
X-Gm-Message-State: ABy/qLb8Ql71OTrop9UrWTnuyOONp4REQlkObAeEZwC6CuZGPRedf5VO
        LxUFLRfJDNlxMXhp7IhCX+nb5P4aVNrxVzcb4lo=
X-Google-Smtp-Source: APBJJlHw1XwQ1faogVbDZh+kdNS5bC+El35QTP8rtjFqeBDAUr+cFaQ7q3PVZBcnKJf+aJ2MF8x9tQ==
X-Received: by 2002:a05:6a00:3016:b0:66f:3fc5:6167 with SMTP id ay22-20020a056a00301600b0066f3fc56167mr2592989pfb.1.1689436324419;
        Sat, 15 Jul 2023 08:52:04 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ey23-20020a056a0038d700b00682a8e600f0sm9002313pfb.35.2023.07.15.08.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 08:52:03 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20230707094239.107968-1-hch@lst.de>
References: <20230707094239.107968-1-hch@lst.de>
Subject: Re: don't allow enabling a write back cache on devices that don't
 support it
Message-Id: <168943632350.808216.1784678611443841591.b4-ty@kernel.dk>
Date:   Sat, 15 Jul 2023 09:52:03 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-099c9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 07 Jul 2023 11:42:37 +0200, Christoph Hellwig wrote:
> this series fixes a case where a user could enable a write back cache
> on a device (driver) that doesn't support it all, potentially leading
> to flush requests being sent to a driver that doesn't know whast to
> do with them.
> 
> diffstat:
>  block/blk-settings.c   |    7 +++++--
>  block/blk-sysfs.c      |   21 ++++++++-------------
>  include/linux/blkdev.h |    1 +
>  3 files changed, 14 insertions(+), 15 deletions(-)
> 
> [...]

Applied, thanks!

[1/2] block: cleanup queue_wc_store
      commit: ba2b2594c0e15a40b7f42dd8aca1867c57c13145
[2/2] block: don't allow enabling a cache on devices that don't support it
      commit: 3e8f23e19c95fb4757f8c77f1473578d2154d7c2

Best regards,
-- 
Jens Axboe



