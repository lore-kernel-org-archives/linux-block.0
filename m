Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E668C10F0C
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 22:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F602217D7
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 22:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfDDWCf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:02:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42308 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfDDWCf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 18:02:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id p6so1894633pgh.9;
        Thu, 04 Apr 2019 15:02:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9JfmbZcklAVyB81871yPAPfitHLhOiipQRB08ttNOKM=;
        b=JnYQ85OZj53toE1K57QUJh89CjV16IpmF7bmybQk3QeiUl977REKz23eRTvNA60udJ
         v7CyJ/DfQowsxDH8t7AX4TAfIqv6gxxJhBKMqglY6hQoU/fw2nwqWPsphNgczmuzsTdA
         4PT9EkZ4nbQjXh8zLvyg5vUEPDzlgy8nXJzTGv3+pKFNqrvwj/grQyl5JDWuCBG99ran
         +tOK5T26r1m7Qmza1ubmtg9DIhvAEz1gtdTVr/aqlb4g32fpNGbnq13tBc2fKWqU8rUp
         G026NDi8rvr+lfva9p2ezjLhAU2Kmv84iv5prGqOUY9CZ4PbV/QgzwWqXX+IyGFpGheX
         itPA==
X-Gm-Message-State: APjAAAUiFj+cW+ONWwevLSF+B8OXrPsaPS2QosefUjwtqZBENmdX2cdm
        qV20lkdSTz4M5t1t1hXlWhY=
X-Google-Smtp-Source: APXvYqxBLz7/uSvBhzNaMvtcdSzjhng0emEs1GWr91RuSUZi8S+f3itptfcg8HDn5JDKi5zaxN7Puw==
X-Received: by 2002:a62:52c3:: with SMTP id g186mr8464226pfb.173.1554415354586;
        Thu, 04 Apr 2019 15:02:34 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id j1sm5672436pgp.91.2019.04.04.15.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 15:02:33 -0700 (PDT)
Message-ID: <1554415351.118779.261.camel@acm.org>
Subject: Re: [PATCH] block: Revert v5.0 blk_mq_request_issue_directly()
 changes
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Laurence Oberman <loberman@redhat.com>, stable@vger.kernel.org
Date:   Thu, 04 Apr 2019 15:02:31 -0700
In-Reply-To: <20190404214344.GA30656@ming.t460p>
References: <20190404170843.83517-1-bvanassche@acm.org>
         <20190404214344.GA30656@ming.t460p>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-04-05 at 05:43 +-0800, Ming Lei wrote:
+AD4 On Thu, Apr 04, 2019 at 10:08:43AM -0700, Bart Van Assche wrote:
+AD4 +AD4 blk+AF8-mq+AF8-try+AF8-issue+AF8-directly() can return BLK+AF8-STS+ACoAXw-RESOURCE for requests that
+AD4 +AD4 have been queued. If that happens when blk+AF8-mq+AF8-try+AF8-issue+AF8-directly() is called
+AD4 +AD4 by the dm-mpath driver then dm-mpath will try to resubmit a request that is
+AD4 +AD4 already queued and a kernel crash follows. Since it is nontrivial to fix
+AD4 +AD4 blk+AF8-mq+AF8-request+AF8-issue+AF8-directly(), revert the blk+AF8-mq+AF8-request+AF8-issue+AF8-directly()
+AD4 +AD4 changes that went into kernel v5.0.
+AD4 +AD4 
+AD4 +AD4 This patch reverts the following commits:
+AD4 +AD4 +ACo d6a51a97c0b2 (+ACI-blk-mq: replace and kill blk+AF8-mq+AF8-request+AF8-issue+AF8-directly+ACI) +ACM v5.0.
+AD4 +AD4 +ACo 5b7a6f128aad (+ACI-blk-mq: issue directly with bypass 'false' in blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests+ACI) +ACM v5.0.
+AD4 +AD4 +ACo 7f556a44e61d (+ACI-blk-mq: refactor the code of issue request directly+ACI) +ACM v5.0.
+AD4 
+AD4 I am fine to revert them now.
+AD4 
+AD4 However, could you revert them one by one so that they can be reviewed
+AD4 easily?

Anyone who wants to verify this patch can do that by reverting the three
commits mentioned above and by using diff to compare the revert result with
this patch.

Thanks,

Bart.
