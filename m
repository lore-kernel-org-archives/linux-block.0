Return-Path: <SRS0=B8lj=SL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EBFC282CE
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 15:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 066F820833
	for <linux-block@archiver.kernel.org>; Tue,  9 Apr 2019 15:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfDIPBt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:01:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39164 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfDIPBs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Apr 2019 11:01:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id i17so6735541pfo.6;
        Tue, 09 Apr 2019 08:01:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7K1Wn40ooEanrHCsFiC2WKAdywLT6zbMPEC8fyLOwO8=;
        b=PReB+HNUbmyvUPq/vByIF4HV8FyCc1Aw14Xx8YKj4VGxJv9Wjnxxx9H0thNzKbaN6Z
         hOVYC6BZ6U1hIo05i/mNq1HiO/Hz92uqd4tvCh/F4Ex9jtUp+l2bBSL03AaAZZPjqyeh
         sfyfcYGrjRN0n+rmQ2Vqn8IZTEaRs2xwwgIdZUEmOS8KAcUKI7gL6+5hZBU5dnbHAkvp
         H3a9odoCCX8TRl/g9rpSth5ck5LwJiLS1h3jj+KyqAUlGseVCXQM57HoDgaWhs3VISYy
         Rv18L4ydHRFSx1vMEEU1TfEfF9QmAvLTtbufAOhdM3yOY26O9OwRyTfJSGFhhByDKAVd
         b6xw==
X-Gm-Message-State: APjAAAW/+8RFdimR0/+Cq8IqbPH6GLg/YTnz+Sdk2TpakX94l28H802N
        dOjX1LGDs5pG8PMNx8g+McQvmr7eMdQ=
X-Google-Smtp-Source: APXvYqz6FQXRMDdENvwHleub4t/z7+1Msuax6iRMcZUo4nyE4TPJ4qQ/torGZvadweUpbXPxmitbnw==
X-Received: by 2002:a62:1a06:: with SMTP id a6mr37324779pfa.18.1554822108047;
        Tue, 09 Apr 2019 08:01:48 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l69sm46126668pga.73.2019.04.09.08.01.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 08:01:46 -0700 (PDT)
Message-ID: <1554822105.161891.2.camel@acm.org>
Subject: Re: [PATCH v2] fs/block_dev.c: remove unused include
From:   Bart Van Assche <bvanassche@acm.org>
To:     Chengguang Xu <cgxu519@gmx.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk
Date:   Tue, 09 Apr 2019 08:01:45 -0700
In-Reply-To: <20190409103752.28532-1-cgxu519@gmx.com>
References: <20190409103752.28532-1-cgxu519@gmx.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-04-09 at 18:37 +-0800, Chengguang Xu wrote:
+AD4 Just remove unused include +ADw-linux/badblocks.h+AD4 from
+AD4 fs/block+AF8-dev.c.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4


