Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8424FC04A68
	for <linux-block@archiver.kernel.org>; Thu, 28 Jul 2022 14:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiG1OOx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jul 2022 10:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbiG1OOr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jul 2022 10:14:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8327222AD
        for <linux-block@vger.kernel.org>; Thu, 28 Jul 2022 07:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659017683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MfLj6nimkQcdqEYY3XHx3f7brs8Urjc0+jJKTY+iX/g=;
        b=UjVNoPmK56y1y/2P97OyRKk0ShHPwYiyNCVhAifkX+Hh8QSWUzBdubFlG1Yg6+T6gBT+Jt
        dVQZQS9E+EGFuCZH4TO0ykgyvuoD/yjgfM+00H84SfIsS6WNuBqE+xH5q1DGYpwO6IoMMb
        KiyyDzbArNm0SjvoAjKyhlvGqlQauKg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-30jeiqZvOdaxRnVUfDgtgA-1; Thu, 28 Jul 2022 10:14:40 -0400
X-MC-Unique: 30jeiqZvOdaxRnVUfDgtgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF8251C08971;
        Thu, 28 Jul 2022 14:14:39 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 84DDD2166B29;
        Thu, 28 Jul 2022 14:14:35 +0000 (UTC)
Date:   Thu, 28 Jul 2022 22:14:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com
Subject: Re: [PATCH V4 2/2] ublk_drv: add support for UBLK_IO_NEED_GET_DATA
Message-ID: <YuKZxpDNhzsKSXB+@T590>
References: <cover.1659011443.git.ZiyangZhang@linux.alibaba.com>
 <3a21007ea1be8304246e654cebbd581ab0012623.1659011443.git.ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a21007ea1be8304246e654cebbd581ab0012623.1659011443.git.ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 28, 2022 at 08:39:16PM +0800, ZiyangZhang wrote:
> UBLK_IO_NEED_GET_DATA is one ublk IO command. It is designed for a user
> application who wants to allocate IO buffer and set IO buffer address
> only after it receives an IO request from ublksrv. This is a reasonable
> scenario because these users may use a RPC framework as one IO backend
> to handle IO requests passed from ublksrv. And a RPC framework may
> allocate its own buffer(or memory pool).
> 
> This new feature (UBLK_F_NEED_GET_DATA) is optional for ublk users.
> Related userspace code has been added in ublksrv[1] as one pull request.
> 
> Test cases for this feature are added in ublksrv and all the tests pass.
> The performance result shows that this new feature does bring additional
> latency because one IO is issued back to ublk_drv once again to copy data
> from bio vectors to user-provided data buffer. UBLK_IO_NEED_GET_DATA is
> suitable for bigger block size such as 512B or 1MB.
> 
> [1] https://github.com/ming1/ubdsrv
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

