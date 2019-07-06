Return-Path: <SRS0=GXCF=VD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5888BC0650E
	for <linux-block@archiver.kernel.org>; Sat,  6 Jul 2019 18:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BE4020838
	for <linux-block@archiver.kernel.org>; Sat,  6 Jul 2019 18:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oTZtAUoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfGFSro (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Jul 2019 14:47:44 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:39915 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbfGFSro (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Jul 2019 14:47:44 -0400
Received: by mail-pl1-f175.google.com with SMTP id b7so6120541pls.6
        for <linux-block@vger.kernel.org>; Sat, 06 Jul 2019 11:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=F1aK7B2lFTi7PxmV0UUUKGw/dtT36IEQUyQRNofgAws=;
        b=oTZtAUoh6C4AtwWPw5eQoXw5qeksDE8d+WYdva2mjN2/1YXC/xGAfCE4JYOtCJfYJp
         PO8qskjnfWIGKH+cKSN49XTcHk/dhiPxRo13LOb1CRCCXcXXlBinr6h5qItTaQ8oHn+L
         PHHSTsegYs9DH9jdQmS3z8ihuCeKN0e3sMLK9rKZCZgU7KAh0p3kGHDkrgpb4l/dwbDf
         Q7jNjZbhnASgNO5EMB6pAuNmKxN3Cn0uUbTDwA5PFGQrOV4HGIDsMEufnI+PU4hONMg/
         3NrtcUYeYbZ0svG8O8NEojRrc4eKPJvSRWPC66f9RzoT50lBV61o9RGtHzoQSDsMT0Hl
         CS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=F1aK7B2lFTi7PxmV0UUUKGw/dtT36IEQUyQRNofgAws=;
        b=VI2iffrK0EjI5gUHdJS61nCyjHAHRfsIBDQ8WPB7YKtbjTFi4a2NKUovDhTNXppwWO
         6ewvEP578Txv54IQ8ywYKOc3i05z7acBaTwsZbpQSlOlpGIEp1eYZCGQGU4otJCiWL/p
         GD24x2929sz7p5++Gh7u+I7qVTgY4X/LAElWTB5IeEw0E1vDT5mv42/z2BoyCr528WUJ
         OIzSFYHNJr+iI7DIE3eVUAWn0TRg8Q1Xw3a3yFJ+uJAZi5kOwFGqtS8mPrJx8sCP6jtq
         iyNocH8kEz7szVRWgO7A1up8FqHtekKayQtuePCFHwJHBWPxoOi0ivBwydE5Kg4fhM0Q
         AkGA==
X-Gm-Message-State: APjAAAU93mNVnITrJUnjPDgTqjJBwi6le2cJQqQ58ux9qxIKg1mtoWQU
        ECvUv1xA+L1WUs9DC27zpiIclw==
X-Google-Smtp-Source: APXvYqz3oUKPtG5A+SuPHx/VW/p92rA7qlZ3GBj3dsGUrO17l100tvo1ee8vVM33y+3+txkEZsrLGw==
X-Received: by 2002:a17:902:29c3:: with SMTP id h61mr12658792plb.37.1562438863402;
        Sat, 06 Jul 2019 11:47:43 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 23sm15647067pfn.176.2019.07.06.11.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jul 2019 11:47:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Single block fix for 5.2-final
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <c6d22c16-de8e-396c-6a17-982498f3e93f@kernel.dk>
Date:   Sat, 6 Jul 2019 12:47:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a single fix for a patch from Greg KH, which reportedly break
block debugfs locations for certain setups. Trivial enough that I think
we should include it now, rather than wait and release 5.2 with it,
since it's a regression in this series.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190706


----------------------------------------------------------------
Greg Kroah-Hartman (1):
      blk-mq: fix up placement of debugfs directory of queue files

 block/blk-mq-debugfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
Jens Axboe

