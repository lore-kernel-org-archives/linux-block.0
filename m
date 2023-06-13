Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E08C7EE43
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 06:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbjFMGKB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 02:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbjFMGJs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 02:09:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E001726
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 23:09:28 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f58444a410so1936e87.0
        for <linux-block@vger.kernel.org>; Mon, 12 Jun 2023 23:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686636567; x=1689228567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xGbu130z1RnxKoH3Z00k/EYNGxDJ/ndaMTIJwz7/L08=;
        b=2KWRZHgRZDRZRt8sfRhTo/wZZKNDXflR5DgEGYXphjyNhgup7HAf5kch2vs9l757hT
         UEiI+x9yZTuuF90p2EBlpPcIJQDFWqqkC4ZO8bFQ2NKJEWiAyWQWFxdPB/y9mwNuC9+8
         lYLotUZYexzi/MTpG/IbQ2jkFyWOpahYa7D4zpQGKxlWIDFssPL9KhKwxE3O22+yANMd
         UDvYaasp2AjuNADnYC6lgirF2Nt46cd2BV8LXhNoL4ZGs4QrNRapqmtMRHGmpWxyTjQh
         5Rntacj6tVjA7FaQOfubwhglbe5vYy4/dScWwwtRutBotttFZaDo3FMlztKik3TcH3C1
         7wrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686636567; x=1689228567;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGbu130z1RnxKoH3Z00k/EYNGxDJ/ndaMTIJwz7/L08=;
        b=EWvSMDoYNvYahcf4Mp/+uYllS4jpkXdQB4B3tPAGLzviz2aMBzbe3FFJemW5eyvb6p
         FwPx+Efomgwp2w44iJ8vzlwpPIJF2AsmV6cTrhyPE4ZkoWTawiA6EI4FIrszRZB+Fb+g
         xiQqZ9FpcFNL/OQrJyyJSvGC5PXsGb9VzscwvYUgyLNJLul4P07tpid0IjQ46zlMA+5E
         qQsVT4gxmw/bdttfI0Q14/mh+VF1UxNNAfwOd0CcFbLGaCdJf1SJic3SdUkGGjEjLIbr
         SwWhGQvTJ0RtmnP3BYUdw+jWyXLZL9WLR2CKJvoGfCfAiPFXwSzJJnjvPP2/LyeLzQVm
         lCXQ==
X-Gm-Message-State: AC+VfDxu2cq/84Dcm2a9GWncqeRehFlaCWi5AulVLbqAcGU332jmPD62
        vP6CnY3CIB+Jkd1CqDOfD9fkQTSAMvmwuEg0v8nK0Q==
X-Google-Smtp-Source: ACHHUZ7NP/ucZh2Q7T8bButu0xoi30PXSQl4jTXOvURjSgowUr9KvJLTTR5O5mItM+PfwvyR4e/lrf8VAiL6oEOo/t4=
X-Received: by 2002:ac2:5dca:0:b0:4f6:1722:d73a with SMTP id
 x10-20020ac25dca000000b004f61722d73amr9300lfq.5.1686636566462; Mon, 12 Jun
 2023 23:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230612161614.10302-1-jack@suse.cz> <ZIf6RrbeyZVXBRhm@infradead.org>
In-Reply-To: <ZIf6RrbeyZVXBRhm@infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 13 Jun 2023 08:09:14 +0200
Message-ID: <CACT4Y+ZsN3wemvGLVyNWj9zjykGwcHoy581w7GuAHGpAj1YLxg@mail.gmail.com>
Subject: Re: [PATCH] block: Add config option to not allow writing to mounted devices
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        yebin <yebin@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 13 Jun 2023 at 07:10, Christoph Hellwig <hch@infradead.org> wrote:
>
> > +config BLK_DEV_WRITE_HARDENING
> > +     bool "Do not allow writing to mounted devices"
> > +     help
> > +     When a block device is mounted, writing to its buffer cache very likely
> > +     going to cause filesystem corruption. It is also rather easy to crash
> > +     the kernel in this way since the filesystem has no practical way of
> > +     detecting these writes to buffer cache and verifying its metadata
> > +     integrity. Select this option to disallow writing to mounted devices.
> > +     This should be mostly fine but some filesystems (e.g. ext4) rely on
> > +     the ability of filesystem tools to write to mounted filesystems to
> > +     set e.g. UUID or run fsck on the root filesystem in some setups.
>
> I'm not sure a config option is really the right thing.
>
> I'd much prefer a BLK_OPEN_ flag to prohibit any other writer.
> Except for etN and maybe fat all file systems can set that
> unconditionally.  And for those file systems that have historically
> allowed writes to mounted file systems they can find a local way
> to decide on when and when not to set it.

I don't question there are use cases for the flag, but there are use
cases for the config as well.

Some distros may want a guarantee that this does not happen as it
compromises lockdown and kernel integrity (on par with unsigned module
loading).
For fuzzing systems it also may be hard to ensure fine-grained
argument constraints, it's much easier and more reliable to prohibit
it on config level.
