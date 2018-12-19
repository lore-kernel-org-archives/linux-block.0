Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5161C43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 00:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729E22184C
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 00:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="fw92V8m8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbeLSAUU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 19:20:20 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33260 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbeLSAUU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 19:20:20 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so14256476ioi.0
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 16:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XwP9hA2/Xl32o8T8xidUbdjrgqg0lyRMBJDgEXcyIr8=;
        b=fw92V8m8YxBQ03qlI8KU+kcQz7RWlTS1jnS4Z6u+hSuZwD839ZRSp+vr4GSIkJgFay
         PsQgdcM+iaf3vhUaayi5Es48tiK9vC0dKUXGvJkOEVMi6cyWhR39RyQ17bCJx50bD1Jx
         Zq58jUT/+GcDwX48Mw53qqyKx2CeHsiKAPDz9bU8wtXxSxc6VV378jW3LVirqgmqYBwg
         bxOGVwO1iEFXWy7XrRHAiAeMDnn03xqOidibMUh+FEXt86rnvredL2T14R44K+aAai3J
         xl7Lqev9z2o54YceWAjFwUyI1H2BFRONE4RO/n/QYgoZpxZGGdS/oM459TbcXStIucI/
         m/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XwP9hA2/Xl32o8T8xidUbdjrgqg0lyRMBJDgEXcyIr8=;
        b=eGykW5cPhjansvJq3hZZ7RkmB2OipDGBty51tC/812YpJl8tI3yQniWcAhzy1T7q+S
         dA7S4eTJxLseXT0EnW9HIOdbwQSlKcuhA4pdcjaGCF/1JDYCZn8kl1BQBtWsoEoog44d
         4jlqWMBn9PTmtbY3Spy8cE+pwUMyHcT0ji3BgZ/E8zchb+Qbid8JhcOt0j4rkyuM5eyh
         NlbVDX8yBlgK4Aw/zsBZNLYxCHS1fXdm+YWO4pqXzNS+RTaXwOFkWpexqu5h2cf5jYat
         +CLDWF/G+wg0CSytFi0NbKbXAqc4gqWTHa3xJ2GLyutg8kKl4XHGZAiU/Q69k2Wr+dFE
         CBFg==
X-Gm-Message-State: AA+aEWZubQ0Ti9yJpjBi1gqGZmHEw1D+dBzKaJS8Jq/TnCGBwwSkdLqO
        UoCYS34j0Iyj9uCaMDz/kyWOsiNRhtnGrw==
X-Google-Smtp-Source: AFSGD/XoA+s6SYyxwntFjIbNtDVsaZUOOrzFP+BaCtBetBNNfb13HqiGv7vFcxC0bb7myEI7AdFf8Q==
X-Received: by 2002:a5d:8b8b:: with SMTP id p11mr15346129iol.223.1545178819455;
        Tue, 18 Dec 2018 16:20:19 -0800 (PST)
Received: from vader ([2620:10d:c090:200::7:ffa])
        by smtp.gmail.com with ESMTPSA id w26sm7181540iol.60.2018.12.18.16.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Dec 2018 16:20:18 -0800 (PST)
Date:   Tue, 18 Dec 2018 16:20:17 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com, kernel-team@fb.com
Subject: Re: [PATCH] blktests: add a test for wbt
Message-ID: <20181219002017.GC12683@vader>
References: <20181212213824.26958-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212213824.26958-1-josef@toxicpanda.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 12, 2018 at 04:38:24PM -0500, Josef Bacik wrote:
> There's currently no tests to verify wbt is working properly, this patch
> fixes that.  Simply run a varied workload and measure the read latencies
> with wbt off, and then turn it on and verify that the read latencies go
> down.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Similar to the io.latency test. Test itself looks fine, but sometimes
fails with "Read latency too high, wbt not working?". Maybe these tests
just aren't well suited for running in QEMU?
