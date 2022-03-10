Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4923EC433F5
	for <linux-block@archiver.kernel.org>; Thu, 10 Mar 2022 12:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241988AbiCJM1o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Mar 2022 07:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236984AbiCJM1n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Mar 2022 07:27:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BF81480F3;
        Thu, 10 Mar 2022 04:26:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13E15B825C4;
        Thu, 10 Mar 2022 12:26:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773CEC340E8;
        Thu, 10 Mar 2022 12:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646915200;
        bh=j9kbFAFVYrcTjwCyYTeY1V6XjDrPlAA8uuO+/0oacRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozVMW2eOCOfrZ2zi8XyEK/zevIbFxjuOusPKicJkb6dBFiaw29irn6QyWsqWRZ++4
         DFepAH4zX/+6KAV5KVpIszGCkYN4csMQXfFUd/C0R082QO8tE0iEZexxWqYnXMCPZU
         k00H/458PY5uii1n212X5p25fh/XlyWkztgPpK2Q=
Date:   Thu, 10 Mar 2022 13:26:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Kleibel <valentin@vrvis.at>
Cc:     stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Justin Sanders <justin@coraid.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH] block: aoe: fix page fault in freedev()
Message-ID: <YinufgnQtSeTA18w@kroah.com>
References: <c274db07-9c7d-d857-33ad-4a762819bcdd@vrvis.at>
 <YinpIKY0HVlJ+TLR@kroah.com>
 <50ddedf1-5ac3-91c3-0b50-645ceb541071@vrvis.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50ddedf1-5ac3-91c3-0b50-645ceb541071@vrvis.at>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 10, 2022 at 01:24:38PM +0100, Valentin Kleibel wrote:
> On 10/03/2022 13:03, Greg Kroah-Hartman wrote:
> > > This patch applies to kernels 5.4 and 5.10.
> > 
> > We need a fix for Linus's tree first before we can backport anything to
> > older kernels.  Does this also work there?
> 
> It is fixed in Linus' tree starting with 5.14.

What commit fixes it there?  Why not just backport that one only?

thanks,

greg k-h
