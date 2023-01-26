Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61278C54E94
	for <linux-block@archiver.kernel.org>; Thu, 26 Jan 2023 11:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237270AbjAZLev (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 06:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbjAZLem (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 06:34:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135F832E76
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 03:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674732833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9PByESDZ41gW2ems66oKjySiJzUt7ebF22FrkpLefB8=;
        b=fry8kPcQfbeFIuNAiC5S3cZPocx1iupuJ5r3+sOPnskQsXPO92iT8I4chE25AqW4zMU4VH
        YqGDV+gHXtus462KV6l+SmCH8lowtXm2MRB1X5/6qGMAuRTqBpYODYYizV7k0wf3keA2Yr
        rNAkssWiZ9ytW17dbskoNJjqJYezOsM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-34-kYl50lNSPzitXixuY26Qfg-1; Thu, 26 Jan 2023 06:33:51 -0500
X-MC-Unique: kYl50lNSPzitXixuY26Qfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99F3985C064;
        Thu, 26 Jan 2023 11:33:51 +0000 (UTC)
Received: from T590 (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1943A40C2064;
        Thu, 26 Jan 2023 11:33:47 +0000 (UTC)
Date:   Thu, 26 Jan 2023 19:33:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Harris, James R" <james.r.harris@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        ming.lei@redhat.com
Subject: Re: kernel oops when rmmod'ing ublk_drv w/ missing UBLK_CMD_START_DEV
Message-ID: <Y9JlFmSgDl3+zy3N@T590>
References: <78E62777-98A7-4D19-9608-D8A3412D9800@intel.com>
 <d949dbc2-a0cf-c581-c5ca-ddefc592a0a5@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d949dbc2-a0cf-c581-c5ca-ddefc592a0a5@kernel.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 25, 2023 at 01:05:55PM -0700, Jens Axboe wrote:
> On 1/25/23 12:50?PM, Harris, James R wrote:
> > Hi,
> > 
> > I can reliably hit a kernel oops with ublk_drv using the following abnormal sequence of events (repro .c file at end of this e-mail):
> > 
> > 1) modprobe ublk_drv
> > 2) run test app which basically does:
> >   a) submit UBLK_CMD_ADD_DEV
> >   b) submit UBLK_CMD_SET_PARAMS
> >   c) wait for completions
> >   d) do *not* submit UBLK_CMD_START_DEV
> >   e) exit
> > 3) rmmod ublk_drv
> > 
> > Reproduces on 6.2-rc5, 6.1.5 and 6.1.
> 
> Something like this may do it, but I'll let Ming sort out the details
> on what's the most appropriate fix.

Hi Jens and James,

The ublk char device still needs to be deleted even though START_DEV
isn't called given the char device is added in ADD_DEV's handler, so
the current logic is correct.

The root cause is that 'ublk_chr_class' is destroyed too early, so
the following patch should fix the issue.

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 17b677b5d3b2..e54693204630 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2092,13 +2092,12 @@ static void __exit ublk_exit(void)
        struct ublk_device *ub;
        int id;

-       class_destroy(ublk_chr_class);
-
-       misc_deregister(&ublk_misc);
-
        idr_for_each_entry(&ublk_index_idr, ub, id)
                ublk_remove(ub);

+       class_destroy(ublk_chr_class);
+       misc_deregister(&ublk_misc);
+
        idr_destroy(&ublk_index_idr);
        unregister_chrdev_region(ublk_chr_devt, UBLK_MINORS);
 }


Thanks, 
Ming

