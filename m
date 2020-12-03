Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57594C6369E
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 00:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE205221F7
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 00:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgLCAwT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 19:52:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbgLCAwT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 19:52:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606956653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DRUzegjIlcBkY7wWtZr/BEsqwEEPB0u0Zdc6QykZL38=;
        b=ZY/Tw2sm/GbgxC/bt58EWihBnaKJ09eIe33zNUs/flu0olWD25sjE/5hOvE1ogqGCKz24/
        I68Uecxqn6zP9V2487TYWk28kzqynN4Fz8Nx/l1Ns+fnS1dlQqFGvOFCJDHKB7CirpmHb5
        OqbhihSoGbx4LYh2AXSKEYy4XhBNyEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-14TkWJ0XPBeI6k_Y0kducA-1; Wed, 02 Dec 2020 19:50:49 -0500
X-MC-Unique: 14TkWJ0XPBeI6k_Y0kducA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A2E518C8C00;
        Thu,  3 Dec 2020 00:50:48 +0000 (UTC)
Received: from T590 (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C712F5C1B4;
        Thu,  3 Dec 2020 00:50:39 +0000 (UTC)
Date:   Thu, 3 Dec 2020 08:50:35 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Qian Cai <qcai@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 0/3] blk-mq/nvme-loop: use nvme-loop's lock class for
 addressing lockdep false positive warning
Message-ID: <20201203005035.GA540033@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201130023606.GC230145@T590>
 <b70f46b855858a28b0e77ee7efbb2dbffbb56490.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b70f46b855858a28b0e77ee7efbb2dbffbb56490.camel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 02, 2020 at 02:07:08PM -0500, Qian Cai wrote:
> On Mon, 2020-11-30 at 10:36 +0800, Ming Lei wrote:
> > Any chance to take a look? And this issue has been reported several
> > times in RH internal test.
> 
> I suppose that you will need to rebase as it does not apply cleanly on today's
> linux-next.
> 

I just apply the three patches against for-5.11/block, and they can be
done cleanly.


Thanks,
Ming

