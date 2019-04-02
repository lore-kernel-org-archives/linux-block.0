Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8441CC4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 18:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CEBB2070D
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 18:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfDBSLL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 14:11:11 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42041 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfDBSLL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 14:11:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id p6so6946552pgh.9;
        Tue, 02 Apr 2019 11:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wih5mIii81zw81+Qj17rwAe9hRpI7uhzOubaqefO/W8=;
        b=HMIcgiJqPUvh1ItasIOAOpjWh1BSK0voPL2V/i+sHphTt5NDQxIclwEHNjKxvzpqpE
         ZwHqA2apeArJuLZdGsjeaQ4m0/qOlAJaNsuVHTUHZP9Ne1aiWgOmfVsL8Mlog5XK3ENV
         iuwuP/wFdv4zi9gBO61q2qvQf6+ZG6I/oHUiPCD7b4DFPzksmf/DX3tjPzT5XbANWYdB
         B59L4ECviR62ljBR/CvRzc5CRS4ah3vechYnezMj8dX8qKl99U2MBnFKYI1YSQj7hQJg
         7WZ1KifRieBdvtCZAGjDbnt0S1egstO17uzjBoUqPhK2QSgfku3e4OgUxVeYA5k2RroO
         ValQ==
X-Gm-Message-State: APjAAAUH19nhgVQHO6+L1uv6xqbNTlVwWLBXwREeacSHnxa5VLXtxyGm
        j163NAq4ArddmjGg6cBtSxs=
X-Google-Smtp-Source: APXvYqxZfpJ5CFbYc/HDeUavLPuN3deIh6aPtMHMOmB6wq1fChRYr5uvT5pTgTCiy8OnKaE7UrJthA==
X-Received: by 2002:a65:5304:: with SMTP id m4mr23060720pgq.281.1554228670597;
        Tue, 02 Apr 2019 11:11:10 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h4sm4858190pgv.61.2019.04.02.11.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 11:11:09 -0700 (PDT)
Message-ID: <1554228668.118779.166.camel@acm.org>
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>,
        "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Date:   Tue, 02 Apr 2019 11:11:08 -0700
In-Reply-To: <20190402025505.GB26316@ming.t460p>
References: <20190331030954.22320-1-ming.lei@redhat.com>
         <10c8ed10-3c96-b73c-18d8-114773b1d675@acm.org>
         <20190401020036.GB30776@ming.t460p>
         <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
         <20190401025237.GE30776@ming.t460p>
         <21b2000b-16b6-f5a6-692b-73143a49a4ec@oracle.com>
         <20190401032852.GG30776@ming.t460p>
         <ef192658-74cd-e193-cb40-aed546c2b309@oracle.com>
         <20190401100334.GA5493@ming.t460p>
         <ad0f8f4c-5efe-e50f-a3a7-4f7e3d368d28@oracle.com>
         <20190402025505.GB26316@ming.t460p>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-02 at 10:55 +-0800, Ming Lei wrote:
+AD4 Also, isn't it the typical practice to release kobject related resources in
+AD4 its release handler?

A typical approach is to call kobject+AF8-del() before starting to clean up a
resource and to defer the final kfree() call to the release handler. I think
that's how it works today in the block layer core. That is easy to see in the
blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-release() implementation:

static void blk+AF8-mq+AF8-hw+AF8-sysfs+AF8-release(struct kobject +ACo-kobj)
+AHs
	struct blk+AF8-mq+AF8-hw+AF8-ctx +ACo-hctx +AD0 container+AF8-of(kobj, struct blk+AF8-mq+AF8-hw+AF8-ctx,
						  kobj)+ADs
	free+AF8-cpumask+AF8-var(hctx-+AD4-cpumask)+ADs
	kfree(hctx-+AD4-ctxs)+ADs
	kfree(hctx)+ADs
+AH0

Bart.
