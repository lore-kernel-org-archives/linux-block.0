Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37BD6C433E0
	for <linux-block@archiver.kernel.org>; Sun,  7 Feb 2021 04:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F309D64E92
	for <linux-block@archiver.kernel.org>; Sun,  7 Feb 2021 04:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBGEvl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Feb 2021 23:51:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229636AbhBGEvk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 6 Feb 2021 23:51:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612673414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ErY66w4dhgf5LV2CZcSNdVtB+mUOpkXGVfPnBx1/S5o=;
        b=RzerSZmyFRgzXn6H2ezuWzN6Gj8Qpf2or8MpOpwRDsIQlz+yB53Hn1L+OFEOmLjOi0bvwo
        tMew8JnOtBFKgnE349v8LbPuF5IDyGitVKAqPscnTbJxfI0TZfaC2Ql2ks4pVdSJWcSUPt
        1JNB+i4shOlJzOcNhi94r6KTK97x6tk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-iLvtF_prOHuUHLPmKpmrdQ-1; Sat, 06 Feb 2021 23:50:12 -0500
X-MC-Unique: iLvtF_prOHuUHLPmKpmrdQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9A4B107ACE6;
        Sun,  7 Feb 2021 04:50:10 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-23.pek2.redhat.com [10.72.12.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 457731C923;
        Sun,  7 Feb 2021 04:50:03 +0000 (UTC)
Subject: Re: kernel null pointer at nvme_tcp_init_iter[nvme_tcp] with blktests
 nvme-tcp/012
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-nvme@lists.infradead.org,
        linux-block <linux-block@vger.kernel.org>
Cc:     axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
Message-ID: <80b7184e-cdfb-cebc-fe07-a228ce57a9e7@redhat.com>
Date:   Sun, 7 Feb 2021 12:50:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


The issue was introduced after merge the NVMe updates

commit 0fd6456fd1f4c8f3ec5a2df6ed7f34458a180409 (HEAD)
Merge: 44d10e4b2f2c 0d7389718c32
Author: Jens Axboe <axboe@kernel.dk>
Date:   Tue Feb 2 07:12:06 2021 -0700

     Merge branch 'for-5.12/drivers' into for-next

     * for-5.12/drivers: (22 commits)
       nvme-tcp: use cancel tagset helper for tear down
       nvme-rdma: use cancel tagset helper for tear down
       nvme-tcp: add clean action for failed reconnection
       nvme-rdma: add clean action for failed reconnection
       nvme-core: add cancel tagset helpers
       nvme-core: get rid of the extra space
       nvme: add tracing of zns commands
       nvme: parse format nvm command details when tracing
       nvme: update enumerations for status codes
       nvmet: add lba to sect conversion helpers
       nvmet: remove extra variable in identify ns
       nvmet: remove extra variable in id-desclist
       nvmet: remove extra variable in smart log nsid
       nvme: refactor ns->ctrl by request
       nvme-tcp: pass multipage bvec to request iov_iter
       nvme-tcp: get rid of unused helper function
       nvme-tcp: fix wrong setting of request iov_iter
       nvme: support command retry delay for admin command
       nvme: constify static attribute_group structs
       nvmet-fc: use RCU proctection for assoc_list


On 2/6/21 11:08 AM, Yi Zhang wrote:
> blktests nvme-tcp/012

