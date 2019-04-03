Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6C0C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 15:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A277D2084B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 15:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfDCPJk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:09:40 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:42565 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCPJj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 11:09:39 -0400
Received: by mail-pg1-f177.google.com with SMTP id p6so8466993pgh.9;
        Wed, 03 Apr 2019 08:09:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3HTDvR1B/jbn6hj5P8atuCe3Fuf7tSz/2om3W8JYbCY=;
        b=uXBtgeShcNGaV3F+p9SEGTV6SkZwh8Iel0iMp1N/U9IwJeKD6OlcJZvOwCaJLjZlaG
         Z53t/MSpANR0H0nyZp5n162sfNS222duFwM/m4WVVvt4N/lRBUZuX7XNSkkbbxGPQXmI
         TmqahqcgYYdF5S8DrvBY18RgoR6n8tm7h9NRoEqt76u5niCCL/RVkuvL+LPd9L7gjVRG
         AnbShUvExussRxt9VlErHQ8OLRG7BOTei/kQO0oa8wRnpzQyAAvvqUzswkKKrmBLj21J
         v9HjpLWEO/WvCGYfIWUPLlTfhD+Lc8jv+D6vq7qm/zlVKdwj8k0TnPqi3hF5U0iK37Sm
         TvSg==
X-Gm-Message-State: APjAAAX3YMMxu2CuDy2ggJcO8NkhKcZG5xCQvpo7jiVi6qL/786PqtJ4
        wwbC2dCecwWUseq58CX0T2M=
X-Google-Smtp-Source: APXvYqzP9QnCDy5r+FYB3JYLiEGjsJBIy3byaESxbVEOdwT/8mxluK3FWYbn78lX90uR6xGsT2nH+A==
X-Received: by 2002:a63:6193:: with SMTP id v141mr153647pgb.392.1554304178621;
        Wed, 03 Apr 2019 08:09:38 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id f65sm24854802pff.21.2019.04.03.08.09.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 08:09:37 -0700 (PDT)
Message-ID: <1554304176.118779.178.camel@acm.org>
Subject: Re: Panic when rebooting target server testing srp on 5.0.0-rc2
From:   Bart Van Assche <bvanassche@acm.org>
To:     Laurence Oberman <loberman@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>
Date:   Wed, 03 Apr 2019 08:09:36 -0700
In-Reply-To: <3a0e6f4b35742a31dc5f11fab30dbdacf673b9ba.camel@redhat.com>
References: <6e19971d315f4a3ce2cc20a1c6693f4a263a280c.camel@redhat.com>
         <7858e19ce3fc3ebf7845494a2209c58cd9e3086d.camel@redhat.com>
         <1553113730.65329.60.camel@acm.org>
         <3645c45e88523d4b242333d96adbb492ab100f97.camel@redhat.com>
         <d9febee1de759206bbf4d66f6570415ae64e4f33.camel@redhat.com>
         <8a6807100283a0c1256410f4f0381979b18398fe.camel@redhat.com>
         <10c96c79ed7a51ec22c6ccecbdbc3323655903b1.camel@redhat.com>
         <3a0e6f4b35742a31dc5f11fab30dbdacf673b9ba.camel@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-03 at 10:53 -0400, Laurence Oberman wrote:
+AD4 Update on this issue
+AD4 
+AD4 If I reset the SRP target server and do not reboot it I do not see the
+AD4 block-mq race with the SRP initiator.
+AD4 Just resetting the SRP target array and not runing the reboot avoids
+AD4 the shutdown scripts of ib+AF8-srpt and seems somehow to prevent the race
+AD4 with the initiator code.
+AD4 
+AD4 Given that I see very little churn and activity with LIO lately I dont
+AD4 know if its worth spending more time on trying to isolate this.
+AD4 
+AD4 If anybody has an SRP native array (like DDN) and can reboot it with
+AD4 5.x plus, that would be a good test.
+AD4 
+AD4 I will reach out to DDN and ask if they can test it.

Hi Laurence,

If the initiator side crashes it means there is a bug in the kernel at the
initiator side. It's not clear to me why you are commenting on the target
side in this e-mail thread?

Thanks,

Bart.
