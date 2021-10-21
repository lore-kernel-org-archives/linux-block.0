Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC13C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 08:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7F4611CB
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 08:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhJUIJH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 04:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhJUIJG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 04:09:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C874860EB2;
        Thu, 21 Oct 2021 08:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634803611;
        bh=Zc1yLj0ZFLXxAZHRYp8pqj+IaLe9PMu7BPN7eOukJpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q1bmAYlu/j3/f+LQGVUFWADL4QwnNGHqPsLFu1G9RlArqYcS51svAqoC1iS5rB1Zs
         YGKDp7EOspKCHWQGieZYOwNTVuofY/naEWtpIl1i87BL5A1yi2CiwhOySOAMzHglrS
         Bgbx98V6ymPRDc3cphWsMyHIX2wFojBV1OoXE05s=
Date:   Thu, 21 Oct 2021 10:06:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] fs: replace the ki_complete two integer arguments
 with a single argument
Message-ID: <YXEfmG4l5Y3WxeUp@kroah.com>
References: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 20, 2021 at 01:08:17PM -0600, Jens Axboe wrote:
> The second argument is only used by the USB gadget code, yet everyone
> pays the overhead of passing a zero to be passed into aio, where it
> ends up being part of the aio res2 value.
> 
> Since we pass this value around as long, there's only 32-bits of
> information in each of these. Linux IO transfers are capped at INT_MAX
> anyway, so could not be any larger return value. For the one cases where
> we care about this second result, mask it into the upper bits of the
> value passed in. aio can then simply shift to get it.
> 
> For everyone else, just pass in res as an argument like before. Update
> all ki_complete handlers to conform to the new prototype.
> 
> On 64-bit, this avoids an extra register allocation and clear for the
> the fast path (non-USB gadget...).
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
