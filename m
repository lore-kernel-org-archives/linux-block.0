Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B4AC4332F
	for <linux-block@archiver.kernel.org>; Fri,  4 Feb 2022 13:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358850AbiBDNdK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Feb 2022 08:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358843AbiBDNdK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Feb 2022 08:33:10 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFA3C061714
        for <linux-block@vger.kernel.org>; Fri,  4 Feb 2022 05:33:10 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x15-20020a17090a6b4f00b001b8778c9183so145100pjl.4
        for <linux-block@vger.kernel.org>; Fri, 04 Feb 2022 05:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=jo/bvJQ+bbTHRoPqzABHC5ghz3NHgQ20n2D3ghkleSk=;
        b=iHyvceh0OaodJw4edYRlN1IK4MdVQwthNvykjiqGcUuqHKxy9eaL5Y24MnKr71hoK/
         mXp8W9C6lvQQGAGYjSE2E17SbLBYl+9pxRL+XpIW813Xj2rt2BY9YGqrhNiwqURVooyd
         nM9AwuHNtrT3OjBSMcN3VhiaB4/DTIP10qc3qbJ3hndkIvDjyo+njx2yBTWXL4TWACKo
         kwciynBVHAVZGTa5zybPRpolNuWHibYy0dFKBEHOq1g6s2dYve9hGh6MmBaVmRAIhSRK
         qEJEmStLqmUNH4gf3j/jh/qVXwA6hEWmNMVHZbu6dUhLYHmwNXGe2kLCuYZhuFgbvx7j
         1e2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=jo/bvJQ+bbTHRoPqzABHC5ghz3NHgQ20n2D3ghkleSk=;
        b=btSS/DpXpgE9vhtwNV5+97nkFDGAW1wrfzHyoe4HTOZ9ztbjM+4CmraM3cUTUC9eJ5
         zHXVsilm260/x0li6TLgX/LbRYvHP/a3mfPZB/Gwoscom4njG1wY2pc16Pdl1yJpcbDa
         tTWvcvITILy5nJefHDuc50pF3vGnkOUvsCA55Zt9Gb+uiF04pEWQpnkyscGoBy8TdDOH
         9albNrw67H7+42iFZqs8b1/s4equkuxc4RP8ZhR3IO2G73JWZf920Dj3g92gHwCFfyXe
         0sxorCzrjSnk3EZyXg6K95rueCzbfqjX2cfSMlW5O0qOuIMfDhxekYUEQQUyFDwiZiIl
         DYnQ==
X-Gm-Message-State: AOAM532nkyVBSg1Zq28m1mbCzixCXZ4njnLF8T2EtbwD37LldOpD6rYA
        Ldf41nKctMUy+aF2keO5F56ayZR5eJEnpw==
X-Google-Smtp-Source: ABdhPJxvkiQLuQb7jRyLi/86KiVqYUedYolrW2j5d4wg9tBOU2oaXzkfGfrwbpN3xIoYki7KLzHELA==
X-Received: by 2002:a17:90a:4b8b:: with SMTP id i11mr3165659pjh.148.1643981589831;
        Fri, 04 Feb 2022 05:33:09 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id s17sm2528575pfk.156.2022.02.04.05.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 05:33:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     syzbot+2b3f18414c37b42dcc94@syzkaller.appspotmail.com,
        linux-block@vger.kernel.org
In-Reply-To: <20220204071934.168469-1-hch@lst.de>
References: <20220204071934.168469-1-hch@lst.de>
Subject: Re: [PATCH] block: call bio_associate_blkg from bio_reset
Message-Id: <164398158883.441900.2159539572105486844.b4-ty@kernel.dk>
Date:   Fri, 04 Feb 2022 06:33:08 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 4 Feb 2022 08:19:34 +0100, Christoph Hellwig wrote:
> Call bio_associate_blkg just like bio_set_dev did in the callers before
> the conversion to set the block device in bio_reset.
> 
> 

Applied, thanks!

[1/1] block: call bio_associate_blkg from bio_reset
      commit: 78e3437450be5236c4949e377c9b848bbcd4fcb0

Best regards,
-- 
Jens Axboe


