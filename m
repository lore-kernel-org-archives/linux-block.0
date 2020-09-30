Return-Path: <SRS0=Yhvv=DH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3243C4727C
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 16:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C48E20759
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601482669;
	bh=3E8K3ITFIRuYqJsCUgJjDp/HNSfeQmlf3FgOS329N3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lxBzMZ6JssNzJPdd60+qfTnLw6F+zU0rfTDcMK4ngu4mydtmlFqRzdl9QpMaAhDNo
	 HPR8Tqgg1nBM5oA4LlEA5INOFz02DGSbR1lEvK+36aL+WZvqnhKl+CvuB4KJNH+BgU
	 3PblsFPIlZRTmRDFD9bFpLtosFpq7weRHWdttaA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgI3QRp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Sep 2020 12:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgI3QRp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Sep 2020 12:17:45 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F77FC061755;
        Wed, 30 Sep 2020 09:17:45 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d1so1646197qtr.6;
        Wed, 30 Sep 2020 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W/Hkl9GFIJfxfeMpU//nmP4ISzumsOYvRtgWyW3bzsw=;
        b=Zu7583FLPnLVk2W7IwechryeUFMKXKRxYi4bjyon/ez2PDMjPBGoc6aa+yX8MxHF/y
         3RIPLiYOlIJfH6j8sXrnQusWZ9Q3bbhIG3+qO5bXXPWkRv/x6y7WegTM/ZD8uABw2Rno
         XfMCyau5o1G8eUlk3M0LmyRKActBQkotAm9D1VqTqTo3M0uBmFgOUuW6xPkW0XnJvFZT
         j3nIrng7UNU9LahUWLhownPwtqlVSwZKiKWyxGoj5mvoHIB2Pge3jrqUCoLQqpRbXXMu
         srw1PsL5fTzTMxrL8RXGq1Q9Zx58OEHZufZfJqZjT8FkOiSl767ULIUDx6h0VUSENXDA
         KMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=W/Hkl9GFIJfxfeMpU//nmP4ISzumsOYvRtgWyW3bzsw=;
        b=ZoKFab7B8wqO5YttiAyuz8NXywlA3PYnnmJ6c3yl1Nw9akOqa0jAZAT+H5VZM7InpT
         f5Z9KIzSXtQNdqvfweyPWUo7XCmpXlzIg+AnDT3yLt0rmUlMc/kuD4qekrH9WrYIKoC3
         xyKeIx/lPbcnw6/LXWIc7M27iPzCo5ojP0ME3G/KltGEPObDtAQo6HD6hRbHGwUDXjxG
         Uw/AAGn5ra6F5fk7o1AF4N5q9pl5s5A3RBKkaP1uPwSTYoHg71Z+fFr5G0j+mtPrTWaP
         IMvbJA8YsPUarzfAzR2ClsVq5jhHl7sa0v+i5Vpmjmeey4ADwIQ/Ce3kk9JpSwglFaXE
         6zMg==
X-Gm-Message-State: AOAM5323zK0Dz7GRm4RR9BPpPvKAFLLvXlQGr4pRPQ0kVKMbU36WOvFg
        8uNGtnwP+ZNtNCmU+rc2jLA=
X-Google-Smtp-Source: ABdhPJw0TgZ5mKhFLZ+syDtkW1lFUgKFwa6w0NbBcz85VahxcBypNFNzyK7OZe3EZB+fpLleb7T/KQ==
X-Received: by 2002:aed:34c1:: with SMTP id x59mr3123308qtd.374.1601482664189;
        Wed, 30 Sep 2020 09:17:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e9fa])
        by smtp.gmail.com with ESMTPSA id z2sm2606770qkg.40.2020.09.30.09.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 09:17:43 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 30 Sep 2020 12:17:42 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Minho Ban <mhban@samsung.com>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: RFC: sort out get_gendisk abuses
Message-ID: <20200930161742.GF4441@mtj.duckdns.org>
References: <20200925161447.1486883-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925161447.1486883-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Christoph.

On Fri, Sep 25, 2020 at 06:14:45PM +0200, Christoph Hellwig wrote:
> this series tries to remove two abuses of the get_gendisk API.
> The first one is fairly straigt forward and switched the blk-cgroup
> configuration API to properly open the block device, but I'd love to see
> it reviewed and tested by the cgroup maintainers, as I don't really know
> how this code is actually used.

I'm a bit worried that requiring fully opening the device for configuration
can lead to surprising behaviors. A now-unlikely but still possible case
would be trying to configure IO parameters for a device w/ removeable media.
All that the user is trying to do is configuring a bunch of parameters but
the kernel would try to spin up the media and fail configuration and so on.

The use case of needing to access the associated data structures without
fully activating the IO device seems valid to me. Whether that interface is
blkdev_get() or something better abstracted, I don't really care.

Thanks.

-- 
tejun
