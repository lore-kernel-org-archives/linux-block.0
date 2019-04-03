Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D4BC4360F
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6572F206DF
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 16:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbfDCQuA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:50:00 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41013 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfDCQuA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Apr 2019 12:50:00 -0400
Received: by mail-pl1-f193.google.com with SMTP id d1so6630013plj.8
        for <linux-block@vger.kernel.org>; Wed, 03 Apr 2019 09:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOGBumKUS4dixVx3Tlr7fGXYQrqgJQ7yhbmUcjQwaew=;
        b=PHuTfgqDmLClgTbMyCLLfR0Wa9cmV1eyYBbTcQoPuOiihgFSCVr+21gHzUxAN6HCsl
         0QdGGQJIkhNDjSy/56qPqa2/Mu70Q7aWVN+XMsEjmBa/9o0JbLKjra8Zy6bSziawKj1U
         BCyCKejCPOYAcqU/Qc51bcxSji+PCz/Y9LNWBoxBSFUUnkTwJmps8+eh5fZCJEnveWFr
         AtaSpipig9/1KMwGxLjJF1YYFpE2IE4LM2Xl/cNHs+6f1kuwqomxDZSfJJSI3j5XRQ+r
         XGSh6Be9EBV2IUGOGlZEBIQ+LtECKjnWC4y+mwbP6jx8NaUDcQfnNgfWq+lDv6hRsjDN
         BxvQ==
X-Gm-Message-State: APjAAAWBnn6rx6Vu+AAkum2i4LGo8CqHzlUlCRgvDWkyEKcQvqndviJ5
        1zw9qTfE1Yf4OZfXVyJB6N0=
X-Google-Smtp-Source: APXvYqzHTQ8nu2pqNeYqvhMZAIflE6NpyrXcuoVwhpBRsL/Wh3rlEp6AkbLj4g7m7hnbRGH5u5UPNA==
X-Received: by 2002:a17:902:1123:: with SMTP id d32mr1048942pla.16.1554310199566;
        Wed, 03 Apr 2019 09:49:59 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id l63sm24838455pfc.89.2019.04.03.09.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 09:49:58 -0700 (PDT)
Message-ID: <1554310197.118779.225.camel@acm.org>
Subject: Re: [PATCH v2] block: don't show io_timeout if driver has no
 timeout handler
From:   Bart Van Assche <bvanassche@acm.org>
To:     Weiping Zhang <zwp10758@gmail.com>
Cc:     Weiping Zhang <zhangweiping@didiglobal.com>,
        Jens Axboe <axboe@kernel.dk>, hch@infradead.org,
        linux-block@vger.kernel.org
Date:   Wed, 03 Apr 2019 09:49:57 -0700
In-Reply-To: <CAA70yB65t+yCcysDUvYCdcpto1BUio0a1woXkzVL7=efJ5FtJw@mail.gmail.com>
References: <20190402131424.GA12935@192.168.3.9>
         <1554217543.118779.130.camel@acm.org>
         <CAA70yB65t+yCcysDUvYCdcpto1BUio0a1woXkzVL7=efJ5FtJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2019-04-03 at 18:48 +-0800, Weiping Zhang wrote:
+AD4 Could you point out the race case for udev?

Hi Weiping,

A quote from Documentation/kobject.txt:

+ACI-Use the KOBJ+AF8-ADD action for when the kobject is first added to the kernel.
This should be done only after any attributes or children of the kobject
have been initialized properly, as userspace will instantly start to look
for them when this call happens.+ACI

You may want to have a look at commit 33b14f67a4e1 (+ACI-nvme: register ns+AF8-id
attributes as default sysfs groups+ACI) as an example of a patch that fixes a
race condition between sysfs attribute creation and udev.

Regarding the block layer timeout attribute: I just noticed that for the
request queue kobj attribute KOBJ+AF8-ADD is triggered explicitly from
blk+AF8-register+AF8-queue():

	kobject+AF8-uevent(+ACY-q-+AD4-kobj, KOBJ+AF8-ADD)+ADs

Your patch adds sysfs attributes before that code is encountered so it should
be fine.

Bart.
