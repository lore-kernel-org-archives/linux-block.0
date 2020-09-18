Return-Path: <SRS0=GCUE=C3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F5C43464
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 01:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FEC92137B
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 01:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XtrrMENT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgIRB4v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Sep 2020 21:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIRB4v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Sep 2020 21:56:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119A6C06174A;
        Thu, 17 Sep 2020 18:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=qwswkVb/gVqgiIAtdm2FTegz/K5eZaLDiC4kOkN2Ga0=; b=XtrrMENTo5BIYv3NzpfHh/rBxM
        ybPwFxkh4tQ7Lzvd9ecUH4sUV7zpxV4a9KoCqxzI3bun1m1GkQDDcPLaWBaLF4hLD395QrROLt9NK
        nONyBCfsa3Xds1ywXSFyOCgrsGwzSISRIcwHH5h8GMYRmfxco4yH2HLrn8wfoC1c8NsCKrGrOoTqS
        0UPqgu0DmBeBQ4Gv9IUFRPb/ZBe7at6ZsiH4XIDEK/+KsS8nbTq59WqjJb9cObbY59pq512bPentD
        8VsaiI4cPxPG/8Yo7eWZyr/8W27wQ1HeEKMFNCjRsRBkIut5MFdGFNfBlZ/1YwnIp0gRbaWBCvQCt
        jD3CLlvw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJ5dl-0007g2-4o; Fri, 18 Sep 2020 01:56:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Karel Zak <kzak@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Mares <mj@ucw.cz>, linux-video@atrey.karlin.mff.cuni.cz,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: [RFC PATCH v2 0/2] Documentation/admin-guide: remove use of "rdev"
Date:   Thu, 17 Sep 2020 18:56:38 -0700
Message-Id: <20200918015640.8439-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Remove mention of using "rdev" to set boot device, video mode,
or ramdisk information for the booting kernel.


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
