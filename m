Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8E3C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 21:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A78206BA
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 21:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfDCVW5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 17:22:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33903 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbfDCVW5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 17:22:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id b3so224794pfd.1;
        Wed, 03 Apr 2019 14:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5O54e/6ayieq/hlbeI1v0/HcZHwsy/WgEqLQEQRLuE0=;
        b=rABulArEmtKJj09ANr/TRewCMti8yaPBuFE6BBz8ECgoBwIvaYU2vOjfOxFuG4TE1u
         FWiQD6LDmP6pBVvLTmhy08HZk+Xu4xcQduSGGX5+Vw4OZ8fyX3o1POkRDl6EUew3GFMt
         chhND5hKHbnNUjx/0AWpAPr8SpUSqfGTEGc9K5A9jhz4MC4s3g5qCAewMR6SdYTBc1CM
         PaHHCsXK8hglNjNb4wsB0NbkTjRw+tQOmeRDrxHhZuJI6U54BdCCPvhlFLKSZzj9q5ej
         deteF7petsZDTNvjSl3I1CunnzkTQkLIMTY91PL5d3PuEFGN+pEMx3KzHEEa714hfzGw
         XARA==
X-Gm-Message-State: APjAAAXOjRGcjzbXg1nwRMbtJ159Agx0f6n0+jWIju0DgX8HKvx76URE
        LRzKbXOmI9rieMnfFGUImeE=
X-Google-Smtp-Source: APXvYqy3n9yNeDk19ZqsDtvZp8GMNaWsWYOmYd8ZuMV9g7FJoaPAjYyCfeNRC7/yKUJ1kNwRcFzo4w==
X-Received: by 2002:a63:4e10:: with SMTP id c16mr1940067pgb.302.1554326576729;
        Wed, 03 Apr 2019 14:22:56 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id r8sm22812415pfd.8.2019.04.03.14.22.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 14:22:55 -0700 (PDT)
Message-ID: <1554326574.118779.235.camel@acm.org>
Subject: Re: [PATCH V3 1/6] blk-mq: grab .q_usage_counter when queuing
 request from plug code path
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
Date:   Wed, 03 Apr 2019 14:22:54 -0700
In-Reply-To: <20190403162726.GB22741@ming.t460p>
References: <20190403102609.18707-1-ming.lei@redhat.com>
         <20190403102609.18707-2-ming.lei@redhat.com>
         <1554304871.118779.185.camel@acm.org> <20190403162726.GB22741@ming.t460p>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-04 at 00:27 +-0800, Ming Lei wrote:
+AD4 blk+AF8-mq+AF8-flush+AF8-plug+AF8-list():
+AD4 	blk+AF8-mq+AF8-sched+AF8-insert+AF8-requests()
+AD4 		insert requests to sw queue or scheduler queue 
+AD4 		blk+AF8-mq+AF8-run+AF8-hw+AF8-queue
+AD4 
+AD4 Because of concurrent run queue, all requests inserted above may be completed
+AD4 before calling the above blk+AF8-mq+AF8-run+AF8-hw+AF8-queue. Then queue can be freed
+AD4 during the above blk+AF8-mq+AF8-run+AF8-hw+AF8-queue().

Thanks for the clarification. That makes sense to me.

Bart.
