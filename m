Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5BAC433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 22:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A95E2078B
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 22:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1QWMgn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgGHWDj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 18:03:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30010 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725903AbgGHWDi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 18:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594245817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WThmnM70xpTfPhR+gWfqnJ5OrmYYzQYfa2iRKS+jwKU=;
        b=d1QWMgn6aheqFM4zE17O5CghMKibZoNAIJokpfzKU0ykp3KePEHHSWdfiJl67YvGcjegOD
        LqFm8h7r8KYhLEOB0wWrgO049uqWdM2u5BJwh7AA9HuDT/Eaik/9g6sNZ6oioelUjQsICx
        bzDkC/Vu9/cRCDFbs7UsV9OZX5hcH2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-P8ZwmZmFP9Wu5hy8mDP_wQ-1; Wed, 08 Jul 2020 18:03:32 -0400
X-MC-Unique: P8ZwmZmFP9Wu5hy8mDP_wQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4505C10060D4;
        Wed,  8 Jul 2020 22:03:31 +0000 (UTC)
Received: from T590 (ovpn-12-29.pek2.redhat.com [10.72.12.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B386479811;
        Wed,  8 Jul 2020 22:03:22 +0000 (UTC)
Date:   Thu, 9 Jul 2020 06:03:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2] blk-mq: streamline handling of q->mq_ops->queue_rq
 result
Message-ID: <20200708220317.GA3348426@T590>
References: <20200701135857.2445459-1-ming.lei@redhat.com>
 <20200708122749.GA3340386@T590>
 <90d57d37-6da9-cae4-55b0-264c3dd885b0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90d57d37-6da9-cae4-55b0-264c3dd885b0@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 08, 2020 at 03:05:03PM +0100, John Garry wrote:
> On 08/07/2020 13:27, Ming Lei wrote:
> > k;
> > -		} else if (ret == BLK_STS_ZONE_RESOURCE) {
> > +		case BLK_STS_RESOURCE:
> > +		case BLK_STS_DEV_RESOURCE:
> > +			blk_mq_handle_dev_resource(rq, list);
> > +			goto out;
> > +		case BLK_STS_ZONE_RESOURCE:
> >   			/*
> >   			 * Move the request to zone_list and keep going through
> >   			 * the dispatch list to find more requests the drive can
> 
> question not on this patch specifically: is this supposed to be "driver",
> and not "drive"? "driver" is mentioned earlier in the function

Hi John,

Please focus on change added by this patch instead of existed context code.

If you have question on existed code, start a new thread for the discussion.

Thanks,
Ming

