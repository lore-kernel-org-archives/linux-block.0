Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24535C48BDF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 07:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F86F613C5
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 07:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhFXHnu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 03:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhFXHnr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 03:43:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333BEC061574
        for <linux-block@vger.kernel.org>; Thu, 24 Jun 2021 00:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=W/hmH166ODN8wWjUqLpssFkptbFNYO/0Oo7ylI48o4M=; b=bbZ+DA9rot/6LCYahcO2hVjdPH
        k6yU6ypytQc8UEzZ+jM7waDr36sH65Wxbmnv258u4J5zqvZx/YLiptWLY5O6rVPGFIktfGa+Ycn8R
        /HROtRDpg8BYtEpyoNegXZoNrD4jo+alakK+1Q4DxK0NON7UwI8QWXNz40/Vvnm9G/4bEPAjh59E9
        4OigqowFksIDpp2XCXVcTL+J3RDKp0MD1qvLDOjdi5AxSkRbyDYWwpvunQ4mNOSTVt3g/+KbXY9Ts
        +XSpYzRtF6gWniPFdJ3dp47Exnz4ZmwEaDxbJFNYjMPndcQUqUbYpIHBLFscTaMe1x8kbF9bzJGGr
        00oTWXTQ==;
Received: from 089144193030.atnat0002.highway.a1.net ([89.144.193.30] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwJyp-00GJnK-DN; Thu, 24 Jun 2021 07:41:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: disk events cleanup
Date:   Thu, 24 Jun 2021 09:38:41 +0200
Message-Id: <20210624073843.251178-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all,

this series first moves the disk events code into its own file, as it
clearly is pretty distinct from the main genhd.c code (Tejun, feel free
to add a Copyright statement as there was none), and then switch the
registeration of the disk event attributes away from sysfs_create_files
in favor of just adding them to the main disk class.
