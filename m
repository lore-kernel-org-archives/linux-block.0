Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA3AC10F0E
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 21:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFB8206B6
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 21:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEI9GKrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfDOVHe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 17:07:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43612 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbfDOVHe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 17:07:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so9215133pfd.10
        for <linux-block@vger.kernel.org>; Mon, 15 Apr 2019 14:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ixyrhwLSHN7xPK++4eqvWmKOejzBaEc82qt+DaQgCnw=;
        b=MEI9GKrgVkl6U/xDARgZOs+ap7/XTXlA/70kCmbiPnyO2J+U00EWs0TDEUzyhy5b3l
         UCMcvzuqe+67ijOg5uM+HvY1w2Z29Gtj9OBv1n7S26R/cHw8kjP9P74brurQUZ/8AYfc
         zocrVEecXGu2IHnbQ2Q//trVfjLklkJf2sJkEOv3H9RPpAWClkqbUe/pHX14iwo0DD7f
         /3F3Y5g314V9sGg1YR0Z8OKlXu8FH+kJ8PtrS0L2Ohan0Rii+YsGBxnuti0ObnuKzZSm
         dOmD1kmlRJr3V0L1wkVajXXTSueYZW+wt4qT7XfIMV0zSeZ1lfZKicNv5k17HKC+hHa/
         wAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ixyrhwLSHN7xPK++4eqvWmKOejzBaEc82qt+DaQgCnw=;
        b=GnhOoCQ4NhBICQekbVrH6/jdAdUWJT1QM6z0ohVAeurxmRPePIfIG8NcUuE9ASOZxj
         EVGgMWaBnDnW9dXa7cgOUygd+Z1eAYpRFtlgLxIbUnk4YvHZuy51tcpWLcQOJh5l97iP
         Yp9Q7LqgzHvY1lo+Phevr/bzHOiFa5w+GzXbSCLS3Yt8n5AO8XmkNK0JsuIToLjISjfV
         scL2+ttffM5bXlKNvrez4OGGzZIf6e2hjDJjnRLBFBoa+oQvhwWY7C1kHYLXV9OL06c5
         d6Uh3EZOEG8igrxikj8WgvHUrUVrwhi19aIEsmFY0X1ttahYBm2SxHy9aTcmqAlH0gUn
         jU7Q==
X-Gm-Message-State: APjAAAWsRGMw1+iE3dy41wHcvL4FDPAipA9nZDDXG9aEpxw9DU44i/iu
        aOhcNkjTkA/LqRbpu1+J0HQ=
X-Google-Smtp-Source: APXvYqwDT3+e5WBPOPoqMkzrdDnwXwUxdoxzRIQFjtyEy/LhyzqeAGHcXAPjvv27SAn0Y20G9vvTmQ==
X-Received: by 2002:a62:b602:: with SMTP id j2mr78945897pff.68.1555362453407;
        Mon, 15 Apr 2019 14:07:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p14sm64964216pfa.26.2019.04.15.14.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 14:07:32 -0700 (PDT)
Date:   Mon, 15 Apr 2019 14:07:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page
 call
Message-ID: <20190415210731.GA32723@roeck-us.net>
References: <20190408104641.4905-1-hch@lst.de>
 <20190408104641.4905-2-hch@lst.de>
 <20190415194435.GA23676@roeck-us.net>
 <20190415205242.GA6380@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415205242.GA6380@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 15, 2019 at 10:52:42PM +0200, Christoph Hellwig wrote:
> On Mon, Apr 15, 2019 at 12:44:35PM -0700, Guenter Roeck wrote:
> > This patch causes crashes with various boot tests. Most sparc tests crash, as
> > well as several arm tests. Bisect results in both cases point to this patch.
> 
> That just means we trigger an existing bug more easily now.  I'll see
> if I can help with the issues.

Code which previously worked reliably no longer does. I would be quite
hesitant to call this "trigger an existing bug more easily". "Regression"
seems to be a more appropriate term - even more so as it seems to cause
'init' crashes, at least on arm.

Guenter
