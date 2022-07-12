Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32479C43334
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 20:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiGLUkB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 16:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiGLUkA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 16:40:00 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD04CC7B9
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 13:39:59 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r186so1407851pgr.2
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=OLmzDzmTPzMJ38g54k0QU/ejd1TogD/xDNa2/MNxm8Y=;
        b=4S57N1Dp6yzh3XLZSy5FPy2xCSspLu5nsV+/x1gMHo5unctBf5APbeNGoJ5CcQz5ce
         E4fgelVwI1LfT1apnNBWVrNjNMZXlrmcMvRyGey8lRtfHq1D5GYFNUsVSgIs3S9DY4Ry
         pjuZwC3sCNTwShONX2njsmi3sHcscnWgwtThDMIqhoUTaqwzOVuKTXD3lZTfC1jI1X+u
         rY+YAEiTfSgMsGBp86XkeAhww2EJpo++SXHolzsQ3a10q7B9+mU50SUKKeU5G3TZx/6X
         R81Brwd4eNlVhJnLsYuv2oO8T0NkyGHwPsup+TM5i/svdTGU8AcnxSbVTXHj1yaAbODG
         5OBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=OLmzDzmTPzMJ38g54k0QU/ejd1TogD/xDNa2/MNxm8Y=;
        b=5Jk0FCfYi0WfZDSGiuoufIFNcHGWkCo4mFIak55qMfn8Pxg6Dq9ctj9uR+iEAhlC6+
         kUxOUu3rtjdPvlu4aj/cd49AeUowaSEcRgSktSt0WOpHnNVQZwXF289yXkISixqYFHAT
         adZZQ+/YKGTIQ9VVQ35JqItr2NKAhZEl9wt4gjJeEPOH9hTh8fpyJKMTGNfNuLyiD2tm
         x08vn3Tbd2mbJbgtdx0TvWdPZU/nvOr8xpy5txe2xlMl+etTCT6btNN+jbVBiq5mGdKX
         Us8IDrrw1E2Uvl7grwVLKWhm5ciNNlVQ1TChRcEeTtVy810DQoo2z41zBRAYo6lasmLI
         779g==
X-Gm-Message-State: AJIora/hEVY+ZRd3gR4J+2pnqQU+xK3G4KXhw+7zZrjMx8gm2QFhoG9d
        InD+RxspigvWVhWa9ousvJeA8w==
X-Google-Smtp-Source: AGRyM1tS4ymO9bj84U+iUu64WK1ti9Ajgly7NrpGjGA4RcoUW3UQW4BCmTK6GYR7i6vj6V5Dv2Vi8Q==
X-Received: by 2002:a63:540d:0:b0:412:9fb2:4d4 with SMTP id i13-20020a63540d000000b004129fb204d4mr41273pgb.475.1657658399182;
        Tue, 12 Jul 2022 13:39:59 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090a930800b001e292e30129sm19266pjo.22.2022.07.12.13.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 13:39:58 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     ubizjak@gmail.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
In-Reply-To: <20220712150547.5786-1-ubizjak@gmail.com>
References: <20220712150547.5786-1-ubizjak@gmail.com>
Subject: Re: [PATCH v2] block/rq_qos: Use atomic_try_cmpxchg in atomic_inc_below
Message-Id: <165765839842.44219.4233753152017615209.b4-ty@kernel.dk>
Date:   Tue, 12 Jul 2022 14:39:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 12 Jul 2022 17:05:47 +0200, Uros Bizjak wrote:
> Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old in
> atomic_inc_below. x86 CMPXCHG instruction returns success in ZF flag,
> so this change saves a compare after cmpxchg (and related move instruction
> in front of cmpxchg).
> 
> Also, atomic_try_cmpxchg implicitly assigns old *ptr value to "old" when
> cmpxchg fails, enabling further code simplifications.
> 
> [...]

Applied, thanks!

[1/1] block/rq_qos: Use atomic_try_cmpxchg in atomic_inc_below
      commit: f4b1e27db49c8b985b116aa99481b4c6a4342ed4

Best regards,
-- 
Jens Axboe


