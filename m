Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB7DC433EF
	for <linux-block@archiver.kernel.org>; Wed, 23 Mar 2022 01:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiCWB3R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 21:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiCWB3P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 21:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 342996FA0A
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 18:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647998866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uv0x7IhJh6HUYVs80OeWrM0ewUxdezb68rDatc83fOk=;
        b=OsdvUwNWUvtcMzB7xmzje4kNYCnsFWGQw1AoRa9R7e6ANNuIXAiLCswSKYmQ5zfO2JBs+o
        4NLvX1bSRLoKtsZ3tnrE7MBBjdTQtwElk/9eXFB2bcRk5jas3ZupUjzJe1ovpiKXHwiJoi
        PKE0Yvk8vtezPxLodCopHdsVqnlKnBs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-pGai4B4ePTaoBfBKVAlgbw-1; Tue, 22 Mar 2022 21:27:40 -0400
X-MC-Unique: pGai4B4ePTaoBfBKVAlgbw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E99C85A5BE;
        Wed, 23 Mar 2022 01:27:40 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E12497AD1;
        Wed, 23 Mar 2022 01:27:22 +0000 (UTC)
Date:   Wed, 23 Mar 2022 09:27:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     Kanchan Joshi <joshiiitr@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <kbusch@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, sbates@raithlin.com,
        logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 10/17] block: wire-up support for plugging
Message-ID: <Yjp3dMxs764WEz6N@T590>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152714epcas5p4c5a0d16512fd7054c9a713ee28ede492@epcas5p4.samsung.com>
 <20220308152105.309618-11-joshi.k@samsung.com>
 <20220310083400.GD26614@lst.de>
 <CA+1E3rJMSc33tkpXUdnftSuxE5yZ8kXpAi+czSNhM74gQgk_Ag@mail.gmail.com>
 <Yi9T9UBIz/Qfciok@T590>
 <20220321070208.GA5107@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321070208.GA5107@test-zns>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 21, 2022 at 12:32:08PM +0530, Kanchan Joshi wrote:
> On Mon, Mar 14, 2022 at 10:40:53PM +0800, Ming Lei wrote:
> > On Thu, Mar 10, 2022 at 06:10:08PM +0530, Kanchan Joshi wrote:
> > > On Thu, Mar 10, 2022 at 2:04 PM Christoph Hellwig <hch@lst.de> wrote:
> > > >
> > > > On Tue, Mar 08, 2022 at 08:50:58PM +0530, Kanchan Joshi wrote:
> > > > > From: Jens Axboe <axboe@kernel.dk>
> > > > >
> > > > > Add support to use plugging if it is enabled, else use default path.
> > > >
> > > > The subject and this comment don't really explain what is done, and
> > > > also don't mention at all why it is done.
> > > 
> > > Missed out, will fix up. But plugging gave a very good hike to IOPS.
> > 
> > But how does plugging improve IOPS here for passthrough request? Not
> > see plug->nr_ios is wired to data.nr_tags in blk_mq_alloc_request(),
> > which is called by nvme_submit_user_cmd().
> 
> Yes, one tag at a time for each request, but none of the request gets
> dispatched and instead added to the plug. And when io_uring ends the
> plug, the whole batch gets dispatched via ->queue_rqs (otherwise it used
> to be via ->queue_rq, one request at a time).
> 
> Only .plug impact looks like this on passthru-randread:
> 
> KIOPS(depth_batch)  1_1    8_2    64_16    128_32
> Without plug        159    496     784      785
> With plug           159    525     991     1044
> 
> Hope it does clarify.

OK, thanks for your confirmation, then the improvement should be from
batch submission only.

If cached request is enabled, I guess the number could be better.


Thanks,
Ming

