Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DE4EB64DA
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 15:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbjGEPZe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 11:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGEPZe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 11:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1C9172B
        for <linux-block@vger.kernel.org>; Wed,  5 Jul 2023 08:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688570684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Go8B2fye6lsvtn92sJ9pJCTHRgcRTAG24v4nf2v9fck=;
        b=IvKieG+dTg37sZLHYPR1TH8H+W9BuinlIILXESXwjGmGWifej7Hv4Dc+FdOE0ruDQxyMyd
        CfQnrk4dpmC+D2cqv/+Zqd72mVHc3bUEstm9EavG5zFHzThxpqpJtBSK58Bm3eKK3WW+2y
        E/X38ych5rjiqyWS2mCCfZylliMCPtc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-48x8429NNmCoQQwJEqCS5A-1; Wed, 05 Jul 2023 11:24:41 -0400
X-MC-Unique: 48x8429NNmCoQQwJEqCS5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FE6D185A7A5;
        Wed,  5 Jul 2023 15:24:41 +0000 (UTC)
Received: from ovpn-8-34.pek2.redhat.com (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B0B9207B2DA;
        Wed,  5 Jul 2023 15:24:38 +0000 (UTC)
Date:   Wed, 5 Jul 2023 23:24:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH blktests] common/ublk: avoid modprobe failure for
 built-in ublk_drv
Message-ID: <ZKWLMZ2+bBeIofSr@ovpn-8-34.pek2.redhat.com>
References: <20230705103522.3383196-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705103522.3383196-1-shinichiro.kawasaki@wdc.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 05, 2023 at 07:35:22PM +0900, Shin'ichiro Kawasaki wrote:
> When ublk_drv driver is not a loadable module but a built-in module,
> modprobe for the driver fails in _init_ublk. This results in unexpected
> test case skips with the message "requires ublk_drv".
> 
> To not skip the test cases with built-in ublk_drv, call modprobe only
> when the driver is loadable and its module file exists. Also, do not set
> SKIP_REASONS to handle modprobe failure as test case failure.
> 
> Fixes: 840ccf1fc33e ("block/033: add test to cover gendisk leak")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

