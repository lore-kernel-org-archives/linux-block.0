Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDFCC28CF5
	for <linux-block@archiver.kernel.org>; Wed, 26 Jan 2022 13:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbiAZNtf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiAZNte (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jan 2022 08:49:34 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C51FC06161C
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 05:49:34 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id h23so27272489iol.11
        for <linux-block@vger.kernel.org>; Wed, 26 Jan 2022 05:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ybwGmxgwKjmKGBzbrpNwzZ2K79xNGpQw+SzUzbPkAfs=;
        b=U9yQwD5hvrqlntYpFepmK0fNluiGtNkAfJwxa/Ys5sUNsY3X4B95sS/6HyKEOFQQ6+
         OH56Bz7LywZcxuSYdgohuohgoAMmLmle66pD9VlUm/murzrnPDlr5+SJ7CdtmixjPNvE
         RTsX9tgGHvaqgbtecSxwbP0cyFUoTknSflTY72QywXtTa8H9M+hKvmWYEGenBvm/53XR
         nxBGtaA30nKlKAx7IKr1qWPr28rKBcfng6IMCxZj8UV6DSgz10onb/sTtkH/90lXoBkZ
         BkgsGi/yVvE1Przu2r4UXM1WfhkQOJbyyW3IkQozJsehnkxJDxpfV0mI90+xMhYE3z9/
         /tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ybwGmxgwKjmKGBzbrpNwzZ2K79xNGpQw+SzUzbPkAfs=;
        b=FVx/3JnwZPi+1iYxqkoUQSoYhTTvLDj8iodU5aPKTzAEmHpZ7sl6UN5cJQUqM5lhci
         wraBSxhRADykUwN9bsaGatERicNWppDNZqktr+B2yrQelBwRr+yq8kryDmU/9YF5K0aB
         58c4WdXjn1YkX/mJmvvxZJ1rtlWIzxIIHJsdpATfhUcM3uT3t2dC6BJFJaB8RaZQWYo+
         A6QArnjhYIQA7VsLNvG0x42ZZsxE+vyM7eXixVXP/ux5UAvc7HRAp6lsSbBpbKIjpyyf
         OAWC+cQBnh7I3F4WP9hIjW2SH9bFd2zU9mD2tliETFEnf0/srAADops1ZI4Wt/aATd+5
         d0Cg==
X-Gm-Message-State: AOAM533aq+vqJ68OT7114Rh9gD3RM+mPNhukQO90b2XXH8p4cO+BJQrJ
        CkyJrn++ml8+Fkgq2Ghzx+E02h9pmDsHfQ==
X-Google-Smtp-Source: ABdhPJztbrAQgID/9caJo8uomH/o7bxx2XtrRpx6ifFCoAIUI8gY+dAte+/Oj66nhikjX8YY88k5Fg==
X-Received: by 2002:a05:6638:345f:: with SMTP id q31mr6537702jav.253.1643204973555;
        Wed, 26 Jan 2022 05:49:33 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n12sm10833857ili.58.2022.01.26.05.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 05:49:33 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
In-Reply-To: <20220104071647.164918-1-hch@lst.de>
References: <20220104071647.164918-1-hch@lst.de>
Subject: Re: [PATCH v2] block: deprecate autoloading based on dev_t
Message-Id: <164320497084.125866.8866965243014223261.b4-ty@kernel.dk>
Date:   Wed, 26 Jan 2022 06:49:30 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 4 Jan 2022 08:16:47 +0100, Christoph Hellwig wrote:
> Make the legacy dev_t based autoloading optional and add a deprecation
> warning.  This kind of autoloading has ceased to be useful about 20 years
> ago.
> 
> 

Applied, thanks!

[1/1] block: deprecate autoloading based on dev_t
      commit: cee57556d6b7521f584f6dd989546ea17d170346

Best regards,
-- 
Jens Axboe


