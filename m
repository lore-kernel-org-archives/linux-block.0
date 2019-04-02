Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFB6C4360F
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 15:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9482420830
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 15:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfDBPN1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:13:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36940 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbfDBPN1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 11:13:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id 8so6543394pfr.4;
        Tue, 02 Apr 2019 08:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KUrW0EVWYnMI5gbpdz18YHQ5NpE3EHja9r6KZxJUkfI=;
        b=JVj+lWy55UmLVdqwva0s9cXkJsjp+m//irSBGKgk00bY6o41qwYZps8aC9YpTVmarh
         HpNUVSuUReBv+hgK7wuGFPaY0efdhvEM2JAOjWpxAGm+AszDcrlBmQD8z3dWzf7WHzfI
         4DLG4+NSpWww3Z1Sn7rSdRIPfnYPbffvG7JFrJSDRMjZZchWpR+3E6/Exwiy+CZkNTij
         3A9Goidpje+mx6Gg8nkvMijRoyphK/qD0MyV63gPl4iX2IyQh4p1nf89XHGzMXYp5RP3
         5I0c30/fihiFqJE8sfqUDqVnWgAh7NLXPdtq6NDF09FBpUfKz3Yp8ohU32ru+jFjR4rT
         +4oA==
X-Gm-Message-State: APjAAAVu/qauxWHxKeYuAM4QMC/c0F+NYWOjz9iaVp00XCmfhwBGa7g5
        tMluJ/pjyvHK/26oYTFoXDo=
X-Google-Smtp-Source: APXvYqx4oIKtnzPLKcJ1/TjS6BOP7r97bGMG6oiemfzGT5pIuNv9lJrCKGaxFofyBkIP2oYsBYIfyQ==
X-Received: by 2002:a63:1918:: with SMTP id z24mr41483014pgl.406.1554218005930;
        Tue, 02 Apr 2019 08:13:25 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id a3sm24179663pfn.182.2019.04.02.08.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 08:13:24 -0700 (PDT)
Message-ID: <1554218003.118779.132.camel@acm.org>
Subject: Re: [PATCH] SCSI: don't hold device refcount in IO path
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ming Lei <ming.lei@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        jianchao wang <jianchao.w.wang@oracle.com>
Date:   Tue, 02 Apr 2019 08:13:23 -0700
In-Reply-To: <20190402114800.2281-1-ming.lei@redhat.com>
References: <20190402114800.2281-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-02 at 19:48 +-0800, Ming Lei wrote:
+AD4 +AEAAQA -201,7 +198,6 +AEAAQA static void +AF8AXw-scsi+AF8-queue+AF8-insert(struct scsi+AF8-cmnd +ACo-cmd, int reason, bool unbusy)
+AD4  	 +ACo happened.
+AD4  	 +ACo-/
+AD4  	blk+AF8-mq+AF8-requeue+AF8-request(cmd-+AD4-request, true)+ADs
+AD4 -	put+AF8-device(+ACY-device-+AD4-sdev+AF8-gendev)+ADs
+AD4  +AH0

The word +ACI-happened+ACI is the last word of a long comment that explains why
the put+AF8-device() call is necessary. Please update this patch such that it
also removes that comment.

Thanks,

Bart.

