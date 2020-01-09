Return-Path: <SRS0=+EVs=26=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7471C32771
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 06:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68EA2073A
	for <linux-block@archiver.kernel.org>; Thu,  9 Jan 2020 06:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6Ybp+w0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgAIGV2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jan 2020 01:21:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21154 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgAIGV1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Jan 2020 01:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578550886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T7gLZ95zTB1FKBiqTbF1erCKAo/ma/Ww0hEMkHOBZP0=;
        b=i6Ybp+w0n79BzdltV3L9p+uINmNAMU6Xzvxk+00HFQofG0cGvQWIXidpcKtwNsWdfmX03d
        53NoKiHMdTDKmCDYdDUrRwPSB4SPjnuL014y+97VsbTfHDnQUSc3dbJNEnrguClnrtpbV9
        9OaHIka+t3laMgx1N8oHyw/phDhsMBQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-xyl5c16WNR2f_icE3yGvbw-1; Thu, 09 Jan 2020 01:21:23 -0500
X-MC-Unique: xyl5c16WNR2f_icE3yGvbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B25E801E67;
        Thu,  9 Jan 2020 06:21:22 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B7475C21A;
        Thu,  9 Jan 2020 06:21:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yufen Yu <yuyufen@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [PATCH 0/4] block: fix partition use-after-free and optimization
Date:   Thu,  9 Jan 2020 14:21:05 +0800
Message-Id: <20200109062109.2313-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch fixes one use-after-free on cached last_lookup partition.

The other 3 patches optimizes partition uses in IO path.



Ming Lei (4):
  block: fix use-after-free on cached last_lookup partition
  block: only define 'nr_sects_seq' in hd_part for 32bit SMP
  block: re-organize fields of 'struct hd_part'
  block: don't hold part0's refcount in IO path

 block/blk-core.c          | 15 ++-------------
 block/genhd.c             |  7 +++++--
 block/partition-generic.c | 12 ++++++++++--
 include/linux/genhd.h     | 25 ++++++++++++++++++-------
 4 files changed, 35 insertions(+), 24 deletions(-)

Cc: Yufen Yu <yuyufen@huawei.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hou Tao <houtao1@huawei.com>

--=20
2.20.1

