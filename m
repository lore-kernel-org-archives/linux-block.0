Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDB1C11F68
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 06:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 454956141E
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 06:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhGBGDw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jul 2021 02:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbhGBGDv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jul 2021 02:03:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CAEBC061762;
        Thu,  1 Jul 2021 23:01:18 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id s14so8131700pfg.0;
        Thu, 01 Jul 2021 23:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oPi06ZHVRg+TxnMHHHCYc5ilWLPWl5RCydFn9y2UZ7I=;
        b=JorXze+DS8+eoxmrF+5lyYwvNYWOThuE7MD8xgX4QhF38EYYDU3oWVyvKQ6mmv8Qkt
         hBNsf689OfUAHH+x6yjutzjhzTTZrmi34y1Ud7taaXLcDYUyQHGp8aNzhXHD9Vh09H1I
         24h3KIA5SVpSHwz6EmUD6xUg34dHuzUxjSrIIkYV36mSyzpFJA0WdB98VeReqjsW/Fui
         7Ht4g6ymp831ULgnh4yPAMGwdy278pbQohBz4sI+ZI5Opoc8d2q5L7HNp2Q3IBYqrUea
         ++9E0xPDt3QeO5kATltboknTnlholsroA+O5LCDMcSrR1h+1RiCEF6etcf1LrsPxFyr2
         g6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oPi06ZHVRg+TxnMHHHCYc5ilWLPWl5RCydFn9y2UZ7I=;
        b=qMvkAhFqXrux0nwXnw5qZalEa2twN3RrDk47Ros2qt3zHPJVZVK8eQYKT9nkWRwP1J
         a12TQBPv05J2CKNKxmmqdDuNwgStubib22RbaDbl0JwY5F5HZlMOHwpPdBC1YGvMguUy
         BowblMgZeaqAKnuVSIApPZpfUSefTiXeLzLempSmgTrvWXdaIleslA3NOPY2h6d6Itc7
         Ty7IgAsTB0nbWBTgTiyQ39iAi87kcDmB9WxHW3oSD1xr88SEmVG91Fdwf9LVLspbjyoc
         LHwYDeSFQ35+vs4I1tT0L9OLdtKyegpt+HgDlmZbNa+ia3RZAxfMc/ctFpOdF32z+Sv1
         pFmQ==
X-Gm-Message-State: AOAM531WMeRe4b8f0JJwcqifcBu+J8gWw67kj6Ri36mx8XuYzARfBCps
        e68THuo5/PayzyIjXVivMuU=
X-Google-Smtp-Source: ABdhPJwF3xarKTWFo9SP0wUcqz8z+4hm+xTgn2YxtNcBcOL6Rq9j7gZz42bkAnngiGbqPoBIWRebAA==
X-Received: by 2002:a63:5446:: with SMTP id e6mr3543764pgm.73.1625205678405;
        Thu, 01 Jul 2021 23:01:18 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:e476:fcd4:d1bf:22a2])
        by smtp.gmail.com with ESMTPSA id gk20sm1431573pjb.17.2021.07.01.23.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 23:01:17 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 1 Jul 2021 23:01:15 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org
Cc:     gregkh@linuxfoundation.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, rafael@kernel.org,
        axboe@kernel.dk, tj@kernel.org, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] zram: fix few sysfs races
Message-ID: <YN6rq03Mf+eSrL43@google.com>
References: <20210702043716.2692247-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702043716.2692247-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 01, 2021 at 09:37:14PM -0700, Luis Chamberlain wrote:
> This v5 modifies the second patch, the set of macros needed a bit of
> adjustments so we can keep the same name attributes. It also updates
> the patches to fix all checkpatch complaints.
> 
> Luis Chamberlain (2):
>   zram: fix crashes with cpu hotplug multistate
>   zram: fix deadlock with sysfs attribute usage and module removal
> 
>  drivers/block/zram/zram_drv.c | 108 ++++++++++++++++++++++++++--------
>  drivers/block/zram/zram_drv.h |  54 +++++++++++++++++
>  2 files changed, 137 insertions(+), 25 deletions(-)

Guess first patch would be confilict with recent kernel.

Anyway, please send the patchset with Andrew If he doesn't
pick in a few days.
