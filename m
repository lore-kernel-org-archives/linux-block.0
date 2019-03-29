Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23885C43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 17:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8E821871
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 17:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="P/QJv8RP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfC2Rqd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:46:33 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58196 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729646AbfC2Rqc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 13:46:32 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2THgdkN031783
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 10:46:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=YV97iqmwGN/mTtKIep9VjPgKHbTR1bD6/5BUIZk3s/4=;
 b=P/QJv8RPzveNi5pfUbgzru7uzUxAXJkCglPc8oOqjnnG3SSDQg4xRr5VHbWYOnkY7EB4
 ZRidKGvQVoAE1VTkIuymrPXv3ReH6NWw+3CPfQQrZ8c/BfWa7dmc4YqwzOrwKzfOnkwH
 NJnp+IVojXc3LE1hpzxYqh+QL4pleKvko78= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rhqfh854r-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 10:46:31 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Fri, 29 Mar 2019 10:46:29 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id A7A8962E1BDA; Fri, 29 Mar 2019 10:46:27 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-raid@vger.kernel.org>, <linux-block@vger.kernel.org>
CC:     <kernel-team@fb.com>, <neilb@suse.com>, <xni@redhat.com>,
        <ncroxon@redhat.com>, <axboe@kernel.dk>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH 0/3] md fixes and improvements
Date:   Fri, 29 Mar 2019 10:46:14 -0700
Message-ID: <20190329174617.3670341-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

These patches are based on your 5.2-tmp branch. Please consider apply them
to the non-tmp 5.2 branch. :)

Thanks,
Song

NeilBrown (2):
  Revert "MD: fix lock contention for flush bios"
  md: batch flush requests.

Nigel Croxon (1):
  Don't jump to compute_result state from check_result state

 drivers/md/md.c    | 172 +++++++++++++++++++--------------------------
 drivers/md/md.h    |  25 +++----
 drivers/md/raid5.c |  19 ++---
 3 files changed, 85 insertions(+), 131 deletions(-)

--
2.17.1
