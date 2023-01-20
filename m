Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0E3C25B4E
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 07:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjATH1N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 02:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjATH1M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 02:27:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A085359;
        Thu, 19 Jan 2023 23:27:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E4A8B81FBA;
        Fri, 20 Jan 2023 07:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB496C433D2;
        Fri, 20 Jan 2023 07:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674199625;
        bh=SXvVC1TWuqjHbriWiGDYFys5n1XX5jAMZePJarDSq6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eDUOiPBAVreLpJxY8MFVQkL3ZVg1PJbjQg+MVeIc54t543eJVKrntwqG+25UVFsHz
         riUE4HwZabNWtMYX1P+sqmigrdK/tN+MQ8nqYoLQV8+/kRiQOJlbV8oAnO+1IdoT7k
         uOHodS41X/2b57iJWowXG7PWe/VlMMpJ8Dw2CSfw=
Date:   Fri, 20 Jan 2023 08:27:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/9] pktcdvd: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <Y8pCRv7MYrdrmr3j@kroah.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
 <20230119220809.5518-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119220809.5518-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 20, 2023 at 12:08:03AM +0200, Andy Shevchenko wrote:
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/block/pktcdvd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
