Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB0BC43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 17:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEB1208CA
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 17:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfDZRE1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:04:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36730 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfDZRE0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 13:04:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so2027226pfn.3;
        Fri, 26 Apr 2019 10:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FIAgZNPR72lee+v7DSC8J9ZbKyJH6hh0iFHAUQ+PSFw=;
        b=mapRohbBpiB+hutWIcUbKmT+CtayT90H6WGbmq726beg/gaW5S41MWvlYlX50O/mYq
         /uQ27Kqfu+lj4+z/68j9d999EvAqwN2wuSlS6oZF1k2kQJUdyGIp65Gn4Y9LMDoCNkIR
         dVHWiTbiEQjjRSOuCI/4+IZEoUqQuSBnvxx1omWBzjyf+kBZl6EfVf0N+L5H4kJGGYau
         esMIa4RrrlPSlfmEVPQggAgx5bSUiXyY5V+wk1fEMjJb1c3UvAv+2cL9Y5+i8cJDwwmN
         sBUfGtUGfGlOa+ZJKT0MGfrWnMCZMzQVGgYpM5A1c3t6ZrxelBiK3UDuIPkLD9cR/oXs
         0Cxw==
X-Gm-Message-State: APjAAAW4SFJUmYjKrPKGNYHPn640J+Ztfb9dqrL8C5kuG/McyTgtjRxJ
        6O/MlDQDvFb8qVKq5P/1yUk=
X-Google-Smtp-Source: APXvYqxLLwM8y5a8lC5KN2F+i0pqYJdAj4fQiUtA6/2kFUmXTCvPITwXxYldDEML+Xy3UJxtvToN3A==
X-Received: by 2002:aa7:8092:: with SMTP id v18mr47356306pff.35.1556298265760;
        Fri, 26 Apr 2019 10:04:25 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id b12sm23079394pfp.93.2019.04.26.10.04.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 10:04:24 -0700 (PDT)
Message-ID: <1556298263.161891.152.camel@acm.org>
Subject: Re: [PATCH V7 9/9] nvme: hold request queue's refcount in ns's
 whole lifetime
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Hannes Reinecke <hare@suse.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bart.vanassche@wdc.com>
Date:   Fri, 26 Apr 2019 10:04:23 -0700
In-Reply-To: <20190426151114.GB20438@lst.de>
References: <20190424110221.17435-1-ming.lei@redhat.com>
         <20190424110221.17435-10-ming.lei@redhat.com>
         <20190424162746.GE23854@lst.de> <20190425010030.GD22636@ming.t460p>
         <20190426151114.GB20438@lst.de>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-04-26 at 17:11 +-0200, Christoph Hellwig wrote:
+AD4 On Thu, Apr 25, 2019 at 09:00:31AM +-0800, Ming Lei wrote:
+AD4 +AD4 The issue is driver(NVMe) specific, the race window is just between
+AD4 +AD4 between blk+AF8-cleanup+AF8-queue() and removing the ns from the controller namspace
+AD4 +AD4 list in nvme+AF8-ns+AF8-remove()
+AD4 
+AD4 And I wouldn't be surprised if others have the same issue.
+AD4 
+AD4 +AD4 
+AD4 +AD4 blk+AF8-mq+AF8-init+AF8-queue() does hold one refcount, and its counter-part is
+AD4 +AD4 blk+AF8-cleanup+AF8-queue().
+AD4 +AD4 
+AD4 +AD4 It is simply ugly to ask blk+AF8-mq+AF8-init+AF8-queue() to grab a refcnt for driver,
+AD4 +AD4 then who is the counter-part for releasing the extra refcount?
+AD4 
+AD4 Well, the problem is exactly that blk+AF8-cleanup+AF8-queue drops the reference.
+AD4 If move the blk+AF8-put+AF8-queue() call from the end of it to the callers the
+AD4 callers can keep the reference as long as they need them, and we wouldn't
+AD4 need an extra reference.

Hi Christoph,

There are more than hundred callers of blk+AF8-cleanup+AF8-queue() so that change
would cause a lot of churn. Since blk+AF8-get+AF8-queue() and blk+AF8-put+AF8-queue() are
available, how inserting a pair of calls to these functions where necessary?

Thanks,

Bart.
