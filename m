Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC5BC43610
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 16:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A878213A2
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 16:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A878213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbeK3Dry (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:47:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36815 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbeK3Dry (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 22:47:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so1178823pgm.3
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 08:41:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U0qc9AXnLTCcTnsPKpukVQfvsf4ob/TOJgOlkC+QS9k=;
        b=tI9VdtYTRvtJ0emEdUS1rerfve9xN/dztIWOwxfxoFDBWWAMVjMZxdXsYg+hCew7Cx
         D3bHkaNZ9TFV6jspC5QQ2mENRh36CrerAA5qrP4FZbN/VWENDRvbEb0iRk0WfKVshDCM
         1yS4e/AXeRdrpZEuuzsN9yyRmWfKX1NL92871ln3K05jWKI82U37RIS+Av4jYZCQ9p8l
         G5qAZzPgb3hCu7YpcLUQXEZ0N8LEnemnPnwDZMW/NaVfN98AvNrgYnvmrC3mxIYO+/sB
         hCYK6WZ0ACIU4ZoLZgfPFvKO8BnxaFfOnHWU6PJvxzMCBuQoXlyIeofRBOABwJwR/Ot9
         zepA==
X-Gm-Message-State: AA+aEWZpeXxj6BJ9Q/wMr2fGbdN86Un5zMuKrvxjywnsUtwR7fNYLnuK
        +670EmihUyX499fxH/R1+Dc=
X-Google-Smtp-Source: AFSGD/UmeP0sukd4zsoH1WlzBZgWUqi1TTYTCDmv/PtPwavOV11xlkr+wUFoZdQHIk192mGzIFMDCw==
X-Received: by 2002:a63:1258:: with SMTP id 24mr1814035pgs.114.1543509716195;
        Thu, 29 Nov 2018 08:41:56 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z8sm6170246pgz.53.2018.11.29.08.41.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 08:41:55 -0800 (PST)
Message-ID: <1543509714.185366.134.camel@acm.org>
Subject: Re: [PATCH v2] block: add documentation for io_timeout
From:   Bart Van Assche <bvanassche@acm.org>
To:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Date:   Thu, 29 Nov 2018 08:41:54 -0800
In-Reply-To: <20181129102237.GA29592@192.168.3.9>
References: <20181129102237.GA29592@192.168.3.9>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-11-29 at 18:22 +-0800, Weiping Zhang wrote:
+AD4 add documentation for /sys/block/+ADw-disk+AD4-/queue/io+AF8-timeout

Patch descriptions should consist of full sentences. That means that these
should start with a capital letter and end with a period.

+AD4 +-
+AD4 +-What:		/sys/block/+ADw-disk+AD4-/queue/io+AF8-timeout
+AD4 +-Date:		November 2018
+AD4 +-Contact:	Weiping Zhang +ADw-zhangweiping+AEA-didiglobal.com+AD4
+AD4 +-Description:
+AD4 +-		io+AF8-timeout is the timeout in milliseconds of a request in
+AD4 +-		block layer. The block layer will start a timer when low
+AD4 +-		level device driver start the request, and cancel timer
+AD4 +-		when request completes.

The grammar of that explanation needs to be improved ... I can spot three
grammatical issues.

Thanks,

Bart.
