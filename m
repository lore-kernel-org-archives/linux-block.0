Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97551C4332F
	for <linux-block@archiver.kernel.org>; Fri,  2 Dec 2022 19:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbiLBTgA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Dec 2022 14:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiLBTf7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Dec 2022 14:35:59 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F06A6074
        for <linux-block@vger.kernel.org>; Fri,  2 Dec 2022 11:35:57 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r18so5153077pgr.12
        for <linux-block@vger.kernel.org>; Fri, 02 Dec 2022 11:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXLe4AcieipOgmpyanQu8zzMg2qhrzhfuhvzqnhslJw=;
        b=evwD0fS0pXDFe1tsORxOMMXoQD5AV4Psap6kmuMWWk81iWpXFJLdxivtmCE/jBFQO2
         yeTuZNMJA2bv076C7c8IQVsJJASFjqUFRAV6D5qtcTPAyRMd+5uQFKmDzNJ58b90lr4l
         pUD2dP22qqSjXi9NDoOAuJEIqHBh5IpDtNFFrLz4qLWCJiUqUa9R1rNpgofVS3XE9+jQ
         4Jk2USIlix1B2KnDK13YbLazuKaVCjbyY/V25AqBQkMjiTkT/LkSDXMYQZ1rlf8GKYIR
         iWFIY04Lnv1mFU5/oBHFdleDpTZAjPi4HWtW7auL43VCdxoYvxoRQgIW4Mot+mkiKql/
         t6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EXLe4AcieipOgmpyanQu8zzMg2qhrzhfuhvzqnhslJw=;
        b=J+4EZ0+QX2cFxkOirgtewMdZ+g8cd+yfsSmbhVL8bS44M2zM7+QLhSgvFbRCU6T759
         FTWTlqFl2wOoLI8H3DDD67su+KdeQWVBSfT3tdJFjUWSVnTQGYnVnKpAjzVSfpkZRY7H
         lY1huh6ye14qGCHYfQbD5I0YurYQ17o4Q5LzYe9Sl5aJP2BJGLziLjua+KGstR28TzL1
         BfoUnU3OmL5hZQt/sdgT7shPAM2NIIZUXCuBh+w0HstKO9Aw78GWn9me2X2bIZ8xL1ul
         TM8/Mf7Bz2ZUSec/e/WlEZ2qLXfLVdwO0DIBQbhcuSMqxZyLVlZDtzO43spiCnU3SsYw
         hZwA==
X-Gm-Message-State: ANoB5plDpi+2vx1SufGrBQUmrd2exUsKt8pkgMbmlwTRfhz65J699HiN
        GFggMWpuXa/Gk9JlEYrs/Jg1yg==
X-Google-Smtp-Source: AA0mqf4g6gzRFmPZif4Mg9zZwILm88jWN4WgiKf4IcKDWlLGDKhoxfmGDBbPhbDlshcx4MQ+LwF+aw==
X-Received: by 2002:a05:6a00:1d81:b0:571:ea17:e111 with SMTP id z1-20020a056a001d8100b00571ea17e111mr53786630pfw.25.1670009757265;
        Fri, 02 Dec 2022 11:35:57 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c1-20020a63d501000000b004351358f056sm4454617pgg.85.2022.12.02.11.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 11:35:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>,
        Peter Osterlund <petero2@telia.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20221202182758.1339039-1-gregkh@linuxfoundation.org>
References: <20221202182758.1339039-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pktcdvd: remove driver.
Message-Id: <167000975630.934246.12888337558390915330.b4-ty@kernel.dk>
Date:   Fri, 02 Dec 2022 12:35:56 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 02 Dec 2022 19:27:58 +0100, Greg Kroah-Hartman wrote:
> Way back in 2016 in commit 5a8b187c61e9 ("pktcdvd: mark as unmaintained
> and deprecated") this driver was marked as "will be removed soon".  5
> years seems long enough to have it stick around after that, so finally
> remove the thing now.
> 
> 

Applied, thanks!

[1/1] pktcdvd: remove driver.
      commit: f40eb99897af665f11858dd7b56edcb62c3f3c67

Best regards,
-- 
Jens Axboe


