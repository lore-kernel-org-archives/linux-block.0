Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73579C282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 17:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B08620866
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 17:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbfAVRF6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:05:58 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39263 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbfAVRF6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 12:05:58 -0500
Received: by mail-pg1-f195.google.com with SMTP id w6so11334445pgl.6
        for <linux-block@vger.kernel.org>; Tue, 22 Jan 2019 09:05:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=izHNSRlw09v27yjUMeuzMnxiO86JC2a8iLbi4HgCLwQ=;
        b=pfTdvmjIEDt5nkAn5z9FnXc7/GtUPS7jUpKjWNT6qWiozjF4zTeaqEjYAiBwwHFaE1
         Hl61CwpJVfepuzvjww0NNenmCLaxh38YyN83ZhTNE16UXkjDl6o8cSZXA69Yul15wK3s
         be5uJxVvzcquoqiR5+MR416w/itUP99WD8W6I6WSwsmTxJDq0Jry2ij+Jef/jzTugbgg
         J8/AVn3gPx1ZOajn486ke8Pe8XkAh0F/JrgNlplOfY21wtAjMwny+FiVVH2Z+T1HXwi+
         tBN/f6bYi5kuF1qSi02f1DVswwPzgbmL74u5MAhA8rYZ5ewf8khGdFXLQAyLHmrUyIXI
         oGvQ==
X-Gm-Message-State: AJcUukcTKC4eXyjIMeOP6KUVdLQ1JYi+b2OO7JWBnyWShhywRVZfYp8K
        bwr5brT9A/oZo8HN2+Uhr+5LBNUV
X-Google-Smtp-Source: ALg8bN43N28RC1geqaTOthZcdw5OrDu69nFZJxzg284TzYdEaXeoHgeD2MGPdmzCjc6gzdGunV12xg==
X-Received: by 2002:a63:680a:: with SMTP id d10mr32919247pgc.396.1548176757444;
        Tue, 22 Jan 2019 09:05:57 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id o1sm29035333pgn.63.2019.01.22.09.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 09:05:56 -0800 (PST)
Message-ID: <1548176754.9266.50.camel@acm.org>
Subject: Re: RFC bio flags and ops in v4.10+
From:   Bart Van Assche <bvanassche@acm.org>
To:     Ashlie Martinez <ashmrtn@utexas.edu>
Cc:     linux-block@vger.kernel.org
Date:   Tue, 22 Jan 2019 09:05:54 -0800
In-Reply-To: <CAFk8rvaNjaDYddBGmgwAir4S-JkkR__9MhSv3Ep7hQA3-YFkCg@mail.gmail.com>
References: <CAFk8rvbdfzdChGf9jsTT7qPVf7bpW4VH0mys1He8_KjUD5mD2A@mail.gmail.com>
         <7064d8d4-675d-8c40-5f20-b865607d3495@acm.org>
         <CAFk8rvaNjaDYddBGmgwAir4S-JkkR__9MhSv3Ep7hQA3-YFkCg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2019-01-21 at 21:12 -0800, Ashlie Martinez wrote:
+AD4 On Mon, Jan 21, 2019 at 9:04 PM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 
+AD4 +AD4 On 1/21/19 8:45 PM, Ashlie Martinez wrote:
+AD4 +AD4 +AD4 I was working on porting parts of a file system crash consistency
+AD4 +AD4 +AD4 checking tool called CrashMonkey +AFs-1+AF0 to linux kernels 4.9 and 4.14
+AD4 +AD4 +AD4 when I noticed an inconsistency in how the bio-+AD4-bi+AF8-opf field is
+AD4 +AD4 +AD4 treated. According to the comments in /include/linux/blk+AF8-types.h, the
+AD4 +AD4 +AD4 REQ+AF8-OP should be the upper bits in bi+AF8-opf, while the request flags
+AD4 +AD4 +AD4 should be in the lower bits. In kernel 4.9, the accessor and setter
+AD4 +AD4 +AD4 methods for this field appear to be correct. However, kernels 4.10+- do
+AD4 +AD4 +AD4 not properly shift the REQ+AF8-OP argument up for either setting it or
+AD4 +AD4 +AD4 getting it from bi+AF8-opf. Is this the intended behavior or is it a
+AD4 +AD4 +AD4 mistake in how the code was written? Please note that I have not
+AD4 +AD4 +AD4 checked all the releases between 4.9 and 5.0-rc3, but I know 4.10,
+AD4 +AD4 +AD4 4.14, 4.15, and 5.0-rc3 contain the same or similar code for setting
+AD4 +AD4 +AD4 bio-+AD4-bi+AF8-opf.
+AD4 +AD4 
+AD4 +AD4 Hi Ashlie,
+AD4 +AD4 
+AD4 +AD4 Are you perhaps referring to commit ef295ecf090d (+ACI-block: better op and
+AD4 +AD4 flags encoding+ACI)? Have you noticed that that commit modified the
+AD4 +AD4 encoding such that the operation ends up in the lower 8 bits and the
+AD4 +AD4 flags in the upper 24 bits? That patch namely includes the following change:
+AD4 +AD4 
+AD4 +AD4 +-enum req+AF8-flag+AF8-bits +AHs
+AD4 +AD4 +-       +AF8AXw-REQ+AF8-FAILFAST+AF8-DEV +AD0    /+ACo no driver retries of device errors +ACo-/
+AD4 +AD4 +-               REQ+AF8-OP+AF8-BITS,
+AD4 +AD4 
+AD4 
+AD4 Ah, I missed that assignment hiding on the next line (possibly because
+AD4 I've been staring at the code for various projects for too long :) ),
+AD4 thanks for pointing it out for me+ACE One (minor) nit about the current
+AD4 code then: it appears that the comment on bio-+AD4-bi+AF8-opf  still refers to
+AD4 the old arrangement where the REQ+AF8-OP occupied the upper bits of the
+AD4 field, making it hard to figure out what's happening at a glance

If you would like to submit a patch that updates the header file comments,
I think it would be welcome :-)

Bart.
