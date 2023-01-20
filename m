Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7C7C05027
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 07:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjATH0x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 02:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjATH0w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 02:26:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29910B462;
        Thu, 19 Jan 2023 23:26:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2093B8205C;
        Fri, 20 Jan 2023 07:26:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B4FC433EF;
        Fri, 20 Jan 2023 07:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674199609;
        bh=7lbn0MwHECmyv8O03dljA2m5K69PDJLHcH0hzXQVQBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uaAPkhOkCLamRVAxH5I5EENqLEHl7uRVBo3Xtz3iiivkZdsT14afe0n+pv4uaB84T
         DH2FhlUSiV2RPELbEVjCz9ueUPfhHygmJ4tRM74/KOJll6lhg9up0Z5aMmq8y86PGj
         W2z3Uf222UB0gRnhsQOEXjesPRBoflm0M0cLuhjw=
Date:   Fri, 20 Jan 2023 08:26:46 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 8/9] pktcdvd: Get rid of redundant 'else'
Message-ID: <Y8pCNlNMNyaYPje4@kroah.com>
References: <20230119220809.5518-1-andriy.shevchenko@linux.intel.com>
 <20230119220809.5518-8-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119220809.5518-8-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 20, 2023 at 12:08:08AM +0200, Andy Shevchenko wrote:
> In the snippets like the following
> 
> 	if (...)
> 		return / goto / break / continue ...;
> 	else
> 		...
> 
> the 'else' is redundant. Get rid of it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
