Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0831CC433F5
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 16:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbhLUQdO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 11:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhLUQdO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 11:33:14 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA673C061574
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 08:33:13 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id m9so18540119iop.0
        for <linux-block@vger.kernel.org>; Tue, 21 Dec 2021 08:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=GSXEhjnLpTCvB70UfgFn0uJiiRy93oW3YjuThR0xejc=;
        b=hn5g5LkyKva2JJhDXZ617ufHbDfsPNPSmPAWQ3WInDmBD+ahyC1Fo9esrGOEc6kI67
         SqFlmZqjw6N5nDuvS2nY3SnkIqpXz93I80n8fvApH6EGX5FTJD03Mzlz25xbJeV18xxN
         MFZvr9Salohm9Lnupig/FVs8Oei9rM7yRi0gb8fxThe623OAaMJW1wXDFfdjKEzSJ7Ak
         wfHxY2MVsQiy+jEVCt+OD2lSZRWg9y8gOClgAjmTCY4HrnhaAv/j6fSIMofPkCIvylpT
         5rfgA7DJESleV0x17uZA49pJJOy69NuG/SOIfmEDn3qM6KFBIrloMuYnhGAJbxQzuONS
         OQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=GSXEhjnLpTCvB70UfgFn0uJiiRy93oW3YjuThR0xejc=;
        b=7sJ08+Rf98UbTtdTBWz/rFyJ8kBbhOQ42wlE0qxy/nUoCTWR6lm0NWImdFNO910SyS
         YocgOzAcga2wMF4FjTFDXjBH+RJHZiglzqgjaqP+CbNyivR1YEtweoSHEzIIlhW5Z1GH
         jpjF7IzGM4ldWDvGZU8nAi1klT15WxTgs83cZlg0waFc1S/NH2hSjTGGMGeM1qVxFvLs
         Qzzw4a7KSNhhehsEOLNUu9HxKKOD3aLmlo6Y2EnoCb52pKjzeb3OJxDnBZRkg5xpGzpn
         A/RveL5BawK9Iu0AdTvemVkZ0X06rFh585Q5NJ9B7hOXGkCOPLXAyzFlrcDl/luVDPg0
         mq0g==
X-Gm-Message-State: AOAM5329yujdwO3jGQmXyevGzMqXxtYEOARPOSuzkDmjBsPAag2embWm
        I7G/iVrcJzzWviwnaHh9WiLhwA==
X-Google-Smtp-Source: ABdhPJxBEmLUzcVXTaW7sBpliF39dFqCIja3Ttvq0uoyJQMdByt3YtPz+5SXixsBZe1FFZnDL+ZrWA==
X-Received: by 2002:a05:6638:1348:: with SMTP id u8mr2450807jad.95.1640104393273;
        Tue, 21 Dec 2021 08:33:13 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g1sm8913979ila.26.2021.12.21.08.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 08:33:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block <linux-block@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
In-Reply-To: <9ecbf057-4375-c2db-ab53-e4cc0dff953d@i-love.sakura.ne.jp>
References: <f81aaa2b-16c4-6e20-8a13-33f0a7d319d1@i-love.sakura.ne.jp> <b114e2c8-d5c2-c2e8-9aeb-c18eaba52de0@kernel.dk> <7943926f-4365-f741-a353-4820b8707d87@i-love.sakura.ne.jp> <6e9e3cf6-5cb6-cde6-c8ef-aafd685d6d97@i-love.sakura.ne.jp> <9ecbf057-4375-c2db-ab53-e4cc0dff953d@i-love.sakura.ne.jp>
Subject: Re: [PATCH v2] block: use "unsigned long" for blk_validate_block_size().
Message-Id: <164010439282.607614.11022428944916554995.b4-ty@kernel.dk>
Date:   Tue, 21 Dec 2021 09:33:12 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 18 Dec 2021 18:41:56 +0900, Tetsuo Handa wrote:
> Since lo_simple_ioctl(LOOP_SET_BLOCK_SIZE) and ioctl(NBD_SET_BLKSIZE) pass
> user-controlled "unsigned long arg" to blk_validate_block_size(),
> "unsigned long" should be used for validation.
> 
> 

Applied, thanks!

[1/1] block: use "unsigned long" for blk_validate_block_size().
      commit: 37ae5a0f5287a52cf51242e76ccf198d02ffe495

Best regards,
-- 
Jens Axboe


