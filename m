Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6B5C433DB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 15:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EDBD6195F
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 15:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCSPyR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 11:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhCSPyJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 11:54:09 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D345DC06174A;
        Fri, 19 Mar 2021 08:54:08 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h7so7047298qtx.3;
        Fri, 19 Mar 2021 08:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0wTT4qv7QZfT/ekLjj+h5aDeBVAVnGNSzJpRlOxQ/w4=;
        b=Ox6QMurZ5IZAN/TtoTqMbrLf3ONKGl/ZJsf4fzZoPIzqWfwodhb/OZc01khel0XyjF
         ACP6ml5yTvw+KEGKQNvgxkrnE60meuRPR/Vgj8e1D7Mdq1YuhlPiOsdWlemwjKb/1X3C
         Bn9NZ3KXAO6QWbPzHgQrt9EjXwJnwHMd+Ke7Qv5J5FjLUsH/pL8/Zo+JmcZK189YVk34
         e+1S2Sx+rgwLvRn+xQ6YngqOhNL3R+e3mKAU1p/b3Ov/DSqAOiFSJnuaiTRNKkci902Z
         X+QgLBAqfUTvRsLQo31NJ2QewfXdOBxDqB6GUudmQXErQlYj7n7WA+BX3/IRwNc8qjxZ
         btSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0wTT4qv7QZfT/ekLjj+h5aDeBVAVnGNSzJpRlOxQ/w4=;
        b=nY0DSeg8W/WdF5zcVHKXB9o1YZwpyNj7wI+XCFLMghMBwawJvVUmPAyln3T+WUMH++
         S/lQjdc4TTzHdBGjjqLiBrl02lRr5/ssjrkI5zl6FdqmOl97pVlk8+H+GtbLU4PSG0Rb
         maI7LWQv5L64q7yz9GoyTCbSCJFzJDGE1CccvGNVFAGmF1ZFN0Rbv07SbEQ2UItRmZqj
         hI3tiDKuIyqWvHNcRwMy4O2r4/Yca0p0f77AdXkV0asMuqSIiITrs/o6K96lNuKte3kn
         WeI3ThxNssjX5/d2lmWfjK+C+cn3POyzIJBRs/hbt+PsV6Im4iHmeGr3RU22BVENnNbE
         4/Sw==
X-Gm-Message-State: AOAM532XJKma9HvOcncKvrFrpvu+x85VMKYeEssQwc/b0DraJ37HrOsi
        2qWylP0qUgXx7Aty3DgxhFc=
X-Google-Smtp-Source: ABdhPJzqjqVK/mIAog/m4xLDgq27X5QRgBw2VSHRyOGPKGOJ/VHmX/cgWd5MglVy75BMcEnJ623F6g==
X-Received: by 2002:aed:2a82:: with SMTP id t2mr8657586qtd.217.1616169248159;
        Fri, 19 Mar 2021 08:54:08 -0700 (PDT)
Received: from dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com ([2620:10d:c091:480::1:41da])
        by smtp.gmail.com with ESMTPSA id h75sm4723533qke.80.2021.03.19.08.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 08:54:07 -0700 (PDT)
Date:   Fri, 19 Mar 2021 11:54:05 -0400
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] loop: Fix missing max_active argument in
 alloc_workqueue call
Message-ID: <YFTJHRfNANFIUgOD@dschatzberg-fedora-PC0Y6AEN.dhcp.thefacebook.com>
References: <20210318151626.17442-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318151626.17442-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 18, 2021 at 03:16:26PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The 3rd argument to alloc_workqueue should be the max_active count,
> however currently it is the lo->lo_number that is intended for the
> loop%d number. Fix this by adding in the missing max_active count.
> 

Thanks for catching this Colin. I'm fairly new to kernel development.
Is there some tool I could have run locally to catch this?
