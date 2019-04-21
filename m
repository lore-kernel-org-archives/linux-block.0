Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285D1C10F14
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 08:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD84720859
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 08:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgQaRqcf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfDUId6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Apr 2019 04:33:58 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:42327 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfDUId5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Apr 2019 04:33:57 -0400
Received: by mail-io1-f41.google.com with SMTP id m188so6332309ioa.9
        for <linux-block@vger.kernel.org>; Sun, 21 Apr 2019 01:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=p8C0OdJ1M1hmKI4i31J4iml6B0M5Tibo3xZOghDffRA=;
        b=PgQaRqcfhqyLZyaKlX2Oasg0XIqQSob6FoF4lQwcm2zXna/ahG7ATMQutxjnXn5A9k
         hioLvBjMoZrQKqSQ2xp1F5qqk4OHXWsSLAawdUXYOwY5p/vL0pPRWDxcWvv/Y4o/CRP8
         wOAz98CscdXEat2D4C3fWQHwTfZviB6Ftm84wg3J+5bBNAR8AhY/uAqTFoZDwCVEIBwC
         9v4E0jtc3vCV5HD4doHyRnyObAGBqfp9rlVe8KxfyRXdBFdEHsPqpF1QysEI2Z/LfsbT
         BlDVE/+gOPSi9a3poWrD2XjLX8PnFLEjQ8xiC+x/TfHI+F4gtAFIxr5nSoXYGxyUc2Zk
         ADpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=p8C0OdJ1M1hmKI4i31J4iml6B0M5Tibo3xZOghDffRA=;
        b=MhApGWwNEK3pYXVV9lWxUF7LDSGMNXL0Jnr4oU3Y4K40Oj6Exdjwd6HDkrIPP2/ypS
         YUaIo/dfUc7FogVqjE//b+ZLCAuKlR15np7Nkf/7Xf22pECrIm6Egc/XxUTPQgRHB9l+
         kT+JdYC4M3xCB42esqA/dqfZwsM/j/bPJnErCHrx6+/9RKP4bTsyXuJgo5BembUXrOoV
         u73wuEedYFUWFc1ZaMDReM15SpARqUUItBvkwoCI4lrkTg0XhSArf1JasJ46ObfpHRjN
         x0oa8fPCjVRRpHzzQlk5KYOtYVQJ8/6ZA+PUAIoO7t6dEb3LgWREnwLrcYh9Rq86+Xpo
         ymNQ==
X-Gm-Message-State: APjAAAU1dw3jI/QoB/cSgQhv/9ouA/AKgiu7ZfeGJMYomp2LgG/8MQhH
        arFYF8eeXR5TZ12dVmWajqKd2z7WFvqgScNVSADZAQ==
X-Google-Smtp-Source: APXvYqz+NcVyv11d5U5mcmDcFkCYRINLJnne8rIIY5dhgy2tE/k6sxd8YljW9uHQ6IaGnzfcJKbKZNZDXZUf4R/z6Hg=
X-Received: by 2002:a6b:7b47:: with SMTP id m7mr827800iop.173.1555835636987;
 Sun, 21 Apr 2019 01:33:56 -0700 (PDT)
MIME-Version: 1.0
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sun, 21 Apr 2019 10:33:45 +0200
Message-ID: <CAKv+Gu-fprVgQ576__VDZ1L8HRghtCus_E-F0Q3gRzDLN=pjtQ@mail.gmail.com>
Subject: breakage after "io_uring: offload write to async worker in case of -EAGAIN"
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        rpenyaev@suse.de,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello all,

I ran into an issue booting a graphical desktop (GNOME) on an ARM
based system with nvidia graphics and the nouveau driver (which is the
only one available on arm64). Bisect identified the following commit
as the culprit

commit 9bf7933fc3f306bc4ce74ad734f690a71670178a
Author: Roman Penyaev <rpenyaev@suse.de>
Date:   Mon Mar 25 20:09:24 2019 +0100

    io_uring: offload write to async worker in case of -EAGAIN

and reverting that on top of v5.1-rc5 gives me a working system again.

I don't see any errors in the kernel log, but the graphical desktop
never comes up. I can still ssh into the system and everything else
appears to work normally.

I'm a bit out of my depth there, so could you please help me diagnose
this further? Any conditions I should check in the 'else' path?

Thanks,
Ard.
