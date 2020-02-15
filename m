Return-Path: <SRS0=Iyu6=4D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FF1C352A3
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 03:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADF22084E
	for <linux-block@archiver.kernel.org>; Sat, 15 Feb 2020 03:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q6naduLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgBODrL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 22:47:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48525 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727720AbgBODrL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 22:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581738430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hkwg5DEXlLJyMnQCtdrdMz1gYg6CkSO++6/Wb9Fh0qI=;
        b=Q6naduLOHcGNrcY1IfhlXeqO/iZ4yAL2rDSWSxQqO0+PW9JkcBB9AMSg8WQG6SZ7nwELWf
        mqqi+/xwdWSH3B7mXFz7dJGiCgPIX49JPMQ7L+kc3u6NMIeK0eZ/bSBBBL6I5bwrksX/EY
        mLGLQ8MG3vp0GfbQyOZ1cXOnJ/oV3TM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-ddDc33jVMHSXuRB4w2yvnA-1; Fri, 14 Feb 2020 22:47:06 -0500
X-MC-Unique: ddDc33jVMHSXuRB4w2yvnA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECBAF800D53;
        Sat, 15 Feb 2020 03:47:04 +0000 (UTC)
Received: from ming.t460p (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA2895C1C3;
        Sat, 15 Feb 2020 03:46:57 +0000 (UTC)
Date:   Sat, 15 Feb 2020 11:46:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Salman Qazi <sqazi@google.com>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Subject: Re: BLKSECDISCARD ioctl and hung tasks
Message-ID: <20200215034652.GA19867@ming.t460p>
References: <CAKUOC8VN5n+YnFLPbQWa1hKp+vOWH26FKS92R+h4EvS=e11jFA@mail.gmail.com>
 <20200213082643.GB9144@ming.t460p>
 <d2c77921-fdcd-4667-d21a-60700e6a2fa5@acm.org>
 <CAKUOC8U1H8qJ+95pcF-fjeu9hag3P3Wm6XiOh26uXOkvpNngZg@mail.gmail.com>
 <de7b841c-a195-1b1e-eb60-02cbd6ba4e0a@acm.org>
 <CACVXFVP114+QBhw1bXqwgKRw_s4tBM_ZkuvjdXEU7nwkbJuH1Q@mail.gmail.com>
 <CAKUOC8Xss0YPefhKfwBiBar-7QQ=QrVh3d_8NBfidCCxUuxcgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKUOC8Xss0YPefhKfwBiBar-7QQ=QrVh3d_8NBfidCCxUuxcgg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Feb 14, 2020 at 11:42:32AM -0800, Salman Qazi wrote:
> On Fri, Feb 14, 2020 at 1:23 AM Ming Lei <tom.leiming@gmail.com> wrote:
> >
> > On Fri, Feb 14, 2020 at 1:50 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > >
> > > On 2020-02-13 11:21, Salman Qazi wrote:
> > > > AFAICT, This is not actually sufficient, because the issuer of the bio
> > > > is waiting for the entire bio, regardless of how it is split later.
> > > > But, also there isn't a good mapping between the size of the secure
> > > > discard and how long it will take.  If given the geometry of a flash
> > > > device, it is not hard to construct a scenario where a relatively
> > > > small secure discard (few thousand sectors) will take a very long time
> > > > (multiple seconds).
> > > >
> > > > Having said that, I don't like neutering the hung task timer either.
> > >
> > > Hi Salman,
> > >
> > > How about modifying the block layer such that completions of bio
> > > fragments are considered as task activity? I think that bio splitting is
> > > rare enough for such a change not to affect performance of the hot path.
> >
> > Are you sure that the task hung warning won't be triggered in case of
> > non-splitting?
> 
> I demonstrated a few emails ago that it doesn't take a very large
> secure discard command to trigger this.  So, I am sceptical that we
> will be able to use splitting to solve this.
> 
> >
> > >
> > > How about setting max_discard_segments such that a discard always
> > > completes in less than half the hung task timeout? This may make
> > > discards a bit slower for one particular block driver but I think that's
> > > better than hung task complaints.
> >
> > I am afraid you can't find a golden setting max_discard_segments working
> > for every drivers. Even it is found, the performance  may have been affected.
> >
> > So just wondering why not take the simple approach used in blk_execute_rq()?
> 
> My colleague Gwendal pointed out another issue which I had missed:
> secure discard is an exclusive command: it monopolizes the device.
> Even if we fix this via your approach, it will show up somewhere else,
> because other operations to the drive will not make progress for that
> length of time.

What are the 'other operations'? Are they block IOs?

If yes, that is why I suggest to fix submit_bio_wait(), which should cover
most of sync bio submission.

Anyway, the fix is simple & generic enough, I'd plan to post a formal
patch if no one figures out better doable approaches.

> 
> For Chromium OS purposes, if we had a blank slate, this is how I would solve it:
> 
> * Under the assumption that the truly sensitive data is not very big:
>     * Keep secure data on a separate partition to make sure that those
> LBAs have controlled history
>     * Treat the files in that partition as immutable (i.e. no
> overwriting the contents of the file without first secure erasing the
> existing contents).
>     * By never letting more than one version of the file accumulate,
> we can guarantee that the secure erase will always be fast for
> moderate sized files.
> 
> But for all the existing machines with keys on them, we will need to
> do something else.

The issue you reported is a generic one, not Chromium only.


Thanks,
Ming

