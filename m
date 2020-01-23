Return-Path: <SRS0=CgA1=3M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C155C2D0DB
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 10:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5EC24125
	for <linux-block@archiver.kernel.org>; Thu, 23 Jan 2020 10:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HuMXlEXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgAWKfv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:35:51 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44923 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgAWKfv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jan 2020 05:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579775750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6L8nK/yXsf3UzKXoncofWr4RqyR/vIboyAU6KZ/JiM0=;
        b=HuMXlEXeU5LNBReMk2Z6CEFabOm1UEPJgQFFEYRY4iUCYnjpjZ0q94Xh7qHzJ03riqMyAX
        KJL946CpGzSKppVgJ9uxN0Bzg7yL7z5gVutijNpAgtdbDfSf4EvGavK7J74UEir23EruCE
        ChgbUJihSd95xECBODazof3M30ydkXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-0nX-IX36P9yjx0TPhlR4iQ-1; Thu, 23 Jan 2020 05:35:46 -0500
X-MC-Unique: 0nX-IX36P9yjx0TPhlR4iQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18C1F477;
        Thu, 23 Jan 2020 10:35:45 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4742F85757;
        Thu, 23 Jan 2020 10:35:42 +0000 (UTC)
Date:   Thu, 23 Jan 2020 05:35:41 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Stefan Bader <stefan.bader@canonical.com>
Cc:     linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        Tyler Hicks <tyler.hicks@canonical.com>
Subject: Re: [PATCH 1/1] blk/core: Gracefully handle unset make_request_fn
Message-ID: <20200123103541.GA28102@redhat.com>
References: <20200123091713.12623-1-stefan.bader@canonical.com>
 <20200123091713.12623-2-stefan.bader@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123091713.12623-2-stefan.bader@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 23 2020 at  4:17am -0500,
Stefan Bader <stefan.bader@canonical.com> wrote:

> When device-mapper adapted for multi-queue functionality, they
> also re-organized the way the make-request function was set.
> Before, this happened when the device-mapper logical device was
> created. Now it is done once the mapping table gets loaded the
> first time (this also decides whether the block device is request
> or bio based).
> 
> However in generic_make_request(), the request function gets used
> without further checks and this happens if one tries to mount such
> a partially set up device.
> 
> This can easily be reproduced with the following steps:
>  - dmsetup create -n test
>  - mount /dev/dm-<#> /mnt
> 
> This maybe is something which also should be fixed up in device-
> mapper.

I'll look closer at other options.

> But given there is already a check for an unset queue
> pointer and potentially there could be other drivers which do or
> might do the same, it sounds like a good move to add another check
> to generic_make_request_checks() and to bail out if the request
> function has not been set, yet.
> 
> BugLink: https://bugs.launchpad.net/bugs/1860231

From that bug;
"The currently proposed fix introduces no chance of stability
regressions. There is a chance of a very small performance regression
since an additional pointer comparison is performed on each block layer
request but this is unlikely to be noticeable."

This captures my immediate concern: slowing down everyone for this DM
edge-case isn't desirable.

Mike

