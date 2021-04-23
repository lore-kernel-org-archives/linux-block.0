Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3197C433ED
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 18:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82DA4613CD
	for <linux-block@archiver.kernel.org>; Fri, 23 Apr 2021 18:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhDWSjY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Apr 2021 14:39:24 -0400
Received: from mail-pj1-f48.google.com ([209.85.216.48]:43774 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWSjX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Apr 2021 14:39:23 -0400
Received: by mail-pj1-f48.google.com with SMTP id f6-20020a17090a6546b029015088cf4a1eso1740883pjs.2;
        Fri, 23 Apr 2021 11:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j4sZXZ1o4MjdkC15QWzfQbK1sY4z7xW8uKy+uGk+ww0=;
        b=pJMGaN1eu8kowV+sAnoRBC22x49Lttm/H8l5qPAO1ESbwRDpyO01Loj56cUAdsEtTn
         7amDL5o+ORjuAKz9EcHS05Gno6gjiOzDwWf7tA94MJISK62Umlud7PUYZL4e9gniz+/4
         xu77LpOgmKCZtkaS5ki0GnonJiOA/4hs9rLAAjT1MEaO4S6p2vgPBXp01A7DFl8k68J9
         EKIn/EMke7QYEPV1wLg3hxnbzbXtwbWpcbOf+REP+hViRhx43prb5Nx/ozYvjROZq5xq
         5Fy+6od6d3dKD4Aw6f3pgccrL+oUTU5Xf1l+CEYEvT8TKQEovADOy6k4E+O7cnSwovus
         5BmQ==
X-Gm-Message-State: AOAM533kVkKMh7a66rZNasL4JHvq9VoO5fZMbxSfocGHmbSk+U7CK+8C
        fBP9pxwG6h8aYS6nHv9kYNE=
X-Google-Smtp-Source: ABdhPJwchh123swOX4qE9Z64SnEPer76yNF3aNDPGpsVvy+ZVNO/T9YCcVpJeh0lk0SW68lkK8nFSQ==
X-Received: by 2002:a17:902:c641:b029:ec:7e59:aca with SMTP id s1-20020a170902c641b02900ec7e590acamr5319104pls.63.1619203126812;
        Fri, 23 Apr 2021 11:38:46 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id e65sm5210008pfe.9.2021.04.23.11.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 11:38:45 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1A82E40244; Fri, 23 Apr 2021 18:38:45 +0000 (UTC)
Date:   Fri, 23 Apr 2021 18:38:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix userspace documentation reference for
 del_gendisk()
Message-ID: <20210423183845.GP4332@42.do-not-panic.com>
References: <20201117140658.12199-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117140658.12199-1-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

*Poke*

This documentation fix is not merged yet.

 Luis

On Tue, Nov 17, 2020 at 02:06:58PM +0000, Luis Chamberlain wrote:
> Commit b5bd357cf8b ("block: add docs for gendisk / request_queue refcount
> helpers") has a typo where it references drivers for del_gendisk() when we
> instead meant userspace, as the reference is to the userspace experience.
> This fixes this.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  block/genhd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index 0a273211fec2..9511620f558a 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -880,8 +880,8 @@ static void invalidate_partition(struct gendisk *disk, int partno)
>   * with put_disk(), which should be called after del_gendisk(), if
>   * __device_add_disk() was used.
>   *
> - * Drivers exist which depend on the release of the gendisk to be synchronous,
> - * it should not be deferred.
> + * Userspace may exist which depends on the release of the gendisk to be
> + * synchronous, it should not be deferred.
>   *
>   * Context: can sleep
>   */
> -- 
> 2.28.0
> 
