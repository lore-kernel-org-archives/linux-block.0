Return-Path: <SRS0=s2CZ=X3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994B4C35280
	for <linux-block@archiver.kernel.org>; Wed,  2 Oct 2019 03:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674E92133F
	for <linux-block@archiver.kernel.org>; Wed,  2 Oct 2019 03:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gOBglnax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbfJBDkn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 23:40:43 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45017 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728532AbfJBDkn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Oct 2019 23:40:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id i14so11100213pgt.11
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2019 20:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PdkeOQUh5ZGKssf3LiRMHaOpQtGsQvi+xQa6gIIE3Ag=;
        b=gOBglnax82521cuzzS/X4cynjhJagcOUgqaa6HR113wMzzCZrvrzmpkHBJzl9E6Wdu
         slGFt5Xagn4ND4ms+Rvk1GysCIbWq1x30hxTgfLJoxSlBctqpUlvCT7MV1BKBScLZbqD
         VUEsyvyGFcN1og5O862nzeOTl00THAzmkfodR27ISeqMZqBaH2Y+fWBMzScy6ak9Ag7y
         /EVVzOhSspq81DsD80AakEA/v2KDzNaf1TArtRtaCTxChx5zeKSvf8U1f0jYFa4cv82k
         bXWwxerGz7+NIhcGbIC9Nl6jYi3Lxmk3tSIE9mv8xaRu488Ea4GLHUTcn+Cj2t5s/tX6
         SVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PdkeOQUh5ZGKssf3LiRMHaOpQtGsQvi+xQa6gIIE3Ag=;
        b=hu4kphk7tO8HtdgZRnDPXnqLaITM+vkRqLCmyk5fXLFw++lRF5oO6yjdQSbZoaqrjL
         PzkBIXcPsAg5vdeBTLyDI86krZjY7zj4axdOW1xgdbpoClf0COKSTt1FcUphi3ZLyyDy
         +Lxpf9VMovwmXHLxqwAg4zXJOwrctXxW6OW8LIe/Lmxs2ARJ1elQXyi4jLz0M+87lL1V
         Zf48E8BnRCwEDSxxpZuPmmivnm20u/vby1NaTBy0m/Qj/ty8zINoCALGNI7pXA6GKPek
         zJcjn/043yeZdnsGn7O0DOYNekmm76ScAvNfQ3xKMvmvX2VmhJ9QjsRh3HyfEdOjPT+k
         /WRw==
X-Gm-Message-State: APjAAAXLtLJFMHhh0v4Idups5lN7V66ifX6g8AZ25Hddl512xvgyEK1U
        0xw3vEKQ8hgupaYa4eTAosKHU13BLpY0qw==
X-Google-Smtp-Source: APXvYqxNO9JUnDKZ6wvH/kH4rVT45qpSvUBlI4mJRdyDbVZiD31/ugjMquxHatwPpz7xvRW5Rqg22w==
X-Received: by 2002:a17:90a:28c5:: with SMTP id f63mr1804014pjd.67.1569987641164;
        Tue, 01 Oct 2019 20:40:41 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id i6sm27938572pfq.20.2019.10.01.20.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 20:40:40 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Simplify blk_mq_in_flight*
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <11ebb046bf422facf6e438672799306b80038173.1569830385.git.asml.silence@gmail.com>
 <cover.1569868094.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6309715a-fd9d-f8de-8c86-3505319665c4@kernel.dk>
Date:   Tue, 1 Oct 2019 21:40:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1569868094.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/30/19 12:55 PM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> Clean up inflight counting code. Deduplicate it and fortify with types.
> 
> v2: splitting the patch in two by Christoph suggestion

Looks good, applied, thanks.

-- 
Jens Axboe

