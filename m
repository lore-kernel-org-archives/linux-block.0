Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67904C07E95
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 19:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4797E613ED
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 19:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhGBTjA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jul 2021 15:39:00 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:38515 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbhGBTjA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jul 2021 15:39:00 -0400
Received: by mail-pg1-f171.google.com with SMTP id h4so10607178pgp.5;
        Fri, 02 Jul 2021 12:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fSA+05GWEA4Xp/RtxaVfD9HgIPZasyGHyolvKc3XGcM=;
        b=q/Uapi+F7Yk0ej7uUT6thJ4WGUtbPr7/hIaUg9yhethBJfplSgDaW3CeVxDVJwX4pQ
         y7f+8Jsm59VzIwb7Htxz31JMeKVN6J7FAe2mNGf8nIr4TuxctdCZKJhuCDF9aSXzfRW2
         9gKNJ26irWL4js0MhTaM70v0zqtsI6kA1BzU1zOIL5gs0qg4+ieKbgHkMQq6XroeKUbf
         uzjcc2K7C106CoK2Om+KJ52j27HsYji0HSGmw8SDvq5IIRqZTRai8/r2x+ceztSXacFA
         s7Lb2n/WQaLfj+bpgOPPJj5w54tpQzDGSAAarFtieZCtDblwb8QuTtZm9jRyXTkif19A
         7FOA==
X-Gm-Message-State: AOAM5327LLknYEWR0M7TkOBzHawUJLhIHvgNL6DoqlwV6lRFp73rluEZ
        mye/dsgLDZJOWzq1srDTOGQ=
X-Google-Smtp-Source: ABdhPJzh6of4wl7VTp9obKCUaCzEG5aKpR7HbTnboBFHPVgv7sZKgmbl3fZZULAxIc94si8PfKZ6WA==
X-Received: by 2002:aa7:818a:0:b029:309:a073:51cb with SMTP id g10-20020aa7818a0000b0290309a07351cbmr1153128pfi.40.1625254586670;
        Fri, 02 Jul 2021 12:36:26 -0700 (PDT)
Received: from garbanzo ([191.96.121.144])
        by smtp.gmail.com with ESMTPSA id w18sm3760127pjg.50.2021.07.02.12.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 12:36:25 -0700 (PDT)
Date:   Fri, 2 Jul 2021 12:36:22 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, rafael@kernel.org,
        axboe@kernel.dk, tj@kernel.org, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] zram: fix few sysfs races
Message-ID: <20210702193622.4nsotee7jz4edwfl@garbanzo>
References: <20210702043716.2692247-1-mcgrof@kernel.org>
 <YN6rq03Mf+eSrL43@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN6rq03Mf+eSrL43@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 01, 2021 at 11:01:15PM -0700, Minchan Kim wrote:
> On Thu, Jul 01, 2021 at 09:37:14PM -0700, Luis Chamberlain wrote:
> > This v5 modifies the second patch, the set of macros needed a bit of
> > adjustments so we can keep the same name attributes. It also updates
> > the patches to fix all checkpatch complaints.
> > 
> > Luis Chamberlain (2):
> >   zram: fix crashes with cpu hotplug multistate
> >   zram: fix deadlock with sysfs attribute usage and module removal
> > 
> >  drivers/block/zram/zram_drv.c | 108 ++++++++++++++++++++++++++--------
> >  drivers/block/zram/zram_drv.h |  54 +++++++++++++++++
> >  2 files changed, 137 insertions(+), 25 deletions(-)
> 
> Guess first patch would be confilict with recent kernel.

OK I guess time to update my linux-next :)

> Anyway, please send the patchset with Andrew If he doesn't
> pick in a few days.

I'll verify if no changes are needed after I bump to the latest
linux-next, otherwise I'll send a v6.

  Luis
