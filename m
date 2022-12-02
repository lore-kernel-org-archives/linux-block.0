Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71324C4332F
	for <linux-block@archiver.kernel.org>; Fri,  2 Dec 2022 10:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiLBKha (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Dec 2022 05:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiLBKh3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Dec 2022 05:37:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE6BCE40D
        for <linux-block@vger.kernel.org>; Fri,  2 Dec 2022 02:37:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B6096222D
        for <linux-block@vger.kernel.org>; Fri,  2 Dec 2022 10:37:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2A4C433C1;
        Fri,  2 Dec 2022 10:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669977448;
        bh=bEGdbn4hF/GMIgW2xow8eTmtEebvKi+vSvpg3WfFCXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u1SbzIFi9DFUv5YzcFVh8stbN2/SoLOrOM2DVEnQS+oZV+t9reHTJjjuxBqZRETSQ
         issJbbj4VqWEJ5JaUlS/peT6GKemmRWlQm4NKbnqAxNIb93hxhaBnLZmoVV/ZDMuLW
         KTccQI3KUaJpsIfR/6h96Y+lgNX8L8fRN7qjFil37iwj7s/oASa5OkPHhqovRihxNL
         K95/Cp1RtU+t5DTkRbAaNJplNie2ri9GcXKVBxsWBtLsh+grSMcK90tKUCiIHdVn2h
         WUz9NPvzz26+DR9gD6ntVFRQyU5Gsp+/GXnOSjv3OzCZSuxDnWK3wQUUtuZLoGTi99
         OUYD5g3zx6zYQ==
Date:   Fri, 2 Dec 2022 11:37:23 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Luca Boccassi <bluca@debian.org>
Cc:     linux-block@vger.kernel.org, jonathan.derrick@linux.dev,
        gmazyland@gmail.com, axboe@kernel.dk, stepan.horacek@gmail.com
Subject: Re: [PATCH] sed-opal: if key is available from IOC_OPAL_SAVE use it
 when locking
Message-ID: <20221202103723.cpzoxido7izctwod@wittgenstein>
References: <20221202003610.100024-1-luca.boccassi@gmail.com>
 <20221202084845.66mn2m3srfabehnu@wittgenstein>
 <CAMw=ZnQ+iPa9gv95_8Z4mVdBr-ma5ohd-Ys49WYOB+KmMQY_9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMw=ZnQ+iPa9gv95_8Z4mVdBr-ma5ohd-Ys49WYOB+KmMQY_9g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Dec 02, 2022 at 10:28:10AM +0000, Luca Boccassi wrote:
> On Fri, 2 Dec 2022 at 08:48, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Dec 02, 2022 at 12:36:10AM +0000, luca.boccassi@gmail.com wrote:
> > > From: Luca Boccassi <bluca@debian.org>
> > >
> > > Usually when closing a crypto device (eg: dm-crypt with LUKS) the
> > > volume key is not required, as it requires root privileges anyway, and
> > > root can deny access to a disk in many ways regardless. Requiring the
> > > volume key to lock the device is a peculiarity of the OPAL
> > > specification.
> > >
> > > Given we might already have saved the key if the user requested it via
> > > the 'IOC_OPAL_SAVE' ioctl, we can use that key to lock the device if no
> > > key was provided here and the locking range matches. This allows
> > > integrating OPAL with tools and libraries that are used to the common
> > > behaviour and do not ask for the volume key when closing a device.
> > >
> > > If the caller provides a key on the other hand it will still be used as
> > > before, no changes in that case.
> > >
> > > Suggested-by: Štěpán Horáček <stepan.horacek@gmail.com>
> > > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > > ---
> >
> > But it would be quite the change in behavior for existing users, no?
> >
> > It might be better to add an ioctl that would allow to set an option on
> > the opal device after it was opened which marks it as closable without
> > providing the key?
> 
> Closing with a zero-length key could not work before and would fail
> with eperm, so I can't imagine anyone using it as such, so I didn't
> bother.

That's not the point though. Afaict, with your change users that rely on
the device only being closable by users that have access to the key
couldn't rely on his anymore. At least that's what the change
description seems to imply.
