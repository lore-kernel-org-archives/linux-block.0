Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3597C04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 00:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C1EB20868
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 00:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1EB20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbeLGAUi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:20:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39286 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeLGAUi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 19:20:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id c72so992471pfc.6
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 16:20:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FCpL2NlNlNJTgYxdgqNvRH1t7pSkO5r8/2i0e1GPM34=;
        b=d+41P+BoQGlGUAIGon48UKcEHGcoJ/XDYGjRW/2wmkiG2Z5FtREK7bo56F4PyouYb3
         jdqrJ9qrla1N8KRxhN/6zqQqd4nB7fL6img5g1hapOAKzclBPxUlOvTJiZL+cPjzaUUz
         JiSz0TelNRaBTueYrSAkKnpSpNDmHdv+j2tbOe4pam2iVuNHbXgHsTU8Cz+A4uFzqY88
         UNAUzgYemmzrV1iJO2laOKImou/vn0n7p52K6/eMY1SkpL6KBvTfKb/WcFSrClQf+CTI
         wc3PcRItTuYQG/u0R566kPxiyJ5Wk9r+IKMPRhSAJN7uw90i0ILFeJPIYe099qvLM9Qb
         /7zg==
X-Gm-Message-State: AA+aEWbsf9P1oDpNkLVhDmZLTolKzvzT+HJzcU7JhSKCw+C5dGmIqnXS
        rlqxDgLO7YJryRVMN3gSL1xV7lHB9MA=
X-Google-Smtp-Source: AFSGD/WxuG28GC/xziaAwzGf+Pd3bTiq/MUbkP1Tyl130xgucWEsjQhoUmDOQIlGtv6YkqsY41hdlw==
X-Received: by 2002:a62:5e41:: with SMTP id s62mr73939pfb.232.1544142036561;
        Thu, 06 Dec 2018 16:20:36 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s21sm3814518pfk.133.2018.12.06.16.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 16:20:35 -0800 (PST)
Message-ID: <1544142034.185366.293.camel@acm.org>
Subject: Re: [GIT PULL] Follow up block fix
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date:   Thu, 06 Dec 2018 16:20:34 -0800
In-Reply-To: <fd37a010-d44e-dab7-4e39-059a339091eb@kernel.dk>
References: <fd37a010-d44e-dab7-4e39-059a339091eb@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-06 at 16:59 -0700, Jens Axboe wrote:
+AD4 Just a single followup fix to the corruption fix from yesterday. We have
+AD4 an exported interface that does direct dispatch, with DM being the sole
+AD4 user of it. Change that to do bypass insert always instead of attempting
+AD4 direct dispatch. This fixes a deadlock that can happen on DM.
+AD4 Additionally, it gets rid of any exported user of direct dispatch, and
+AD4 enables DM to drop any BUSY handling from using the interface.
+AD4 
+AD4 Please pull+ACE
+AD4 
+AD4 
+AD4   git://git.kernel.dk/linux-block.git tags/for-linus-20181206

Hi Jens,

Which branch does that tag correspond to? Even after having run git fetch
--tags I can't find that tag in your repository. Additionally, the patch on
your for-linus branch is missing the +ACI-Cc: stable+ACI and +ACI-Reported-by:+ACI tags
that you had promised to add. Did I look at the wrong branch?

Thanks,

Bart.
