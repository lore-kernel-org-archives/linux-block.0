Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFE1C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0FAD20850
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:10:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FAD20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbeLFSKI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:10:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35361 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeLFSKI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 13:10:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id s198so495207pgs.2
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 10:10:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O5a5LalbuDEnr7q+cXJmBZ57cPpVrI//7b44Vs0ZvmQ=;
        b=mwJ/TGf8/K2vYJjolPfcNLguRwe8DfBPcQQuAHFUSX3+QmKnj/DtRz6JUEf66/anXJ
         fNru+Z4fRT/qsdWprTI19R6wFWcdefl58efwmgpTJy0s5/wC1xMMsiHxre8BmmZrG49v
         UYdYaRevrKMrvErwlHqOGkE0rFdP3jWBpSRoH19bIoe7Ihz7sQlmbw2TtJeF22ix/jqZ
         A4woQ1aFM0BE1U0VKJlv2d4nCPj86iwrvBR8xrgu8jFamZUs+uZRcbLaBdd36km7Apm0
         z5/hayyED1wVRYUkzYMmzQFWd1qIK7k5oUMh6Rl0hJpofEZlNOTvJljVr1n+ml7UoSX+
         Uf+Q==
X-Gm-Message-State: AA+aEWaoB3aqDGc5xhDeeWJQkf28WioLlsA49X5fDDtEinHCHu0h5nPM
        vTwoBc1zY5+KAdEEuYWK3Rs=
X-Google-Smtp-Source: AFSGD/WpShNq8Fp3BYbFb859hKJfIuQyrCSC/NA3kSz1GOmtcUcnssQYo9/EGN9GmGzBAWthzf9GkQ==
X-Received: by 2002:a62:64d7:: with SMTP id y206mr29665620pfb.84.1544119807275;
        Thu, 06 Dec 2018 10:10:07 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m67sm2155525pfm.73.2018.12.06.10.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 10:10:06 -0800 (PST)
Message-ID: <1544119805.185366.279.camel@acm.org>
Subject: Re: for-next branch and blktests/srp
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Date:   Thu, 06 Dec 2018 10:10:05 -0800
In-Reply-To: <1544119321.185366.277.camel@acm.org>
References: <1544114872.185366.250.camel@acm.org>
         <41bbac1e-7461-4378-a18d-531b625d6784@kernel.dk>
         <1544116771.185366.261.camel@acm.org>
         <707b709c-547f-b330-bd37-29b8fc427827@kernel.dk>
         <a73ef579-e4e8-f245-b203-1b52eb41af78@kernel.dk>
         <1544119321.185366.277.camel@acm.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-06 at 10:02 -0800, Bart Van Assche wrote:
+AD4 On Thu, 2018-12-06 at 10:48 -0700, Jens Axboe wrote:
+AD4 +AD4 which would result in a non-zero exit, which should be expected for this
+AD4 +AD4 test?
+AD4 
+AD4 Test srp/002 simulates network failures while running fio on top of dm-mpath.
+AD4 Since queue+AF8-if+AF8-no+AF8-path is enabled in multipath.conf dm-mpath will keep retrying
+AD4 the block layer requests it receives if these requests fail due to path removal.
+AD4 If fio reports +ACI-io+AF8-u error+ACI for this test then that means that the test failed.
+AD4 I haven't seen fio reporting any I/O errors for this test with any upstream
+AD4 kernel that I tested in the past year or so.

Hi Jens,

Please also verify that the version of multipath-tools that you are running includes
the following patch:

From a2675025ae9f652b005345b9082f5042b32c992c Mon Sep 17 00:00:00 2001
From: Bart Van Assche +ADw-bart.vanassche+AEA-sandisk.com+AD4
Date: Fri, 18 Nov 2016 13:33:44 -0800
Subject: +AFs-PATCH+AF0 Avoid that reloading a map sporadically triggers I/O errors

Avoid that reloading a map while there are no paths triggers a flush
and hence unwanted I/O errors if 'queue+AF8-if+AF8-no+AF8-path' is enabled.

Fixes: commit d569988e7528 (+ACI-libmultipath: Fixup 'DM+AF8-DEVICE+AF8-RELOAD' handling+ACI)
Signed-off-by: Bart Van Assche +ADw-bart.vanassche+AEA-sandisk.com+AD4
---
 libmultipath/devmapper.c +AHw 2 +--
 1 file changed, 1 insertion(+-), 1 deletion(-)

diff --git a/libmultipath/devmapper.c b/libmultipath/devmapper.c
index 9b6b0537ba6d..1576dd017d6a 100644
--- a/libmultipath/devmapper.c
+-+-+- b/libmultipath/devmapper.c
+AEAAQA -392,7 +-392,7 +AEAAQA int dm+AF8-addmap+AF8-reload(struct multipath +ACo-mpp, char +ACo-params, int flush)
 			      params, ADDMAP+AF8-RO, SKIP+AF8-KPARTX+AF8-OFF)+ADs
 	+AH0
 	if (r)
-		r +AD0 dm+AF8-simplecmd(DM+AF8-DEVICE+AF8-RESUME, mpp-+AD4-alias, flush,
+-		r +AD0 dm+AF8-simplecmd(DM+AF8-DEVICE+AF8-RESUME, mpp-+AD4-alias, +ACE-flush,
 				 1, udev+AF8-flags, 0)+ADs
 	return r+ADs
 +AH0

