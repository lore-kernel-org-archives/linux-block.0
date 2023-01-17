Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF6DC63797
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 15:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjAQPdx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 10:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjAQPdw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 10:33:52 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DC33FF38
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 07:33:50 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id v6so6017699ilq.3
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 07:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEDyPm6c9QmB9LOvSCVJL1yg8ANlOELPCBpOPRT9CaI=;
        b=Xo/AQhYWsi57ALzv4E/rWKr/YNxZW7PU5SyvsWabBkOgy6pAYa78qYRKdLKqZ744jz
         npqcW6XjK/OtJPk07zjL9vKgemCNP6/CtfavddFkbHSs5ukxgC4503PvA2TXRHP2czRU
         i+R4g4Iv1kXri8Xd/mVWR/OHeYHlzbzxZdrf7bp4/OxNAsrhyr/1mxSPwPSbtUC0kQ1h
         vGFpdjdwE00l6G1fdSlNlGxo9uokD8OfcYOIMQqkzX7VeY8wqhJ/YlP3MnVNA1jYpPR7
         qMAiXbd2zfHxRJcRmIUbtQbdFPObbuNdwuxrDM7ylXX0EEX1Cr+xucJbcY1kDJDS+ICJ
         O2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEDyPm6c9QmB9LOvSCVJL1yg8ANlOELPCBpOPRT9CaI=;
        b=HHC1lUJVuHMrCIzlYpjnMEmxfW4fBOtxp8sEuL92sXYAKMjSUpkrJiCg1FAKYz93ed
         h+O3kmW8FuLE6D6v5Ij8PHGTKXYuZhDe5Lpb7TDJYimXpql4UPRYTJmrcy+CcJm9kzBa
         u/1W/DhqHhWWOIuqs6LNvVqtz2J8tqVdfYjs5awvs4ZXj3cqLRIN6z0/+oHHDPaY4yrb
         XKf6bzJCrjRRNnKAN/WWC+/L69/w8qXOoqCxrE2dCwVWO61PLEJ0oqsTE9XhZUhyCjov
         GSJDKBDMtU5MI2tRVleHz9kzKRQUdLfsWtxYVc25i2AMWX6r+qEjKfSiUPakn0HAlNbn
         W1pA==
X-Gm-Message-State: AFqh2kojpoqYK5JUsCOdCsO3xsF6YnEIpkocG8+ZUy3mgsG7+YJWjAoq
        sm7ut/zSNm1aOPKDtsudvcyOUuSOqvIskKe0
X-Google-Smtp-Source: AMrXdXtXjpkD4er/qZjNXXJgQ/XKFE/5ZWGqHV6cxynbL1AX7jG1SB1gmLCmBDdtrAryxKqkBxS8qw==
X-Received: by 2002:a05:6e02:ed1:b0:30d:c502:a9de with SMTP id i17-20020a056e020ed100b0030dc502a9demr598459ilk.2.1673969629158;
        Tue, 17 Jan 2023 07:33:49 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e10-20020a026d4a000000b0038ac4923addsm9366185jaf.53.2023.01.17.07.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 07:33:48 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        christophe.jaillet@wanadoo.fr,
        Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20221230010926.32243-1-guoqing.jiang@linux.dev>
References: <20221230010926.32243-1-guoqing.jiang@linux.dev>
Subject: Re: [PATCH V2] block/rnbd-clt: fix wrong max ID in ida_alloc_max
Message-Id: <167396962861.7227.6056453469138933870.b4-ty@kernel.dk>
Date:   Tue, 17 Jan 2023 08:33:48 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 30 Dec 2022 09:09:26 +0800, Guoqing Jiang wrote:
> We need to pass 'end - 1' to ida_alloc_max after switch from
> ida_simple_get to ida_alloc_max.
> 
> Otherwise smatch warns.
> 
> drivers/block/rnbd/rnbd-clt.c:1460 init_dev() error: Calling ida_alloc_max() with a 'max' argument which is a power of 2. -1 missing?
> 
> [...]

Applied, thanks!

[1/1] block/rnbd-clt: fix wrong max ID in ida_alloc_max
      commit: 9d6033e350694a67885605674244d43c9559dc36

Best regards,
-- 
Jens Axboe



