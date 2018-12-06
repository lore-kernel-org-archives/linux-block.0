Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9B2C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 20:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075B62146F
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 20:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 075B62146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbeLFU4r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:56:47 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:40784 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbeLFU4r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 15:56:47 -0500
Received: by mail-pg1-f171.google.com with SMTP id z10so670890pgp.7
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 12:56:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8QNGSohP2oUThlbBnhT8bhpU2XXjCwTYKVwbJOUNV0=;
        b=Zthx5ejWNYvaHwUPFEe3i3xTsgWSspp+guBBCiNbLYJ4RxcNWnTkXEtVXhbb4HIf17
         /dNUmK37suMbmz14CsSFhgUS58jryuKgJwtjYpek1KE76r4qqO/A1PCEN0Dcfs7AzQay
         ByZOXNolkQJWKAeHpXymi2Nr+81fHszv3FGx2V29FKm7t6aex0TVqVpTtKnTYE92OCAf
         QgMBe0YvsFG949em4VZNMPta6dEbVS5agj9q6jF/f1av2/IokoZGXiXJqDv7iIOfxcC+
         kXQcx5mpVIZ93jbqw4PKZ1bP+F24PJZXXxf/inv7SthAsn8ox/nQktuofrZxkZqrMfD9
         15tw==
X-Gm-Message-State: AA+aEWYV35ZYBde5xbG6WuJ2RRK1AKRcy3bpOJyaFqwt0OYfIOzYXzqr
        F4UjTBTepz52Iy+Cp+vHkII=
X-Google-Smtp-Source: AFSGD/Wurhy3JOR/we6+y/PsVOtdBZDPGmoFby2YZB+mt7pn/r56oT665/fmDrK6zLH9xE115CzUNA==
X-Received: by 2002:a63:e545:: with SMTP id z5mr25405080pgj.195.1544129806255;
        Thu, 06 Dec 2018 12:56:46 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id y1sm1476660pfe.9.2018.12.06.12.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 12:56:44 -0800 (PST)
Message-ID: <1544129803.185366.287.camel@acm.org>
Subject: Re: for-next branch and blktests/srp
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Date:   Thu, 06 Dec 2018 12:56:43 -0800
In-Reply-To: <1544114872.185366.250.camel@acm.org>
References: <1544114872.185366.250.camel@acm.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-06 at 08:47 -0800, Bart Van Assche wrote:
+AD4 If I merge Jens' for-next branch with Linus' master branch, boot the
+AD4 resulting kernel in a VM and run blktests/tests/srp/002 then that test
+AD4 never finishes. The same test passes against Linus' master branch. I
+AD4 think this is a regression. The following appears in the system log if
+AD4 I run that test:
+AD4 
+AD4 Call Trace:
+AD4 INFO: task kworker/0:1:12 blocked for more than 120 seconds.
+AD4 Call Trace:
+AD4 INFO: task ext4lazyinit:2079 blocked for more than 120 seconds.
+AD4 Call Trace:
+AD4 INFO: task fio:2151 blocked for more than 120 seconds.
+AD4 Call Trace:
+AD4 INFO: task fio:2154 blocked for more than 120 seconds.

Hi Jens,

My test results so far are as follows:
+ACo With kernel v4.20-rc5 test srp/002 passes.
+ACo With your for-next branch test srp/002 reports the symptoms reported in my e-mail.
+ACo With Linus' master branch from this morning test srp/002 fails in the same way as
  your for-next branch.
+ACo Also with Linus' master branch, test srp/002 passes if I revert the following commit:
  ffe81d45322c (+ACI-blk-mq: fix corruption with direct issue+ACI). So it seems like that
  commit fixed one regression but introduced another regression.

Bart.
