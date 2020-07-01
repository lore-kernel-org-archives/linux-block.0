Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CDBC433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 17:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82AF42078A
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 17:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iRssY8jH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731491AbgGARlL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 13:41:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30909 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731122AbgGARlK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Jul 2020 13:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593625269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=tXKGxpnc5BMs3iDgwihQRstOyMb/SsOmJWMhA/a2H4Q=;
        b=iRssY8jH6rmNOC4kwQjfLDacvOeiesE3VbwYYASQL5w4UJazL6Q1jnH44RWadtZQxAaqBr
        8BgaJnUjN2hneIBeV5eHpvEiJanmKmprsRCQwQyeQ5+Lu5J9vFoRHqCTpshzAlNSKBJ7ZI
        Nf7laTzBlNqZfTsOVoC/MiKMzj9W4r4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-Jk4wup8QPmylhlXZ_xTslg-1; Wed, 01 Jul 2020 13:41:07 -0400
X-MC-Unique: Jk4wup8QPmylhlXZ_xTslg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB355107ACCD;
        Wed,  1 Jul 2020 17:41:05 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 93E7D5C6C0;
        Wed,  1 Jul 2020 17:41:02 +0000 (UTC)
Date:   Wed, 1 Jul 2020 12:39:42 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Ewan Milne <emilne@redhat.com>, Hannes Reinecke <hare@suse.de>,
        John Meneghini <johnm@netapp.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, dm-devel@redhat.com
Subject: NVMe regression, NVMe no longer uses blk_path_error()
Message-ID: <20200701163942.GB27063@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

IF NVMe's isn't a primary user of blk_path_error() it largely kills
the entire point of blk_path_error(). (And no the response to this must
not be: "that's fine")

This commit shows NVMe's previous continued use of blk_path_error():

  8decf5d5b9f3f7 ("nvme: remove nvme_req_needs_failover")

but then nvme_failover_req() was relatively recently refactored with:

  764e9332098c0 ("nvme-multipath: do not reset on unknown status")

NVMe should've continued to use blk_path_error().  If there was some gap
in error classification that should've been fixed in NVMe.

Instead, with commit 764e9332098c0 NVMe is no longer using retryable
error classifications commonly maintained within block core.  As such it
introduces serious potential for regression with DM multipath no longer
having a shared understanding for what _really_ constitutes a retryable
blk_status_t from NVMe.

Mike

