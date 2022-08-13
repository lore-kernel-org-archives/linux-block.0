Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F463C25B0F
	for <linux-block@archiver.kernel.org>; Sat, 13 Aug 2022 14:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbiHMOf7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Aug 2022 10:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239657AbiHMOfk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Aug 2022 10:35:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4302F676
        for <linux-block@vger.kernel.org>; Sat, 13 Aug 2022 07:35:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t22so3405317pjy.1
        for <linux-block@vger.kernel.org>; Sat, 13 Aug 2022 07:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc;
        bh=D/5tA9dtOXmWxz01GBPUrQpvOpxL4CLRHL9xoTz6Wg0=;
        b=HzmKoGgDCBMnygGSxcLte4W8y00NM3WOGOtmNTA1VP7rhTM1Zk3CuRkMQImsylTHZd
         Bb3ZRAWKWuF66JjH/YkUl/1OGt7JL/dt6Xmg7xWNEtUQbvzeeomLaVAL8Nju8YbpKDtu
         76diQBsi6K3BlPuJ74z1XYh2aMJ6IcbTeMuIeu1r7dwez8zioNAtYqF/t2f/+huGNj+e
         ONmmpdv0AmMffh/K6zNRcmC8Xk94p8g48XC1DwCqgHa6FRO7kU6PJ3T6KkZ1h5MxS2aU
         aOrRCLdQVb/UlEaGKZsBDnU8k/dDHmyYpslxU8Mtr9VkT5Xx9AwxClGMdnm1Nu007e+V
         ZHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc;
        bh=D/5tA9dtOXmWxz01GBPUrQpvOpxL4CLRHL9xoTz6Wg0=;
        b=1I+YgKzwOIjGYfakAkXGj+3yfQBgMgvKRxNc/8AsEVaH+rU2TeUd/F3vBfIAv0EsCh
         nln4aqHLL13kYWC5a4w9/q06cFR6e+dCH58LTwbm4biTV0OzvCrdI2Mosxi10VMapnF5
         lUO0xHYFEoB3gN7rN8xo2H1w6Jsn22DcSWLXNEPVV4dSa42uj2VKnQTnre54O4rg9UAP
         KD/xsliOTjHvJHhg32eBqfnEfSOwtnlmGBIqL1lIpuxvc9N8Mpi20L9CST1j5WjtH2B7
         miuo8/sTa1p7aCCawLbtjX5nIW3/cysnuCgXaAzvkzi5gC1tsv60SMbu6kVpD8wt3Fo9
         o9EQ==
X-Gm-Message-State: ACgBeo3EM3vjPIm7C7SYIezyOdVOpqp1Nw9rSQvg302FgT0rQzKMIaCm
        7epRDChNakdLWbs/kUwevLzt2agJRkN7zg==
X-Google-Smtp-Source: AA6agR5umMnzhL7674l/fFY/YmqHTwfYDyFvqY8zdH9rx8NcYGb5tGKtzSakER4gcQ1wa10pd9XTFA==
X-Received: by 2002:a17:90b:1b07:b0:1f5:115c:79a4 with SMTP id nu7-20020a17090b1b0700b001f5115c79a4mr9428679pjb.166.1660401339051;
        Sat, 13 Aug 2022 07:35:39 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d26-20020a65621a000000b00421841943dfsm3067691pgv.12.2022.08.13.07.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 07:35:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ming.lei@redhat.com, ZiyangZhang@linux.alibaba.com
Cc:     linux-block@vger.kernel.org, xiaoguang.wang@linux.alibaba.com
In-Reply-To: <20220810055212.66417-1-ZiyangZhang@linux.alibaba.com>
References: <20220810055212.66417-1-ZiyangZhang@linux.alibaba.com>
Subject: Re: [PATCH] ublk_drv: update iod->addr for UBLK_IO_NEED_GET_DATA
Message-Id: <166040133822.1411411.10162305492233115292.b4-ty@kernel.dk>
Date:   Sat, 13 Aug 2022 08:35:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 10 Aug 2022 13:52:12 +0800, ZiyangZhang wrote:
> If ublksrv sends UBLK_IO_NEED_GET_DATA with new allocated io buffer, we
> have to update iod->addr in task_work before calling io_uring_cmd_done().
> Then usersapce target can handle (write)io request with the new io
> buffer reading from updated iod.
> 
> Without this change, userspace target may touch a wrong io buffer!
> 
> [...]

Applied, thanks!

[1/1] ublk_drv: update iod->addr for UBLK_IO_NEED_GET_DATA
      commit: 92cb6e2e5dbaea02c2fa317f3543c8918db25e89

Best regards,
-- 
Jens Axboe


