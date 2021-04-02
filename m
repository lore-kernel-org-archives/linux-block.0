Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EFCC433B4
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 07:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136C5610FC
	for <linux-block@archiver.kernel.org>; Fri,  2 Apr 2021 07:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhDBHyQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Apr 2021 03:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:34096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234217AbhDBHyQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Apr 2021 03:54:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAE4061103;
        Fri,  2 Apr 2021 07:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617350055;
        bh=rgAN5tZmvrtw+l6Z9MPiySclNGXhZ1o2U2MSPQYWr3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ux+hbwzMDDMPpgMKWAK/ZdqlMjwjDKCk3k4nHlq7/vmtiMNbA39NNQiftujSoK6da
         ixoeeWGlZeFt20Ed1CpxsayE5/GIzcq0iYnn5bTASWKA4XMF366eKIcMHapf1aGU9I
         002pWXurMeElpLaGHfYm1awf4b5JpcVR10+TDcuI=
Date:   Fri, 2 Apr 2021 09:54:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Minchan Kim <minchan@kernel.org>, keescook@chromium.org,
        dhowells@redhat.com, hch@infradead.org, mbenes@suse.com,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] zram: fix crashes due to use of cpu hotplug
 multistate
Message-ID: <YGbNpLKXfWpy0ZZa@kroah.com>
References: <YEbjom8FIclEgRYv@google.com>
 <20210310212128.GR4332@42.do-not-panic.com>
 <YErOkGrvtQODXtB0@google.com>
 <20210312183238.GW4332@42.do-not-panic.com>
 <YEvA1dzDsFOuKdZ/@google.com>
 <20210319190924.GK4332@42.do-not-panic.com>
 <YFjHvUolScp3btJ9@google.com>
 <20210322204156.GM4332@42.do-not-panic.com>
 <YFkWMZ0m9nKCT69T@google.com>
 <20210401235925.GR4332@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401235925.GR4332@42.do-not-panic.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 01, 2021 at 11:59:25PM +0000, Luis Chamberlain wrote:
> As for the syfs deadlock possible with drivers, this fixes it in a generic way:
> 
> commit fac43d8025727a74f80a183cc5eb74ed902a5d14
> Author: Luis Chamberlain <mcgrof@kernel.org>
> Date:   Sat Mar 27 14:58:15 2021 +0000
> 
>     sysfs: add optional module_owner to attribute
>     
>     This is needed as otherwise the owner of the attribute
>     or group read/store might have a shared lock used on driver removal,
>     and deadlock if we race with driver removal.
>     
>     Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

No, please no.  Module removal is a "best effort", if the system dies
when it happens, that's on you.  I am not willing to expend extra energy
and maintance of core things like sysfs for stuff like this that does
not matter in any system other than a developer's box.

Lock data, not code please.  Trying to tie data structure's lifespans
to the lifespan of code is a tangled mess, and one that I do not want to
add to in any form.

sorry,

greg k-h
