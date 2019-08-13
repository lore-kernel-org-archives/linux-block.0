Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7E4C433FF
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 16:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0830C20840
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 16:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfHMQj6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:39:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62235 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfHMQj6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 12:39:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 825BE16A350;
        Tue, 13 Aug 2019 16:39:54 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-122-147.rdu2.redhat.com [10.10.122.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB1704EE5D;
        Tue, 13 Aug 2019 16:39:53 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org
Subject: [PATCH 0/4] nbd: cmd timeout fixes V2
Date:   Tue, 13 Aug 2019 11:39:48 -0500
Message-Id: <20190813163952.23486-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Tue, 13 Aug 2019 16:39:58 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The following patches fix bugs related to the nbd cmd timeout feature.

The patches were made over Linus's current tree and also apply over
this nbd patch:

https://marc.info/?l=linux-block&m=156494582914495&w=2

V2:
- Fix patch4 so it allows resetting of the nbd cmd timeout to 0 as well
initializing it to 0.
- Add Josef's revewied-by tag.


