Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2D8C05027
	for <linux-block@archiver.kernel.org>; Thu,  2 Feb 2023 16:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjBBQv1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Feb 2023 11:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjBBQv0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Feb 2023 11:51:26 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F846D5D7
        for <linux-block@vger.kernel.org>; Thu,  2 Feb 2023 08:50:40 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id m26so2503350qtp.9
        for <linux-block@vger.kernel.org>; Thu, 02 Feb 2023 08:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tztcBchRZ+ahQ+Rv8slGEZ3rlEReGoboay+wBElNpk=;
        b=V65m8bLeKyomRle8R1oVGJUm8ix6KUU1yFpdYC/oIP9+vA8K/rtDRq3erNqvoaiz1P
         uxVx6NrlDCldHPpzSBUC3nvoU4LH2+qtB+JN1sBEyn0yIG0C+pgCY+Od7Yg/bdcmubz8
         8nTJeq/o7YinhTl4qYJ0B0U2LGji7Tw29dT2ObC/Lamg3x1ZFnp7s8CZpNiXpiwLptP3
         gP3MmhWXkN5ObLxoo03DRY57B/5w8VTPTxS1CbtlPZGAvbukGV2XaeUF2gAw/cuD5MWd
         GxwWBPM0y5a9RMMQ25Jg3tLE0dtW1BqGdEVjTcewazcPV59oIW2LdZwA9iwaJwSX6+4u
         PQgQ==
X-Gm-Message-State: AO0yUKUW0zuP98HDwCLuu2vEgk3hE8Q47kTFYIJIdmqovzwAFxvQlgHs
        c9yDk+tY/XBUFxxbxpNZmJwn
X-Google-Smtp-Source: AK7set+4Pyeb5ompgmUg0JYUv54bCb2ceknHgU0XW/UAy594tQAOCFstY5279x2+bA/W3Ae7xhvLGQ==
X-Received: by 2002:a05:622a:1788:b0:3b8:2ea9:a093 with SMTP id s8-20020a05622a178800b003b82ea9a093mr13141578qtk.1.1675356639078;
        Thu, 02 Feb 2023 08:50:39 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id t9-20020a05620a034900b0071eddd3bebbsm31687qkm.81.2023.02.02.08.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:50:38 -0800 (PST)
Date:   Thu, 2 Feb 2023 11:50:37 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, dm-devel@redhat.com
Subject: Re: [RFC PATCH 0/7] Allow race-free block device handling
Message-ID: <Y9vp3XDEQAl7TLND@redhat.com>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230126033358.1880-1-demi@invisiblethingslab.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 25 2023 at 10:33P -0500,
Demi Marie Obenour <demi@invisiblethingslab.com> wrote:

> This work aims to allow userspace to create and destroy block devices
> in a race-free and leak-free way,

"race-free and leak-free way" implies there both races and leaks in
existing code. You're making claims that are likely very specific to
your Xen use-case.  Please explain more carefully.

> and to allow them to be exposed to
> other Xen VMs via blkback without leaks or races.  It’s marked as RFC
> for a few reasons:
> 
> - The code has been only lightly tested.  It might be unstable or
>   insecure.
> 
> - The DM_DEV_CREATE ioctl gains a new flag.  Unknown flags were
>   previously ignored, so this could theoretically break buggy userspace
>   tools.

Not seeing a reason that type of DM change is needed. If you feel
strongly about it send a separate patch and we can discuss it.

> - I have no idea if I got the block device reference counting and
>   locking correct.

Your headers and justifcation for this line of work are really way too
terse. Please take the time to clearly make the case for your changes
in both the patch headers and code.

Mike
