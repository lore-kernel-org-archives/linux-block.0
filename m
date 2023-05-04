Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98177C77B7C
	for <linux-block@archiver.kernel.org>; Thu,  4 May 2023 14:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjEDOlP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 May 2023 10:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjEDOlN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2023 10:41:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ECE118
        for <linux-block@vger.kernel.org>; Thu,  4 May 2023 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683211230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uvHjox96ToDS6v8WQFCM85pSp37qrGwYc/dcWxuXOUk=;
        b=CTBf2F0LpnnANcefb2yk6M1zMSwsRrx4s8eHwFfXNcRJL/LkTs0twd2qKvJCc89GGoFA/N
        KJHk8odocohtx/MWkjrWultZxdr0A+8Ca+TmzRcEiR/vGG+meFD8wZtDKnVxhglpOl16lx
        1vZY0F0DAO15LhMuP1BmBwYqAT9yMR0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-K-Hn359RNia3YVI7sMxXKg-1; Thu, 04 May 2023 10:40:29 -0400
X-MC-Unique: K-Hn359RNia3YVI7sMxXKg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B42588B7AC;
        Thu,  4 May 2023 14:40:28 +0000 (UTC)
Received: from ovpn-8-16.pek2.redhat.com (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 62B0040BC799;
        Thu,  4 May 2023 14:40:22 +0000 (UTC)
Date:   Thu, 4 May 2023 22:40:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        asml.silence@gmail.com, hch@lst.de, axboe@kernel.dk, leit@fb.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        sagi@grimberg.me, joshi.k@samsung.com, kbusch@kernel.org
Subject: Re: [PATCH v4 3/3] io_uring: Remove unnecessary BUILD_BUG_ON
Message-ID: <ZFPD0c2dxQT2N9+f@ovpn-8-16.pek2.redhat.com>
References: <20230504121856.904491-1-leitao@debian.org>
 <20230504121856.904491-4-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504121856.904491-4-leitao@debian.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, May 04, 2023 at 05:18:56AM -0700, Breno Leitao wrote:
> In the io_uring_cmd_prep_async() there is an unnecessary compilation time
> check to check if cmd is correctly placed at field 48 of the SQE.
> 
> This is unnecessary, since this check is already in place at
> io_uring_init():
> 
>           BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
> 
> Remove it and the uring_cmd_pdu_size() function, which is not used
> anymore.
> 
> Keith started a discussion about this topic in the following thread:
> Link: https://lore.kernel.org/lkml/ZDBmQOhbyU0iLhMw@kbusch-mbp.dhcp.thefacebook.com/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

