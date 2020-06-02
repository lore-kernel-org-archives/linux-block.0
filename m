Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0537CC433DF
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F9720679
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5FuXGcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFBJkx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:40:53 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27088 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726012AbgFBJkx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 2 Jun 2020 05:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591090851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTL19+Q0xzZ/Y1ZMPXlpGkch/dH+zfN9lM7KDFzM7/4=;
        b=Q5FuXGcKujzqiUV8PZ0aRTvKT341VRn7McVaDdF6pW77MRnw3YE/QOY+lnTxjkqs7WLuZR
        jeoY7EuBQUxFITP2cDw03RKmwf6KebNZwlGjHW3a02q+7l/TepX9ni43fYy3oZeLPKBPVf
        XQVMPQ/01fifZqSWdoJtbpdrbOEmNjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-J_3HlkhWPzqvsfxsrSaitA-1; Tue, 02 Jun 2020 05:40:47 -0400
X-MC-Unique: J_3HlkhWPzqvsfxsrSaitA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5B1B835B8E;
        Tue,  2 Jun 2020 09:40:46 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC8BF10013C1;
        Tue,  2 Jun 2020 09:40:46 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id B3DF393902;
        Tue,  2 Jun 2020 09:40:46 +0000 (UTC)
Date:   Tue, 2 Jun 2020 05:40:46 -0400 (EDT)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     hch@lst.de
Cc:     mkoutny@suse.com, xuyang2018 jy <xuyang2018.jy@cn.fujitsu.com>,
        linux-block <linux-block@vger.kernel.org>
Message-ID: <210459651.28761642.1591090846537.JavaMail.zimbra@redhat.com>
In-Reply-To: <788249564.27423058.1589862273371.JavaMail.zimbra@redhat.com>
References: <788249564.27423058.1589862273371.JavaMail.zimbra@redhat.com>
Subject: Re: blktests block/013 failed from commit "block: remove the
 bd_openers checks in blk_drop_partitions"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.10]
Thread-Topic: blktests block/013 failed from commit "block: remove the bd_openers checks in blk_drop_partitions"
Thread-Index: /sWw4UcHbh385HTdRhZbZf5p+gbONjw+SBpz
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ping

Best Regards,
  Yi Zhang


----- Original Message -----
From: "Yi Zhang" <yi.zhang@redhat.com>
To: "linux-block" <linux-block@vger.kernel.org>
Cc: hch@lst.de, mkoutny@suse.com, "xuyang2018 jy" <xuyang2018.jy@cn.fujitsu.com>
Sent: Tuesday, May 19, 2020 12:24:33 PM
Subject: blktests block/013 failed from commit "block: remove the bd_openers checks in blk_drop_partitions"

Hello
With commit[1], blktests block/013[2] will be failed and it doesn't report "Device or resource busy", could anyone help check it?

[1]
commit 10c70d95c0f2f9a6f52d0e33243d2877370cef51
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Apr 28 10:52:03 2020 +0200

    block: remove the bd_openers checks in blk_drop_partitions


[2]
[root@storageqe-62 blktests]# ./check block/013
block/013 => sdd (try BLKRRPART on a mounted device)         [failed]
    runtime  19.026s  ...  18.543s
    --- tests/block/013.out	2020-05-18 04:38:47.872418459 -0400
    +++ /mnt/tests/kernel/storage/SSD/nvme_blktest/blktests/results/sdd/block/013.out.bad	2020-05-18 23:58:56.875256644 -0400
    @@ -1,3 +1,3 @@
     Running block/013
    -Device or resource busy
    +
     Test complete
[root@storageqe-62 blktests]# uname -r
5.7.0-rc4


