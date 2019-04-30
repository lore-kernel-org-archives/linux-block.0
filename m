Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179C0C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 18:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC60A21670
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 18:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="acLw4abI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfD3Sn1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 14:43:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56860 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfD3Sn0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 14:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=STJhfFIcl8NmsqBz0oUJKAuRfU7ewVikywFTxDg+V7c=; b=acLw4abIWyEHtIntf0uWm2LS1
        fSsFms0K0ESI7Hfynftciog+orQBUebHYcRfizGpVk77mNrrjGaRDJ8OW13B/4ieYT1GRieg42j1T
        XqeUx7URYJypdU2EpwiFrod6yrH/Z+s5ELdgs/HPOeEElB/1cdxcE1MkUE2YkvOIhyipeRZVa/mbm
        92JKfYE20wECUQIbbhiUgqvzAnnsZq6F36thLksEMh+VCFPEfvkNWYxuDmMDZP03Rcgby8V73+zcU
        d9v/LpPVpRHYLhVm6ofeFdELtMIuE0Z7VVe1YjKjZoCTj4lst64zZeodIEWC2qfKu2YO+IvDG2kBD
        LJ6RDjUWQ==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLXiq-0000rm-Pr; Tue, 30 Apr 2019 18:43:21 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Josef Bacik <jbacik@fb.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Fabio Checconi <fabio@gandalf.sssup.it>,
        Nauman Rafique <nauman@google.com>,
        Arianna Avanzini <avanzini.arianna@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: add SPDX tags to all block layer files
Date:   Tue, 30 Apr 2019 14:42:38 -0400
Message-Id: <20190430184243.23436-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

this series adds SPDX tags to all block layer files that are still
missing them.  The last patch adds them to files that didn't have
any licensing, and I've cced everyone who is mentioned in the
Copyright notices for these files to make sure no one has any
disagreement with the fact that that they are per default under
the kernels GPLv2 license.
