Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AC3C6FD1D
	for <linux-block@archiver.kernel.org>; Fri, 17 Mar 2023 23:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCQXlj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Mar 2023 19:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCQXli (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Mar 2023 19:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5304FCC0
        for <linux-block@vger.kernel.org>; Fri, 17 Mar 2023 16:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679096353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J0MV8dXAx3XlfP7A8fcIkXLDi3NRKZPJJn5uzYghVGY=;
        b=IBXduzC+mgyq42Ws/uqfcDkfnikWxwH6qwcQNoxEvk0zDsMjXj47WUm5Od4FxliPtkSNRq
        QYN5Z/h8M/8DZrUVeRoHaY6fkVFhACzQXzGiWK0S9ykl9JEhJj7F/MH6BGTHJuJsk2lsMP
        OhcrtM5w4/OHnHw2v0qObWLXZPaF5SA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-5_cxyGGQN1e7pEfk-xMSEw-1; Fri, 17 Mar 2023 19:39:09 -0400
X-MC-Unique: 5_cxyGGQN1e7pEfk-xMSEw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1E01185C06A;
        Fri, 17 Mar 2023 23:39:09 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DD0C6B597;
        Fri, 17 Mar 2023 23:39:02 +0000 (UTC)
Date:   Sat, 18 Mar 2023 07:38:58 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Message-ID: <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317195938.1745318-3-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 17, 2023 at 12:59:38PM -0700, Bart Van Assche wrote:
> Instead of submitting the bio fragment with the highest LBA first,
> submit the bio fragment with the lowest LBA first. If plugging is
> active, append requests at the end of the list with plugged requests
> instead of at the start. This approach prevents write errors when
> submitting large bios to host-managed zoned block devices.

zoned pages are added via bio_add_zone_append_page(), which is supposed
to not call into split code path, do you have such error log?

Thanks,
Ming

