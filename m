Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C94EB64D8
	for <linux-block@archiver.kernel.org>; Thu, 22 Jun 2023 15:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjFVPJ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Jun 2023 11:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjFVPJy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Jun 2023 11:09:54 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A84EB4
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 08:09:53 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7747cc8bea0so66467239f.1
        for <linux-block@vger.kernel.org>; Thu, 22 Jun 2023 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687446593; x=1690038593;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n3QcLKxgqXqc9TxaznnA+GDbShUxCQedNAGKPYu4oqM=;
        b=3QyJ6ywKEGKckxsId+BjZWiDM+GYaX9QLbG3j5wawhxhh6Mt9rRKFCbV67G/k58/hu
         i7KK/5cJk6aRhjP71gHh8+lw5cqAKg4DzIdFE5sMLXTXBzeDmssfBw7m1B2hlUNOr3pL
         y1j+bCAEo5an4dk4Cxd0RW+fr2Qb4jrh8Zqe+OQEO0LF/9XH9H5iPJB7jCkeUfXvJIw7
         Mmcx5uKfKpJMHOyU52h4nOAgX/7A12XtyyVjwEQ73/sqPXbcCkAiPX6BedFibuL5g7f/
         6FElBiBDDbLRBI7FR8UFB4XNOq1LK4E8Gqppv8+HSlt8eIciu9PN0X5dW1tJBOIqyKf1
         60vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687446593; x=1690038593;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n3QcLKxgqXqc9TxaznnA+GDbShUxCQedNAGKPYu4oqM=;
        b=MB+BA973/V9TRHAQfI3E0bfAhkga2IwGF4MfWYY1wuLFiXdbrCO3cf2xE1UojJV6zT
         U9G0203rXMDAwkOlNpEHmkJbXXK/hCYWf+qMJlLL5kvf/ZEChyL7REP155I1dPb5ytts
         Zhr9ed3rl/i3uoUes3v2/9/PotD5s11lTUuv4NI4V91OxyQ3YeDcTcEyJjJRhBBPBl92
         Rhv/EV3+Pv0KnH777j1qMjYy43ufwief587WHCgQgawYUPapzFjqGsv//OoalCawgOSs
         UMLmkcaUjQ7ffIbp33IS8TGP3nhORtcvsSeJBhsOCotPw2BcMCVga9p9D/4aaXPFJVnE
         LMqw==
X-Gm-Message-State: AC+VfDyWlfPM0pB+uM4vomGtwQpy/jei8Zx83njW3EjLWcoYIkWVOj2G
        bWP3LWKPEUvgdWFI/NC2b/914hVw+4Dz2/Y3/p0=
X-Google-Smtp-Source: ACHHUZ5ib9OoyU3EsPuLequVHz9N5n2W44QU/GijCiT6miXuP2tUJoXbIL49ArMqhr0ovZE/qqrUJw==
X-Received: by 2002:a05:6e02:1207:b0:32a:8792:7248 with SMTP id a7-20020a056e02120700b0032a87927248mr16169123ilq.2.1687446592975;
        Thu, 22 Jun 2023 08:09:52 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d13-20020a92d78d000000b0033b27117120sm2105204iln.13.2023.06.22.08.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 08:09:52 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230622150644.600327-1-hch@lst.de>
References: <20230622150644.600327-1-hch@lst.de>
Subject: Re: [PATCH] block: don't return -EINVAL for not found names in
 devt_from_devname
Message-Id: <168744659235.30871.12393942722171956862.b4-ty@kernel.dk>
Date:   Thu, 22 Jun 2023 09:09:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-d8b83
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 22 Jun 2023 17:06:44 +0200, Christoph Hellwig wrote:
> When we didn't find a device and didn't guess it might be a partition,
> it might still show up later, so don't disable rootwait for it by
> returning -EINVAL.
> 
> 

Applied, thanks!

[1/1] block: don't return -EINVAL for not found names in devt_from_devname
      commit: 648fa60fa7de3ca6f6303e1721591ad73def9cf0

Best regards,
-- 
Jens Axboe



