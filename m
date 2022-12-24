Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0565EC4332F
	for <linux-block@archiver.kernel.org>; Sat, 24 Dec 2022 16:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiLXQS7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Dec 2022 11:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLXQS6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Dec 2022 11:18:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167D89583;
        Sat, 24 Dec 2022 08:18:57 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8AACE1EC04F0;
        Sat, 24 Dec 2022 17:18:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1671898735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RVJ0PnNUNU0W/A0zqIX1b4pYOT85QscQ0XmdXgufrJs=;
        b=ZpSoTeAT+I5wjboJ+nasStScKU69dGFgtCbE8hJGMifjRYOwfO1MpaHJBNoK/gjdAwfupj
        NtuUCAbpGCYuVYxWaIp2ZrHdN3cbDkkpth7eiYk/5xcP4He+omtt5lDeYDMDmLtPOPnBCY
        Ow2ZKdoIr0VA3vyBaeomhZ1wstQQcQY=
Date:   Sat, 24 Dec 2022 17:18:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] pktcdvd: remove driver.
Message-ID: <Y6cma26FKzBQD8AN@zn.tnic>
References: <20221202182758.1339039-1-gregkh@linuxfoundation.org>
 <20221224095353.w32xhmyzlft6qi4v@pali>
 <Y6bObzIoHrJMotI3@kroah.com>
 <20221224101139.sgvhr2n3pbrs4agm@pali>
 <Y6bvh48kTTzbMX6M@kroah.com>
 <20221224133425.vlcxbaaynihiom4a@pali>
 <Y6cXRbGUsarzoJEw@zn.tnic>
 <20221224154842.o4ngrwmskduowttm@pali>
 <Y6chm9khdG4pmNhN@zn.tnic>
 <20221224160055.ln3dbhx7dnut7dwi@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221224160055.ln3dbhx7dnut7dwi@pali>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Dec 24, 2022 at 05:00:55PM +0100, Pali Rohár wrote:
> Maybe it would be a wise to read a documentation which is in the kernel
> source tree?

I guess you mean udftools...

> Or at least read the deletion patch itself as it is linked from there?

You mean the documentation file is pointed at there?

> Or what else could be easier than this?

Well, apparently it ain't as easy because people do not necessarily see
it how you see it. That's why I'm asking.

I have removed ancient stuff in the past myself and it is not always
easy to go dig out who uses it and whether it is used at all in the
first place.

And people do not always reply and projects are dead and they maybe use
it but the machine which has this hw hasn't been booted for a decade and
it ain't worth the enegry to power it back on and so so on and so on...

So you don't have to get all worked up about it - if it is really used,
I'm sure the maintainers involved will do the right decision. The point
is, finding out whether something still has users and with the latest
kernel is not always trivial.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
