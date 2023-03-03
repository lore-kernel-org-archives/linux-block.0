Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D44C6FA8E
	for <linux-block@archiver.kernel.org>; Fri,  3 Mar 2023 03:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCCDC6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Mar 2023 22:02:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCCDCs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Mar 2023 22:02:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9DC5708B
        for <linux-block@vger.kernel.org>; Thu,  2 Mar 2023 19:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677812522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XdamV2Uqp74frt8HUiRoWRCldVodbU/8sCppa7dCDOo=;
        b=H0gx80fa2sM6n/E1wPpksht30L63gBkdiRfsGGGqP3OW7F695X62AE4JEcEEc9bDnl5072
        TQo+5PPOV/bzfR9JMceLEGY0NwHacemIVJBTIUULe0pkwrsqCk2TwUyFrzf+jtRau6Qb2f
        3kb+h+4JBkEVxlByzrFdlFK6hHmMN4Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-139--NpgzR2sNw29JG4ZeFAJIw-1; Thu, 02 Mar 2023 22:02:00 -0500
X-MC-Unique: -NpgzR2sNw29JG4ZeFAJIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B519101A52E;
        Fri,  3 Mar 2023 03:02:00 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C4B5F1121318;
        Fri,  3 Mar 2023 03:01:57 +0000 (UTC)
Date:   Fri, 3 Mar 2023 11:01:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Cc:     linux-block@vger.kernel.org, io-uring@vger.kernel.org
Subject: Re: [RFC PATCH 00/12] io_uring: add IORING_OP_FUSED_CMD
Message-ID: <ZAFjINz3FPZnSaCx@T590>
References: <20230301140611.163055-1-ming.lei@redhat.com>
 <7c787a9f-3cd9-cc76-8194-d861b5674334@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c787a9f-3cd9-cc76-8194-d861b5674334@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 03, 2023 at 10:52:00AM +0800, Ziyang Zhang wrote:
> Hi Ming,
> 
> I tried this patchset but there are some conflicts while applying.
> Could please tell me the base branch? I have tried both io_uring
> and block.

The patchset is against the following commit:

489fa31ea873 (master) Merge branch 'work.misc' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs

I guess there might be new io_uring/block commits merged recently.

I will send V2 out after 6.3-rc1 or -rc2 is released. 


Thanks,
Ming

