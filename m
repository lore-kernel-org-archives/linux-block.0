Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924AAC433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 04:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65AB6207D8
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 04:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFazT0xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgESEYm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 00:24:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57849 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725791AbgESEYm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 00:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589862280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=zqC0iTOS7MsS7ORK14skLYI/HrQoGHgioBg7h+sh8dE=;
        b=HFazT0xwWBZmnJoBKRXYXw+r9+Sby77JZkYldTgrek/l+cdARBmkDl6VyW3HPpT3z5TUqz
        WeysiRTSssOiwxgbYsipYcESYt91oKvgWWYZgeDpWLSVzscO2N4R4Ovxq7Aj4Hnw2vdFQC
        tIUVwTo8lenzGAtVCD0hnQU+NHN57vw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-1PwBp9zNPnKtqmalt1V_0w-1; Tue, 19 May 2020 00:24:35 -0400
X-MC-Unique: 1PwBp9zNPnKtqmalt1V_0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8EB11800D42;
        Tue, 19 May 2020 04:24:33 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E19C25D9DC;
        Tue, 19 May 2020 04:24:33 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id AD58A4EA70;
        Tue, 19 May 2020 04:24:33 +0000 (UTC)
Date:   Tue, 19 May 2020 00:24:33 -0400 (EDT)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-block <linux-block@vger.kernel.org>
Cc:     hch@lst.de, mkoutny@suse.com, xuyang2018.jy@cn.fujitsu.com
Message-ID: <788249564.27423058.1589862273371.JavaMail.zimbra@redhat.com>
In-Reply-To: <191340985.27421983.1589858341899.JavaMail.zimbra@redhat.com>
Subject: blktests block/013 failed from commit "block: remove the bd_openers
 checks in blk_drop_partitions"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.68.5.41, 10.4.195.9]
Thread-Topic: blktests block/013 failed from commit "block: remove the bd_openers checks in blk_drop_partitions"
Thread-Index: /sWw4UcHbh385HTdRhZbZf5p+gbONg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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


