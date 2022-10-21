Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15B7C4332F
	for <linux-block@archiver.kernel.org>; Fri, 21 Oct 2022 01:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJUB7n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Oct 2022 21:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJUB7k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Oct 2022 21:59:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286621D6
        for <linux-block@vger.kernel.org>; Thu, 20 Oct 2022 18:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666317571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LDTDNAkU8sTfjDDlApsPftrfWWGuTc+92MZJQiOg5XY=;
        b=GrSkUq4vn3gjE84j0t7Lt/jtiqGdVK2ewCpHQvSGc9UepW3HNEeeizno9xCR8TROcPrVTb
        FE8kmrSvXhF9UPiIFzaAbZW3qM3mEvQtF+HtLQqI9ZqOmAvrneVoCeSylyTyg/VtBDmBuM
        Y4FXo3ldhNijUCtebXwVJ3q0UA7EhrY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-XzoCMDs4OmKfEnnzTpQN5A-1; Thu, 20 Oct 2022 21:59:27 -0400
X-MC-Unique: XzoCMDs4OmKfEnnzTpQN5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F698381A721;
        Fri, 21 Oct 2022 01:59:27 +0000 (UTC)
Received: from T590 (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5534640C95B0;
        Fri, 21 Oct 2022 01:59:21 +0000 (UTC)
Date:   Fri, 21 Oct 2022 09:59:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 01/10] block: Remove request.write_hint
Message-ID: <Y1H88yYaENNYaf2r@T590>
References: <20221019222324.362705-1-bvanassche@acm.org>
 <20221019222324.362705-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019222324.362705-2-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 19, 2022 at 03:23:15PM -0700, Bart Van Assche wrote:
> Commit c75e707fe1aa ("block: remove the per-bio/request write hint")
> removed all code that uses the struct request write_hint member. Hence
> also remove 'write_hint' itself.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

