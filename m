Return-Path: <SRS0=uOpu=37=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E408C35242
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 22:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 340C520708
	for <linux-block@archiver.kernel.org>; Tue, 11 Feb 2020 22:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="ebUWlOGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgBKWXr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:23:47 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41226 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgBKWXr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Feb 2020 17:23:47 -0500
Received: by mail-pf1-f196.google.com with SMTP id j9so143837pfa.8
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2020 14:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xg0CTgImhuNBjklYUgaKo95yHzvGv/Ra+RK9xC15ymo=;
        b=ebUWlOGVyCEwah8yNl+AotrKbO46qIk/Qn80A9OgmsIrCXVQpBcV2dQVE4h+qOVs63
         3J/LnIPNFdSxy+l3HrBdmrWxa1IOrPseq8gj7Wuwv12BadWSU2To6V1fR5vxjcH9hoNT
         4fIa/LWCkp+ghwnEvAHkuAONjVW8Tf+n6nJVnQEQWQEYP0WUOp5lZnZ32yXyqAOmcx9m
         7g3nPcTYWr6c4PFjONWlPAvVs0ACT/O8Ya52P9ZRN3507SyvJN/PMOu4Lctqlyf3Cspl
         xherKfWaXB4SOf9/pV4gLpePAusuUXlEWu69aSqLntrdHstUyGxcR+pUR7HKrlhtjdT2
         XBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xg0CTgImhuNBjklYUgaKo95yHzvGv/Ra+RK9xC15ymo=;
        b=I6WjpRMg1KcYDuGgvnVJYRBu3S25KHtOrXow1qVMCGlCfe3wzmdUKKsCfmQOEHqCNj
         Lbfx5J9xtbwNEMoawL4D+Tdj2uzLCS8LLM/hncPjsdfF+eD4vrw901fZKAsBkor0Mb60
         2CduN+iGWZqSSY/AZKHaHZQlRbvRPmZH1PCXakU1o6VZ75AQhunsY6BSOxTRfzZFf6D7
         FYPEozYxAnLo+y+/2C0XeOqLzEGTguUXzjWnALLqbgqi7+LOwm+MiBzsA7pPruRRkHk/
         fb2oY3eejsgQnAQbqOQ/i84pEpdIdqc4CFzXoLkwuCX8a0IzS2vRaFdkB+oi48gAsVFK
         2faA==
X-Gm-Message-State: APjAAAVcKxCDrzSOwewy+k7TMiNcnLtFALFGd383C67Yr+p4qfjmdlSZ
        9TJSqmPQnHCEbUJ7X5JyNkI48w==
X-Google-Smtp-Source: APXvYqzDbotXR3HCxXdQu4taDUsD3ZPuBn1Il6vdmoS0W+uyrH4iOyoGbEEhh4Qb/wbvRGhd79uRlA==
X-Received: by 2002:a65:4685:: with SMTP id h5mr9481255pgr.203.1581459826229;
        Tue, 11 Feb 2020 14:23:46 -0800 (PST)
Received: from vader ([2620:10d:c090:200::1:80ca])
        by smtp.gmail.com with ESMTPSA id d14sm5630909pfq.117.2020.02.11.14.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 14:23:45 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:23:45 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     "sunke (E)" <sunke32@huawei.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com
Subject: Re: [PATCH blktests v4] nbd/003:add mount and clear_sock test for nbd
Message-ID: <20200211222345.GI100751@vader>
References: <1577071109-68332-1-git-send-email-sunke32@huawei.com>
 <8ece15f7-addf-44b2-0b54-4e1a450037f2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ece15f7-addf-44b2-0b54-4e1a450037f2@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 23, 2019 at 11:15:35AM +0800, sunke (E) wrote:
> Hi Omar,
> 
> The nbd/003 you simplified does the same I want to do and I made some small
> changes. I ran the simplified nbd/003 with linux kernel at the commit
> 7e0165b2f1a, it could pass.Then, I rollbacked the linux kernel to commit
> 090bb803708, it indeed triggered the BUGON.
> 
> However, there is one difference. NBD has ioctl and netlink interfaces. I
> use the netlink interface and the simplified nbd/003 use the ioctl
> interface. The nbd/003 with the netlink interface indeed seem to trigger
> some other issue. So, can it be nbd/004?

Sure, how about we add a flag to mount_clear_sock that specifies to use
the netlink interface instead of the ioctl interface, and make nbd/004
which is the same as nbd/003 expect it runs it with the netlink flag?
