Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD90ECE59E
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 23:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A119320872
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 23:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="ndzXv4fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfJOXIx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 19:08:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37240 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfJOXIx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 19:08:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so13055610pgi.4
        for <linux-block@vger.kernel.org>; Tue, 15 Oct 2019 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T15lTYBpQbYj/G8GLCYZUILrfB3Jwz4M9cchF+mKnB4=;
        b=ndzXv4fzXaenGVr4iNtuiIA6JUMRYo0CY+3bD4OohadcchwE+pJHBfmkNBhppQ+zdj
         +SEZ5IFpzwvCjA8EAsQhMLRzc7C2JIN5s++7Qbyz1FIGMNvxnX1xHrznCO/rT3DJL2SV
         nWkcqFCzdBpQ/5XWbzYVWRRmk8J0vhoit00h1ogNhC0Ogqir0CeJxIIaYENPdzse0L3p
         KA7Wi6c3Rn9pYCrNDq/PPHF5zXja2oHRA6uK6BXifqgMu46NMQwxiMJ6jnUCTG7HRnCn
         Ul8qpxTOSvabMtSWkR7W4Ff2koEZ5O16Z3+R8XKPhTHRpiec4upjzqBxLh3JJIRhXK/y
         Folw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T15lTYBpQbYj/G8GLCYZUILrfB3Jwz4M9cchF+mKnB4=;
        b=J7j1Shs8JqFgLOp33bxtrxv3wehiDI/Tiw7spTji1s9wjjKzBmhX5xqjcaGJ+RcE1a
         +RN9WKPOtWzKVP2qhPA78HKRBR/pi49WXpPkSHG+IoVb9sxqDcPmuJ/mN12CQqek9R7o
         w1Ie1Gl17WChe/w09k91wq7PBJL+aEwIOHfeXtkZuZbPtPXkDBv33GPUwfJlcRMWtjps
         ajl5Yv+YrEDw4Rbzubh94NBFz6eZ8OHBf7grgP0WrHoXT/P95YOiBYs8sWxrnNL3HiEi
         DWRerxmyS52G4k1i53sqP4vdTQbibZ9R5zOXkwpfv2bXnQf3cLMMJjDK+oHfMCh6ec4m
         Vbqw==
X-Gm-Message-State: APjAAAXR14AZfEdn+29mN14sMD3MElAWAFeay3hgEapsGxKXzvZTfH3Q
        cXlYHhNA127m95iKz4qsxBWE0vU9y/4=
X-Google-Smtp-Source: APXvYqz/PanUTBoeo6JC49Cmj7Rc9OxT37Ow1lArdnJ9Uwvf6ZqrLa+p3HUtf1PkSS/7UvNX9VXK/A==
X-Received: by 2002:a63:5b07:: with SMTP id p7mr42328040pgb.416.1571180930873;
        Tue, 15 Oct 2019 16:08:50 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::2:3e5e])
        by smtp.gmail.com with ESMTPSA id n3sm24944514pff.102.2019.10.15.16.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 16:08:50 -0700 (PDT)
Date:   Tue, 15 Oct 2019 16:08:49 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Omar Sandoval <osandov@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v3] nvme/031: Add test to check controller
 deletion after setup
Message-ID: <20191015230849.GA483958@vader>
References: <20190911172021.5760-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911172021.5760-1-logang@deltatee.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 11, 2019 at 11:20:21AM -0600, Logan Gunthorpe wrote:
> A number of bug fixes have been submitted to the kernel to
> fix bugs when a controller is removed immediately after it is
> set up. This new test ensures this doesn't regress.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> 
> Changes for v3:
>  * Drops the double loop_dev declaration (per Chaitanya)
>  * Collected Sagi's reviewed-by tag
> 
>  tests/nvme/031     | 54 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/031.out |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/nvme/031
>  create mode 100644 tests/nvme/031.out

Thanks, applied.
