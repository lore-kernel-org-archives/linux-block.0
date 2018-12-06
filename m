Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34CDC64EB1
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762FB20838
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 16:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762FB20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbeLFQTg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:19:36 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34026 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeLFQTg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 11:19:36 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so394393plz.1
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 08:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cSgjB10Jr+0j1WUZCexLwmHWH5NljPdCKSUlKELqo2Y=;
        b=SMOcWdhlkhrvEII/EBe8lgoXBn6mOWI88NhU/3Db8CMt/2ZicoYBe/2EZuiW5PcDtw
         AcZQri6oyfqyCb4qsEU89r2oycNp6iIqwLu+7oo8pXxxPDkfIJDSUHeFIJITwQECHYEd
         cX/GrhgurL1N49MwII/d0UDWNqAPApyoIAnA3rNokJwXxsAvaY09SI7mh+pV8puNZi7W
         y0urWT0EcrjNhgeDg9iRwlMBT4cpmKNaoIYeAWJEQ0foICCOEDU6ew4Hpoqm7/dK0HJj
         ONMHwk0NkLL55dQm+AGYLhsIlxnyKBwzoZgKBXx6c8b9pBhIYAs8Qx/4UUtqqVCR2qBD
         LuVA==
X-Gm-Message-State: AA+aEWbXRsdusBtqk3F8nHV7wCCgvYpgPslEJ7U68ykl2znE5XQViiE0
        3qTTkTD6lUkeN34KQNRd4sI=
X-Google-Smtp-Source: AFSGD/UikW5kduDeBHAm5+nT+US1e7y/mfEYjudYH/tIAcHHU91FpRYaiSe8YKjB12UTx0yxmONIJg==
X-Received: by 2002:a17:902:e002:: with SMTP id ca2mr29270754plb.103.1544113175821;
        Thu, 06 Dec 2018 08:19:35 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id y184sm870387pgd.71.2018.12.06.08.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 08:19:35 -0800 (PST)
Message-ID: <1544113174.185366.240.camel@acm.org>
Subject: Re: [PATCH v3] block: add documentation for io_timeout
From:   Bart Van Assche <bvanassche@acm.org>
To:     Weiping Zhang <zhangweiping@didiglobal.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Date:   Thu, 06 Dec 2018 08:19:34 -0800
In-Reply-To: <20181205141701.GA33910@192.168.3.9>
References: <20181205141701.GA33910@192.168.3.9>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2018-12-05 at 22:17 +-0800, Weiping Zhang wrote:
+AD4 +-Description:
+AD4 +-		io+AF8-timeout is a request+IBk-s timeouts at block layer in
+AD4 +-		milliseconds. When the underlying driver starts processing
+AD4 +-		a request, the generic block layer will start a timer, if
+AD4 +-		this request cannot be completed in io+AF8-timeout milliseconds,
+AD4 +-		a timeout event will occur.

Sorry but I think this description is still somewhat confusing. How about
changing that description into the following?

	io+AF8-timeout is the request timeout in milliseconds. If a request does not
	complete in this time then the block driver timeout handler is invoked.
	That timeout handler can decide to retry the request, to fail it or to
	start a device recovery strategy.

Bart.
