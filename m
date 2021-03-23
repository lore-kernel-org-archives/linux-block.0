Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8D3C433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 11:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB0F0619C8
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 11:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhCWLtj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 07:49:39 -0400
Received: from mx4.veeam.com ([104.41.138.86]:34876 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhCWLtG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 07:49:06 -0400
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 91EDD7319B;
        Tue, 23 Mar 2021 14:49:01 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1616500141; bh=/4M7LwHDNpv3QnfR6OMnF5pPWU520KQP4VdKjFepKC0=;
        h=From:To:CC:Subject:Date:From;
        b=JUU0nsvDoIxO/Ao+kCCoJ2L/fH4E88sRDDvpy84pAq2xUMz7eRumuONh5bNuerbuR
         ppRhfQXEQ9s+OwQYXZ+wISmBV3bfk6sOhJoo1A/KwVWNUcwzrleIo/uCt1gHjQvUmQ
         GfDeLSGATx/7JOMTLgd2BquI277pl0S7VCoRtLIc=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Tue, 23 Mar 2021 12:49:00 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     Jens Axboe <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <sergei.shtepa@veeam.com>, <pavel.tide@veeam.com>
Subject: [PATCH 0/1] block: fix potential infinite loop in the negative branch in __submit_bio_noacct_mq()
Date:   Tue, 23 Mar 2021 14:48:35 +0300
Message-ID: <1616500116-3411-1-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.0.171) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50B586D7D62
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all.

It seems to me that the __submit_bio_noacct_mq() function incorrectly
processes the return code of the blk_crypto_bio_prep() function.

If the blk_crypto_bio_prep() function returns false, it means that
the processing of the bio request was completed with an error and
further processing of the request is unnecessary.

But in the code, in case of an error when executing the
blk_crypto_bio_prep() function, an attempt is made to repeat the
execution of this function. This can lead to an infinite loop.
In addition, since the function __blk_crypto_bio_prep calls bio_endio(),
it is likely to access the freed data or access the null pointer.

At the same time, the implementation of the negative branch of the
blk_crypto_bio_prep() function implemented correctly in the
__submit_bio_noacct() and __submit_bio() functions.

Sergei Shtepa (1):
  block: fix potential infinite loop in the negative branch in
    __submit_bio_noacct_mq()

 block/blk-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.20.1

