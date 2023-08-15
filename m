Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775D7C41513
	for <linux-block@archiver.kernel.org>; Tue, 15 Aug 2023 01:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjHOBzm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Aug 2023 21:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjHOBzW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Aug 2023 21:55:22 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD90EC3
        for <linux-block@vger.kernel.org>; Mon, 14 Aug 2023 18:55:21 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc76cdf0cbso4758265ad.1
        for <linux-block@vger.kernel.org>; Mon, 14 Aug 2023 18:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692064521; x=1692669321;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8E3gqVae+/3PhY35u0mE0K55UplNn5j0SdclWsmek8=;
        b=fyMXhgpNcQU5FSZaE+nF1hE9LIn3vy4r+slj2VBx1gyj8Dkq/AfBjS27jZpaFDACb2
         JbzjhjsH8s5RHi9iYE6IpCzAcywiRmNfx1d5xqDDc3yDR88BBZT+FlqNd3RWLgTmFPPp
         m/PNxcD0kRRJ8bN5ERQzT4MvQrjkvsxtmzOmhXA2BqW8rlkP5QvHTflITQVGFORoj6qF
         7SjTeVwdS0AC1OBVqvC9DIt12HCiaQTCbZUUBHC9hD9Dhmli10mVxAraM5hLT2aaLnc1
         272Tn4ew4AqSS4JDliIJV6kx9Z6F7GUCtUIbCfMoXjuY9w9ECbmJQv9GTifewTupIJvH
         Vorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692064521; x=1692669321;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8E3gqVae+/3PhY35u0mE0K55UplNn5j0SdclWsmek8=;
        b=FnCWuAE0TrtV8xoEghqcdhkSmR9YHwHluVNAq3DXT4eNX8013GtZKPsEjluJF9ucGc
         rH95N85EO27HHrfTVfWOUzCyEbpKie5gZX+DLmm4RIVqRaa1C/nwiXQ3LUKeBHB9WZby
         we2Mvc8dV/h+4GB99d2lFUE/AGZ9ngy8IizCFRHT/FaWKPyGUQ1vIlzIZtonn55oW1fn
         fBK8loNuyFTsy8dYHs7jFjQb4cvJk/o1rO/OJ0QXa8i5Z9RRr6u7OTqBBs0lXpEaU0lP
         xiuCqFGsOGOc3BtT/MQ7Ac58MIvsbK2bS3gNvKQgUg3ZECD8Oq+oznUKz91tDJwuVKCs
         T+LQ==
X-Gm-Message-State: AOJu0YwX2Mi1owEWZxX1D3M2Et2a65C7pWcAjVNw4PNTEDZppl2bnSsG
        +r7gXApeKazxOkJg+X18E4VlfW9Z7UDBjGFzPIs=
X-Google-Smtp-Source: AGHT+IER8i24BIs/ILoxEMFOzy6YgNjCWsIXiFZWf8lu2tK5ujSefa2PYKpW1EQRxf0Tekn2/0I4iA==
X-Received: by 2002:a17:902:db03:b0:1b8:ac61:ffcd with SMTP id m3-20020a170902db0300b001b8ac61ffcdmr13835425plx.3.1692064521308;
        Mon, 14 Aug 2023 18:55:21 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y2-20020a170902700200b001bbb1eec92dsm10097420plk.224.2023.08.14.18.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 18:55:20 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc:     Igor Pylypiv <ipylypiv@google.com>
In-Reply-To: <20230814215833.259286-1-dlemoal@kernel.org>
References: <20230814215833.259286-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: uapi: Fix compilation errors using ioprio.h
 with C++
Message-Id: <169206452014.428095.9972774953529871129.b4-ty@kernel.dk>
Date:   Mon, 14 Aug 2023 19:55:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13-dev-034f2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 15 Aug 2023 06:58:32 +0900, Damien Le Moal wrote:
> The use of the "class" argument name in the ioprio_value() inline
> function in include/uapi/linux/ioprio.h confuses C++ compilers
> resulting in compilation errors such as:
> 
> /usr/include/linux/ioprio.h:110:43: error: expected primary-expression before ‘int’
>   110 | static __always_inline __u16 ioprio_value(int class, int level, int hint)
>       |                                           ^~~
> 
> [...]

Applied, thanks!

[1/1] block: uapi: Fix compilation errors using ioprio.h with C++
      commit: 8b6e92c358d2e12ff9f12e55bb6101e2ab053ee7

Best regards,
-- 
Jens Axboe



