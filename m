Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141F7C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9AE20868
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9AE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725898AbeLFSQ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:16:28 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36877 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeLFSQ2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 13:16:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so537664plr.4
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 10:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZ0HYSEJhuLKakbSWKjTIaELqzLoVoF121BlP30pgvE=;
        b=kA76Xh57GQuRsczZRxJ7D6ktSfH0d7lRN2c58Vrcx6Rk9GKtdTJvcJfVLp7qUkaZn2
         ypXNFNT4bPW7+TOPAFk7/jX2fdT9KBz5Du6PYlW2dDeGNXhzRMvoICKGLHzX3pW/JxDE
         KxCPfC95Xl8Yiq7KuBbX+3/uBqMNGlQbFGJavUsZzINf/sTWpxgD24MYQkW7kztMD/GF
         jRjlkKF41jxFsPGHqokUMPesHa0x7t9vVVzDNTKrS86k1gAnmSLSbODEsMUVrLW6Npaw
         8FVwgWGI4bgKOtem+/nz2hRf5VtkK/r8hM0xnSfspSlEL45VS6GwtiXCXeF9UGf0KwTN
         9LXQ==
X-Gm-Message-State: AA+aEWYzzPpNg3SXla8njtJpujwuBIrSfmnuzepLzwxSrYwoTBjjZfpg
        sULHD2L4fpRGmloV0FEwd0E=
X-Google-Smtp-Source: AFSGD/XcrKg3l+306XO95TUucBQ4mV1rqHwIsuPSsuhoG4Jl/PzYmQda4SjoG99IZv5cuK3NhDQPAg==
X-Received: by 2002:a17:902:7107:: with SMTP id a7mr28995294pll.290.1544120187259;
        Thu, 06 Dec 2018 10:16:27 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h8sm1439567pfo.162.2018.12.06.10.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 10:16:26 -0800 (PST)
Message-ID: <1544120185.185366.282.camel@acm.org>
Subject: Re: for-next branch and blktests/srp
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Date:   Thu, 06 Dec 2018 10:16:25 -0800
In-Reply-To: <a6388520-5037-7a77-4e90-679419d16dbd@kernel.dk>
References: <1544114872.185366.250.camel@acm.org>
         <41bbac1e-7461-4378-a18d-531b625d6784@kernel.dk>
         <1544116771.185366.261.camel@acm.org>
         <707b709c-547f-b330-bd37-29b8fc427827@kernel.dk>
         <a73ef579-e4e8-f245-b203-1b52eb41af78@kernel.dk>
         <1544119321.185366.277.camel@acm.org> <1544119805.185366.279.camel@acm.org>
         <a6388520-5037-7a77-4e90-679419d16dbd@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-06 at 11:12 -0700, Jens Axboe wrote:
+AD4 On 12/6/18 11:10 AM, Bart Van Assche wrote:
+AD4 +AD4 On Thu, 2018-12-06 at 10:02 -0800, Bart Van Assche wrote:
+AD4 +AD4 +AD4 On Thu, 2018-12-06 at 10:48 -0700, Jens Axboe wrote:
+AD4 +AD4 +AD4 +AD4 which would result in a non-zero exit, which should be expected for this
+AD4 +AD4 +AD4 +AD4 test?
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Test srp/002 simulates network failures while running fio on top of dm-mpath.
+AD4 +AD4 +AD4 Since queue+AF8-if+AF8-no+AF8-path is enabled in multipath.conf dm-mpath will keep retrying
+AD4 +AD4 +AD4 the block layer requests it receives if these requests fail due to path removal.
+AD4 +AD4 +AD4 If fio reports +ACI-io+AF8-u error+ACI for this test then that means that the test failed.
+AD4 +AD4 +AD4 I haven't seen fio reporting any I/O errors for this test with any upstream
+AD4 +AD4 +AD4 kernel that I tested in the past year or so.
+AD4 +AD4 
+AD4 +AD4 Hi Jens,
+AD4 +AD4 
+AD4 +AD4 Please also verify that the version of multipath-tools that you are running includes
+AD4 +AD4 the following patch:
+AD4 
+AD4 I installed from apt... Says this:
+AD4 
+AD4 +ACM apt show multipath-tools
+AD4 Package: multipath-tools
+AD4 Version: 0.6.4-5+-deb9u1
+AD4 
+AD4 I can run a self-compiled one, if this one doesn't work.

Please do. I use the following script to build and install multipath-tools
over the Debian binaries:

export LIB+AD0-/lib
apt-get install -y libaio-dev libdevmapper-dev libjson-c-dev librados-dev libreadline-dev libsystemd-dev liburcu-dev
make -s 
make -s install

Bart.
