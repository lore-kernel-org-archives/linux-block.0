Return-Path: <SRS0=51nD=SG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2715EC10F0C
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 17:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF591206BA
	for <linux-block@archiver.kernel.org>; Thu,  4 Apr 2019 17:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfDDRJS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:09:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33543 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDRJS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Apr 2019 13:09:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id i19so1688684pfd.0;
        Thu, 04 Apr 2019 10:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c90rAYe/PypfPIjnzJXCvQ6dkckM/Yr7BxQzJxKSq8M=;
        b=f4NNeWFuzkxuOXdgDTNqa91sRRS4+RZBCyfMVlLTlPDQU5rGXrUF7CEsSjUB3MShmU
         JFRBMzeZciEb5zae+2dPpGu+rp2GC6PUOR6WTI/NTxLigMpvkklGfwjb9ijtVVmQvPxi
         oBhM0Iflv73faaHGF3jSEDqs50aTojUT+04ouhhGmBheptyyN3XSgF9oQ2a/CfT5826v
         qknoQWDGXKKZyL02T1Cc5cM20wzTkhpKBnujGvjVyit6E097AXY5Peq5ODY5UnO40epE
         VMMsvmqzU+/9pi3NnkMe8SNov/gYMh/xu6k94jjylr64pdjpseij/O7pPhmycMuFkVPC
         /qEw==
X-Gm-Message-State: APjAAAXe9dho4VzrN7brpnzhrvSyonere4jYrTl2ekPLQ5/d7t3WsnYZ
        eYPxaU4OATKxEVLtk7QSaCc=
X-Google-Smtp-Source: APXvYqytee+/AD0qaXbPY+jH2rjzaMOiCn9reCYA4sO+mgHPoHjY381KRfVespd7Phi6eRSqz7wwCw==
X-Received: by 2002:a63:6907:: with SMTP id e7mr1514881pgc.209.1554397757313;
        Thu, 04 Apr 2019 10:09:17 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id d69sm47601052pfg.26.2019.04.04.10.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 10:09:16 -0700 (PDT)
Message-ID: <1554397755.118779.252.camel@acm.org>
Subject: Re: [PATCH] block: Fix blk_mq_try_issue_directly()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Laurence Oberman <loberman@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongli Zhang <dongli.zhang@oracle.com>, stable@vger.kernel.org
Date:   Thu, 04 Apr 2019 10:09:15 -0700
In-Reply-To: <4b19805967da8d6a11346a7820af06eb91c5bc6c.camel@redhat.com>
References: <20190403201126.22819-1-bvanassche@acm.org>
         <20190404070849.GD5004@ming.t460p> <1554389983.118779.237.camel@acm.org>
         <2b049ffa57ccac27b876c674bc1fa06faca5d3b6.camel@redhat.com>
         <1554391728.118779.241.camel@acm.org>
         <4b19805967da8d6a11346a7820af06eb91c5bc6c.camel@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-04 at 12:47 -0400, Laurence Oberman wrote:
+AD4 I can conform, reverting those 3 in order also resolves the panic I was
+AD4 seeing. I have 3 reboot tests of the srpt server allowing the client ot
+AD4 remain stable and try reconnect.
+AD4 
+AD4 For the above patch:
+AD4 Tested-by: Laurence Oberman +ADw-loberman+AEA-redhat.com+AD4
+AD4 
+AD4 Too many changes in code I am not familiar enough to review and
+AD4 comnment why reverting helps.

Thanks for the testing+ACE

Bart.
