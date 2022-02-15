Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393D4C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 21:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbiBOVnY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:43:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbiBOVnX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 16:43:23 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24536B3E4C
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 13:43:13 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e11so49295ils.3
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 13:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:in-reply-to:references:subject:message-id:date:mime-version
         :content-transfer-encoding;
        bh=ngpIg9tl8qQjRFLR4HZLIWqei74jAfA/kRCbUbOKoqs=;
        b=FtYGja45nuYkJHqgefciap4RzuAERv7iIPyKyYbMsanvPArdWQUmpCv1J072QYnu1H
         t8j31lmrMTjhQWjLCaJRA2/UzWjHXY8EkrDxGbkoahKL+R2fqYAxnqu7Vha3l0Qjr1id
         Gs2s5OSYzmxoE2ZzI0W/stnWzk/Bd14dTCgkSLVylrnt3P8ic7JBXQlNoha+GEuftaj0
         t6QpC/tQjMW04yuonkTok8plGgHq7G7ulwKhp5ZmHZGjt+cvDwZ8ArmMEOr34Isq7tiy
         IIZ5ukmd+w1y9arvQ+2AxcK+0TUL1Q+L+INx152S8RfBLZn6OucCwIwngm2h2LJp+Nmu
         oxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ngpIg9tl8qQjRFLR4HZLIWqei74jAfA/kRCbUbOKoqs=;
        b=vHW669XxkY71y1K4WykAq4CSMOnNT2gLSDLu5NmSXcLM3CscY2IG2P56cVBFtpIy9x
         98ybsa43buxJPoCCAJ6eJ1ZwHLa/k52+uhywbD/Jg9yJ6jnYM6pQJqrdkbBrX2PP/gXy
         Uw8grXoe+Eo+FER+MQA044g+LSwvKtWE4mwUl5bpbpbzrbsOElDxSFIhdU0N4sSpwouF
         SLbMv6crR4mDBdV2JvFkLbww+naXTZCi3PHqbydHxAO/QtbycKrrS0+0PakfnR/dcX8g
         L5iAqc8ra2mty2F+S2jnvEVskHniW0ZY+aVqVgvS8EM7RwqZ1tn5w9HxLFcVL4zZIdvS
         591Q==
X-Gm-Message-State: AOAM531F8ggYow+xLGvez8LNiVgWzq+79w8dtfAySqvS38/gL6KGWweq
        qv4zE46v68jaaSg0upLcH3LrC/gEelwfAw==
X-Google-Smtp-Source: ABdhPJxGxKMmBx6nJ3pGWfUHMDRiN0aVvkQjcNYRFIDsRpduNuzQvXMh0KBfeA30KhSxCzOUVnresw==
X-Received: by 2002:a92:c60f:: with SMTP id p15mr660845ilm.196.1644961392305;
        Tue, 15 Feb 2022 13:43:12 -0800 (PST)
Received: from m1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d8sm11108593ioy.27.2022.02.15.13.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:43:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org
In-Reply-To: <20220215213310.7264-1-kch@nvidia.com>
References: <20220215213310.7264-1-kch@nvidia.com>
Subject: Re: [PATCH V3 0/4] loop: cleanup and few improvements
Message-Id: <164496139156.13148.1299670905252631936.b4-ty@kernel.dk>
Date:   Tue, 15 Feb 2022 14:43:11 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 15 Feb 2022 13:33:06 -0800, Chaitanya Kulkarni wrote:
> This has few improvment and cleanups such as using sysfs_emit() for the
> sysfs dev attributes and removing variables that are only used once and
> a cleanup with fixing declaration.
> 
> Below is the test log where 10 loop devices created, each device is
> linked to it's own file in ./loopX, formatted with xfs and mounted on
> /mnt/loopX. For each device it reads the offset, sizelimit, autoclear,
> partscan, and dio attr from sysfs using cat command, then it runs fio
> verify job on it.
> root@dev loop-sysfs-emit (for-next) # grep err= 0000-cover-letter.patch
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=3802: Tue Feb 15 12:53:57 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=3824: Tue Feb 15 12:54:24 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=3836: Tue Feb 15 12:54:51 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=3849: Tue Feb 15 12:55:18 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=3879: Tue Feb 15 12:55:45 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=3907: Tue Feb 15 12:56:12 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=3959: Tue Feb 15 12:56:39 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=3980: Tue Feb 15 12:57:06 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=3998: Tue Feb 15 12:57:34 2022
> write-and-verify: (groupid=0, jobs=1): err= 0: pid=4018: Tue Feb 15 12:58:01 2022
> 
> [...]

Applied, thanks!

[1/4] loop: use sysfs_emit() in the sysfs xxx show()
      (no commit info)
[2/4] loop: remove extra variable in lo_fallocate()
      (no commit info)
[3/4] loop: remove extra variable in lo_req_flush
      (no commit info)
[4/4] loop: allow user to set the queue depth
      (no commit info)

Best regards,
-- 
Jens Axboe


