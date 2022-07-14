Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8C3C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 13:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240224AbiGNN6L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbiGNN54 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 09:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FC2A6717A
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 06:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657806937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KhtmeoLhSVw8TxG3EM8WGDxXWprw20ODCHZnU0rs1oc=;
        b=W0OZYfMURsnAdmD0QiseEhDF80Xv+t3gF89K20YNXo8aAq6fSiHjuACXUPTkO8xBN0fXT3
        e+W/FpBFfltPtKxtxql5LkkWCzcoKXsjEbYOCoXpBNrf6idj4MnXb26UVIm4T2pjGU7wuR
        6UNGLctY/LKIk8HAvl6hbCn1ep+HuSs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-JLYhTxIqP1mO5l_seL57XQ-1; Thu, 14 Jul 2022 09:55:32 -0400
X-MC-Unique: JLYhTxIqP1mO5l_seL57XQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96B5A80418F;
        Thu, 14 Jul 2022 13:55:30 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1618A2026D64;
        Thu, 14 Jul 2022 13:55:22 +0000 (UTC)
Date:   Thu, 14 Jul 2022 21:55:17 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Kanchan Joshi <joshi.k@samsung.com>
Cc:     hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@kernel.dk,
        io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, asml.silence@gmail.com,
        joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com,
        ming.lei@redhat.com
Subject: Re: [PATCH for-next 1/4] io_uring, nvme: rename a function
Message-ID: <YtAgReh6PnevFwzX@T590>
References: <20220711110155.649153-1-joshi.k@samsung.com>
 <CGME20220711110800epcas5p3d338dd486fd778c5ba5bfe93a91ec8bd@epcas5p3.samsung.com>
 <20220711110155.649153-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711110155.649153-2-joshi.k@samsung.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 11, 2022 at 04:31:52PM +0530, Kanchan Joshi wrote:
> io_uring_cmd_complete_in_task() is bit of a misnomer. It schedules a
> callback function for execution in task context. What callback does is
> private to provider, and does not have to be completion. So rename it to
> io_uring_cmd_execute_in_task() to allow more generic use.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>

ublk driver has same usage, and this change makes sense:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming

