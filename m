Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B10C54EAA
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 11:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbjAZLnA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 06:43:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbjAZLm6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 06:42:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C486227F
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 03:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674733332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WOqVAkLN/9qgsCOhdKb2dnJagQhxr9Jvg7AG5tmqelI=;
        b=Cn77jNq+DWEYWU0Ci8vxf6TCK+a2eFuCY9uLZKGv2ZoB8pUU6jrUAqj5a7ld2LyvQcEUiQ
        XSrpFUbxac1NPvfYC6RN6CDtK+fQFMic+8WAgQDchrMivoWJScoOBjTXV4mJdTTZ9965W/
        4mpKuGGpXARzr4lTaR523aVkQaCv5+s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-w1F774iMPp-_quIS7UBOUw-1; Thu, 26 Jan 2023 06:42:07 -0500
X-MC-Unique: w1F774iMPp-_quIS7UBOUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 558BF3C42204;
        Thu, 26 Jan 2023 11:42:07 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 860B351E5;
        Thu, 26 Jan 2023 11:42:02 +0000 (UTC)
Date:   Thu, 26 Jan 2023 19:41:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        nbd@other.debian.org, ming.lei@redhat.com
Subject: Re: ublk-nbd: ublk-nbd is avaialbe
Message-ID: <Y9JnBDrm0V1ZdWK6@T590>
References: <Y8lSYBU9q5fjs7jS@T590>
 <4f22f15f-c15f-5fba-1569-3da8c0f37f0e@kernel.dk>
 <Y9Huqg9HeU3+Ki1H@T590>
 <20230126040822.GA2858@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230126040822.GA2858@1wt.eu>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 26, 2023 at 05:08:22AM +0100, Willy Tarreau wrote:
> Hi,
> 
> On Thu, Jan 26, 2023 at 11:08:26AM +0800, Ming Lei wrote:
> > Hi Jens,
> > 
> > On Thu, Jan 19, 2023 at 11:49:04AM -0700, Jens Axboe wrote:
> > > On 1/19/23 7:23 AM, Ming Lei wrote:
> > > > Hi,
> > > > 
> > > > ublk-nbd[1] is available now.
> > > > 
> > > > Basically it is one nbd client, but totally implemented in userspace,
> > > > and wrt. current nbd-client in [2], the transmission phase is done
> > > > by linux block nbd driver.
> > > > 
> > > > The handshake implementation is borrowed from nbd project[2], so
> > > > basically ublk-nbd just adds new code for implementing transmission
> > > > phase, and it can be thought as moving linux block nbd driver into
> > > > userspace.
> > > > 
> > > > The added new code is basically in nbd/tgt_nbd.cpp, and io handling
> > > > is based on liburing[3], and implemented by c++20 coroutine, so
> > > > everything is done in single pthread totally lockless, meantime turns
> > > > out it is pretty easy to design & implement, attributed to ublk framework,
> > > > c++20 coroutine and liburing.
> > > > 
> > > > ublk-nbd supports both tcp and unix socket, and allows to enable io_uring
> > > > send zero copy via command line '--send_zc', see details in README[4].
> > > > 
> > > > No regression is found in xfstests by using ublk-nbd as both test device
> > > > and scratch device, and builtin test(make test T=nbd) runs well.
> > > > 
> > > > Fio test("make test T=nbd") shows that ublk-nbd performance is
> > > > basically same with nbd-client/nbd driver when running fio on real
> > > > ethernet link(1g, 10+g), but ublk-nbd IOPS is higher by ~40% than
> > > > nbd-client(nbd driver) with 512K BS, which is because linux nbd
> > > > driver sets max_sectors_kb as 64KB at default.
> > > > 
> > > > But when running fio over local tcp socket, it is observed in my test
> > > > machine that ublk-nbd performs better than nbd-client/nbd driver,
> > > > especially with 2 queue/2 jobs, and the gap could be 10% ~ 30%
> > > > according to different block size.
> > > 
> > > This is pretty nice! Just curious, have you tried setting up your
> > > ring with
> > > 
> > > p.flags |= IORING_SETUP_SINGLE_ISSUER | IORING_SETUP_DEFER_TASKRUN;
> > > 
> > > and see if that yields any extra performance improvements for you?
> > > Depending on how you do processing, you should not need to do any
> > > further changes there.
> > > 
> > > A "lighter" version is just setting IORING_SETUP_COOP_TASKRUN.
> > 
> > IORING_SETUP_COOP_TASKRUN is enabled in current ublksrv.
> > 
> > After disabling COOP_TASKRUN and enabling SINGLE_ISSUER & DEFER_TASKRUN,
> > not see obvious improvement, meantime regression is observed on 64k
> > rw.
> 
> Does it handle network errors better than the default nbd client, i.e.
> is it able to seamlessly reconnect after while keeping the same device
> or do you end up with multiple devices ? That's one big trouble I faced
> with the original nbd client, forcing you to unmount and remount
> everything after a network outage for example.

All kinds of ublk disk supports such seamlessly recovery which is
provided by UBLK_CMD_START_USER_RECOVERY/UBLK_CMD_END_USER_RECOVERY.
During user recovery, the bdev and gendisk instance won't be gone,
and will become fully functional after the recovery(such as reconnect)
is successful.

So yes for this seamlessly reconnect error handling.


Thanks, 
Ming

