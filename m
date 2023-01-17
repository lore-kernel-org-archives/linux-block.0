Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC07AC3DA78
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 17:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjAQRYH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbjAQRXi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 12:23:38 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C79D45207
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 09:23:05 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id p66so15217515iof.1
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 09:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5DIPHY/njq2wIS08dD2d3rKYvkfcqoz4OTAbEpZhhU=;
        b=AEdTGsUVnxiZSN2T+ib6yVx8rOwEB75qn738SFJoSgzISngltLKD3QzUbBR1zyifU/
         3SVCS45Ef7Cjr+cQas7BL+rKwMtbYwYDg63AcwWYXJOV7dslrWe4ZeAcUFOdgTXVNTc+
         UCjioy2h9dItUaDItwKsmD8Po49JAeZPzhbxQY3jvQlcF+oZUAajjRAZCbQzw2245WJO
         Ty2QKJHn5fSTjoBL95sArlMRecK+rkTXq/4AG4bcPGbArlvv6uM43aP2xC+on33I/4Se
         gdo/duoUP/6iyoNaQVcrAbjLUWqrg3+C43/tDQ5AKbeJHulNQycE+KYJnshDYIZc08HW
         YxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5DIPHY/njq2wIS08dD2d3rKYvkfcqoz4OTAbEpZhhU=;
        b=20GnIVxC58aXyD5gs2tj5rtg3/wNetK9ZET6nMKKydwbE77wxgwak/dNgi1eAMsJdI
         rjillJJsqxq4QyFCnYL5q3UZ8XsSP3TwdvNt9UWTODEnsC586lQ/98ps7GnUFrmNH1uo
         gpHRHfTixkXHfugEiZQv6L11f4OlxcP4RPxDfxVvdb4IWK4mDii8/Yce21+v3Ti24/81
         Jauk+d0sIfvDzqxmOrDU+/HL301n0a4/nL/o2OGwgJ3EpJwo9aV9A9fo4U8OhrX74s0h
         h0WuVT0zAch/yZbp5ZQybmvJJ0cMH0EGEXz4tKkyUhBKwOZzp6EaR53w+JqsPsWsQSjg
         jtFw==
X-Gm-Message-State: AFqh2kqI1lgFjPd09dmsyg+ss70wcJdQLZINTXenMddHO3fx4N0J4YCT
        vHCchHzYVZVlJEn7EU1OEPLHiQ==
X-Google-Smtp-Source: AMrXdXsbkGmLNzDhmyWLDFtrqMnmqJZzH0nw5a4ERljZLMuqERTXm4Ww7xSXu2luIPAHBlCBueZBMw==
X-Received: by 2002:a05:6602:341a:b0:704:d91f:9932 with SMTP id n26-20020a056602341a00b00704d91f9932mr281103ioz.0.1673976184716;
        Tue, 17 Jan 2023 09:23:04 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h31-20020a056638339f00b0039e8a5930a2sm7549588jav.8.2023.01.17.09.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:23:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
        Anuj Gupta <anuj20.g@samsung.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com
In-Reply-To: <20230117120638.72254-1-anuj20.g@samsung.com>
References: <CGME20230117120741epcas5p2c7d2a20edd0f09bdff585fbe95bdadd9@epcas5p2.samsung.com>
 <20230117120638.72254-1-anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v1 0/2] enable pcpu bio-cache for IRQ
 uring-passthru I/O
Message-Id: <167397618395.17297.16132962940608644546.b4-ty@kernel.dk>
Date:   Tue, 17 Jan 2023 10:23:03 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-78c63
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 17 Jan 2023 17:36:36 +0530, Anuj Gupta wrote:
> This series extends bio pcpu caching for normal / IRQ-driven
> uring-passthru I/Os. Earlier, only polled uring-passthru I/Os could
> leverage bio-cache. After the series from Pavel[1], bio-cache can be
> leveraged by normal / IRQ driven I/Os as well. t/io_uring with an Optane
> SSD setup shows +7.21% for batches of 32 requests.
> 
> [1] https://lore.kernel.org/io-uring/cover.1666347703.git.asml.silence@gmail.com/
> 
> [...]

Applied, thanks!

[1/2] nvme: set REQ_ALLOC_CACHE for uring-passthru request
      commit: 988136a307157de9e6e9d27ee9f7ea24ee374f32
[2/2] block: extend bio-cache for non-polled requests
      commit: 934f178446b11f621ab52e83211ebf399896db47

Best regards,
-- 
Jens Axboe



