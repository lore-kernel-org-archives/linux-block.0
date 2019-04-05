Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD26C10F00
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 12:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297202186A
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 12:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfDEMne (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 08:43:34 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33132 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfDEMne (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Apr 2019 08:43:34 -0400
Received: by mail-qk1-f196.google.com with SMTP id k189so3719824qkc.0
        for <linux-block@vger.kernel.org>; Fri, 05 Apr 2019 05:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HkGPiIWA6VaMA/boszo5nO83O+MCoRThxQSBdQ2LSM=;
        b=A1BDucxwR0dmSd9vRAnJprNntHSgc5ElP4bq23nLRb8KEJRBltBrFBGjZKbbjNmZnf
         COZAWDWMcljq7YUN0ipgnln95fTCOy34/yr1ax0BhthRpgWElpTOOxfSS2H3sYsIRudU
         6811dty4UM1isqXm5OxvJGhnzwZp3h1AYof/W6npYCE+aQnTZRV1H/UtRfcNVayHpaOg
         P1lqH7iC9Y8TQZwELxVVWic3rhk3Qs0yOVDbR4CJnLI0ZwozXjSJKtIvo1Ka1/n7d55+
         Odtx7r2tlVNzpHZyZvhSj7jQuJx0wtyc9La4yLnI37Ly6vaSh6WwDLQ/DyTcbos19YHC
         mTLQ==
X-Gm-Message-State: APjAAAUH2jdf/gIArDS4QFx4Q6kpGDuItqCdmx4KHiEHKq6k+lm7allg
        0B6d3z6H44KrggWU+RPY8QYHzg==
X-Google-Smtp-Source: APXvYqyLx909AfFbFVMf2zX+gw8JRQjwXOiKqL6xGdxabzP2gl6a36pwSEX0bqDgeeumZLBdfzUrSg==
X-Received: by 2002:a37:4c04:: with SMTP id z4mr9950399qka.312.1554468213171;
        Fri, 05 Apr 2019 05:43:33 -0700 (PDT)
Received: from 2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net (2600-6c64-4e80-00f1-422c-9885-0a6c-81b2.dhcp6.chtrptr.net. [2600:6c64:4e80:f1:422c:9885:a6c:81b2])
        by smtp.gmail.com with ESMTPSA id w18sm17747498qta.2.2019.04.05.05.43.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 05:43:32 -0700 (PDT)
Message-ID: <72814f8faee5f55d661863321e48f2a7ef521c63.camel@redhat.com>
Subject: Re: [PATCH] block: Revert v5.0 blk_mq_request_issue_directly()
 changes
From:   Laurence Oberman <loberman@redhat.com>
To:     Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        James Smart <james.smart@broadcom.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Date:   Fri, 05 Apr 2019 08:43:31 -0400
In-Reply-To: <20190405060612.GA32144@lst.de>
References: <20190404170843.83517-1-bvanassche@acm.org>
         <20190405060612.GA32144@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-04-05 at 08:06 +0200, Christoph Hellwig wrote:
> On Thu, Apr 04, 2019 at 10:08:43AM -0700, Bart Van Assche wrote:
> > blk_mq_try_issue_directly() can return BLK_STS*_RESOURCE for
> > requests that
> > have been queued. If that happens when blk_mq_try_issue_directly()
> > is called
> > by the dm-mpath driver then dm-mpath will try to resubmit a request
> > that is
> > already queued and a kernel crash follows. Since it is nontrivial
> > to fix
> > blk_mq_request_issue_directly(), revert the
> > blk_mq_request_issue_directly()
> > changes that went into kernel v5.0.
> 
> And what are we going to do about 5.1+?

Hello Christoph
All the testing of the reverts etc. was agains 5.1-rc3.
I believe the intention is to revert for 5.1x+ and earlier.
Regards
Laurence

