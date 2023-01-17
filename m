Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1A3C3DA78
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 09:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbjAQJkx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 04:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236682AbjAQJjq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 04:39:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5972F7B7
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 01:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673948211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xpdeFW0bHtT7ktoN32N4n2bkd34BDy70xdl/uBQT2mo=;
        b=LSXZGPX5tWRIUDFk7Tq1ka57SQHcs9UnpzATWupuqpBgw+aGYwnI/0VWwrDVsx2vyrAV9S
        KPipte/Ea1ba5P0VZB40q3xz7kvLOVtICMrZYosFlrejRfkjz+KEgiAYZR+OtxnmGJamCA
        +yG8Ky+wJ9/MErvxWvjzbVQwd0Q4NsI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-JJ7NoKYJMmeJ3ftDxfYeTg-1; Tue, 17 Jan 2023 04:36:47 -0500
X-MC-Unique: JJ7NoKYJMmeJ3ftDxfYeTg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 959BA1816EC2;
        Tue, 17 Jan 2023 09:36:47 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F8B32026D4B;
        Tue, 17 Jan 2023 09:36:42 +0000 (UTC)
Date:   Tue, 17 Jan 2023 17:36:37 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, ming.lei@redhat.com
Subject: Re: [PATCH V4 0/6] ublk_drv: add mechanism for supporting
 unprivileged ublk device
Message-ID: <Y8ZsJefw/Q6ArMzk@T590>
References: <20230106041711.914434-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106041711.914434-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 06, 2023 at 12:17:05PM +0800, Ming Lei wrote:
> Hello,
> 
> Stefan Hajnoczi suggested un-privileged ublk device[1] for container
> use case.
> 
> So far only administrator can create/control ublk device which is too
> strict and increase system administrator burden, and this patchset
> implements un-privileged ublk device:
> 
> - any user can create ublk device, which can only be controlled &
>   accessed by the owner of the device or administrator
> 
> For using such mechanism, system administrator needs to deploy two
> simple udev rules[2] after running 'make install' in ublksrv.
> 
> Userspace(ublksrv):
> 
> 	https://github.com/ming1/ubdsrv/tree/unprivileged-ublk
>     
> 'ublk add -t $TYPE --un_privileged' is for creating one un-privileged
> ublk device if the user is un-privileged.
> 
> 
> [1] https://lore.kernel.org/linux-block/YoOr6jBfgVm8GvWg@stefanha-x1.localdomain/
> [2] https://github.com/ming1/ubdsrv/blob/unprivileged-ublk/README.rst#un-privileged-mode
> 
> V4:
> 	- only allow to create unprivileged udev for current user, as
> 	  suggested by Jonathan Corbet
> 	- fix misc bug for handling failure
> 	- add detailed document
> 	- update userspace

Hello Guys,

Ping...

Thanks,
Ming

