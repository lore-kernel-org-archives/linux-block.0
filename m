Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B32C433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 05:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57415208CA
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 05:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uQqpnV4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgIAFie (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAFid (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 01:38:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661E5C061290;
        Mon, 31 Aug 2020 22:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=74ARs/QLVt0FtIH6XZq1/tIKx5RoEbX/1dBxjgtPyXo=; b=uQqpnV4Z8fohmyamj23JkpBaND
        7/ZzYrkKs48eP7mR7t/ymk7r5XXIwa+++KZN2Ek4YFgf22uprngL/NZ6HKYpuVFnRH9vukA8l9j7i
        i98hI2wHyZdADe6Clv3kaIz9+pyBL2zKIl8QN9kplzfy4WXy1pDpDPd7pHXWzrJAODsfCT3Idk3Yq
        vl18o7tm3wuU9Yu890Avx+cFxmj5bi349JejbPvAmrUWMPqaecJsFaGNSVE18Yvyzqi8q+X+8RZSa
        dTN7AcxOGbm7U+yqZxRBSsCddIBsVQ+fbxrRpYcZm21f9iI8DS5utnlFoOyfc8t64upZoy7AekpUP
        8TGxKvMA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCz01-0000U6-2P; Tue, 01 Sep 2020 05:38:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Karel Zak <kzak@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Mares <mj@ucw.cz>, linux-video@atrey.karlin.mff.cuni.cz,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [RFC PATCH 0/2] Documentation/admin-guide: remove use of "rdev"
Date:   Mon, 31 Aug 2020 22:38:20 -0700
Message-Id: <20200901053822.9374-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Remove mention of using "rdev" to set boot device, video mode,
or ramdisk information for the booting kernel.

FIX patch 1/2 Subject:

Cc: Karel Zak <kzak@redhat.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Martin Mares <mj@ucw.cz>
Cc: linux-video@atrey.karlin.mff.cuni.cz
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org


 [RFC PATCH 1/2] Documentation/admin-guide: README & svga: remove use of "rdev"
 [RFC PATCH 2/2] Documentation/admin-guide: blockdev/ramdisk: remove use of "rdev"

 Documentation/admin-guide/README.rst            |    6 -
 Documentation/admin-guide/blockdev/ramdisk.rst  |   70 ++++----------
 Documentation/admin-guide/kernel-parameters.txt |    9 -
 Documentation/admin-guide/svga.rst              |    6 -
 4 files changed, 33 insertions(+), 58 deletions(-)
