Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B55C433FE
	for <linux-block@archiver.kernel.org>; Tue,  4 Oct 2022 16:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJDQmE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Oct 2022 12:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJDQmB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Oct 2022 12:42:01 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C515F222
        for <linux-block@vger.kernel.org>; Tue,  4 Oct 2022 09:42:01 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z191so10936090iof.10
        for <linux-block@vger.kernel.org>; Tue, 04 Oct 2022 09:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=Fv/RATIKH7DVnVoK46aeiXnGHzrASEQkGihJLuSD98Q=;
        b=OxB4M4DCGeQWSb2yecuTG5Cooq6Vsqk9UdlZpr80kpwsgwgoAkHd9pyp8lU2VUeOSR
         GJK6bnOUYbWolSJCgZEt9BVXvKOD5jGatt/lqHTDkZ0HHve0EcUrxEE+f67pwlZ8M2Pt
         hFUz9hk6E3MEUNVwvjRdg/QNCMnVCFgJrLxYvfKFUVqeVttBU49HnrLk0veT3V5rA6qn
         4zvLnjbyjj9L/E35VQAld0GOlaF3mPXb8orcpULsEkM7Y87EV9FOpY3222UXpfwHmYCO
         qBCJaK7yutyJzmbAeJFbNmY71FTlq+PbPtvyGmCddLWMgeeKxaYrnQoTAnqmmygijPLI
         O0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Fv/RATIKH7DVnVoK46aeiXnGHzrASEQkGihJLuSD98Q=;
        b=PBllNHZRgafFN95Yz1VDarFEP0fVE5ERKjtCvA6Y16g6qdlo35glmSYEAb9gB2seJh
         sufG3tr264EJwlkAtN79O0eawWv2C1Qw1xmHwuxd7SfUi6Dt7a2ejE7bN0RIwH9hy0nv
         B87u+qMK+PAD7XUhhVq79Pp5LHt49kr60+P8JDy6kGOjCU9fLIdFhejXAv9xj0Il4r8P
         KqIqCRwOqDudvtjBRpxm2hoO4MYFPucFXMrmV9verSInuxYK/96MWsjeDt++i51nl1m4
         wfQfQ3Atlra8fjlBd+REac6XnY38Nmtc6u4ssvGpcdqkXyV1fbD3aFjCYD7v75BrWkfo
         rWvg==
X-Gm-Message-State: ACrzQf0N+C+j9B4ylV1vnnrwXVlGIcHoR0CzMSIUEKmDXxNdYwUkE3Av
        bGoZBscTiI+XemQS8099bQYHN2/yOt8aOw==
X-Google-Smtp-Source: AMsMyM4NeENQ9RrdgmRLfa9eppQvWRZBwzbHLgFLi2NlheGpPAbafceQz30mT1kiJmMMyHXxNKYNgw==
X-Received: by 2002:a05:6602:3ca:b0:6a4:16a0:9862 with SMTP id g10-20020a05660203ca00b006a416a09862mr11681253iov.217.1664901720258;
        Tue, 04 Oct 2022 09:42:00 -0700 (PDT)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c72-20020a02964e000000b003633ef39bd3sm1638823jai.92.2022.10.04.09.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:41:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20221003202511.5124-1-jonathan.derrick@linux.dev>
References: <20221003202511.5124-1-jonathan.derrick@linux.dev>
Subject: Re: [PATCH] MAINTAINERS: Update SED-Opal Maintainers
Message-Id: <166490171926.91699.11306873216901064768.b4-ty@kernel.dk>
Date:   Tue, 04 Oct 2022 10:41:59 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 3 Oct 2022 14:25:11 -0600, Jonathan Derrick wrote:
> Add my new email address and remove Revanth
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Update SED-Opal Maintainers
      commit: 1d800f32b2574c1d055984ad17223198caddbb54

Best regards,
-- 
Jens Axboe


