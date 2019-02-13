Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7E4C282CA
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 18:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC62A20811
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 18:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404813AbfBMSLR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:11:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39012 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393586AbfBMSLR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 13:11:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so1552356pld.6;
        Wed, 13 Feb 2019 10:11:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIPAyucGiQMJurC7Aq4B7eYrtOEcVyV8crP9SpRksUM=;
        b=B9o8ETx4jIN8AAQlJ7G5om0o++CoGAPq8FsbDuaU/N1yuys6j1u45RBU7713QvWDbR
         cbyJZcNz2CuzJumJfoS64YhxIrzX5YD6ezTK9/YsUKS6lyHM14HdPoGKNxek3CKlh0wj
         hGeBo0F6HbxuAMG9pWJRVBBebTlhetuXdufYkovIa2bssUh+IN3oOAZcMmcQ5m78Hvam
         t/7cmxeKlemfwevb807lfMEb7TAJwIHZqojp0rXTloal3NauyVXK6q8d30SJnTYV8K5q
         yH0Qp4uxLXZWooLo+2NL6w+wTm8WoDy0Ww5c27bpMU+jXKGuHzJejT2jUT8m8ZoyKYu3
         TJcw==
X-Gm-Message-State: AHQUAuaeh/BX58sxyLPhZdjHCkQNKFcrPW6WUmQ9EWaa1ruFmSHhVxyN
        wnfibDY6yFTv+/C8inbPGMw=
X-Google-Smtp-Source: AHgI3IZxNXloh2GZfRU90weMnf+INv5zObqqEkeNdlvbgLbJ3MWbto/TiafXKOwWiWmC/TYDD0buIA==
X-Received: by 2002:a17:902:145:: with SMTP id 63mr1753603plb.256.1550081476460;
        Wed, 13 Feb 2019 10:11:16 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h15sm21613325pgl.43.2019.02.13.10.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 10:11:15 -0800 (PST)
Message-ID: <1550081474.19311.62.camel@acm.org>
Subject: Re: [LSF/MM TOPIC] : blktests: status, an expansion plan for the
 storage stack test framework
From:   Bart Van Assche <bvanassche@acm.org>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, "hare@suse.de" <hare@suse.de>,
        "hch@infradead.org" <hch@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "osandov@fb.com" <osandov@fb.com>, "tytso@mit.edu" <tytso@mit.edu>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Date:   Wed, 13 Feb 2019 10:11:14 -0800
In-Reply-To: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
References: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-02-06 at 05:21 +-0000, Chaitanya Kulkarni wrote:
+AD4 For storage track, we would like to propose a session dedicated to blktests. It is a great
+AD4 opportunity for the storage developers to gather and have a discussion about:-
+AD4 
+AD4 1. Current status of the blktests framework.
+AD4 2. Any new/missing features that we want to add in the blktests.
+AD4 3. Any new kernel features that could be used to make testing easier?
+AD4 E.g. Implementing new features in the null+AF8-blk.c in order to have device
+AD4 independent complete test coverage. (e.g. adding discard command for null+AF8-blk or any
+AD4 other specific REQ+AF8-OP). Discussion about having any new tracepoint events in the block layer.
+AD4 4. Any new test cases/categories which are lacking in the blktests framework.

Hi Chaitanya,

Thanks for having proposed this topic. I'd like to add a fifth item to the
agenda, namely blktests maintainership. The following could e.g. be discussed:
- How many maintainers should the blktests project have? A single maintainer
  or also one or more co-maintainers?
- Is it acceptable that patches get accepted in the blktests repository that
  break the continuous integration tests? If so, why do we even have continuous
  integration tests? See also +ACIAWw-PATCH+AF0 Unbreak the continuous integration build+ACI
  (https://marc.info/?l+AD0-linux-block+ACY-m+AD0-154990323618159).
- How long should it take before a blktests maintainer provides feedback on
  blktests patches and pull requests? Is it considered acceptable that it takes
  more than four weeks to process a pull request that is in perfect shape? See
  e.g. https://github.com/osandov/blktests/pull/44.

Bart.
