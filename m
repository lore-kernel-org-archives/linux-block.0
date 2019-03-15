Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10230C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CC3218A1
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 16:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbfCOQTI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:19:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41330 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfCOQTH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 12:19:07 -0400
Received: by mail-pf1-f195.google.com with SMTP id d25so6672525pfn.8;
        Fri, 15 Mar 2019 09:19:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRvu+G8ug8+5vTKCte4q4HWLddoOJc2SzP36FOtasqk=;
        b=srwqnUOs00pYmaQ9S29sYCcgpPbiqnQe9JmprGDCrJKT8kxmDxO0saFHrCwCqeBnOr
         ZbsRZw4DfLBnxegtFejN2EgpK/H7C/fPtf6w6eT2+b1kLodZxc6OLMnAfc5Rgejg+YrN
         c073VEeI2uzIAVsWJ/L2Zjtnly/z8tuz6ywAyWQctWk4QQaxrg8h7xyEfmtzoKX5rPqF
         2bkMC9+Ho13tTcQuonz1aSFMqo14pY0DbIWd8kwJNBjmMX1/bQawtq79M/fqQ/rTHO32
         fE8kva5uNJEi2RBsZ7eg6QsSYOkTi4BTB/nrRUu+qXCv1hW7V3F6LqEIFxgL+GpngsOY
         RlOA==
X-Gm-Message-State: APjAAAVPdub7C+wUcD5vAMb/lSCSo8RZTIgnMpM2HyOGhwb7j9vI0gbU
        uBuXn5HCv18MiD+Q+a0COGs=
X-Google-Smtp-Source: APXvYqyXvkV5j22cA33UXZzOjZ4yukDdes4z00vBK/fYv0zVskzgARlZwJpUVx908kErWQu1ET4z0g==
X-Received: by 2002:a63:6ecb:: with SMTP id j194mr4354525pgc.250.1552666746704;
        Fri, 15 Mar 2019 09:19:06 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h63sm8448897pfd.148.2019.03.15.09.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 09:19:05 -0700 (PDT)
Message-ID: <1552666744.45180.135.camel@acm.org>
Subject: Re: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
From:   Bart Van Assche <bvanassche@acm.org>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jsmart2021@gmail.com,
        josef@toxicpanda.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, keith.busch@intel.com, hare@suse.de,
        jthumshirn@suse.de, sagi@grimberg.me
Date:   Fri, 15 Mar 2019 09:19:04 -0700
In-Reply-To: <a36be8bd-bb9c-745e-cfdb-018cf0a96d42@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
         <20190315092020.GA2405@lst.de>
         <a36be8bd-bb9c-745e-cfdb-018cf0a96d42@oracle.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-03-15 at 17:44 +-0800, jianchao.wang wrote:
+AD4 On 3/15/19 5:20 PM, Christoph Hellwig wrote:
+AD4 +AD4 On Fri, Mar 15, 2019 at 04:57:36PM +-0800, Jianchao Wang wrote:
+AD4 +AD4 +AD4 Hi Jens
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 As we know, there is a risk of accesing stale requests when iterate
+AD4 +AD4 +AD4 in-flight requests with tags-+AD4-rqs+AFsAXQ and this has been talked in following
+AD4 +AD4 +AD4 thread,
+AD4 +AD4 +AD4 +AFs-1+AF0 https://urldefense.proofpoint.com/v2/url?u+AD0-https-3A+AF8AXw-marc.info+AF8--3Fl-3Dlinux-2Dscsi-26m-3D154511693912752-26w-3D2+ACY-d+AD0-DwICAg+ACY-c+AD0-RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI+AF8-JnE+ACY-r+AD0-7WdAxUBeiTUTCy8v-7zX
+AD4 +AD4 +AD4 yr4qk7sx26ATvfo6QSTvZyQ+ACY-m+AD0-CydqJPTf4FUrfs7ipUc2chm2jGuNuDVn+AF8-onIetKEehM+ACY-s+AD0-ZQ7RfO6-737-t5kQv7SFlXMhIdpwn+AF8-AxJI93d6c-nj0+ACY-e+AD0
+AD4 +AD4 +AD4 +AFs-2+AF0 https://urldefense.proofpoint.com/v2/url?u+AD0-https-3A+AF8AXw-marc.info+AF8--3Fl-3Dlinux-2Dblock-26m-3D154526189023236-26w-3D2+ACY-d+AD0-DwICAg+ACY-c+AD0-RoP1YumCXCgaWHvlZYR8PZh8Bv7qIrMUB65eapI+AF8-JnE+ACY-r+AD0-7WdAxUBeiTUTCy8v-7z
+AD4 +AD4 +AD4 Xyr4qk7sx26ATvfo6QSTvZyQ+ACY-m+AD0-CydqJPTf4FUrfs7ipUc2chm2jGuNuDVn+AF8-onIetKEehM+ACY-s+AD0-EBV1M5p4mE8jZ5ZD1ecU5kMbJ9EtbpVJoc7Tqolrsc8+ACY-e+AD0
+AD4 +AD4 
+AD4 +AD4 I'd rather take one step back and figure out why we are iterating
+AD4 +AD4 the busy requests.  There really shouldn't be any reason why a driver
+AD4 +AD4 is even doings that (vs some error handling helpers in the core
+AD4 +AD4 block code that can properly synchronize).
+AD4 +AD4 
+AD4 
+AD4 A typical scene is blk+AF8-mq+AF8-in+AF8-flight,
+AD4                           
+AD4 blk+AF8-mq+AF8-get+AF8-request         blk+AF8-mq+AF8-in+AF8-flight
+AD4   -+AD4 blk+AF8-mq+AF8-get+AF8-tag        -+AD4 blk+AF8-mq+AF8-queue+AF8-tag+AF8-busy+AF8-iter
+AD4                              -+AD4 bt+AF8-for+AF8-each
+AD4                                -+AD4 bt+AF8-iter
+AD4                                  -+AD4 rq +AD0 taags-+AD4-rqs+AFsAXQ
+AD4                                  -+AD4 rq-+AD4-q       //---+AD4 get a stale request
+AD4   -+AD4 blk+AF8-mq+AF8-rq+AF8-ctx+AF8-init
+AD4     -+AD4 data-+AD4-hctx-+AD4-tags-+AD4-rqs+AFs-rq-+AD4-tag+AF0 +AD0 rq
+AD4 
+AD4 This stale request maybe something that has been freed due to io scheduler
+AD4 is detached or a q using a shared tagset is gone.
+AD4 
+AD4 And also the blk+AF8-mq+AF8-timeout+AF8-work could use it to pick up the expired request.
+AD4 The driver would also use it to requeue the in-flight requests when the device is dead.
+AD4 
+AD4 Compared with adding more synchronization, using static+AF8-rqs+AFsAXQ directly maybe simpler :)

Hi Jianchao,

Although I appreciate your work: I agree with Christoph that we should avoid races
like this rather than modifying the block layer to make sure that such races are
handled safely.

Thanks,

Bart.
