Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F128BC433FE
	for <linux-block@archiver.kernel.org>; Wed, 19 Jan 2022 11:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354240AbiASLjM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jan 2022 06:39:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354244AbiASLjK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jan 2022 06:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642592348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z23E4Um11BOkgt39lK2OE7q1T4sdztW+qOUuVlme2a4=;
        b=N02AlMBYRJkUftXEvAnr05qcgnUtZ0RbOyixeaF/1NakSdGX7S2gSZYmtUpNFcVFjom/T+
        lhfDttyQwEyWcw9kyfEBkVax8Qk+gwDyRyn9CuL//OMzPcX/xyB2A4nLkX+ujnayCxWkIo
        DhMphfkEDiIy0zroXwlS+wyZ+fRVjJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-111-ydGGwi7GOLyv-AR0jtGzIw-1; Wed, 19 Jan 2022 06:39:05 -0500
X-MC-Unique: ydGGwi7GOLyv-AR0jtGzIw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 505291083F61;
        Wed, 19 Jan 2022 11:39:04 +0000 (UTC)
Received: from ws.net.home (ovpn-112-8.ams2.redhat.com [10.36.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 308A97D475;
        Wed, 19 Jan 2022 11:39:03 +0000 (UTC)
Date:   Wed, 19 Jan 2022 12:39:00 +0100
From:   Karel Zak <kzak@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     util-linux@vger.kernel.org, linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: Racy loop device reuse logic
Message-ID: <20220119113900.tm5j65wzxglggsig@ws.net.home>
References: <20220113154735.hdzi4cqsz5jt6asp@quack3.lan>
 <20220119085247.duhblxzp6joukarw@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119085247.duhblxzp6joukarw@quack3.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 19, 2022 at 09:52:47AM +0100, Jan Kara wrote:
> Ping? Any opinion?

 Sorry for the delay.

> On Thu 13-01-22 16:47:35, Jan Kara wrote:
> > Hello,
> > 
> > Tetsuo has been doing some changes to the loop device shutdown in the
> > kernel and that broke LTP that is doing essentially the following loop:
> > 
> > while :; do mount -o loop,ro isofs.iso isofs/; umount isofs/; done
> > 
> > And this loop is broken because of a subtle interaction with systemd-udev
> > that also opens the loop device. The race seems to be in mount(8) handling
> > itself and the altered kernel timing makes it happen. It look like:
> > 
> > bash					systemd-udev
> >   mount -o loop,ro isofs.iso isofs/
> >     /dev/loop0 is created and bound to isofs.iso, autoclear is set for
> >     loop0
> >   					opens /dev/loop0
> >   umount isofs/
> >   loop0 still lives because systemd-udev still has device open
> >   mount -o loop,ro isofs.iso isofs/
> >     gets to mnt_context_setup_loopdev()
> >       loopcxt_find_overlap()
> >       sees loop0 is still valid and with proper parameters
> >       reuse = true;
> > 					close /dev/loop0
> > 					  last fd closed => loop0 is
> > 					    cleaned up
> >       loopcxt_get_fd()
> >         opens loop0 but it is no longer the device we wanted!
> >     calls mount(2) which fails because we cannot read from the loop device
> > 
> > It seems to me that mnt_context_setup_loopdev() should actually recheck
> > that loop device parameters still match what we need after opening
> > /dev/loop0 (if LOOP_GET_STATUS ioctl succeeds on the fd, you are guaranteed
> > the loop device is in that state and will not be torn down under your
> > hands). What do you think?

Seems like elegant solution. Please, send a patch.

(It would be possible to be care about autoclear in
loopcxt_find_overlap(), but it sounds complicated and probably still
racy.

> > 
> > 								Honza
> > -- 
> > Jan Kara <jack@suse.com>
> > SUSE Labs, CR
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

