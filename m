Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AD1EB64DC
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 10:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjGUKve (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 06:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjGUKvd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 06:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A8E1FDF
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 03:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689936643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HbDpyl9zOA+nL7XffWP2QXUGvL5G3XjA2LRR+IouFd4=;
        b=a79ZY23PS5SnUfvz2fWEAJiD+wB7JpcovKVvd2XPQLYjxvqSPPotfBro6ZqjQ5qRwB+aNT
        4V+m34XJyzY+BlmwHAZON89U49ovW9cF/ONQ1BpEia36AE0pTj8GnXrY1Nq5HSdiWGrPOv
        C0y5Yu//w6VbfYAEyjEPxwYCUwqoWRg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-4jJaCq4gOdq0_aWs8yC8Jg-1; Fri, 21 Jul 2023 06:50:39 -0400
X-MC-Unique: 4jJaCq4gOdq0_aWs8yC8Jg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7325F1044591;
        Fri, 21 Jul 2023 10:50:39 +0000 (UTC)
Received: from ovpn-8-26.pek2.redhat.com (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07AC34CD0C1;
        Fri, 21 Jul 2023 10:50:33 +0000 (UTC)
Date:   Fri, 21 Jul 2023 18:50:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        David Jeffery <djeffery@redhat.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Gabriel Krisman Bertazi <krisman@suse.de>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Jan Kara <jack@suse.cz>, ming.lei@redhat.com
Subject: Re: [RFC PATCH] sbitmap: fix batching wakeup
Message-ID: <ZLpi9IVwJcK6hJvt@ovpn-8-26.pek2.redhat.com>
References: <20230721095715.232728-1-ming.lei@redhat.com>
 <ZLpgk95AQSnKWg+o@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLpgk95AQSnKWg+o@kbusch-mbp.dhcp.thefacebook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jul 21, 2023 at 12:40:19PM +0200, Keith Busch wrote:
> On Fri, Jul 21, 2023 at 05:57:15PM +0800, Ming Lei wrote:
> > From: David Jeffery <djeffery@redhat.com>
> 
> ...
>  
> > Cc: David Jeffery <djeffery@redhat.com>
> > Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> > Cc: Gabriel Krisman Bertazi <krisman@suse.de>
> > Cc: Chengming Zhou <zhouchengming@bytedance.com>
> > Cc: Jan Kara <jack@suse.cz>
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> 
> Shouldn't the author include their sign off? Or is this supposed to be
> from you?

I understand signed-off-by needs to be explicit from David, and let's
focus on patch itself. And I believe David can reply with his
signed-off-by when the patch is ready to go.


Thanks,
Ming

