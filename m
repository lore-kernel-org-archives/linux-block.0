Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0F8EB64DA
	for <linux-block@archiver.kernel.org>; Mon, 26 Jun 2023 08:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjFZIKl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jun 2023 04:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjFZIKY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2023 04:10:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3DAE6F
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2023 01:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687766981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CjQ7qNGo2v1HEI8QUPhx23BtJ/165v3Z1WNalwOEs8w=;
        b=ZwMV9RkgxVIOM4QzqhfYCzcUTlN9YdPC2WXknlwZu2FfrkRq72apIKHbnPVeAgbw38lBNt
        8oF2AtVwaFc/FhffBIve0vc7MPhQQ3LnpBdOa1hUGt7RjTUKGBa6PbyH4KvVcWSYCnBLSQ
        ezdVLw6xCd+M03MdW6/vQrLkYRD8/Kk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-377-uI8flNvaNnGqJk3iWF5fmA-1; Mon, 26 Jun 2023 04:09:35 -0400
X-MC-Unique: uI8flNvaNnGqJk3iWF5fmA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37BE529A9CA0;
        Mon, 26 Jun 2023 08:09:35 +0000 (UTC)
Received: from ovpn-8-20.pek2.redhat.com (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAE682166B25;
        Mon, 26 Jun 2023 08:09:30 +0000 (UTC)
Date:   Mon, 26 Jun 2023 16:09:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v4 4/7] block: One requeue list per hctx
Message-ID: <ZJlHtQySAAVYLbNy@ovpn-8-20.pek2.redhat.com>
References: <20230621201237.796902-1-bvanassche@acm.org>
 <20230621201237.796902-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621201237.796902-5-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 21, 2023 at 01:12:31PM -0700, Bart Van Assche wrote:
> Prepare for processing the requeue list from inside __blk_mq_run_hw_queue().

Please add more details about the motivation for this kind of change.

IMO requeue is supposed to be run in slow code path, not see reason why
it has to be moved to hw queue level.

Thanks,
Ming

