Return-Path: <SRS0=59TO=Y4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED6BCA9EC9
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 22:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA492080F
	for <linux-block@archiver.kernel.org>; Mon,  4 Nov 2019 22:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CxklQKtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfKDW7r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Nov 2019 17:59:47 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39315 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbfKDW7r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Nov 2019 17:59:47 -0500
Received: by mail-pf1-f195.google.com with SMTP id x28so10398417pfo.6
        for <linux-block@vger.kernel.org>; Mon, 04 Nov 2019 14:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NxwJfarZTo82V8R+Ot4nL0hX1Y7j7+WSmdyRqTrmmhA=;
        b=CxklQKtRpAHTXZOqXk2ctdDG51V3iVc0oGBRlGb0I/NOUqTicBwBkPsBKU/3WY7EKr
         kuSrAw65W1RGFsWwIxbvzk8Ht9zmrIjAjlCjthAURVpGUZP+Ll7qnlUNg4cQjSjzjh7W
         xHKp7GywnxuijCJB/mJOqDfqXSyz3M/y72rN1gdT7f+jfm1lv78VUH+zwdm79S2SWzqq
         c7zhCHU3M7rn6Xnh2tLU1UIdB74fVQrMnrec30hPDOoS2PgZpPDkAd9YNrsrXyYz6khW
         GqmgpBmPRgrnLZgqoCFHX7MWFtAeM3S3xcWsoz8sVKmcirj4CIrnIzTMsoSwQ/eOuvvt
         SxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NxwJfarZTo82V8R+Ot4nL0hX1Y7j7+WSmdyRqTrmmhA=;
        b=MnvJIlM7/00VLqTCYQcglW6JhMAkJiwvg1OHnWkI6ZH5GDXgrAEjCFMQS5EMLYi6nN
         WDGaMAJsYAE7XPuiMa3KRYSKVQ0btzoOfpwk+mzxPHlyKAJz/CUyYsUDbkdxslHs/4Y+
         ZGCwy27Nxrbb052fSeNcwAhA8xPVSh8f4tIO/svSDxv4I318N1j3+J1+r+SpezUp47do
         nurEgYO3rZCXM++iBC3Y2DIrrN4S3uxc8QfHyKxA7IiohZ4nKrHsqwEFHqxrhmi/knbm
         X3Gk70gq+63hcpLLi1MYy9DT+KLxUhz9rZCVzAhzDFNGSAGIPtNeRUrMZpznm9dLJi/g
         z1Lg==
X-Gm-Message-State: APjAAAXaNthaxa7Bl3HXZdHKjyqAbpt86tOokJmq0d3TDmEDoboutRex
        LhH+wn4fBcJISZ3+2XN6IfsHZs+K5EsxKw==
X-Google-Smtp-Source: APXvYqz49E5DqIyO6+xjur14eE68L/KO92/QejeTuz/cMgZQwz4SXryJQyi/0sKlVRcWs9rveZH63A==
X-Received: by 2002:a17:90a:26c1:: with SMTP id m59mr2061815pje.101.1572908386239;
        Mon, 04 Nov 2019 14:59:46 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id m4sm15921073pjs.8.2019.11.04.14.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 14:59:45 -0800 (PST)
Subject: Re: [PATCH] block: avoid blk_bio_segment_split for small I/O
 operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, ming.lei@redhat.com,
        linux-block@vger.kernel.org
References: <20191104180543.23123-1-hch@lst.de>
 <20191104193002.GA21075@redsun51.ssa.fujisawa.hgst.com>
 <f1050949-31b1-a9cf-02d6-00c94f505290@kernel.dk>
 <20191104225036.GA21282@redsun51.ssa.fujisawa.hgst.com>
 <2822bfe1-5d9d-ec87-9607-36617e528985@kernel.dk>
 <20191104225736.GA25569@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ac50c3f6-086d-4a6d-69b9-20347d32c8f9@kernel.dk>
Date:   Mon, 4 Nov 2019 15:59:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104225736.GA25569@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/4/19 3:57 PM, Christoph Hellwig wrote:
> On Mon, Nov 04, 2019 at 03:55:41PM -0700, Jens Axboe wrote:
>>> All existing ones I'm aware of are 128k, so 4k aligned, but if the LBA
>>> format is 512B, you could start a 4k IO at a 126k offset to straddle the
>>> boundary. Hm, maybe we don't care about the split penalty in that case
>>> since unaligned access is already going to be slower for other reasons ...
>>
>> Yeah, not sure that's a huge concern for that particular case. If you
>> think it's a real world issue, it should be possible to set aside a
>> queue bit for this and always have them hit the slower split path.
> 
> Well, we use that field for zoned devices also, in which case it is an
> issue.  I think I'll need to send a patch to skip the fast path if
> we have chunk_sectors set.

Yes, let's do that, makes sense.

-- 
Jens Axboe

