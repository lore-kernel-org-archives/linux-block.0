Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F20C2D0E4
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 09:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8E924686
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 09:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AZrU0tuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgKSJnB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 04:43:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26641 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726073AbgKSJnB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 04:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605778980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cjfdvm5Tfse8jTWw5YoNVzoIaAqmnjpRqiwz0+jowt4=;
        b=AZrU0tuk8Edb2aNq8/hnRDrsEY3JJgbGBofOcjpXnczOVqsGaY1aCGm9j7XLSHoqtZtbp/
        ilqxuDVOrHilcsRpR8Fc/LVm+CcqtUS6Zgms7vvsY7l7/ez3hdtFCbe+YfSYXkpYTM/Z0d
        A21/yu5dK0EdbbNX/aFlKdAvPlJ8ENc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-iCkBv1ZPNd-59-2s06qvYw-1; Thu, 19 Nov 2020 04:42:58 -0500
X-MC-Unique: iCkBv1ZPNd-59-2s06qvYw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF2411906819;
        Thu, 19 Nov 2020 09:42:56 +0000 (UTC)
Received: from T590 (ovpn-13-167.pek2.redhat.com [10.72.13.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D71705B4BC;
        Thu, 19 Nov 2020 09:42:47 +0000 (UTC)
Date:   Thu, 19 Nov 2020 17:42:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     Omar Sandoval <osandov@fb.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumanesh Samanta <sumanesh.samanta@broadcom.com>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH V5 00/13] blk-mq/scsi: tracking device queue depth via
 sbitmap
Message-ID: <20201119094242.GA279559@T590>
References: <20201119093402.279318-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119093402.279318-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 19, 2020 at 05:33:49PM +0800, Ming Lei wrote:
> Hi,
> 

Looks this git-send-email is terminated  and the whole series isn't
sent out completely.

Please ignore this thread, will re-send soon.

Thanks,
Ming

