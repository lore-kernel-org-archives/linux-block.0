Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AEBC6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD702084C
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD702084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLKXJa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:09:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33384 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeLKXJ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:09:29 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so7366849pgu.0
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 15:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dWP3mQsqj+4/Hh2q+VMnOMRAraMb8P6gfH0O9wqesgE=;
        b=BXtzk0JPdvOyHfEWklClJZHYzPEcwpS67IZocI+Q1hKaeSP/LVCJgbXsNnNZvR4wn5
         CYIwVRObgORzzOVi5ja6+AMz77r7by9LRQybrkCSjKFvwVTWX4Xwq7oAw//AtWeVPLZN
         YZHCPE/baXs8I0QMHt6hDaujy54vB8sDvVbOKs4HduB6HSDrtq73LUBIzEVRWa5gdik+
         3MiBRD5O+SrpsDkq+kwWXDfzVblh41stPSt25KNvj6dPHBtKZTXmS8X5WH8V7Q/FZ+V8
         7IDU9c6g/WcebjoZJ8Gjf95U+GfSju8wXbMnK5isuPkqRUbpmW0IdStuBpWeKw63/A4o
         XOng==
X-Gm-Message-State: AA+aEWa+ZZT6F3xaNY++r71MXp7XbrWE40fa20xxpuQaXZeqfQ2WshfX
        VSSWqhw05bs5enXnpqeJOe58NlobD9E=
X-Google-Smtp-Source: AFSGD/X4QJChxgrjIsYR8+o1ZuOWwxpuHMh7A8rpVA6pX0BiMBTilGI0F2tpnlpAajVkhbdyj7gmCA==
X-Received: by 2002:a63:d547:: with SMTP id v7mr16063941pgi.339.1544569768994;
        Tue, 11 Dec 2018 15:09:28 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id x2sm21267489pfx.78.2018.12.11.15.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 15:09:28 -0800 (PST)
Message-ID: <1544569767.185366.393.camel@acm.org>
Subject: Re: for-next hangs on test srp/012
From:   Bart Van Assche <bvanassche@acm.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        dm-devel@redhat.com
Date:   Tue, 11 Dec 2018 15:09:27 -0800
In-Reply-To: <20181211230514.GA20445@redhat.com>
References: <1544569107.185366.391.camel@acm.org>
         <20181211230514.GA20445@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2018-12-11 at 18:05 -0500, Mike Snitzer wrote:
+AD4 On Tue, Dec 11 2018 at  5:58pm -0500,
+AD4 Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 
+AD4 +AD4 Hi Jens,
+AD4 +AD4 
+AD4 +AD4 If I run the following subset of blktests:
+AD4 +AD4 
+AD4 +AD4   while :+ADs do ./check -q srp +ACYAJg ./check -q nvmeof-mp+ADs done
+AD4 +AD4 
+AD4 +AD4 against today's for-next branch (commit dd2bf2df85a7) then after some
+AD4 +AD4 time the following hang is reported:
+AD4 
+AD4 Jens has applied a fix from me today that I think is very relevant+ADs
+AD4 it'll be in tomorrow's for-next:
+AD4 
+AD4 http://git.kernel.dk/cgit/linux-block/commit/?h+AD0-for-4.21/block+ACY-id+AD0-c4576aed8d85d808cd6443bda58393d525207d01
+AD4 
+AD4 Please try with that and see how things go.

Hi Mike,

Thank you for your reply. I should have mentioned that I used Jens' for-next
branch as starting point and that that commit is present in the branch I used
as a starting point for my tests:

+ACQ git branch --contains c4576aed8d85d808cd6443bda58393d525207d01    
+ACo axboe-block-for-next

Bart.

