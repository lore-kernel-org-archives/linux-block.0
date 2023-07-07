Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE79EB64D9
	for <linux-block@archiver.kernel.org>; Fri,  7 Jul 2023 01:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjGGBDY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jul 2023 21:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjGGBDX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 21:03:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010511BDB
        for <linux-block@vger.kernel.org>; Thu,  6 Jul 2023 18:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688691756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1yyqbpHCBj1owppJL9+7IUc8i+R1e/YK0bJp67wQ+M4=;
        b=WBJwCJLCQ3a1MsQbWVG8FWeYXwl6+JiPcIsVDEQSbiYpqHVjKWuN9pzfT2EIdl0PlXj2B6
        bVC195wvIfgUFiNzdl8NXvIi9nGzSyjOGIs9lHWmORpavQ03fLFD6ugN1aOhvrc6oxDPXn
        LHNTpyOQNPMt8izEG6bkEPDalH5Q9QE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-YTUVvhpkPzS6e8xMtzWI9Q-1; Thu, 06 Jul 2023 21:02:32 -0400
X-MC-Unique: YTUVvhpkPzS6e8xMtzWI9Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3B66858F1E;
        Fri,  7 Jul 2023 01:02:31 +0000 (UTC)
Received: from ovpn-8-34.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E14F492B02;
        Fri,  7 Jul 2023 01:02:22 +0000 (UTC)
Date:   Fri, 7 Jul 2023 09:02:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Andreas Hindborg <nmi@metaspace.dk>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        gost.dev@samsung.com, Jens Axboe <axboe@kernel.dk>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v6 2/3] ublk: add helper to check if device supports user
 copy
Message-ID: <ZKdkGZBLINFV8cbj@ovpn-8-34.pek2.redhat.com>
References: <20230706130930.64283-1-nmi@metaspace.dk>
 <20230706130930.64283-3-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706130930.64283-3-nmi@metaspace.dk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 06, 2023 at 03:09:29PM +0200, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> This will be used by ublk zoned storage support.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

