Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59738C35E15
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 21:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E52420714
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 21:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkxCRvxW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgBYVXG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:23:06 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39108 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728955AbgBYVXG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 16:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582665785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PQObOh8Mnx+x3iklpCFJ8G4T1sYfTd2NhFbZUFwGDBM=;
        b=MkxCRvxWnHp7MtowpwudPuyp33VzfmdzGAycNqfwGbWb0jozG4wWP6xEVLKBwlmLb1wUjs
        OMJaf0eLG9y6WhyCq/sionMt+16LcCFUSAg9pSwb+/tqyvxOQegpi3COdqxhcnRBIq68iv
        0EycI52BXvlLlmkp7Ucq6HNhCi2HwQo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-cZkbFr_HNWO6Rkhkuflldg-1; Tue, 25 Feb 2020 16:23:00 -0500
X-MC-Unique: cZkbFr_HNWO6Rkhkuflldg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14A201B2C98A;
        Tue, 25 Feb 2020 21:22:59 +0000 (UTC)
Received: from ming.t460p (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4570C90F72;
        Tue, 25 Feb 2020 21:22:52 +0000 (UTC)
Date:   Wed, 26 Feb 2020 05:22:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH V2] blk-mq: insert passthrough request into
 hctx->dispatch directly
Message-ID: <20200225212248.GA18633@ming.t460p>
References: <20200225010432.29225-1-ming.lei@redhat.com>
 <20200225155102.GA18299@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225155102.GA18299@infradead.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On Tue, Feb 25, 2020 at 07:51:02AM -0800, Christoph Hellwig wrote:
> It would be really helpful if the commit log contained the explanation
> from your reply on the previous submission..

IMO, the issue isn't only on SCSI with ALUA which is just one example,
and it should happen on any situation in which FS request depends on
passthrough request. From this viewpoint, the commit log is enough,
and ALUA story may not be needed.


Thanks,
Ming

