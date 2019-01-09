Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A8BC43612
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 20:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79C1206B7
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 20:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfAIUvd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 15:51:33 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37784 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfAIUvd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 15:51:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so3818930pgb.4;
        Wed, 09 Jan 2019 12:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mv6qB4UcQSszzDw4pkq6KXA+yj2suUtqattZixkiQsQ=;
        b=ZyVwTLZVo5BXX9UzxCESiZJjZ35RzLLKA/ZhKvhQe+jjjcrNzGzsBa4Py8WrdjyLY3
         fWvoxsfiUe8oWY6XpwNtXIJvPIrfz0u/SveP0qqiw+qnOSCXVAeBSDfqI37ev3CIoUS8
         HMYIuevXGwgn9gcnrXE61O4M3yJJfiMGmwnY3IeBhwP7rO8lrMdb6HqE6J4pPrm5BPX5
         wb4j1Qf1/+52bEfLpbgxSTUmnp4vvo8SCyQKC2Q23U3iOfKvYz90KUMbAAFj6u1R31Ri
         rr6K8jZs3vm89j4yMTKlTpcP5zwe48QCvN/azdd4a4xPlJ1A/b8DxVIGM89O2FUM9CXz
         BEfQ==
X-Gm-Message-State: AJcUukcrYqTljaHUeHB0ygGDoqJsM4aRh3PD+YIN1ZNB1xTBjZurpHLH
        xU36GflSc5j51759BJg6A3c=
X-Google-Smtp-Source: ALg8bN74B4Cfu9sT7HzEkMYfur3FNmme2tybBly9s7Fs6RoZJE/zR9MKbaKyi8jFS6Sq4SqUibOeHg==
X-Received: by 2002:a62:6204:: with SMTP id w4mr7544163pfb.5.1547067092008;
        Wed, 09 Jan 2019 12:51:32 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id u186sm109312823pfu.51.2019.01.09.12.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 12:51:30 -0800 (PST)
Message-ID: <1547067088.83374.41.camel@acm.org>
Subject: Re: [PATCH v3] loop: drop caches if offset or block_size are changed
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Date:   Wed, 09 Jan 2019 12:51:28 -0800
In-Reply-To: <20181218224139.GB31062@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181214203223.7063-1-jaegeuk@kernel.org>
         <20181217194236.GA50659@jaegeuk-macbookpro.roam.corp.google.com>
         <29369548-df14-a5a7-2bee-a40b3479df68@kernel.dk>
         <20181218224139.GB31062@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2018-12-18 at 14:41 -0800, Jaegeuk Kim wrote:
+AD4 +AFs ... +AF0

Please post new versions of a patch as a new e-mail thread instead of
as a reply to a previous e-mail.

+AD4 +AFs ... +AF0
+AD4
+AD4  	if (lo-+AD4-lo+AF8-offset +ACEAPQ info-+AD4-lo+AF8-offset +AHwAfA
+AD4  	    lo-+AD4-lo+AF8-sizelimit +ACEAPQ info-+AD4-lo+AF8-sizelimit) +AHs
+AD4 +-		/+ACo kill+AF8-bdev should have truncated all the pages +ACo-/
+AD4 +-		if (lo-+AD4-lo+AF8-device-+AD4-bd+AF8-inode-+AD4-i+AF8-mapping-+AD4-nrpages) +AHs
+AD4 +-			err +AD0 -EAGAIN+ADs
+AD4 +-			goto exit+ADs
+AD4 +-		+AH0

Please add a pr+AF8-info() or pr+AF8-warn() statement here such that it becomes
easy for the user to figure out why EAGAIN has been returned.

+AD4  	blk+AF8-mq+AF8-freeze+AF8-queue(lo-+AD4-lo+AF8-queue)+ADs
+AD4  
+AD4 +-	/+ACo kill+AF8-bdev should have truncated all the pages +ACo-/
+AD4 +-	if (lo-+AD4-lo+AF8-queue-+AD4-limits.logical+AF8-block+AF8-size +ACEAPQ arg +ACYAJg
+AD4 +-			lo-+AD4-lo+AF8-device-+AD4-bd+AF8-inode-+AD4-i+AF8-mapping-+AD4-nrpages) +AHs
+AD4 +-		err +AD0 -EAGAIN+ADs
+AD4 +-		goto out+ADs
+AD4 +-	+AH0

Same comment here. Additionally, please consider renaming the +ACI-out+ACI label
into +ACI-unfreeze+ACI or so. I think that will make the use of label names more
consistent with the rest of the block layer. Once these two comments are
addressed, feel free to add:

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


