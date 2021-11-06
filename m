Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A88C433EF
	for <linux-block@archiver.kernel.org>; Sat,  6 Nov 2021 19:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0D9610E9
	for <linux-block@archiver.kernel.org>; Sat,  6 Nov 2021 19:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhKFTaR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Nov 2021 15:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhKFTaR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Nov 2021 15:30:17 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B73C061570
        for <linux-block@vger.kernel.org>; Sat,  6 Nov 2021 12:27:35 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w15so12951477ill.2
        for <linux-block@vger.kernel.org>; Sat, 06 Nov 2021 12:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=g6dCQa8LHOVQsABsddtajlBRunqB4Uil1VxpOE1O+8o=;
        b=WQ0ToyOVPQKgfjBZCSwYr33XbhHdGzbxGU1+nJMORZhGLxFREBEmqbIYd+ED+nlxb6
         2veZSghDoUU7BUZvzuXbxh995TLYSql2kYGJqx+tHHsCRhuvvcgGnAaziIXXYOjiQVXZ
         AfLp6vv2WIjt1r/ulOUITH8ELwysH0qADzQHRiUyfk9rM/Eu0+JvgZJ0O9jIwPx5Irh4
         JbVz882LaSloBhoytyDuMAA6xTAWNET3Oo40hzDHtdpyGsiXlR2A1Vyidn9J7YbbaRFF
         jzFqW2ZrGzJE4GmUk6rnJXYihA5NjB1WPYz0dCI/ddQhcqMCpe3sDwmrRlbMjCkaKq1J
         0vAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=g6dCQa8LHOVQsABsddtajlBRunqB4Uil1VxpOE1O+8o=;
        b=gMOHxEvpQR0qYCz/peqrV5TzZMuRf9UInBP9zBt91oiwiNP7mUTs6rMtSr1K/Q318F
         bYLn/T+T7b5b3hhG7HQvJMFmztCHZcSCtioYuUyvTzFXRp8P5iFqlVNzhNYeVz9waNlx
         WMrwdo81IcXEdKppsAZ2xAv/JW/26QWwtemhPxDdryGU2jTATntEVTVXPcG9hWDOJLMT
         ewAtnovbexFbb5E5PCiHPmUGqExzxNBeDoOKVhaFw80t8RdHUhg519g0YeCtXMwZU2Es
         8xy0BNNZ3VrYNHnvH6euyeAQdNYiceFADsWzs5KsqtoVl2CcNKU3M/auiCi54EELH6xo
         FkVA==
X-Gm-Message-State: AOAM530guPr/oL8lcNrnt5Pv7kJ+6jiF4iDSg0n4ugB+RozSJPlQzBBy
        tmWipTwHEHX1aR+GY9GlY1svuQ==
X-Google-Smtp-Source: ABdhPJwYAg9h7KdgsD0GqlyFP6YqfXCbbo9reZ4XcToNIbXicMp8ZQjys1oQD+6Jn5aMStdiUw6FQA==
X-Received: by 2002:a92:d411:: with SMTP id q17mr31461470ilm.116.1636226855303;
        Sat, 06 Nov 2021 12:27:35 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id c12sm6560928ils.31.2021.11.06.12.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 12:27:34 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org, noreply@ellerman.id.au,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211106185549.1578444-1-geert@linux-m68k.org>
References: <20211106185549.1578444-1-geert@linux-m68k.org>
Subject: Re: [PATCH -next] ataflop: Add missing semicolon to return statement
Message-Id: <163622685463.267869.14813196810807657315.b4-ty@kernel.dk>
Date:   Sat, 06 Nov 2021 13:27:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 6 Nov 2021 19:55:49 +0100, Geert Uytterhoeven wrote:
>     drivers/block/ataflop.c: In function ‘ataflop_probe’:
>     drivers/block/ataflop.c:2023:2: error: expected expression before ‘if’
>      2023 |  if (ataflop_alloc_disk(drive, type))
> 	  |  ^~
>     drivers/block/ataflop.c:2023:2: error: ‘return’ with a value, in function returning void [-Werror=return-type]
>     drivers/block/ataflop.c:2011:13: note: declared here
>      2011 | static void ataflop_probe(dev_t dev)
> 	  |             ^~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] ataflop: Add missing semicolon to return statement
      commit: 38987a872b313e72f7a64e91ec0b8084eaec0f10

Best regards,
-- 
Jens Axboe


