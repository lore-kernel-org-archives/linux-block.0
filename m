Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAFAC25B4E
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 07:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjATH2Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 02:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjATH2Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 02:28:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33D485346;
        Thu, 19 Jan 2023 23:28:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B227B81A58;
        Fri, 20 Jan 2023 07:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DB7C433D2;
        Fri, 20 Jan 2023 07:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674199698;
        bh=zVKZsC8WsIiQV1dZYEbGak20ApmEwM8LBG8nEVEorto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfvyUK0gSco+vUJdHE4cfadqaZySmsAUOauAJzXUfTJNUdm/Rz+LqT0yRPIHrK9XP
         ZDMKNb8y7WyJQMPkuvd2Vtq3vzpR4jsTXGJzgxmmeyIsHS2osJ3fCll7zrzIAZxMlt
         Tx+hoygXFuOGYfBtBYQqs+wHg+PCyUpHAq0i5cOs=
Date:   Fri, 20 Jan 2023 08:28:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/9] pktcdvd: Drop redundant castings for sector_t
Message-ID: <Y8pCj942DVS7Mavu@kroah.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
 <20230119220809.5518-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119220809.5518-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 20, 2023 at 12:08:05AM +0200, Andy Shevchenko wrote:
> Since the commit 72deb455b5ec ("block: remove CONFIG_LBDAF")
> the sector_t is always 64-bit type, no need to cast anymore.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
