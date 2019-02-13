Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD32C0044B
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 20:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2077222C9
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 20:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394637AbfBMU44 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:56:56 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:36085 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388727AbfBMU4z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 15:56:55 -0500
Received: by mail-pl1-f178.google.com with SMTP id g9so1791317plo.3;
        Wed, 13 Feb 2019 12:56:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fpEFeEhuuBg2s+SRQs5CMK/nbLmWzb9kdAv0QfpNnq4=;
        b=Jkaknerf8lgYCrfuJW6TsCkQGPH9Tu9ScnyOkuhN5CnM30EPkG2dnrI4hxQQsUSnIW
         A1dUAePFrZFh3lkOfVbwuXnqqm+GLwAgVa1g8AFYWdEOQt+lP3Ho5mNUyXt/A9lCZtn2
         yMG7KThvV7V5tvapJadEQEABAZRES+f6jC1NA9yaszZx98wk7WwMw2MCvE3jL/h+NhjF
         zSS0zrOTfrAvQ9s2UZJMTlxCzZbGkhM+dDMtS+XQHFk2ct6+dh5a4xZP1k+/LlZNqwsM
         OAxwwEbJ3sQ4i8/tdx3BRQYfq+wqtum22fpZVXTUfyHhdJHezuvYW/J/d/V8zxKUwRKy
         sMTg==
X-Gm-Message-State: AHQUAuYUGsPZQw4dyxSeePFU8+09A+D9pVDftG2p7uzo+Aw4HiAYYkAr
        IRGzsaYMsWaHPIUVRyJy03I=
X-Google-Smtp-Source: AHgI3IbHAfAVXyGR/G2oMjaaWdLDqppTGnVe56B0KcHmKjLd0FFZSWRrx4k8UGE79xQIxbehpxdzdA==
X-Received: by 2002:a17:902:f096:: with SMTP id go22mr119213plb.23.1550091414078;
        Wed, 13 Feb 2019 12:56:54 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l87sm307694pfj.35.2019.02.13.12.56.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 12:56:53 -0800 (PST)
Message-ID: <1550091411.31902.45.camel@acm.org>
Subject: Re: [LSF/MM TOPIC] : blktests: status, an expansion plan for the
 storage stack test framework
From:   Bart Van Assche <bvanassche@acm.org>
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "jack@suse.cz" <jack@suse.cz>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "osandov@fb.com" <osandov@fb.com>, Sagi Grimberg <sagi@grimberg.me>
Date:   Wed, 13 Feb 2019 12:56:51 -0800
In-Reply-To: <20190213195658.GB9819@vader>
References: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
         <1550081474.19311.62.camel@acm.org> <20190213184331.GA9819@vader>
         <1550084044.19311.73.camel@acm.org> <20190213195658.GB9819@vader>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-02-13 at 11:56 -0800, Omar Sandoval wrote:
+AD4 On Wed, Feb 13, 2019 at 10:54:04AM -0800, Bart Van Assche wrote:
+AD4 +AD4 What is a build status badge?
+AD4 
+AD4 I just added it, see
+AD4 https://github.com/osandov/blktests/commit/a61aa7fcce0bad9094b0e7646f3a8299c30afa6a
+AD4 
+AD4 Anyway, enabling Travis CI is easy:
+AD4 +AD4 +ACo Navigate to https://travis-ci.org/ and click on +ACI-Sign in with github+ACI.
+AD4 +AD4 +ACo In the left column, click on +ACIAKwAi (Add New Repository).
+AD4 +AD4 +ACo For the blktests repository, enable continuous integration. This will cause a
+AD4 +AD4   continuous integration test to be started after every git push and also every
+AD4 +AD4   time a pull request is submitted. The rdma-core project uses Travis CI not only
+AD4 +AD4   to compile-test pull requests but also to verify whether new code in pull
+AD4 +AD4   requests passes building with sparse. This is useful for the rdma-core project
+AD4 +AD4   since a lot of endianness conversions happen in that code and sparse can
+AD4 +AD4   verify whether these conversions have been annotated correctly. See also
+AD4 +AD4   https://github.com/linux-rdma/rdma-core.
+AD4 
+AD4 Thanks, I got it set up now.

Thanks+ACE

Bart.
