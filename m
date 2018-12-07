Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48339C04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 00:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 172EB20989
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 00:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 172EB20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbeLGAbe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:31:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40300 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGAbd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 19:31:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so1005513pfo.7
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 16:31:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y/AYb6DBi9gpjZPJasWRq26K+cC373ofz3IfA8x38i0=;
        b=kgypBzu8TV51JBKybrEX7384fIqaepmankLMIvicaOFGlrRBLOggSFIktjTl7jZOdq
         jpDg2xVn3k8ylYl2JgSVVnI33dMq0BM4upg4pXFTsUN5d9H0s3dUvl1RNrN1a1QNHBa5
         tMuf1+HquUZpekSiZrVmx+K6SgVFNF8+UahXdxyfsVOG6bf0Rt9Vvwl4N0TAtw6rBM6y
         HyZRBwVLcxjVXrF2sfHZqBpuqHZPfmyojUsEUV0+WJ1VleGOimBfxZhpoLG1KFjzq8U/
         VUtEFy79D8TFS1Pv8l90YiboGz/SA8fekuDeQgFt+dwYFsvhMegUTLnt7cWvHqZPkg5d
         e9Qw==
X-Gm-Message-State: AA+aEWa4Z8ZoksYvS+2KWGpMuK9nWJIsClIYHOMm3p8a8LD7T8+gpOTF
        UaMcYLILolv5kc4xPs5onY8=
X-Google-Smtp-Source: AFSGD/V0equFEb6lOASFDXg0JKw2ibfNaRIrmWDFsZkSqjRcdekYJ8gH8CO06wjKyzY2V0yeWcSAmQ==
X-Received: by 2002:a63:5518:: with SMTP id j24mr93210pgb.208.1544142692836;
        Thu, 06 Dec 2018 16:31:32 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 196sm3110190pfc.77.2018.12.06.16.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 16:31:31 -0800 (PST)
Message-ID: <1544142690.185366.296.camel@acm.org>
Subject: Re: [GIT PULL] Follow up block fix
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Thu, 06 Dec 2018 16:31:30 -0800
In-Reply-To: <ee93d591-3476-dff1-590a-6ea74efd8f8b@kernel.dk>
References: <fd37a010-d44e-dab7-4e39-059a339091eb@kernel.dk>
         <1544142034.185366.293.camel@acm.org>
         <ee93d591-3476-dff1-590a-6ea74efd8f8b@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-06 at 17:26 -0700, Jens Axboe wrote:
+AD4 On 12/6/18 5:20 PM, Bart Van Assche wrote:
+AD4 +AD4 Which branch does that tag correspond to? Even after having run git fetch
+AD4 +AD4 --tags I can't find that tag in your repository.
+AD4 
+AD4 I pushed it before I sent the email, where are you looking?
+AD4 
+AD4 http://git.kernel.dk/cgit/linux-block/tag/?h+AD0-for-linus-20181206

On my development system git has been configured to fetch from the following repository:
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/

Should I fetch your branches from the git.kernel.dk repository instead?

Thanks,

Bart.
