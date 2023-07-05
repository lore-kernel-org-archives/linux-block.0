Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4F9EB64DA
	for <linux-block@archiver.kernel.org>; Wed,  5 Jul 2023 15:04:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbjGEPEM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jul 2023 11:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjGEPEF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jul 2023 11:04:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9503E1713
        for <linux-block@vger.kernel.org>; Wed,  5 Jul 2023 08:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688569286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CYB3cvLDnc3P98VVJYn8G9DoZ+oTFJfoiNpil4CwPA0=;
        b=POpcIOfdi6E+fmTagEZOoknjYETG9vI26VN+WFtBmz6HF3OrCvvdSbosjLbFnEqhYlhMny
        mvizBQM1EmxUfdLiM4GtAK+7juKw+JTgP/eUe3q6w6UEjQfqFcUMqoZobyMdG+LBZDAU2i
        nOKnApmr2WNRWBXF+OUU/f3DzlEa1mY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-qCzxabckPx2me5_7gFTaHQ-1; Wed, 05 Jul 2023 11:01:25 -0400
X-MC-Unique: qCzxabckPx2me5_7gFTaHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01A3B185A7BA;
        Wed,  5 Jul 2023 15:01:12 +0000 (UTC)
Received: from ovpn-8-34.pek2.redhat.com (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CF0DC51488;
        Wed,  5 Jul 2023 15:01:07 +0000 (UTC)
Date:   Wed, 5 Jul 2023 23:01:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, tj@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 1/4] blk-mq: use percpu csd to remote complete instead
 of per-rq csd
Message-ID: <ZKWFrirq9Eemm788@ovpn-8-34.pek2.redhat.com>
References: <20230629110359.1111832-1-chengming.zhou@linux.dev>
 <20230629110359.1111832-2-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629110359.1111832-2-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 29, 2023 at 07:03:56PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> If request need to be completed remotely, we insert it into percpu llist,
> and smp_call_function_single_async() if llist is empty previously.
> 
> We don't need to use per-rq csd, percpu csd is enough. And the size of
> struct request is decreased by 24 bytes.
> 
> This way is cleaner, and looks correct, given block softirq is guaranteed to be
> scheduled to consume the list if one new request is added to this percpu list,
> either smp_call_function_single_async() returns -EBUSY or 0.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
> v2:
>  - Change to use call_single_data_t, which avoid to use 2 cache lines
>    for 1 csd, as suggested by Ming Lei.
>  - Improve the commit log, the explanation is copied from Ming Lei.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

