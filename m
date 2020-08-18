Return-Path: <SRS0=KeVv=B4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E13AC433E4
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 02:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1BE20716
	for <linux-block@archiver.kernel.org>; Tue, 18 Aug 2020 02:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hysDGvta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgHRCo7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Aug 2020 22:44:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40378 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726360AbgHRCo6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Aug 2020 22:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597718697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=byIIg0+hWGx+CIQdfvHdI9GzTtVaRLGpZ3kdt86FSFw=;
        b=hysDGvtaJO1GRqS+x6pLcgQLhC5WjDBz20YOhyRxvMvRjGcxSr26apssz1kthj4Ka/q8P1
        g/aIz3iltw/e83ff2dk4rkAKYKFK949InU8R21J2XlkdrDSFa984pmkbPOeLjkvhf4PU86
        j22ePWCLb2T7rC9Nu/ryDfuxN7vcO08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-B0Fd9nOeN1Oi63nCENRJlQ-1; Mon, 17 Aug 2020 22:44:54 -0400
X-MC-Unique: B0Fd9nOeN1Oi63nCENRJlQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 371CC1084C84;
        Tue, 18 Aug 2020 02:44:53 +0000 (UTC)
Received: from T590 (ovpn-13-119.pek2.redhat.com [10.72.13.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7CE54709E4;
        Tue, 18 Aug 2020 02:44:45 +0000 (UTC)
Date:   Tue, 18 Aug 2020 10:44:40 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     bpf@vger.kernel.org, linux-block@vger.kernel.org,
        orbekk@google.com, harshads@google.com, jasiu@google.com,
        saranyamohan@google.com, tytso@google.com, bvanassche@google.com
Subject: Re: [RFC PATCH 0/4] block/bpf: add eBPF based block layer IO
 filtering
Message-ID: <20200818024440.GA2508858@T590>
References: <20200812163305.545447-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812163305.545447-1-leah.rumancik@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 12, 2020 at 04:33:01PM +0000, Leah Rumancik wrote:
> This patch series adds support for a new security mechanism to filter IO
> in the block layer. With this patch series, the policy for IO filtering
> can be programmed into an eBPF program which gets attached to the struct
> gendisk. The filter can either drop or allow IO requests. It cannot modify
> requests. We do not support splitting of IOs, and we do not support
> filtering of IOs that bypass submit_bio (such as SG_IO, NVMe passthrough).
> At Google, we use IO filtering to prevent accidental modification of data.

I understand both SCSI's Persistent Reservations and NVMe's Reservation
may prevent accidental modification of data on shared LUN/NS, but they may
not work in request level.

Could you explain a bit about some real use cases with this filter
mechanism? 


Thanks, 
Ming

