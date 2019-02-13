Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CC6C282CE
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 18:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2474F20835
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 18:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394259AbfBMSyN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:54:13 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45189 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394257AbfBMSyH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 13:54:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id r14so1600743pls.12;
        Wed, 13 Feb 2019 10:54:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hPuFWcapf1G4S4lK97lsQUrUxfGwBltk9HsS7yxyoGQ=;
        b=R7UfJSahyIKttQPnkn8WeHLrcKR6kCXj0VYAsBP/+8Aac12shEQwf8QlZY5KWNPE1c
         rQbrc0SwOHfooXRT9zVjuOfOAykwDclEHtPuoPIpVS7siTrNINVivK2aFjfkj23WLmNA
         KFgfkJkyeXNHv2GBmNH9/Cqjvd51umwY1JJXF7O1Gyy1gnp3cywSReC0FcvHE6969+Xp
         gftVfgRsZHx4GhZIQxXLbiOYijvLdTBJBw9Xo9lcWM3Ew3owl1ocdvXWkOCpGa8uZ41L
         42VuXBsQk9lZP/YezEr7SZJZCt9X+G7cGCz/kdYk0IRrZdqdK5xSg8nOOVicFEYHDtbS
         pSeQ==
X-Gm-Message-State: AHQUAuZpO8A2RbZf7pPKs5AJ41jp+oyAPBpGPO7+AwBjL8sFNzzx1ueB
        1/p0NRbuXhlD7BJWQH8inUhdDQobJ6k=
X-Google-Smtp-Source: AHgI3IbHwIPIoZzRsSAtjLHirWmtoMj3L7Yc9M4XkEvdPDv8EJrFNbP7Jd9b6BIYc2Kkqev4nhBv9Q==
X-Received: by 2002:a17:902:2ba8:: with SMTP id l37mr1892518plb.243.1550084047052;
        Wed, 13 Feb 2019 10:54:07 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 10sm23447pfq.146.2019.02.13.10.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 10:54:06 -0800 (PST)
Message-ID: <1550084044.19311.73.camel@acm.org>
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
Date:   Wed, 13 Feb 2019 10:54:04 -0800
In-Reply-To: <20190213184331.GA9819@vader>
References: <BYAPR04MB4502158B1588C8EFF7B4E345866F0@BYAPR04MB4502.namprd04.prod.outlook.com>
         <1550081474.19311.62.camel@acm.org> <20190213184331.GA9819@vader>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-02-13 at 10:43 -0800, Omar Sandoval wrote:
+AD4 On Wed, Feb 13, 2019 at 10:11:14AM -0800, Bart Van Assche wrote:
+AD4 +AD4 - Is it acceptable that patches get accepted in the blktests repository that
+AD4 +AD4   break the continuous integration tests? If so, why do we even have continuous
+AD4 +AD4   integration tests? See also +ACIAWw-PATCH+AF0 Unbreak the continuous integration build+ACI
+AD4 +AD4   (https://marc.info/?l+AD0-linux-block+ACY-m+AD0-154990323618159).
+AD4 
+AD4 To be honest, I've never used travis, so I don't even know where to find
+AD4 the results. https://travis-ci.org/osandov/blktests doesn't point to
+AD4 anything. Can we add a build status badge to the README like other
+AD4 projects have?

Hi Omar,

What is a build status badge? Anyway, enabling Travis CI is easy:
+ACo Navigate to https://travis-ci.org/ and click on +ACI-Sign in with github+ACI.
+ACo In the left column, click on +ACIAKwAi (Add New Repository).
+ACo For the blktests repository, enable continuous integration. This will cause a
  continuous integration test to be started after every git push and also every
  time a pull request is submitted. The rdma-core project uses Travis CI not only
  to compile-test pull requests but also to verify whether new code in pull
  requests passes building with sparse. This is useful for the rdma-core project
  since a lot of endianness conversions happen in that code and sparse can
  verify whether these conversions have been annotated correctly. See also
  https://github.com/linux-rdma/rdma-core.

Bart.
