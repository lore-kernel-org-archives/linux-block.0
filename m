Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DC0C4332F
	for <linux-block@archiver.kernel.org>; Mon, 12 Dec 2022 04:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiLLEBF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Dec 2022 23:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiLLEBE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Dec 2022 23:01:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0102D2C2
        for <linux-block@vger.kernel.org>; Sun, 11 Dec 2022 20:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670817608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rfgbf1yYdfASHlLhjTEM6Klr/mi55HCilood1heSzso=;
        b=e4CXYCW64ChFChfCar6h06tUhKu/9gO51lLuH6/iy9nDkorvPVdwXsfvxVn1xF3gmG3sDJ
        YQhdt0SCf8gbjdqdMUguHzwynTAp8wi1c0Ap97/9UVk+IFF1hiti0VYxx3lg3BRGrXc53M
        VpKHvLEzaMa4F10ZTJwI1BocTpzOUhs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-RWvNE94SMdG4Fgpz7XFIhg-1; Sun, 11 Dec 2022 23:00:05 -0500
X-MC-Unique: RWvNE94SMdG4Fgpz7XFIhg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD228801580;
        Mon, 12 Dec 2022 04:00:04 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DD9840C2004;
        Mon, 12 Dec 2022 03:59:58 +0000 (UTC)
Date:   Mon, 12 Dec 2022 11:59:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>, ming.lei@redhat.com
Subject: Re: [PATCH V3 0/6] ublk_drv: add mechanism for supporting
 unprivileged ublk device
Message-ID: <Y5anOZyJBCes1XEo@T590>
References: <20221207123305.937678-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207123305.937678-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 07, 2022 at 08:32:59PM +0800, Ming Lei wrote:
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
> V3:
> 	- don't warn on invalid user input for setting devt parameter, as
> 	  suggested by Ziyang, patch 4/6
> 	- fix one memory corruption issue, patch 6/6

Hello Guys,

Ping...


thanks,
Ming

