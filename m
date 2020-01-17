Return-Path: <SRS0=x5xE=3G=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF3CC33CB1
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 10:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 255A02082F
	for <linux-block@archiver.kernel.org>; Fri, 17 Jan 2020 10:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPYiUE6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgAQKQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:16:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46634 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbgAQKQT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jan 2020 05:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579256178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rwRXymUwAkMDCgXlcoxUIxeW4ktjQFA/XyK4tMjm+kE=;
        b=DPYiUE6xGSj1g26efI/uZjZMm+ze5NcG0qRZ9Bog1Og0b5BQsWbrJY8OdDwXfDe9CGIkle
        bhPpdkjOTeVcNy7gaeGmS1ASXJrWHE6LW2qT/HQo2Y8LZA4x1USJ2TcEEaH25uhrHR0Htf
        TZDyDVD8m0u5Ato/fx/W8/Fv7kPtVAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-Ja14PRT2NIGpP9fDSIURlg-1; Fri, 17 Jan 2020 05:16:15 -0500
X-MC-Unique: Ja14PRT2NIGpP9fDSIURlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89D0B800D48;
        Fri, 17 Jan 2020 10:16:13 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 738E210016DA;
        Fri, 17 Jan 2020 10:16:06 +0000 (UTC)
Date:   Fri, 17 Jan 2020 18:16:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        john.garry@huawei.com, "axboe@kernel.dk" <axboe@kernel.dk>,
        hare@suse.de, Bart Van Assche <bvanassche@acm.org>,
        yanaijie <yanaijie@huawei.com>
Subject: Re: [Question] about shared tags for SCSI drivers
Message-ID: <20200117101602.GA22310@ming.t460p>
References: <bd959b9f-78dd-e0e7-0421-8d7e3cd2f41b@huawei.com>
 <20200116090347.GA7438@ming.t460p>
 <825dc368-1b97-b418-dc71-6541b1c20a70@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <825dc368-1b97-b418-dc71-6541b1c20a70@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jan 17, 2020 at 03:19:18PM +0800, Yufen Yu wrote:
> Hi, ming
> 
> On 2020/1/16 17:03, Ming Lei wrote:
> > On Thu, Jan 16, 2020 at 12:06:02PM +0800, Yufen Yu wrote:
> > > Hi, all
> > > 
> > > Shared tags is introduced to maintains a notion of fairness between
> > > active users. This may be good for nvme with multiple namespace to
> > > avoid starving some users. Right?
> > 
> > Actually nvme namespace is LUN of scsi world.
> > 
> > Shared tags isn't for maintaining fairness, it is just natural sw
> > implementation of scsi host's tags, since every scsi host shares
> > tags among all LUNs. If the SCSI host supports real MQ, the tags
> > is hw-queue wide, otherwise it is host wide.
> > 
> > > 
> > > However, I don't understand why we introduce the shared tag for SCSI.
> > > IMO, there are two concerns for scsi shared tag:
> > > 
> > > 1) For now, 'shost->can_queue' is used as queue depth in block layer.
> > > And all target drivers share tags on one host. Then, the max tags for
> > > each target can get:
> > > 
> > > 	depth = max((bt->sb.depth + users - 1) / users, 4U);
> > > 
> > > But, each target driver may have their own capacity of tags and queue depth.
> > > Does shared tag limit target device bandwidth?
> > 
> > No, if the 'target driver' means LUN, each LUN hasn't its independent
> > tags, maybe it has its own queue depth, which is often for maintaining
> > fairness among all active LUNs, not real queue depth.
> > 
> > You may see the patches[1] which try to bypass per-LUN queue depth for SSD.
> > 
> > [1] https://lore.kernel.org/linux-block/20191118103117.978-1-ming.lei@redhat.com/
> > 
> > > 
> > > 2) When add new target or remove device, it may need to freeze other device
> > > to update hctx->flags of BLK_MQ_F_TAG_SHARED. That may hurt performance.
> > 
> > Add/removing device isn't a frequent event, so it shouldn't be a real
> > issue, or you have seen effect on real use case?
> 
> Thanks a lot for your detailed explanation.
> 
> We found that removing scsi device will delay a long time (such as 6 * 30s)
> for waiting the other device in the same host to complete all IOs, where
> some IO retry multiple times. If our driver allowed more times to retry,
> removing device will wait longer. That is not expected.

I'd suggest you to figure out why IO timeout is triggered in your
device.

> 
> In fact, that is not problem before switching scsi blk-mq. All target
> devices are independent when removing.

Is there IO timeout triggered before switching to scsi-mq?

I guess it shouldn't be one issue if io timeout isn't triggered.

However, there is still something we can improve, such as,
start concurrent queue freeze in blk_mq_update_tag_set_depth().

Thanks,
Ming

