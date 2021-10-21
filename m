Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD37FC433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E5F6121E
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 14:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhJUOZm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbhJUOZm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 10:25:42 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528C5C0613B9
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:23:26 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id q129so1109477oib.0
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 07:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=vGtljH2BhJ+3xXJWSW5RPDwkeW4g/e4rQxKKLaDQsEU=;
        b=ydUYd6dPcBWYYemxbeNd365ENl1rq/5uRh/N+sYMgI7nPF90B1KiYtLKopaiqZlLCn
         JQdIJgpjKf9QAnL62AcPIK3wrph6TX5/Sd4bebgBKTPZ7z3fL7lURtWpw3Dj/OnUyV54
         vXV7LVzXvoficNKmEDJR5hMdHhXuTXsnsXFc3QVeCEd9db1rCY+RWUIf+IzYQX/4FW2V
         Ca2QJPhdCki7cHYWxu4r6RiKEvwBMiF8n5D3hCxXAme/6CHRRmsSxlr2JWxOcseHtFcO
         G4BdQaKA5gaEKOhYVJelDHp06kjL4/C4k1qAODmPg6DV84DE8Fb1RwsGiZzgvA1Xx4ro
         g3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=vGtljH2BhJ+3xXJWSW5RPDwkeW4g/e4rQxKKLaDQsEU=;
        b=l16c5e4JcZ41zl46/Dg7hU1CudrKAvuySV6T7K1c/NjYCDmR5qHHyI2fSp29W5fynO
         sjdSzb/0b1US6wzLcFEsQ36koT0X0NYKpLiCwp2xwRKluMg9uKUqRQ4iN70/XUg2Kvh1
         KqWXhK3XH55RY0GvmCBuTy6+MPUQe8AqncTZqn8wP8j6b81bbvfp8OlsUkYcCnjaiuig
         ARIGoQf+aLxqmyyoVc1U5+lVkKssMoa7strcLRGVGV7lPisjcG5Z0UEfiS1b8HQl0kSl
         DeCcR0wksCJm/DepNG2NcdgCZZ5uwzL57B+XJf9M3vJYUsXu1X0BdjJTXXke6WV24mM3
         xKyQ==
X-Gm-Message-State: AOAM533ctB8rkBMIOJ3vNknaQCkxmXliuu5vhkels9NIMqDqGkDrSke7
        vmydL85cqsCKL+P8P6dYTcViOw==
X-Google-Smtp-Source: ABdhPJwWoVAJjxfHOeY0hW6g0Xk5RCIJFa50R/Iiyl8yzoOIRdf2FnzUA2SayCMDDv5lqcfIbGN44Q==
X-Received: by 2002:aca:60c5:: with SMTP id u188mr4983770oib.87.1634826205604;
        Thu, 21 Oct 2021 07:23:25 -0700 (PDT)
Received: from [127.0.1.1] ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id e1sm1204299oiw.16.2021.10.21.07.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:23:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20211021074621.901-1-phil@philpotter.co.uk>
References: <20211021074621.901-1-phil@philpotter.co.uk>
Subject: Re: [PATCH] cdrom: Remove redundant variable and its assignment
Message-Id: <163482620376.38159.8605397988259176959.b4-ty@kernel.dk>
Date:   Thu, 21 Oct 2021 08:23:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 21 Oct 2021 08:46:21 +0100, Phillip Potter wrote:
> From: luo penghao <luo.penghao@zte.com.cn>
> 
> Variable is not used in functions, and its assignment is redundant too.
> So it should be deleted. Also the inner-most set of parentheses is no
> longer needed.
> 
> The clang_analyzer complains as follows:
> 
> [...]

Applied, thanks!

[1/1] cdrom: Remove redundant variable and its assignment
      commit: bbc3925cf696422492ebdaba386e61450fa2294c

Best regards,
-- 
Jens Axboe


