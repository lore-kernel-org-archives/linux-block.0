Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D782C282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 05:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C5F20879
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 05:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725862AbfAVFEt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:04:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35294 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfAVFEt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 00:04:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so10863049plo.2
        for <linux-block@vger.kernel.org>; Mon, 21 Jan 2019 21:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qLhIFQB/g7eTapKVTEpzlRzWDVJH5IuAEI8OLxmsK84=;
        b=Sy3D1+5y6n9Z+Py9i/8op/6RGwJuDZAx89l0hZP4wCmUvP4xm0yl9E61Hul//055lq
         ARoMNcDkXPTabf5AJPBWvsJl17lZmzy7m+rYs2HL6Fwd51d0WTa+tL8QOzM9Tr1Udu33
         xWu+exARThyaIXcRRS5OACFCop4vMVIRspTZtAuhRnqwHxrgcmNZH9Czqi4XXeYkf9aM
         LImi1TM5npefWTuHfnt2Sn/wrv/4kEv56QswFnscpe6gc8o8g7E25siG6eZToYnbF8jg
         vGjFqlP+8gO3NFdbuNhZq1qFnH00n0IC+cSNU/vbAflFodKzbdnsZnKvuqhHCB+lhKVe
         hPMQ==
X-Gm-Message-State: AJcUukc5viRj/uZqlvL4yZB3UVf4yUWK7qsp03mRgFXFSO36OwTuln23
        OFZAFJ94KF6CZkRZE6a3zMA4Z/r4
X-Google-Smtp-Source: ALg8bN6zYRBt9PukIMlKQHA1wMUABb1QKjGw0+3DP2J9wC3zimDrxDdszAALI/g8iDTx3vHDiD8LYg==
X-Received: by 2002:a17:902:f24:: with SMTP id 33mr33001699ply.65.1548133488324;
        Mon, 21 Jan 2019 21:04:48 -0800 (PST)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id u126sm40472269pgb.2.2019.01.21.21.04.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 21:04:47 -0800 (PST)
Subject: Re: RFC bio flags and ops in v4.10+
To:     Ashlie Martinez <ashmrtn@utexas.edu>, linux-block@vger.kernel.org
References: <CAFk8rvbdfzdChGf9jsTT7qPVf7bpW4VH0mys1He8_KjUD5mD2A@mail.gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <7064d8d4-675d-8c40-5f20-b865607d3495@acm.org>
Date:   Mon, 21 Jan 2019 21:04:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAFk8rvbdfzdChGf9jsTT7qPVf7bpW4VH0mys1He8_KjUD5mD2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/21/19 8:45 PM, Ashlie Martinez wrote:
> I was working on porting parts of a file system crash consistency
> checking tool called CrashMonkey [1] to linux kernels 4.9 and 4.14
> when I noticed an inconsistency in how the bio->bi_opf field is
> treated. According to the comments in /include/linux/blk_types.h, the
> REQ_OP should be the upper bits in bi_opf, while the request flags
> should be in the lower bits. In kernel 4.9, the accessor and setter
> methods for this field appear to be correct. However, kernels 4.10+ do
> not properly shift the REQ_OP argument up for either setting it or
> getting it from bi_opf. Is this the intended behavior or is it a
> mistake in how the code was written? Please note that I have not
> checked all the releases between 4.9 and 5.0-rc3, but I know 4.10,
> 4.14, 4.15, and 5.0-rc3 contain the same or similar code for setting
> bio->bi_opf.

Hi Ashlie,

Are you perhaps referring to commit ef295ecf090d ("block: better op and 
flags encoding")? Have you noticed that that commit modified the 
encoding such that the operation ends up in the lower 8 bits and the 
flags in the upper 24 bits? That patch namely includes the following change:

+enum req_flag_bits {
+	__REQ_FAILFAST_DEV =	/* no driver retries of device errors */
+		REQ_OP_BITS,

Bart.
