Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8351C433EF
	for <linux-block@archiver.kernel.org>; Sat, 21 May 2022 19:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345382AbiEUTqJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 May 2022 15:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244562AbiEUTqI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 May 2022 15:46:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662171583C
        for <linux-block@vger.kernel.org>; Sat, 21 May 2022 12:46:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p8so10373679pfh.8
        for <linux-block@vger.kernel.org>; Sat, 21 May 2022 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zX5ok7BJ7D+wfGwmQ8/pQkeL6pnnmgUlA3fKtsver3U=;
        b=WOzdn6iO4OrpBAgQhS+QhjwGJ1+p1jNil1znlCHh1oyStS/cCmofFee1gCmgKV00FQ
         SQX1GEC0F98jIatP1VV2t9F04XF9Q0nSe3EsuhfSA/AI2/IVqwm1KtF2pW0KDmnm3WGI
         VW9Ttok+oxGHkkzwgPg3/81BJB2YmSEiraKkE6xmPNa2oxxNHsxAi5cQ7kIgXnPBpF7q
         9gCJIl7jVbqRkgdD490aNOQNlvhhyWa8SndtLn53/sXqiCK9+HfjkyaFmKmXrNJNhjtJ
         O8LxeCRMpP16/ABpUxMUbFQiEEYXpC/MmnkMykxcJMBZxd4HhkwPa/vneb+YOPLlLKqt
         I/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zX5ok7BJ7D+wfGwmQ8/pQkeL6pnnmgUlA3fKtsver3U=;
        b=awlqhrsToynDIC4es98BMVzl7AgbB9SWmh/s6Vw82j0rShpPeRqAyS+H0TG6//ETR2
         yuY5ALwnFqj9y8J/50iVkw8kvLbtrg6neVF4UfQaN1EVCwp/hKyMf/bF6EnZy4eZugo8
         Vo2eM6/xYcNMUgHSzExeebXmhYoM5o20kBekWG0VotDTIKh/wbOpVXNM5IrjxMJz+/9+
         MTATSJUV+XEzUkyaZLS0mJzd4y03RcDE9TGn5aQq8Rh8Pt6mq7hMdu0NXGs2SCrZlrG5
         Gpnce9RrKw4kbH+sYg0YJCiYNZ7i8cOYpSZ8E+/BtzNXXqYvSDAQAlvWxDsrDVvcgy2H
         83Bg==
X-Gm-Message-State: AOAM531vze1wmpU3RTOgjtNMw1E873Xa20K7BmnGjYkIVRss21DT/Vx9
        iEqZwr20CQVhwbv3ujm7uxQYoA==
X-Google-Smtp-Source: ABdhPJxbcUpunxaw0PstfwrdemrAznw9JU57xGuOAyg7DM7aIFDIXAliI8Nxt6ZJIbS/N6XC+EMeow==
X-Received: by 2002:a63:1e0c:0:b0:3f2:5b19:24d0 with SMTP id e12-20020a631e0c000000b003f25b1924d0mr13900376pge.562.1653162362867;
        Sat, 21 May 2022 12:46:02 -0700 (PDT)
Received: from hermes.local (204-195-112-199.wavecable.com. [204.195.112.199])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902760b00b0015eaa9aee50sm1955491pll.202.2022.05.21.12.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 12:46:02 -0700 (PDT)
Date:   Sat, 21 May 2022 12:45:59 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, mcgrof@kernel.org, tytso@mit.edu
Subject: Re: RFC: Ioctl v2
Message-ID: <20220521124559.69414fec@hermes.local>
In-Reply-To: <20220521164546.h7huckdwvguvmmyy@moria.home.lan>
References: <20220520161652.rmhqlvwvfrvskg4w@moria.home.lan>
        <Yof6hsC1hLiYITdh@lunn.ch>
        <20220521164546.h7huckdwvguvmmyy@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 21 May 2022 12:45:46 -0400
Kent Overstreet <kent.overstreet@gmail.com> wrote:

> On Fri, May 20, 2022 at 10:31:02PM +0200, Andrew Lunn wrote:
> > > I want to circulate this and get some comments and feedback, and if
> > > no one raises any serious objections - I'd love to get collaborators
> > > to work on this with me. Flame away!  
> > 
> > Hi Kent
> > 
> > I doubt you will get much interest from netdev. netdev already
> > considers ioctl as legacy, and mostly uses netlink and a message
> > passing structure, which is easy to extend in a backwards compatible
> > manor.  
> 
> The more I look at netlink the more I wonder what on earth it's targeted at or
> was trying to solve. It must exist for a reason, but I've written a few ioctls
> myself and I can't fathom a situation where I'd actually want any of the stuff
> netlink provides.

Netlink was built for networking operations, you want to set something like a route with a large
number of varying parameters in one transaction. And you don't want to have to invent
a new system call every time a new option is added.

Also, you want to monitor changes and see these events for a userspace control
application such as a routing daemon.

