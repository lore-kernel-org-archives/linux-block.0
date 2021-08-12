Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7EBC432BE
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 15:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D3F60FC0
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 15:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbhHLPgM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 11:36:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40109 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236638AbhHLPgL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 11:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628782541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NHxcJB6Dx8/bsst5x+A7CZjcxgMXd7//qJ3xADNRAT8=;
        b=iFbR0uGGSMFaolOPiftR0209zIzjSrJtXusWWq9vCSOS9fp65AdVT+wwIIje+HpzZBFgBj
        um0SfuKXwhd5kZjEjqvFLG+yvIKSoSljgI28VpWT5GE6Yr2wd8pePC9dfWB6ADU4a2VXf+
        zKDTnwv8OfJxlCqR/MeKjpqz57oZQAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-oLMqJgz-PaSewlFGmDQ1nA-1; Thu, 12 Aug 2021 11:35:37 -0400
X-MC-Unique: oLMqJgz-PaSewlFGmDQ1nA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A077E100A972;
        Thu, 12 Aug 2021 15:35:28 +0000 (UTC)
Received: from redhat.com (ovpn-112-138.phx2.redhat.com [10.3.112.138])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFD9783BF8;
        Thu, 12 Aug 2021 15:35:27 +0000 (UTC)
Date:   Thu, 12 Aug 2021 10:35:25 -0500
From:   Eric Blake <eblake@redhat.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     josef@toxicpanda.com, axboe@kernel.dk, hch@lst.de,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        syzbot+9937dc42271cd87d4b98@syzkaller.appspotmail.com
Subject: Re: [PATCH] block: nbd: add sanity check for first_minor
Message-ID: <20210812153525.hlged76ivhqtffyg@redhat.com>
References: <20210812091501.22648-1-paskripkin@gmail.com>
 <7f9a6877-12d9-0177-d09a-6522e5a557ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f9a6877-12d9-0177-d09a-6522e5a557ec@gmail.com>
User-Agent: NeoMutt/20210205-687-0ed190
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Aug 12, 2021 at 12:42:38PM +0300, Pavel Skripkin wrote:
> 
> Fun thing: I got a reply to this email from
> nsd-public@police.gov.hk, which is Hong Kong Police office email. Does
> anyone know what is going on? :) It's a bit scary...

You are not alone.  Apparently, someone subscribed that address to the
nbd@other.debian.org list and it is auto-responding to every message
it receives; hopefully, a list administrator (I am not one) will be
willing to forcefully unsubscribe that address.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

