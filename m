Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553EEC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 20:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227322063F
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 20:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEBU6G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 May 2019 16:58:06 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:43470 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBU6G (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 May 2019 16:58:06 -0400
Received: by mail-pl1-f174.google.com with SMTP id n8so1576730plp.10;
        Thu, 02 May 2019 13:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iz+C3RCLp9HpaaPir9p3FKE0SNn7bTO1gYlGmiRiEQQ=;
        b=eh4Df5nvgyAKsv9AjpP7UEhsRpcSLV4Amfd6frUkp8vv9pUV+4Sr6RQ5Y28rOLtXtD
         Q6r3idFhAHoJyOFfHUr26YAxiJYdntAIaSCK/qOjDb8qIJmpq+8rM5QZMo6PX5d4hTsY
         N/hd7X6e00vMoKwxxTXIeYfEtM5LkzdBDLCjxGg+xUUD/hGS7WHEmIDYyTZmXCfqAHsr
         2FLRt0RpDsBGgjvPOUZw7+Uze78qBl7rMGxbpU8u+9wpPJdEm/BSgjqmEl6A017Fpfqm
         K7OSpL4NLjybinPy1OrFNaEv09plgDMOlgkLgE9i3y0GplkuNJvhoVahSzdBnnjuVQOR
         NBFQ==
X-Gm-Message-State: APjAAAWLWnWu6aF8uu0O6cyT443RPneSZeJDl6I8/MOztfXBMVseIYpP
        i+YUxrDFzbUPX5W7prMqS4U=
X-Google-Smtp-Source: APXvYqwNdMoGkvnp4aaLhhbxBcXKWKBQ1+9cE3yJ1LMiXHa3TTziC+pDsuOP5IHS0vCpBJVgxft23g==
X-Received: by 2002:a17:902:2f:: with SMTP id 44mr5994480pla.137.1556830685467;
        Thu, 02 May 2019 13:58:05 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m16sm104235pfi.29.2019.05.02.13.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 13:58:04 -0700 (PDT)
Message-ID: <1556830683.130741.1.camel@acm.org>
Subject: Re: [PATCH] block: Fix function name in comment
From:   Bart Van Assche <bvanassche@acm.org>
To:     Raul E Rangel <rrangel@chromium.org>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Date:   Thu, 02 May 2019 13:58:03 -0700
In-Reply-To: <20190502194811.200677-1-rrangel@chromium.org>
References: <20190502194811.200677-1-rrangel@chromium.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-05-02 at 13:48 -0600, Raul E Rangel wrote:
+AD4 The comment was out of date.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


