Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8EDC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E885E20878
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E885E20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbeLFRTf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:19:35 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37094 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeLFRTf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 12:19:35 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so494306pfb.4
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 09:19:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YppyoTWb9j+zmtta/cIhrwqsQnUnD6zwXceEsn+tWpQ=;
        b=nCGhoGY7M45Q3iX6hO/8+hlYC+cJVXYumhGG+dYXWWD3qUqQdGeecRBOwZbrPlCl19
         GBnLUgDzgdsRThW9cNkvh/fXeqvPsJuXz3Bi/IzL5Z785+0olW77q0tCEfjaoi/kEiEI
         6yhI2/FtvkBbJ2eqpIa+kdOVkIdElchryPwPBeLo5aBOU9QM8ZR/yLVQi9giGA8+yBHe
         GxDNJQCOq7nnCMcZ5DIqdCDw/QCIbAHNW2FZn9gmW034BD1nNPuUK6g/4abF0NWvqGkC
         d/gmK4n9x+GYMsqsmKaozuIhWVMcoCRpiUU+RT4WyD5hhdsfor/d3OKxDrmmaMfeE/az
         vdtA==
X-Gm-Message-State: AA+aEWY/Slu7kxp54+y3by5YtqZziWbyzMHlkhFxyHlAeh2cJnJH1IlC
        MhfGHhZEPdvyfcKSxNr/j+c=
X-Google-Smtp-Source: AFSGD/XY6gh7ZCBbKrEKei+6fxRcgR1K7TVliKmGM2Wl2XAPBCBjvJCd4y8NjT+q+fhAlV8l4FXqqA==
X-Received: by 2002:a63:801:: with SMTP id 1mr24476374pgi.275.1544116774200;
        Thu, 06 Dec 2018 09:19:34 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id n22sm1496517pfh.166.2018.12.06.09.19.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 09:19:32 -0800 (PST)
Message-ID: <1544116771.185366.261.camel@acm.org>
Subject: Re: for-next branch and blktests/srp
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Date:   Thu, 06 Dec 2018 09:19:31 -0800
In-Reply-To: <41bbac1e-7461-4378-a18d-531b625d6784@kernel.dk>
References: <1544114872.185366.250.camel@acm.org>
         <41bbac1e-7461-4378-a18d-531b625d6784@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-06 at 10:00 -0700, Jens Axboe wrote:
+AD4 On 12/6/18 9:47 AM, Bart Van Assche wrote:
+AD4 +AD4 If I merge Jens' for-next branch with Linus' master branch, boot the
+AD4 +AD4 resulting kernel in a VM and run blktests/tests/srp/002 then that test
+AD4 +AD4 never finishes. The same test passes against Linus' master branch. I
+AD4 +AD4 think this is a regression. The following appears in the system log if
+AD4 +AD4 I run that test:
+AD4 
+AD4 You are running that test on a dm device? Can you shed some light on
+AD4 how that dm device is setup?

Hi Jens,

The dm device referred to in my e-mail is a dm-mpath device created by test
srp/002. All parameters of that device are under control of that test script.
From the srp/002 test script:

DESCRIPTION+AD0AIg-File I/O on top of multipath concurrently with logout and login (mq)+ACI

From srp/multipath.conf:

defaults +AHs
	find+AF8-multipaths		no
	user+AF8-friendly+AF8-names	yes
	queue+AF8-without+AF8-daemon	no
+AH0

devices +AHs
	device +AHs
		vendor		+ACI-LIO-ORG+AHw-SCST+AF8-BIO+AHw-FUSIONIO+ACI
		product		+ACI.+ACoAIg
		features	+ACI-1 queue+AF8-if+AF8-no+AF8-path+ACI
		path+AF8-checker	tur
	+AH0
+AH0

Bart.
