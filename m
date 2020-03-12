Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43C9C10DCE
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 12:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C8C206E7
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 12:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wbj5fAZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgCLMeb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 08:34:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39975 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726299AbgCLMea (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 08:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584016468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aq5ynHWp3a1dNNzDlF2bQ3ak1ZRxNfcBoMq41RZPyZg=;
        b=Wbj5fAZBusREhkJaJ56vyih73ab8e5WWOuviIn8nepxvd56i+mbgdhXvzcUTLyyIPpoxz6
        sXBgV0ZYHvYeR0xCqRFCUZs3FuTNHKbJtNV2Hdzh4vdxUz2AfPQTKfKNCg/uq0pJPvQmjR
        deCdp1vE4Z4gq0SIIgonOS6kDyCn7uA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-J2TaXc-FPUOgUSjildFoSw-1; Thu, 12 Mar 2020 08:34:26 -0400
X-MC-Unique: J2TaXc-FPUOgUSjildFoSw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93EC98017CC;
        Thu, 12 Mar 2020 12:34:25 +0000 (UTC)
Received: from ming.t460p (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E8D5090CFF;
        Thu, 12 Mar 2020 12:34:20 +0000 (UTC)
Date:   Thu, 12 Mar 2020 20:34:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Feng Li <lifeng1519@gmail.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [Question] IO is split by block layer when size is larger than 4k
Message-ID: <20200312123415.GA7660@ming.t460p>
References: <CAEK8JBBSqiXPY8FhrQ7XqdQ38L9zQepYrZkjoF+r4euTeqfGQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEK8JBBSqiXPY8FhrQ7XqdQ38L9zQepYrZkjoF+r4euTeqfGQQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Mar 12, 2020 at 07:13:28PM +0800, Feng Li wrote:
> Hi experts,
> 
> May I ask a question about block layer?
> When running fio in guest os, I find a 256k IO is split into the page
> by page in bio, saved in bvecs.
> And virtio-blk just put the bio_vec one by one in the available
> descriptor table.
> 
> So if my backend device does not support iovector
> opertion(preadv/pwritev), then IO is issued to a low layer page by
> page.
> My question is: why doesn't the bio save multi-pages in one bio_vec?

We start multipage bvec since v5.1, especially since 07173c3ec276
("block: enable multipage bvecs").

Thanks, 
Ming

