Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF8CC04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6941120878
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 18:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6941120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbeLFSCE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:02:04 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:43532 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFSCD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 13:02:03 -0500
Received: by mail-pg1-f172.google.com with SMTP id v28so471820pgk.10
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 10:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vuPoCWxHnkqp3gAyy+muhBVDStWdCEwdR529shXOJoo=;
        b=Ha98lUnFOPUWbRqFEyS5d5ZgAzIEuH3ufpWOiDVImcRjrBN3XzM2L5GZnQUng7Aq9J
         ih9ZzEod46chtL8ps71DD8Q+K6umkGUQutlOI1xz1luw58GaU66wDa5ErzYFQlC85j9y
         UmUAAhAfFiox6P4dMtpUPGkJA2BO6cqenReJq+sYvnkSIkHbGJgPnB89cpYzqOQAJxNT
         TGq/LJGxFkqsXN7uFcHSbtR12PKftyGSjx1o532qfU63zEsfGW6kOyaEQq4xlQIrM86R
         LtCIOdxVt0PgsdEldj1IpGjdpE9Efsiw/TZ5ECFSWpbLn7dG4FqSeav6JX839+dI/lXm
         6S3A==
X-Gm-Message-State: AA+aEWYO1hxNu23EL44okkQwA/K9RKjBt5OG9EAgLqrUAXaWj78N1Ryh
        5hCvxR9J/Z/VbREfhu1MRJU=
X-Google-Smtp-Source: AFSGD/Wmx9K7aSCstRlEUcx3mMaI2rXdajJTwrYbPDbM+OsAHeYFPHXiZSe5R7ImkllQ8gb6pq0SNw==
X-Received: by 2002:aa7:81d0:: with SMTP id c16mr29170553pfn.153.1544119322940;
        Thu, 06 Dec 2018 10:02:02 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id g15sm4952703pfj.131.2018.12.06.10.02.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 10:02:02 -0800 (PST)
Message-ID: <1544119321.185366.277.camel@acm.org>
Subject: Re: for-next branch and blktests/srp
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>
Date:   Thu, 06 Dec 2018 10:02:01 -0800
In-Reply-To: <a73ef579-e4e8-f245-b203-1b52eb41af78@kernel.dk>
References: <1544114872.185366.250.camel@acm.org>
         <41bbac1e-7461-4378-a18d-531b625d6784@kernel.dk>
         <1544116771.185366.261.camel@acm.org>
         <707b709c-547f-b330-bd37-29b8fc427827@kernel.dk>
         <a73ef579-e4e8-f245-b203-1b52eb41af78@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2018-12-06 at 10:48 -0700, Jens Axboe wrote:
+AD4 which would result in a non-zero exit, which should be expected for this
+AD4 test?

Hi Jens,

Test srp/002 simulates network failures while running fio on top of dm-mpath.
Since queue+AF8-if+AF8-no+AF8-path is enabled in multipath.conf dm-mpath will keep retrying
the block layer requests it receives if these requests fail due to path removal.
If fio reports +ACI-io+AF8-u error+ACI for this test then that means that the test failed.
I haven't seen fio reporting any I/O errors for this test with any upstream
kernel that I tested in the past year or so.

Bart.
