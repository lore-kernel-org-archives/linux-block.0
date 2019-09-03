Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AE1C3A5A7
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 14:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE1F23891
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 14:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1Q9bi1VI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbfICOGl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:06:41 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33645 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfICOGl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Sep 2019 10:06:41 -0400
Received: by mail-io1-f66.google.com with SMTP id m11so4190401ioo.0
        for <linux-block@vger.kernel.org>; Tue, 03 Sep 2019 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=0p3oWLhAQWaGVemN+5EpRiaC7HumZE71N/2ba/fW6JY=;
        b=1Q9bi1VIzUqAMTYaHO9z9TpvDFwOZ+0dH9NVanlMlykig3srm3wskTSPXdjXa6Jrbv
         1HA9BfwMkf/TPF5ev2nhry6re0D+KIJQzTm5/b/mIcWDg0+kDFx3xVuf1mbs0cEldcw0
         bJxlBU0u0D0soKewZHyXOY5hYpTi15LMaAa3ctQ8YWhToZhcZ3rXitF6ziQCUZA47GaT
         x/vdPsZUW30aYziNM+ESkpRcvfYkBt9uAjhT8ChgpTCNP0okGG0g5jVB54W4cytIaFAT
         t9cjEpdy0S6rd1jiLNmOzj6kqyfKx3lJfYKaNgr+XxD3Heed5+Y72l169Gnpcr3/oqxX
         M+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0p3oWLhAQWaGVemN+5EpRiaC7HumZE71N/2ba/fW6JY=;
        b=Xl9sOXSAXZkT0cOckz4t0JnxpNHzArS4CKgM5WAiCxkWvhwmcBzV2aevTykI25Femb
         bmtJ0m6gKx/etXFfcCobWpOzvRcfAjfSa8AFTxGyd6t0nQMKs6j+uqa1IK28m6NQE932
         v5EgYp0X/iXwXlRnN5jC4V2/N3BlLMwo1AAqFDAoUqnLsVYsvPYVF/6a9MKEJQmtxH2K
         MnXcvQYK6/uStx6FOnsaYI9ih0FEZJeI4OSd7JC2SP7SxIxffw+1kTEMATVjKxMsJ7Cf
         /iNakOMPi1IoLZzrL3CRjHp+0L8JyJ59bJiJVuJ9w2VL9d7mbXonMXvt8imqP0wm3mrJ
         NPPQ==
X-Gm-Message-State: APjAAAUl9N4rAyhMVZhobt9zZXcfaHzC/5SqbCaAg0kJhckkM5KN+exp
        wnYiQn5gMwPKWYNuRrmY4bhzZvxBtIbIpg==
X-Google-Smtp-Source: APXvYqx03uOP/C8Dqwl5Q+wDp0JvHsGemvVGA6YOvYAgWggFpmv/rcZ3Ucmu6Ek5/kCC5fF+sj+pcg==
X-Received: by 2002:a05:6602:2508:: with SMTP id i8mr29737153ioe.91.1567519600140;
        Tue, 03 Sep 2019 07:06:40 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k21sm15220719iob.49.2019.09.03.07.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 07:06:39 -0700 (PDT)
Subject: Re: [RESEND PATCH 0/4] Remove elevator kernel parameter
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <20190828011930.29791-1-marcos.souza.org@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <80b367d6-393e-330a-c5df-f48e73bae86b@kernel.dk>
Date:   Tue, 3 Sep 2019 08:06:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828011930.29791-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/19 7:19 PM, Marcos Paulo de Souza wrote:
> This is just a resend, now with reviews by Hannes and Bob in place. These
> patches were based in linux-block/for-next branch.
> 
> Original cover letter:
> After the first patch sent[1], together with some background from Jens[2], this
> patchset aims to remove completely elevator kernel parameter, since it is not
> being used since blk-mq was set by default.
> 
> Along with elevator code, some documentation was also updated to remove elevator
> references.

Applied, but:

1) Folded patch 1+2
2) Patch 3+4 .txt files are dead

-- 
Jens Axboe

