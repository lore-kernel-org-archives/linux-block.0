Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A131C77B7A
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 07:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjERHGX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 03:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjERHGW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 03:06:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E4C2D4F
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 00:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684393539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BoFy2lmwnrztWjBxOIMFN/gKg2qk/GJaafFqs/XHrp0=;
        b=gfRJq7DNqZS8uU/UOR4Jys1jJCBGP+CSS3ojxS6C0f/hvCuXTWGColnhdhtCyTcHbgaBOu
        +CDbcSiKQBRd6jrT013KwIRFYPBUaKBHLxYvXs2OgL+OmiyPt1/LqR4lW9CuJ6Ewd6L7op
        WN/4uLhHmJ7wG7C+PNZ5MnyylY/jfYE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-OxXkyyK1OQqkdRdo2uwmdQ-1; Thu, 18 May 2023 03:05:36 -0400
X-MC-Unique: OxXkyyK1OQqkdRdo2uwmdQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA9EC101A556;
        Thu, 18 May 2023 07:05:35 +0000 (UTC)
Received: from ovpn-8-21.pek2.redhat.com (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1B621492C13;
        Thu, 18 May 2023 07:05:32 +0000 (UTC)
Date:   Thu, 18 May 2023 15:05:27 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] blk-mq: remove RQF_ELVPRIV
Message-ID: <ZGXONwrVtSrSpRUX@ovpn-8-21.pek2.redhat.com>
References: <20230518053101.760632-1-hch@lst.de>
 <20230518053101.760632-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518053101.760632-3-hch@lst.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 18, 2023 at 07:31:00AM +0200, Christoph Hellwig wrote:
> RQF_ELVPRIV is set for all non-flush requests that have RQF_ELV set.
> Expand this condition in the two users of the flag and remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

