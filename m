Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775E9C433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 14:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiCNOmX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 10:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiCNOmW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 10:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8254E12AAA
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 07:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647268871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CerS4a8OUZGYW+X8CS5QhG576h4KjCig00kFCIeH3Dg=;
        b=QzKSnZAge3lL0X4y0BkWJGzs5FEQ9K3Y0Erny5uktOQqEyngGbPBnHUZSFfJ0Z+qV7Vj4C
        eVMDAsJuGkHo7/GTQQBDdlzDL/y5lttHkPpgCYE3RnZi/sRZCqPvzPsJTWB930n9LEzNwp
        f6wiy5MN+Dh/WDhmfLTp9BJa4nDOZ3I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-GIcs86ffO8SR6ecWw880HQ-1; Mon, 14 Mar 2022 10:41:08 -0400
X-MC-Unique: GIcs86ffO8SR6ecWw880HQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26E211C01506;
        Mon, 14 Mar 2022 14:41:07 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 995B5145B961;
        Mon, 14 Mar 2022 14:40:58 +0000 (UTC)
Date:   Mon, 14 Mar 2022 22:40:53 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Kanchan Joshi <joshiiitr@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, sbates@raithlin.com,
        logang@deltatee.com, Pankaj Raghav <pankydev8@gmail.com>,
        Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 10/17] block: wire-up support for plugging
Message-ID: <Yi9T9UBIz/Qfciok@T590>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152714epcas5p4c5a0d16512fd7054c9a713ee28ede492@epcas5p4.samsung.com>
 <20220308152105.309618-11-joshi.k@samsung.com>
 <20220310083400.GD26614@lst.de>
 <CA+1E3rJMSc33tkpXUdnftSuxE5yZ8kXpAi+czSNhM74gQgk_Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+1E3rJMSc33tkpXUdnftSuxE5yZ8kXpAi+czSNhM74gQgk_Ag@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 10, 2022 at 06:10:08PM +0530, Kanchan Joshi wrote:
> On Thu, Mar 10, 2022 at 2:04 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Tue, Mar 08, 2022 at 08:50:58PM +0530, Kanchan Joshi wrote:
> > > From: Jens Axboe <axboe@kernel.dk>
> > >
> > > Add support to use plugging if it is enabled, else use default path.
> >
> > The subject and this comment don't really explain what is done, and
> > also don't mention at all why it is done.
> 
> Missed out, will fix up. But plugging gave a very good hike to IOPS.

But how does plugging improve IOPS here for passthrough request? Not
see plug->nr_ios is wired to data.nr_tags in blk_mq_alloc_request(),
which is called by nvme_submit_user_cmd().


Thanks, 
Ming

