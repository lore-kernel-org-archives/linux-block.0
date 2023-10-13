Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C9CDB474
	for <linux-block@archiver.kernel.org>; Fri, 13 Oct 2023 00:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbjJMATj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Oct 2023 20:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjJMATi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2023 20:19:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53689B7
        for <linux-block@vger.kernel.org>; Thu, 12 Oct 2023 17:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697156329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cEIdnl1qOAHdz+0J8aPaQSeQnaYrHrYOx65OArdfMZE=;
        b=SaXRK8b5oiAmpuwFfPgmjy+4lN6kJ6dH5v6CLkPGHZ5wxCAtgAxxop4tG5KbidPKs0bqOs
        J8ihCeknBEUHXM6HfqOmswWUz+vASd3OZOCPoAYQw+gAnH3gFqew6UMr78uqW+ZRVDyKHi
        YBKujSXZwFE8od08wauJ71bU+PcvuqA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-SBtnOMKvMSua-vuju3gHCw-1; Thu, 12 Oct 2023 20:18:36 -0400
X-MC-Unique: SBtnOMKvMSua-vuju3gHCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DE50801E62;
        Fri, 13 Oct 2023 00:18:35 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD2446403C;
        Fri, 13 Oct 2023 00:18:32 +0000 (UTC)
Date:   Fri, 13 Oct 2023 08:18:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] ublk: Limit dev_id/ub_number values
Message-ID: <ZSiM04fMHOndfvYq@fedora>
References: <20231012150600.6198-1-michael.christie@oracle.com>
 <20231012150600.6198-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012150600.6198-2-michael.christie@oracle.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 12, 2023 at 10:05:59AM -0500, Mike Christie wrote:
> The dev_id/ub_number is used for the ublk dev's char device's minor
> number so it has to fit into MINORMASK. This patch adds checks to prevent
> userspace from passing a number that's too large and limits what can be
> allocated by the ublk_index_idr for the case where userspace has the
> kernel allocate the dev_id/ub_number.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

