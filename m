Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D06C43334
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 07:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiGRHjK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 03:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiGRHjJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 03:39:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BCD06256
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 00:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658129947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=++2N/7imJMoWf5QasX18W1tqzVPTcMTwmvlhsNVpq6M=;
        b=CBxskKql13qT7JjyBJaWXCE5P51EIySgh33gtqwczHMtLJaA7AR9ZImkSUaFq3InS9XxLx
        ZXwt2oyHJgNv0uvtIn9O5V/6RB4WJk6Pt4nrjUpziwzi7cmdcdbEPKaRe0LAL9iiz+ubsz
        MAV7Gf4MMYIJ6H5nGj4JNJ1aMf7CJU0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-pjUrVSikPW2Ls1cENHQ50g-1; Mon, 18 Jul 2022 03:38:58 -0400
X-MC-Unique: pjUrVSikPW2Ls1cENHQ50g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFAFF382C968;
        Mon, 18 Jul 2022 07:38:57 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 13FE640E80E0;
        Mon, 18 Jul 2022 07:38:53 +0000 (UTC)
Date:   Mon, 18 Jul 2022 15:38:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] ublk_drv: remove unneeded semicolon
Message-ID: <YtUOCAnJeMp9n66u@T590>
References: <20220718015431.40185-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718015431.40185-1-yang.lee@linux.alibaba.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 18, 2022 at 09:54:31AM +0800, Yang Li wrote:
> Eliminate the following coccicheck warnings:
> ./drivers/block/ublk_drv.c:1467:2-3: Unneeded semicolon
> ./drivers/block/ublk_drv.c:1528:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming

