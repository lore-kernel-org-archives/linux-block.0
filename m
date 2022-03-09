Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A65C433EF
	for <linux-block@archiver.kernel.org>; Wed,  9 Mar 2022 01:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiCIBGB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 20:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiCIBFz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 20:05:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7903B1323E9
        for <linux-block@vger.kernel.org>; Tue,  8 Mar 2022 16:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646786672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E6n7SzvjbjV0fhN0o0d1nNAG+YC9und3wfm85quzSDE=;
        b=LYLw/IHZh1rM7IoZi5X/uPNTSNfdxONTz4/LEVA+YypOr3BU5ANXC5DDzLwfOmU2VmN4Gi
        Pc04quPnNXecHxNKSGexjROElJBdNKSee0wHGdVsdj/9pBZck7T6i/sX2XSGsHSv2IexqL
        aFcPyT1y1dw3JLgabOGSunl+pvROXWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-cPmmNhjuP1qUWe_mBGATDQ-1; Tue, 08 Mar 2022 19:44:29 -0500
X-MC-Unique: cPmmNhjuP1qUWe_mBGATDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC510800050;
        Wed,  9 Mar 2022 00:44:27 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6CAF6163C9;
        Wed,  9 Mar 2022 00:44:15 +0000 (UTC)
Date:   Wed, 9 Mar 2022 08:44:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH] block: fix blk_mq_attempt_bio_merge and rq_qos_throttle
 protection
Message-ID: <Yif4WwqMAKA7YsJY@T590>
References: <20220308080915.3473689-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308080915.3473689-1-shinichiro.kawasaki@wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 08, 2022 at 05:09:15PM +0900, Shin'ichiro Kawasaki wrote:
> Commit 9d497e2941c3 ("block: don't protect submit_bio_checks by
> q_usage_counter") moved blk_mq_attempt_bio_merge and rq_qos_throttle
> calls out of q_usage_counter protection. However, these functions require
> q_usage_counter protection. The blk_mq_attempt_bio_merge call without
> the protection resulted in blktests block/005 failure with KASAN null-
> ptr-deref or use-after-free at bio merge. The rq_qos_throttle call
> without the protection caused kernel hang at qos throttle.
> 
> To fix the failures, move the blk_mq_attempt_bio_merge and
> rq_qos_throttle calls back to q_usage_counter protection.
> 
> Fixes: 9d497e2941c3 ("block: don't protect submit_bio_checks by q_usage_counter")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

