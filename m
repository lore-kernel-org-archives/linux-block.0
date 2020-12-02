Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3173CC71155
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 19:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F9422254
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 19:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387902AbgLBTIs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 14:08:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726082AbgLBTIs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 14:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606936042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GyPnByql6hDKb++n9qwMPEM+6fVfKn8Oppnc5Ohl5K0=;
        b=ExQHEADEp/3hX7aENhdplJkPlru5PGz0iOwUgGfqOKlCrYQKvOhjLfEWfMZrRDEWes6suz
        oKy2Zf7WqUrx2COi8CSF8OopLAIYku4EEuR10wQkudSUOKZ4pS2NkdKbWk0DksDgDzdOMW
        HnYgQeeurUiNcfb+tlTSh4btAPJrY9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-OCx1hdEmPci61uW7KC8THA-1; Wed, 02 Dec 2020 14:07:16 -0500
X-MC-Unique: OCx1hdEmPci61uW7KC8THA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C49CB8145E6;
        Wed,  2 Dec 2020 19:07:14 +0000 (UTC)
Received: from ovpn-66-132.rdu2.redhat.com (unknown [10.10.67.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E4836060F;
        Wed,  2 Dec 2020 19:07:08 +0000 (UTC)
Message-ID: <b70f46b855858a28b0e77ee7efbb2dbffbb56490.camel@redhat.com>
Subject: Re: [PATCH 0/3] blk-mq/nvme-loop: use nvme-loop's lock class for
 addressing lockdep false positive warning
From:   Qian Cai <qcai@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Date:   Wed, 02 Dec 2020 14:07:08 -0500
In-Reply-To: <20201130023606.GC230145@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
         <20201130023606.GC230145@T590>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2020-11-30 at 10:36 +0800, Ming Lei wrote:
> Any chance to take a look? And this issue has been reported several
> times in RH internal test.

I suppose that you will need to rebase as it does not apply cleanly on today's
linux-next.

