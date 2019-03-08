Return-Path: <SRS0=/NKK=RL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5122C43381
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 21:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD5B72081B
	for <linux-block@archiver.kernel.org>; Fri,  8 Mar 2019 21:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfCHVZU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:25:20 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:38893 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCHVZT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Mar 2019 16:25:19 -0500
Received: by mail-pg1-f178.google.com with SMTP id m2so15099013pgl.5
        for <linux-block@vger.kernel.org>; Fri, 08 Mar 2019 13:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNU/5JFx679QHWDVwWzec0xuorXsjgz+zZIvLGaNTM8=;
        b=EPFNMRHgPBhhZr+rqDtXpLBWxKfSAsY7hBgiTJLjviIs56ZPZAxzTujTXXzpzz15b8
         CyEe0nz0BO7fRHmNGFgUtWq7uVg5lpFO1OGgm8s5oPvG4Zk7wI5J02YHPqHxbFj0hWZO
         qXx3Hwn6CYl3aE6/5rz9XYXdY7yUxSjtjZBDZjfcdDZLUkFAXG/WSghKyHgttlG+Yc3u
         4rbL48MNWYYegXq5WjcBk2NwtyJULHkkPS1+UH7MF6V0s+p4QE6KkozHDAV3+9yAdl8T
         TymqR/vj57XYpKTmP7hWLaPEDSGEiJ36E6aXvtvPOdNzEUz3lRLRQKNx4IP2WpHLdlh2
         ziqQ==
X-Gm-Message-State: APjAAAXjf/cDvIlqDA+4C9TBMnXfA0tzlCRcGL5/0tuf27HZ7JhSmS5C
        0t03wae4Yp3YElJUSCxHPVW962NR
X-Google-Smtp-Source: APXvYqzV21t9i8Vz2q6nPNxtRkg4fJod/0AlskDqnT08OG3Iv+AQvU1cIx/HkOsMooPZc2qgJ34YHg==
X-Received: by 2002:a63:f84d:: with SMTP id v13mr18863991pgj.384.1552080318763;
        Fri, 08 Mar 2019 13:25:18 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:fb9c:664d:d2ad:c9b5? ([2620:15c:2c1:200:fb9c:664d:d2ad:c9b5])
        by smtp.gmail.com with ESMTPSA id z77sm14809343pfi.155.2019.03.08.13.25.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 13:25:17 -0800 (PST)
Message-ID: <1552080316.138960.11.camel@acm.org>
Subject: Re: [PATCH 1/5] blk-mq: Export reading mq request state
From:   Bart Van Assche <bvanassche@acm.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Date:   Fri, 08 Mar 2019 13:25:16 -0800
In-Reply-To: <20190308211431.GA5438@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
         <1552068443.45180.24.camel@acm.org>
         <20190308181551.GB5214@localhost.localdomain>
         <1552070537.45180.38.camel@acm.org>
         <20190308191954.GC5232@localhost.localdomain>
         <1552078030.45180.88.camel@acm.org>
         <20190308211431.GA5438@localhost.localdomain>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-03-08 at 14:14 -0700, Keith Busch wrote:
+AD4 On Fri, Mar 08, 2019 at 12:47:10PM -0800, Bart Van Assche wrote:
+AD4 +AD4 If no such mechanism has been defined in the NVMe spec: have you considered
+AD4 +AD4 to cancel all outstanding requests instead of calling blk+AF8-mq+AF8-end+AF8-request() for
+AD4 +AD4 all outstanding requests?
+AD4 
+AD4 Isn't this cancelling requests? Is there an existing block interface
+AD4 that accomplishes this?

Hi Keith,

Sorry if I was unclear. With +ACI-canceling outstanding requests+ACI I was referring to
the NVMe abort command. I think aborting outstanding requests has the advantage
that no new explicit call to blk+AF8-mq+AF8-end+AF8-request() call has to be added.

Bart.
