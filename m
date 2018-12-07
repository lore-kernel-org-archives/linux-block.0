Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B834C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 16:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CEF2081C
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 16:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CEF2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbeLGQlY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:41:24 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45456 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeLGQlY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 11:41:24 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so2058919plm.12
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 08:41:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3B54Fz3zncSi29/5Nei8t4KaHbt1agP06LWR0MM+pw=;
        b=slOtpwfa0Aj3BWrLWyow69MbNT3Cm08l+Y8g4ihTDF8p2Mi1wk3TGaw8oL2K2Pb1ZK
         m1BbMhfqb9jhRJbtU1VvdvOGSNgWHmpD1t9Ltzk+M/v507m+t4/2FngZeoethTThoa8e
         gWEiN1vJeIu+6H0pUgOsqq9pw2PKfFjHZQ3r1Fgzmj0X7yiQKndOCFCQ5NpKlYzNNSoy
         CQCVjKhgoR6nDroVHDbT+U+ffBPoXSVlKe+Tqqw1MredfnvZbpytN0f1iErUHN9GVl80
         51cnACQqS4SB1OoUUFJCY3ObqE8AQXGLjm7Aw3T+VAuh+Y9sNfMEvyhd6CLcQR7IdUP1
         RvWA==
X-Gm-Message-State: AA+aEWaI7ERY72CP/o5LQD14sOg4tFCpxuZSNuMXUM1QYbQxiMbuSQKb
        Flj94E3FO6aRYkZyffjVmMs=
X-Google-Smtp-Source: AFSGD/UCz4Hd6Gzgwcs9RUcXsRuox+NF7xFtAT+T179n46LudnUU4oFGz25f4HzX4dK2YietTSqfrg==
X-Received: by 2002:a17:902:24d:: with SMTP id 71mr2704191plc.225.1544200882597;
        Fri, 07 Dec 2018 08:41:22 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id i123sm6260775pfg.164.2018.12.07.08.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 08:41:21 -0800 (PST)
Message-ID: <1544200879.185366.314.camel@acm.org>
Subject: Re: [PATCH v3] blk-mq: punt failed direct issue to dispatch list
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ming Lei <ming.lei@redhat.com>
Date:   Fri, 07 Dec 2018 08:41:19 -0800
In-Reply-To: <7eaf8a39-3628-e153-79c9-0f115a4392d4@kernel.dk>
References: <aa6abfa7-30c3-57d7-7369-754d514584f5@kernel.dk>
         <1544199585.185366.303.camel@acm.org>
         <693ac87a-ebb5-2e4e-25e5-92a1d3865c8f@kernel.dk>
         <7eaf8a39-3628-e153-79c9-0f115a4392d4@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2018-12-07 at 09:35 -0700, Jens Axboe wrote:
+AD4 diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
+AD4 index 29bfe8017a2d..9e5bda8800f8 100644
+AD4 --- a/block/blk-mq-sched.c
+AD4 +-+-+- b/block/blk-mq-sched.c
+AD4 +AEAAQA -377,6 +-377,16 +AEAAQA void blk+AF8-mq+AF8-sched+AF8-insert+AF8-request(struct request +ACo-rq, bool at+AF8-head,
+AD4  
+AD4  	WARN+AF8-ON(e +ACYAJg (rq-+AD4-tag +ACEAPQ -1))+ADs
+AD4  
+AD4 +-	/+ACo
+AD4 +-	 +ACo It's illegal to insert a request into the scheduler that has
+AD4 +-	 +ACo been through -+AD4-queue+AF8-rq(). Warn for that case, and use a bypass
+AD4 +-	 +ACo insert to be safe.
+AD4 +-	 +ACo-/

Shouldn't this refer to requests that have been prepared instead of requests
that have been through -+AD4-queue+AF8-rq()? I think this function is called for
requests that are requeued. Requeued requests have been through -+AD4-queue+AF8-rq()
but are unprepared before being requeued.

Thanks,

Bart.
