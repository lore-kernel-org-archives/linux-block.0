Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796CEC43444
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 16:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4641220645
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 16:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbfAOQ5b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:57:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39410 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbfAOQko (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jan 2019 11:40:44 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so1455236pgl.6
        for <linux-block@vger.kernel.org>; Tue, 15 Jan 2019 08:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MnUMQKfmpqPrNgt1v1amnwGUjNngd4NfzjUoApmpKzg=;
        b=I0Zb+Lw1OllWbTr0Wm36NLduWGcjBp1okp1Eg7GxzYZzrJgehXqRyvHUSZ69ic/t7i
         VsI+RP4sol6ltSe3WQGMVhPdDNHXdCfggPPm9dO75WMQSMEeRhiRHZTKGbtxYHgZtl7k
         yjld+8TSBi5I1SVgXrqeKVhzc0FasszePfl/IBZx4J37mmB0Whz0YwJSjBMut5b9SS7Y
         yUP0dqkarf2MUtdDws1pgCDwK+AZLgfIVjQh6P+PuoodYWf5hcapx+rziuyObyWhoSHM
         XRomG2T9bw2gGInXwSbGK9ChLRjYY7nUhWE1JalpjJ4JNPj6jEKrdNbjB8x82thJOGoU
         yqAg==
X-Gm-Message-State: AJcUukfDAqf5udn7/KZylGkPrOXsz3Gl9a+0FCbNIOndDemT5qpvnXc5
        iwOLKpoQIveF5YGcmQr9bsjx/Z4e
X-Google-Smtp-Source: ALg8bN5wnkQnKR/4i6397YdZ6ehCeC5Gbp/k4t0Si6hzHqPSuK/hc+IfOBbPKYdT+8MCKOyyMpK3Pg==
X-Received: by 2002:a62:1f9d:: with SMTP id l29mr4940545pfj.14.1547570443572;
        Tue, 15 Jan 2019 08:40:43 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id s2sm6085703pfa.167.2019.01.15.08.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 08:40:42 -0800 (PST)
Message-ID: <1547570441.83374.112.camel@acm.org>
Subject: Re: [PATCH 1/3] blktests: add cgroup2 infrastructure
From:   Bart Van Assche <bvanassche@acm.org>
To:     Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
        kernel-team@fb.com, osandov@fb.com
Date:   Tue, 15 Jan 2019 08:40:41 -0800
In-Reply-To: <1211bf78-c442-ea71-9e71-f6d86681ed56@acm.org>
References: <20181204174733.7423-1-josef@toxicpanda.com>
         <20181204174733.7423-2-josef@toxicpanda.com>
         <1211bf78-c442-ea71-9e71-f6d86681ed56@acm.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-01-01 at 19:13 -0800, Bart Van Assche wrote:
+AD4 On 12/4/18 9:47 AM, Josef Bacik wrote:
+AD4 +AD4 In order to test io.latency and other cgroup related things we need some
+AD4 +AD4 supporting helpers to setup and tear down cgroup2.  This adds support
+AD4 +AD4 for checking that we can even configure cgroup2 things, set them up if
+AD4 +AD4 need be, and then add the cleanup stuff to the main cleanup function so
+AD4 +AD4 everything is always in a clean state.
+AD4 
+AD4 Is this the patch that went in as commit ae7daae7e35a (+ACI-blktests: add 
+AD4 cgroup2 infrastructure+ACI)? I think that commit introduced a regression. 
+AD4 With that patch applied the SRP tests fail as follows:
+AD4 
+AD4 +ACM ./check -q srp/001
+AD4 srp/001 (Create and remove LUNs)
+AD4      runtime  4.067s  ...
+AD4 common/cgroup: line 25: CGROUP2+AF8-DIR: unbound variable
+AD4 
+AD4 Is this a known issue?

Hi Josef,

Had you noticed this e-mail?

Thanks,

Bart.
