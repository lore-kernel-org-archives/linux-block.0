Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D8DC433F5
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1431C6112F
	for <linux-block@archiver.kernel.org>; Wed, 22 Sep 2021 12:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhIVMNh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 08:13:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23470 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234294AbhIVMNh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 08:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632312727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+xSsbPHQKOwQ9OmkdFU3DkicOwCTWlOdhjf2gURoAqY=;
        b=hlF/fM3FT1eTi5ORLeGL/mak2RPV2iWy6dEK9rG0vbdvWT9v9k+NCnJR/nF4l/Egl2Z8XF
        C91AvraOktPCsLuaf4LuGeDilQmP4H6O2Shvf1SC/lW7tovZl1LD5lfqIVtknsSAe5c/3H
        iAcP05tdEOjgjjCXbkkinGQKeeljuFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-wM_WK9WsNt-yQlVxCkaXgg-1; Wed, 22 Sep 2021 08:12:06 -0400
X-MC-Unique: wM_WK9WsNt-yQlVxCkaXgg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EE5E101F000;
        Wed, 22 Sep 2021 12:12:04 +0000 (UTC)
Received: from redhat.com (ovpn-115-8.phx2.redhat.com [10.3.115.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A18E12D4A;
        Wed, 22 Sep 2021 12:12:03 +0000 (UTC)
Date:   Wed, 22 Sep 2021 07:12:01 -0500
From:   Eric Blake <eblake@redhat.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     "yukuai (C)" <yukuai3@huawei.com>, josef@toxicpanda.com,
        axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [patch v8 3/7] nbd: check sock index in nbd_read_stat()
Message-ID: <20210922121201.neskyaenjh64wmyb@redhat.com>
References: <20210916093350.1410403-1-yukuai3@huawei.com>
 <20210916093350.1410403-4-yukuai3@huawei.com>
 <7e2913ca-1089-9ab7-cfdb-5e8837d36034@huawei.com>
 <YUr1v8zylPOFFXTO@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUr1v8zylPOFFXTO@T590>
User-Agent: NeoMutt/20210205-772-2b4c52
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 22, 2021 at 05:22:07PM +0800, Ming Lei wrote:
> 
> I think this one relies on nbd protocol between server and client, and
> does the protocol require both request and reply xmitted via same
> socket?

Yes, a reply must be transmitted on the same socket as the request
came over.  This is because independent sockets are not required to
use distinct 64-bit handles, and there is no way for a server to tell
if independent clients are related to one another; sending a reply on
the wrong socket is thus not guaranteed to reach the intended client.
Thus, a compliant server will never send a reply over a different
socket than the original request, and if a client ever gets a reply
with a handle it was not expecting, then the server is buggy or
malicious.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

