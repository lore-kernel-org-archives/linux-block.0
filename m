Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A90DC43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 07:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiGUHLp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 03:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiGUHLn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 03:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E48297B367
        for <linux-block@vger.kernel.org>; Thu, 21 Jul 2022 00:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658387500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=taRIXaNuSlUmIVr4NVnn+redWQKPETu3IWXV5Xsa/Cg=;
        b=VvFdHjKkOCK3cwPBYbg2CnfuuPDCT5RdCZ3dHY1rMLxccvZOIAU17kaD1a/tzD9l5IIcK8
        LAjumKBePZgSq/pY234SVDM8mDXTDgvg+pQBZ4WOOY7o9DIgz56EuN9ShVkqoM6MaIatk3
        UGK/0vm1Eta6rDZxqJLRwyJIO7VlsPs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-331-y5h-Y5GIO7CZTc0jhtHRuQ-1; Thu, 21 Jul 2022 03:11:39 -0400
X-MC-Unique: y5h-Y5GIO7CZTc0jhtHRuQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B57FA811E80;
        Thu, 21 Jul 2022 07:11:38 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 11A6240D2962;
        Thu, 21 Jul 2022 07:11:35 +0000 (UTC)
Date:   Thu, 21 Jul 2022 15:11:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/8] ublk: add a MAINTAINERS entry
Message-ID: <Ytj8IuE3ydPY21Z9@T590>
References: <20220721051632.1676890-1-hch@lst.de>
 <20220721051632.1676890-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721051632.1676890-2-hch@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 21, 2022 at 07:16:25AM +0200, Christoph Hellwig wrote:
> Make get_maintainers.pl work for ublk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

