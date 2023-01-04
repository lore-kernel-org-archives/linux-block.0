Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F9C4332F
	for <linux-block@archiver.kernel.org>; Wed,  4 Jan 2023 08:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbjADIUi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 03:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjADIUh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 03:20:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12D319C07
        for <linux-block@vger.kernel.org>; Wed,  4 Jan 2023 00:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672820392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TaIt1E713BausU+dyJgM5xXKuUZPPOufGW2XT61ZWTU=;
        b=CgX3E16gjIKm5dZNrhW+OsDYlLK26kLWGmGO7OvLm1Jd1JcjH7/HCWzL/XnVfslA2bdYGD
        nGaaLUSfKwXiHrYSTs4DDU5XBG06bFx60CDdvpGumt16v29tmof1pXjt95I75UxIWMMjV+
        J1X0ddVCcsVaw3df58reEin2BRGY2/c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-yIMW1LRAP-i-eJdx8a-ttQ-1; Wed, 04 Jan 2023 03:19:49 -0500
X-MC-Unique: yIMW1LRAP-i-eJdx8a-ttQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A58B3811F37;
        Wed,  4 Jan 2023 08:19:49 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CB592166B30;
        Wed,  4 Jan 2023 08:19:43 +0000 (UTC)
Date:   Wed, 4 Jan 2023 16:19:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>, ming.lei@redhat.com
Subject: Re: [PATCH V3 6/6] ublk_drv: add mechanism for supporting
 unprivileged ublk device
Message-ID: <Y7U2mshx9s9rx++C@T590>
References: <20221207123305.937678-1-ming.lei@redhat.com>
 <20221207123305.937678-7-ming.lei@redhat.com>
 <87a62ze4ql.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a62ze4ql.fsf@meer.lwn.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jonathan,

On Tue, Jan 03, 2023 at 01:35:14PM -0700, Jonathan Corbet wrote:
> I have one quick question...
> 
> Ming Lei <ming.lei@redhat.com> writes:
> 
> > In case of UBLK_F_UNPRIVILEGED_DEV:
> >
> > 1) for command UBLK_CMD_ADD_DEV, it is always allowed, and user needs
> > to provide owner's uid/gid in this command, so that udev can set correct
> > ownership for the created ublk device, since the device owner uid/gid
> > can be queried via command of UBLK_CMD_GET_DEV_INFO.
> 
> Why do you have the user provide the uid/gid rather than just using the
> user's credentials directly?  It seems a bit strange to me to let
> unprivileged users create devices with arbitrary ownership.  What am I
> missing here?

It is one good question.

The original idea is to allow user A to create device for another user
B, and it still depends on user A's capability, such as, if the created
daemon can open the created device which is owned by user B actually.

The above behavior may be extended in future if there is such
requirement. I will switch to just allow to create device for the
current user in V4, then we can start with this easy/simple model.

BTW, that is exactly the current userspace implementation, only the
current uid/gid is passed.

	https://github.com/ming1/ubdsrv/tree/unprivileged-ublk


Thanks,
Ming

