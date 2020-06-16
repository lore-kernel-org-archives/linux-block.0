Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8D2C433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 04:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C9F207E8
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 04:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sv8NB9se"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbgFPEQi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Jun 2020 00:16:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45433 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725306AbgFPEQi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Jun 2020 00:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592280997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O1xnRnGhMhEwz+wjNoiBLED8iGeKhij45TdHR9vNevI=;
        b=Sv8NB9seoKSHuH/D6DWfs4L9k3f9f6jswFqIFJmtVU8ZdFHEMQ+K0hwcCxtWmiFnbdt4Fm
        EZD5ZoGhGw8a8OxE5pGqxE0Hr2V82vPPPxxWZr4GMXW0XrtGn9xvv9WJKa1hLtXLJlmOAx
        uwo2y+oZMc8WKLnA/zdKyftCjYxOp2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-dxsaplCfNMSfSVigeg3-jg-1; Tue, 16 Jun 2020 00:16:34 -0400
X-MC-Unique: dxsaplCfNMSfSVigeg3-jg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9FA5188361B;
        Tue, 16 Jun 2020 04:16:33 +0000 (UTC)
Received: from T590 (ovpn-12-136.pek2.redhat.com [10.72.12.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C9E7160C05;
        Tue, 16 Jun 2020 04:16:28 +0000 (UTC)
Date:   Tue, 16 Jun 2020 12:16:24 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-block@vger.kernel.org, "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] block: add split_alignment for request queue
Message-ID: <20200616041624.GA52855@T590>
References: <20200616005633.172804-1-harshadshirwadkar@gmail.com>
 <20200616024028.GE27192@T590>
 <CAD+ocbyJ7hfC-UyO5MupgnzbPbVAVO5b1Ff-+xgHLin_FXCE-w@mail.gmail.com>
 <CAD+ocbzP70UXWRdhx-j2=+DdGihEbP94Djksij_Ykzgaayim3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbzP70UXWRdhx-j2=+DdGihEbP94Djksij_Ykzgaayim3Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jun 15, 2020 at 08:24:08PM -0700, harshad shirwadkar wrote:
> After taking a closer look, I don't see chunk_sectors being accounted
> for in the splitting code. If I understand correctly, the implementation
> of chunk_sectors is such that it allows for one big IO to go through.
> In other words, it tries to avoid the splitting code if possible. But,
> it doesn't seem to guarantee that when an IO is split, it will be

Please take a look at blk_max_size_offset() which is called by
get_max_io_size() from blk_bio_segment_split(), which splits
bio into chunk_sectors aligned bio.

Also you may run IO trace on queue with chunk_sectors setup, and check
if the splitted IO request is what you expected.


Thanks, 
Ming

