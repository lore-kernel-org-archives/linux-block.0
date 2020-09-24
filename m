Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBE7C4363D
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 16:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50D352396E
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 16:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgIXQvH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbgIXQvD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 12:51:03 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61BFC0613CE
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2020 09:51:03 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4A60B750;
        Thu, 24 Sep 2020 16:51:01 +0000 (UTC)
Date:   Thu, 24 Sep 2020 10:50:57 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Mares <mj@ucw.cz>, linux-video@atrey.karlin.mff.cuni.cz,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/2] Documentation/admin-guide: remove use of
 "rdev"
Message-ID: <20200924105057.00fa0cf8@lwn.net>
In-Reply-To: <20200918015640.8439-1-rdunlap@infradead.org>
References: <20200918015640.8439-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 17 Sep 2020 18:56:38 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Remove mention of using "rdev" to set boot device, video mode,
> or ramdisk information for the booting kernel.
> 
> 
> Cc: Karel Zak <kzak@redhat.com>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Martin Mares <mj@ucw.cz>
> Cc: linux-video@atrey.karlin.mff.cuni.cz
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> 
> 
>  [RFC PATCH 1/2] Documentation/admin-guide: README & svga: remove use of "rdev"
>  [RFC PATCH 2/2] Documentation/admin-guide: blockdev/ramdisk: remove use of "rdev"

Applied, thanks.

jon
