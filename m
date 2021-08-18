Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04941C4320A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 08:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9646102A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 08:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239533AbhHRITm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 04:19:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240523AbhHRITk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 04:19:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629274739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SoCaANl7c6RKlEzHTDXqFNCLh+Bt3BGSnoCfVpJEyYw=;
        b=N/SXHsKM7TWTlfQ4olhvBxzQrPe7tS7USMb7gsUnZ8n92oRa2+S7hQURaXW27px4HRL74k
        FSriH2Zx6nM1b83MyTFsW1/q2OnLIqxIRdzd6YwSHZN2WO36EqT1aJJ/UHQjpleMKhy3ZF
        D2dSUwq1H6H4H7JcIQtEna54udR39wI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-VaJeJ4VrOYeAIMcuW4hdcA-1; Wed, 18 Aug 2021 04:18:56 -0400
X-MC-Unique: VaJeJ4VrOYeAIMcuW4hdcA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BB07190B2AA;
        Wed, 18 Aug 2021 08:18:54 +0000 (UTC)
Received: from T590 (ovpn-8-40.pek2.redhat.com [10.72.8.40])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 552AF60C0F;
        Wed, 18 Aug 2021 08:18:42 +0000 (UTC)
Date:   Wed, 18 Aug 2021 16:18:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, kashyap.desai@broadcom.com,
        hare@suse.de
Subject: Re: [PATCH v2 11/11] blk-mq: Stop using pointers for blk_mq_tags
 bitmap tags
Message-ID: <YRzCXnZXIM+MLvLI@T590>
References: <1628519378-211232-1-git-send-email-john.garry@huawei.com>
 <1628519378-211232-12-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628519378-211232-12-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Aug 09, 2021 at 10:29:38PM +0800, John Garry wrote:
> Now that we use shared tags for shared sbitmap support, we don't require
> the tags sbitmap pointers, so drop them.
> 
> This essentially reverts commit 222a5ae03cdd ("blk-mq: Use pointers for
> blk_mq_tags bitmap tags").
> 
> Signed-off-by: John Garry <john.garry@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

