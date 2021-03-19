Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252F8C433E5
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 15:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EAD61966
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 15:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhCSPwL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 11:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhCSPwB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 11:52:01 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23358C06174A;
        Fri, 19 Mar 2021 08:52:01 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y5so1779456qkl.9;
        Fri, 19 Mar 2021 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kMjEDPbpygnC4Zgi7zZrR1DkHP0YbRZnHQE2aFdwmCU=;
        b=mS5zw8Oe01ntEFj6jOCIzJO5fCGguYLRvG33EOKUjDHhWRPAzsPS7zPWWuk8wm+kIF
         VEiinXvyfr+0//VQOES7tV0CCW1ygzZn7yqOuO5/FcZyRhFBVQxn00utV6zHJGry9o/3
         5fdHlpfeitvN7sPd//kY6N9N7ua1e7JMjSoqmcyz0R+AO5Vh/kcwoLU09BDodvIpsZpx
         wGWtpwxlNPa0xXruw7FwaTcG9Vbidy2k20bgYQ211E5IA6SgHS9qyfuyTkWxZhowyktn
         L7CfTfy60IQJayYRFAEXiehOpMyBdb04GAwUyHD6QEhbobKnWliXF7gSkHRfJAK/50yW
         axzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kMjEDPbpygnC4Zgi7zZrR1DkHP0YbRZnHQE2aFdwmCU=;
        b=JV6aR1wpuyr+VEbvgydY39ZC/UMnYM1NRUTkg7ncB7qRxN423dJtuzE9zuWfO12cbD
         2rcSPIgfRt9xdCwCmY3rqIAm9G1rFnTpR6Tb84B9u9Y+kcdO55a9cnbZGToHMMtWabZR
         j84YGMczxR1vOYHOCJz1HYi+HHwa3NjkCOAualNDeqdc1In/6Sbz0sGStT6YGD9dPEON
         vazACvZLhOMzQS6B5WqWiQnTe+qHfono72AAWUK2CJEB4jBIf1yVkuEpEwR4cZrjSVeM
         f+Tujfm7P9NrDiTo8l30YTS9wQsRDR4RTy3l4+ONugNXD0008oqskwXnu3PwT/v2PqgJ
         m67w==
X-Gm-Message-State: AOAM532JQ0TqPLbXOYFoSTlhguPX6+UlxlilF+HSSOmfQHfMLeEKpzFp
        AhIe5Dm50RnRgri/jlyN9KI=
X-Google-Smtp-Source: ABdhPJwD8WFIjbeMufyINYoEA0x03j4g3xSoNVdNodVntJh36Ck1kzsQePadXpXJ+Yl8a9Xyhhdajg==
X-Received: by 2002:a05:620a:1235:: with SMTP id v21mr10018945qkj.305.1616169120455;
        Fri, 19 Mar 2021 08:52:00 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:480::1:41da])
        by smtp.gmail.com with ESMTPSA id j26sm4017062qtp.30.2021.03.19.08.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:52:00 -0700 (PDT)
Date:   Fri, 19 Mar 2021 11:51:58 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Colin King <colin.king@canonical.com>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] loop: Fix missing max_active argument in
 alloc_workqueue call
Message-ID: <YFTInvfk0vE4VFvW@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20210318151626.17442-1-colin.king@canonical.com>
 <13a1d187-4d6d-9e06-b94a-553d872de756@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13a1d187-4d6d-9e06-b94a-553d872de756@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 18, 2021 at 02:12:10PM -0600, Jens Axboe wrote:
> On 3/18/21 9:16 AM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The 3rd argument to alloc_workqueue should be the max_active count,
> > however currently it is the lo->lo_number that is intended for the
> > loop%d number. Fix this by adding in the missing max_active count.
> 
> Dan, please fold this (or something similar) in when you're redoing the
> series.
> 
> -- 
> Jens Axboe
> 

Will do.
