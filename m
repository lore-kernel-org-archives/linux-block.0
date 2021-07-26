Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761EBC4338F
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 10:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DFFD60F22
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 10:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhGZJgz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42165 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231639AbhGZJgz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 05:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627294643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qvooalKqaksodbnEb98trPc90g6gz5WIFCvmG4lsvoU=;
        b=Hp5U44QhtDaayQ4IOKotiMpdb+h+OD57tIwxneFw7IY+ujo5XCleOAiSCmcUmkAv15ZQYO
        /NJZGaHwyadeF7UcCj9f/W8cxEaXej/tlMKySYOCTzbO3yAbe4xebwdhx1vHG0xjxDWAw0
        B7zRXzdG8uXLvfEx6DcBD+r90gMxQzM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-lbQTvKNUPMerpFZL-JCigQ-1; Mon, 26 Jul 2021 06:17:22 -0400
X-MC-Unique: lbQTvKNUPMerpFZL-JCigQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D145800D55;
        Mon, 26 Jul 2021 10:17:20 +0000 (UTC)
Received: from T590 (ovpn-13-107.pek2.redhat.com [10.72.13.107])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 920095D9D3;
        Mon, 26 Jul 2021 10:17:13 +0000 (UTC)
Date:   Mon, 26 Jul 2021 18:17:11 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 06/10] block: change the refcounting for partitions
Message-ID: <YP6Lp5LRSlMOacic@T590>
References: <20210724071249.1284585-1-hch@lst.de>
 <20210724071249.1284585-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724071249.1284585-7-hch@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jul 24, 2021 at 09:12:45AM +0200, Christoph Hellwig wrote:
> Instead of acquiring an inode reference on open make sure partitions
> always hold device model references to the disk while alive, and switch
> open to grab only a device model reference to the opened block device.
> If that is a partition the disk reference is transitively held by the
> partition already.

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

