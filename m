Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDA7C433E0
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 14:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F5882074B
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 14:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591624869;
	bh=XixQp93lspus85NPPKF37jVF3oSST+JuOU19MO5ECRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0ucnnYL+s6MMmbbzrUglW4y4n5XAwDekT7NW6CC3tOd0bi3fRzrUbP1OSiBgUGmLy
	 AbpmtPMNzqC+xAx+MkM10W9W6u8hlTrQM2kTM6QchgNCapdFgdg4O8NWN2mNv6Ndvx
	 zAzWC1GGYMa1q4rZAYBwYhqp9MEjGyISLskD53Xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgFHOBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:01:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46450 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbgFHOBH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 10:01:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id b16so8567342pfi.13
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2020 07:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tz2+FM+x9SJDnO7Y3WCb5r5W8K4z0Zf2nVJcXJyVKWM=;
        b=ZljkGMAZ3OBKjVyeNIvgYNXYsFdYZh/oAnyAWHEE7pCT4FuFE5H8iVU3Hy+SavyuJu
         hdj/uRJ80PMJpl6OtryWGjBWSZ7aNL97erwb6zGaquUoC8H4E/RMA9f9XEGQZVgvJBCf
         KWDrvgC0myDvjz0vc8WpFZw7IA19l13hRfnoZ0HsOVL4ekbfA25rt7bIiCUxoNY0UsLo
         0mFWdKFhP7/MtS9WhA2nfp/0lneD7NeD6GMooYF8CGmYz3r/DnwIxztrUw/QuA33fKQ6
         g4q4sP/M7yjJ21P6FHqW6pkK1xITw7htDj5CXLOOvoAeO/HTYYDt1AcGRq0f62Q1SJ1T
         CrQA==
X-Gm-Message-State: AOAM532RCmY4DT5JMqvZ7+WGpRqD2U3J1WFOMlHVmAH43pC6sgyLj0lt
        Z9+zhF76D/C0IBru0W+U9iI6OXzGQyI=
X-Google-Smtp-Source: ABdhPJwgWKLbgQEtp90QYDXwMurm1HMhb3amemkBg6sARduwpI2D98dmOUg8pYA7jVbLXIsq8y04og==
X-Received: by 2002:a65:6715:: with SMTP id u21mr21354079pgf.365.1591624865710;
        Mon, 08 Jun 2020 07:01:05 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h13sm7365712pfk.25.2020.06.08.07.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 07:01:03 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7456E403AB; Mon,  8 Jun 2020 14:01:02 +0000 (UTC)
Date:   Mon, 8 Jun 2020 14:01:02 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2 v3] blktrace: Fix sparse annotations and warn if
 enabling multiple traces
Message-ID: <20200608140102.GO11244@42.do-not-panic.com>
References: <20200605145349.18454-1-jack@suse.cz>
 <20200605150350.GM11244@42.do-not-panic.com>
 <20200608082528.GK13248@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608082528.GK13248@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 08, 2020 at 10:25:28AM +0200, Jan Kara wrote:
> BTW the two patches applied just fine separately from the rest of
> the series so I don't think there's any dependency to the rest of your
> series even in context.

The depndency was just minor contextual edits, which can be fixed with
a rebase, I've done that now, so this is good to go in first. I'll skip
these two patches fromy series then.

  Luis
