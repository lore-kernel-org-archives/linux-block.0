Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC763C636CC
	for <linux-block@archiver.kernel.org>; Mon, 13 Feb 2023 08:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBMILy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Feb 2023 03:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBMILx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2023 03:11:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB062126C2
        for <linux-block@vger.kernel.org>; Mon, 13 Feb 2023 00:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676275863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4x46xLL0TfJzuXnHW5U4zSHrJGp5PcgN9oI7YofbjDc=;
        b=Swm2iu3IP+NE3hQau6jpG3GIdmAmkyaNO9+g/tF3vzU9+pJkmvk78H7PRjWc+B8EIohLow
        PMPbHdRed7MzKtNH9ZZpsknTKBbPusYCKUjOZHQq5qS4SoTyMqkjTpGr+mpfk5qlviGuZM
        Q23NCFDtEBV/i/CXKzihI3Z/FzeGRYQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-e3brSu57Pbi6OR3Ux-wDRQ-1; Mon, 13 Feb 2023 03:10:58 -0500
X-MC-Unique: e3brSu57Pbi6OR3Ux-wDRQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0BE82A59557;
        Mon, 13 Feb 2023 08:10:57 +0000 (UTC)
Received: from T590 (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 529DC140EBF4;
        Mon, 13 Feb 2023 08:10:52 +0000 (UTC)
Date:   Mon, 13 Feb 2023 16:10:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     axboe@kernel.dk, hch@lst.de, mcgrof@kernel.org,
        gost.dev@samsung.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/1] improve brd performance with blk-mq
Message-ID: <Y+nwh7V5xehxMWDR@T590>
References: <CGME20230203103122eucas1p161c0f0b674d26e23cf38466d5415420e@eucas1p1.samsung.com>
 <20230203103005.31290-1-p.raghav@samsung.com>
 <Y+Gsu0PiXBIf8fFU@T590>
 <6035da22-5667-93d5-fe00-62b988425cb5@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6035da22-5667-93d5-fe00-62b988425cb5@samsung.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 13, 2023 at 11:26:22AM +0530, Pankaj Raghav wrote:
> On 2023-02-07 07:13, Ming Lei wrote:
> > On Fri, Feb 03, 2023 at 04:00:05PM +0530, Pankaj Raghav wrote:
> >> Hi Jens,
> >>  brd is one of the few block drivers that still uses submit_bio instead
> >>  of blk-mq framework. The following patch converts brd to start using
> >>  blk-mq framework. Performance gains are pretty evident for read workloads.
> >>  The performance numbers are also attached as a part of
> >>  the commit log.
> >>
> >>  Performance (WD=[read|randread|write|randwrite]):
> >>  $ modprobe brd rd_size=1048576 rd_nr=1
> >>  $ echo "none" > /sys/block/ram0/queue/scheduler
> >>  $ fio --name=<WD>  --ioengine=io_uring --iodepth=64 --rw=<WD> --size=1G \
> >>    --io_size=20G --loop=4 --cpus_allowed=1 --filename=/dev/ram0 --iodepth=64
> >>    --direct=[0/1]
> >>
> >>   --direct=0
> > 
> > Can you share perf data on other non-io_uring engine often used? The
> > thing is that we still have lots of non-io_uring workloads, which can't
> > be hurt now.
> > 
> Sounds good. Does psync and libaio along with io_uring suffice?

Yeah, it should be enough.


Thanks,
Ming

