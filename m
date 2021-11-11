Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC2AC433EF
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 12:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E2561267
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 12:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbhKKMJC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 07:09:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48367 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232318AbhKKMJC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 07:09:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636632372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fHQHjtQ2HtSwcNWHV1xAbliIto05tchAMgw+CQxuMds=;
        b=NglCR4e+kMyqF1zN4rjHd6/xYXt/Vhgp8JjPxzoGExgA1f2PdH3+mRAd3r+F2Wh5047H7n
        OcbBpnnnnSsQq37OkervtmDAHCcjYCM9YWh+qMeW0jewRlUNm6LuY0IkHep7JHB4Mj0gPQ
        tcHaXvhw08ZFocHFIBabkg615acnDNI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-BNiJ9pHxNOCqVQ-lU58NDw-1; Thu, 11 Nov 2021 07:06:07 -0500
X-MC-Unique: BNiJ9pHxNOCqVQ-lU58NDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 612E880DDE1;
        Thu, 11 Nov 2021 12:06:06 +0000 (UTC)
Received: from T590 (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B4ED956A9A;
        Thu, 11 Nov 2021 12:05:54 +0000 (UTC)
Date:   Thu, 11 Nov 2021 20:05:49 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] block: Hold invalidate_lock in BLKRESETZONE ioctl
Message-ID: <YY0HHSR/c+8eg1rD@T590>
References: <20211111085238.942492-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111085238.942492-1-shinichiro.kawasaki@wdc.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 11, 2021 at 05:52:38PM +0900, Shin'ichiro Kawasaki wrote:
> When BLKRESETZONE ioctl and data read race, the data read leaves stale
> page cache. The commit e5113505904e ("block: Discard page cache of zone
> reset target range") added page cache truncation to avoid stale page
> cache after the ioctl. However, the stale page cache still can be read
> during the reset zone operation for the ioctl. To avoid the stale page
> cache completely, hold invalidate_lock of the block device file mapping.
> 
> Fixes: e5113505904e ("block: Discard page cache of zone reset target range")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Cc: stable@vger.kernel.org # v5.15
> ---

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

