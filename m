Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FA8C4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25B0206B8
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfDCQy2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:54:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44853 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfDCQy2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 12:54:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id g12so8324671pll.11
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2019 09:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JEt3/7mEXxTrVFkDHp1Ln5fixSkvRvsnBA9P5Wb2Gpw=;
        b=EvsLTr2f3kKgi7JqIfXLS1LSXySTWLNvPtBYKeKy4oQXFHx3pHpSMwtjxzRNiKiU4l
         ugN0SysRRKGSJvciY2P4HrwwdLa6HuPZxlGTOcm+3obhsUIck4k0sEjjRylpjSTi9276
         iTLKW8G9kAz67UwDRNR9bXlbHLB8oAy79sdBdOrW5Bt9K3H/aGElJQZ4ipvofzxn1yWN
         tpjyDqJgFpqWynydyXd9qTdpDADRrtVTrrG8dXSBflRJ7SiGBh0aJ2rAlPQOekPJO7wN
         ijRpmVXXYoSHa2QcPw5vePpU5/9cF6nmi0UDa/cOv1seYVaY6FYFof6XFCVU9qY+RjxZ
         0RcQ==
X-Gm-Message-State: APjAAAVPgAU/ksr4WXkg/bRGTJgn4Lw/zqYZ6FQo+zI/s60LmireQLWv
        +9okBVvE1Zr0+znJvnWl0qo=
X-Google-Smtp-Source: APXvYqwHkK6BeQL38ITCjIp7ML4v5bdr05L6zAqrdARj3WDpIKJuMGY8Q3tm7RDy0ODv9RXROQnPNw==
X-Received: by 2002:a17:902:e382:: with SMTP id ch2mr1012961plb.94.1554310467335;
        Wed, 03 Apr 2019 09:54:27 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id v20sm24874873pfn.116.2019.04.03.09.54.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:54:26 -0700 (PDT)
Message-ID: <1554310465.118779.227.camel@acm.org>
Subject: Re: [PATCH v2] block: don't show io_timeout if driver has no
 timeout handler
From:   Bart Van Assche <bvanassche@acm.org>
To:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk,
        hch@infradead.org
Cc:     linux-block@vger.kernel.org
Date:   Wed, 03 Apr 2019 09:54:25 -0700
In-Reply-To: <20190402131424.GA12935@192.168.3.9>
References: <20190402131424.GA12935@192.168.3.9>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-02 at 21:14 +-0800, Weiping Zhang wrote:
+AD4 If the low level driver has no timeout handler, the
+AD4 /sys/block/+ADw-disk+AD4-/queue/io+AF8-timeout will not be displayed.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


