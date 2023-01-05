Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E205C4708D
	for <linux-block@archiver.kernel.org>; Thu,  5 Jan 2023 03:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjAEDRV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 22:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjAEDRM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 22:17:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85E165F1
        for <linux-block@vger.kernel.org>; Wed,  4 Jan 2023 19:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672888586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlIoIdIFG2dVWZi2K+OCOkv3+deoG+uvdHhvJiUMwkc=;
        b=axK0Rq+D6hqhh5maU11TmtzjvVj+KqtTX/g569QHHWVWm5vbBqSta2lJwRrtD86tYx0r/W
        T/WupgJxR3uBgx04112Dsru6MEfApsuFvvo8lvkSGUeGIMJS84/4Ktqbph5ZSBeUi2FUuK
        XcyEjXCVxbRyvuDZSKjXGQkG9Bp8BnA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-KtsVNwuQN4q-wGBvptFzYA-1; Wed, 04 Jan 2023 22:16:23 -0500
X-MC-Unique: KtsVNwuQN4q-wGBvptFzYA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 19C3E38041D5;
        Thu,  5 Jan 2023 03:16:23 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 93891C15BA0;
        Thu,  5 Jan 2023 03:16:19 +0000 (UTC)
Date:   Thu, 5 Jan 2023 11:16:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: Potential hang on ublk_ctrl_del_dev()
Message-ID: <Y7ZA/ULE4hg3lkbY@T590>
References: <862272BC-C6A3-4A60-A620-4C5596972D01@gmail.com>
 <Y7URsuwxaAHFmn8S@T590>
 <20EBDD77-21AD-4C39-B1F2-E9A9954FA360@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20EBDD77-21AD-4C39-B1F2-E9A9954FA360@gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 04, 2023 at 10:13:05AM -0800, Nadav Amit wrote:
> 
> 
> > On Jan 3, 2023, at 9:42 PM, Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > On Tue, Jan 03, 2023 at 01:47:37PM -0800, Nadav Amit wrote:
> >> Hello Ming,
> >> 
> >> I am trying the ublk and it seems very exciting.
> >> 
> >> However, I encounter an issue when I remove a ublk device that is mounted or
> >> in use.
> >> 
> >> In ublk_ctrl_del_dev(), shouldn’t we *not* wait if ublk_idr_freed() is false?
> >> It seems to me that it is saner to return -EBUSY in such a case and let
> >> userspace deal with the results.
> >> 
> >> For instance, if I run the following (using ubdsrv):
> >> 
> >> $ mkfs.ext4 /dev/ram0
> >> $ ./ublk add -t loop -f /dev/ram0
> >> $ sudo mount /dev/ublkb0 tmp
> >> $ sudo ./ublk del -a
> >> 
> >> ublk_ctrl_del_dev() would not be done until the partition is unmounted, and you
> >> can get a splat that is similar to the one below.
> > 
> > The splat itself can be avoided easily by replace wait_event with
> > wait_event_timeout() plus loop, but I guess you think the sync delete
> > isn't good too?
> 
> I don’t think the splat is the issue. The issue is the blocking behavior,
> which is both unconditional and unbounded in time, and (worse) takes place
> without relinquishing the locks. wait_event_timeout() is therefore not a
> valid solution IMHO.
> 
> > 
> >> 
> >> What do you say? Would you agree to change the behavior to return -EBUSY?
> > 
> > It is designed in this way from beginning, and I believe it is just for
> > the sake of simplicity, and one point is that the device number needs
> > to be freed after 'ublk del' returns.
> > 
> > But if it isn't friendly from user's viewpoint, we can change to return
> > -EBUSY. One simple solution is to check if the ublk block device
> > is opened before running any deletion action, if yes, stop to delete it
> > and return -EBUSY; otherwise go ahead and stop & delete the pair of devices.
> > And the userspace part(ublk utility) needs update too.
> > 
> > However, -EBUSY isn't perfect too, cause user has to retry the delete
> > command manually.
> 
> I understand your considerations. My intuition is that just as umount
> cannot be done while a file is opened and would return -EBUSY, so should
> deleting the ublock while the ublk is in use.
> 
> So as I see it, there are 2 possible options for proper deletion of ublk,
> and actually both can be implemented and distinguished with a new flag
> (UBLK_F_*):
> 
> 1. Blocking - similar to the way it is done today, but (hopefully) without
>    holding locks, and with using wait_event_interruptible() instead of
>    wait_event() to allow interruption (and return EINTR if interrupted).
> 
> 2. Best-effort - returning EBUSY if it cannot be removed.
> 
> I can imagine use-cases for both, and it would also allow you not to
> change ubdsrv if you choose so.
> 
> Does it make sense?
 
I prefer to the 1st approach:

1) the wait event is still one positive signal for user to cleanup the
device use, since the correct step is to umount ublk disk before deleting
the device.

2) the wait still can avoid the current context to reuse the device
number

3) after switching to wait_event_interruptible(), we need to avoid
double delete, and one flag of UB_STATE_DELETED can be used for failing
new delete command.

4) IMO new flag(UBLK_F_*) isn't needed to distinguish this change
with current behavior.

Please let us know if you'd like to cook one patch for improving
the delete handling.

BTW, there could be another option, such as, 'ublk delete --no-wait' just
run the remove and without waiting at all, but not sure if it is useful.


thanks,
Ming

