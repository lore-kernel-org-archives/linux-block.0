Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC88C433F5
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 15:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiI2PDG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234946AbiI2PDF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 11:03:05 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD0A13FB52
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 08:03:03 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id c6-20020a17090a4d0600b0020958fcd9acso312248pjg.4
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 08:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date;
        bh=4Q0kGVidgZNn5EqKq2GsASyHbngmRwJEXLTs/tkeDIc=;
        b=4DDUpgenrUgPc2PhLG5hb+GDdgqrGI3mZDqixC0ki+TNdQb/HuE8YLQSw6EQl5VcPu
         kRNzSk9ckQAeJ7ijq3UwZsfm1D+3U+Jzw582PFpg9EX4IzB64tdaSRb0gFn1YeHC1VqD
         FTkMhXYfk+Bjn94feiC/AtfRdoaQE3rEpthRaDX107KRf7WCG+xER0qEroaoPjoTWSDE
         EZpIPm7WbfAW2hWz15TmqMbYxLaeBQJUE3wSaEgvT39yNcK7PLyDqO1xlQMdFHatA43t
         HaCWz9gTPkH40HdJmypNSau+CyIlRjt0Pezw6TXFM2+6QPXnoNdDKiy4HNtRraT7HH+5
         VRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4Q0kGVidgZNn5EqKq2GsASyHbngmRwJEXLTs/tkeDIc=;
        b=fPRH9WSpownoxNol6tF4I4SW4+K8q70doWePJnl2yEN0ABJkf4JbY5ofe+BRysINTE
         oXEnTp3EfNaoAyfedLAox+R2RexldzKved31v63lhi4dshPpV2SJqNHHXvJLM+QuVDH1
         QDlybqVYpzgiDPMe0cwPcHJLhPGBErr/A0QorFXmkjFqa7vGULghg7IFTZul/IOsxa2g
         fKNOECDHqBvIb8kOGCGaUJB7gUqjDf0++skDe95H8+y9EHjlDyJQpeP8CCUhxYiO8Zxg
         QqPkm1s+OulNK3cp5+xFABX4fivxsr2mEyEHG8EjwD6TEHvhOeHh5E7toDqQG49DK3Os
         VV3A==
X-Gm-Message-State: ACrzQf3GespQGgrm4uMGkFEdHgYlTTipTwJqQU12Exr7wkXWDcxXwe2a
        EM+tnAePqXFPZ4OQWmP6NWsHjQ==
X-Google-Smtp-Source: AMsMyM691xfeHbJc15gMbYjUX2BSNul/FEylRXq2504/rMiKYev1kqFvA+IqZ1GQYKTlDJEkykgH8A==
X-Received: by 2002:a17:902:b285:b0:17b:c8bf:8beb with SMTP id u5-20020a170902b28500b0017bc8bf8bebmr930294plr.141.1664463783314;
        Thu, 29 Sep 2022 08:03:03 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a188-20020a621ac5000000b0052c849d0886sm6341281pfa.86.2022.09.29.08.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 08:03:02 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de
Cc:     damien.lemoal@opensource.wdc.com, gost.dev@samsung.com,
        linux-block@vger.kernel.org
In-Reply-To: <20220929144141.140077-1-p.raghav@samsung.com>
References: <CGME20220929144143eucas1p2a68d7cb3f5e347954e3a5a5e335cf620@eucas1p2.samsung.com>
 <20220929144141.140077-1-p.raghav@samsung.com>
Subject: Re: [PATCH] block: add rationale for not using blk_mq_plug() when applicable
Message-Id: <166446378255.69599.14942031119369908314.b4-ty@kernel.dk>
Date:   Thu, 29 Sep 2022 09:03:02 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 29 Sep 2022 16:41:41 +0200, Pankaj Raghav wrote:
> There are two places in the block layer at the moment where
> blk_mq_plug() helper could be used instead of directly accessing the
> plug from struct current. In both these cases, directly accessing the plug
> should not have any consequences for zoned devices.
> 
> Make the intent explicit by adding comments instead of introducing unwanted
> checks with blk_mq_plug() helper.[1]
> 
> [...]

Applied, thanks!

[1/1] block: add rationale for not using blk_mq_plug() when applicable
      commit: 110fdb4486d3a5e67d55bc6866d6426e6d49ccfc

Best regards,
-- 
Jens Axboe


