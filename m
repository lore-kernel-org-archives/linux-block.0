Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40591C43334
	for <linux-block@archiver.kernel.org>; Tue, 12 Jul 2022 21:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiGLVqK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jul 2022 17:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233330AbiGLVqK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jul 2022 17:46:10 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFA8BA17D
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 14:46:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id a15so8552165pfv.13
        for <linux-block@vger.kernel.org>; Tue, 12 Jul 2022 14:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=A6xrqQWA6jeLZCKzGyv6HOaKaBTGjGBMWi46TTAW3NE=;
        b=dBCvL7PckWNfimecHeUdndjicSzsENsANzx9a2+4PzMtTJXW++/jGwuHPooILnuMqV
         TFSIO05QVRh4+j/Y+obn6avKugA39neLaq//1a5JKzAJaRgeg93qXqu7BdJNupsXlLuk
         NeH6Mzb77a8+uYfvprFoiSIEQWZ25cRIfQ2HV6umhZoXk1lCY3wGqL+QO8wHWjaUZTd+
         bIhyWMVhHF9JfBUm1WuNxZv37ubas0QkuFGN981rCkgyYJII+nfnEqv+bV4OjFSNcQfN
         5Fu2lUEJ26LVFznC1uNBnoTddjn4Jy+eI8J/oMhZG1hVMngwejPQg8oQHqvpDkHb6fgk
         0S5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=A6xrqQWA6jeLZCKzGyv6HOaKaBTGjGBMWi46TTAW3NE=;
        b=x3rWiPbeWcAApQdTGemQgSUioMBZj30imTD+HwP5vqH9N+807IOx9wX8B0ldXan+pu
         fe1duolqA1FNJHkVT6+4Moavjqy/5u4Hf3cRooczuidPcTl7JoGeLkP9dGZoLA8Vo5zc
         EyHppzkqs1WzWZVh+7PboerW1G1oeOnTAtIztq0BhWFj108c+MOmn3cI7qmrpuehHs4w
         K1AJalb/uTsU2MF9Rxvg9hm4ZTWcUNP5rGRQK9jjXXssfa17KarakSthsknU0ZyExeKr
         J9xWbVdQqwIrti++LgRtEUyWILZBf/KT7aJ8Xbd9SKG9ZS0aeKDUZOSxXLQwRM4LP3V2
         I+Hw==
X-Gm-Message-State: AJIora8bpYz5UDYOa+fjP9GCKuJZgx8nwKAbDmbaQPz2kgOk2scUuaXH
        4+L5OLFkXi4xzIxISKurPlm6UA==
X-Google-Smtp-Source: AGRyM1vWI+V7E6AzSreUqm3+cx1ca1Z7Shzh8KEPiwUAjimNW3hM3VzDqrS5RgbhHimZmzGlmWXSUQ==
X-Received: by 2002:a63:e057:0:b0:419:71bd:1d0f with SMTP id n23-20020a63e057000000b0041971bd1d0fmr257014pgj.538.1657662368306;
        Tue, 12 Jul 2022 14:46:08 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id l129-20020a622587000000b00528d843afabsm7296402pfl.204.2022.07.12.14.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:46:07 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ubizjak@gmail.com
In-Reply-To: <20220712154455.66868-1-ubizjak@gmail.com>
References: <20220712154455.66868-1-ubizjak@gmail.com>
Subject: Re: [PATCH v2] blk-cgroup: Use atomic{,64}_try_cmpxchg
Message-Id: <165766236676.63083.2141527891325153647.b4-ty@kernel.dk>
Date:   Tue, 12 Jul 2022 15:46:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 12 Jul 2022 17:44:55 +0200, Uros Bizjak wrote:
> Use atomic_try_cmpxchg instead of atomic_cmpxchg (*ptr, old, new) == old
> in blkcg_unuse_delay, blkcg_set_delay and blkcg_clear_delay and
> atomic64_try_cmpxchg in blkcg_scale_delay.  x86 CMPXCHG instruction
> returns success in ZF flag, so this change saves a compare after cmpxchg
> (and related move instruction in front of cmpxchg).
> 
> Also, atomic_try_cmpxchg implicitly assigns old *ptr value to "old" when
> cmpxchg fails, enabling further code simplifications.
> 
> [...]

Applied, thanks!

[1/1] blk-cgroup: Use atomic{,64}_try_cmpxchg
      commit: 96388f57d2aad9836b2c589181fa1dbaba4066b4

Best regards,
-- 
Jens Axboe


