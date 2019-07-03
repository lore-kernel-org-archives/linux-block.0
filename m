Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75F7C0650E
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 13:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A38F218A4
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 13:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="E2J3OtBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfGCNjp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:39:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34736 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCNjo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 09:39:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so1320737pfc.1
        for <linux-block@vger.kernel.org>; Wed, 03 Jul 2019 06:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=h50Ku1zzWuK4sP2+ucFN+PfKN+6I6hTliwiy75O52GI=;
        b=E2J3OtBSkhZFbz9xCXcbAxlG7o0Gh96nr1xC55FlUgeLKsezPGzKub3rytVpFO7W+d
         y9rMZIWAD7VoLSrBgUkucntL2iYr3lKtJ2WkKTQvi5vZ2zVri1zwtOKZ+bDcwbTd2vaL
         9bBRmRHxBOrX27taTCnOUvQG8D+5rkOoTdjEZZQazOiBjVDfH/SSOK/u4GA8DdX2PcNO
         6n0wTWf/EjNx7SuFZBenW59GhWw0hlVbTgTRccQxnMDFkI6uEUh5eHkCSBuStIHyxjgP
         bZOvH9DDtGGaQF6x71OjliEgeCrkUqNmzh6TtGDHabZn8Uu6B7NJdhnR/GFppcyd5IH2
         IToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h50Ku1zzWuK4sP2+ucFN+PfKN+6I6hTliwiy75O52GI=;
        b=OC+1vzK9WqDTFOJK+pswtUB/yV2g1I4ZOj9BQkrxVmnIuDP0BCGM92C//N2hARAPeK
         1iyFcJLtmeQNDHVBsYEEPDHebPuuTw/n/sVoEGNUjqhnFWk/Y+QdT7kcD7aok5u1Lx6U
         xibllm0qDU6/+PsEF8xIKQ7p6ib7TyFoqrrohL5u8owmMGSYQwio/ZzECaZKloR2k+d2
         Luurl5EoiRuwLIzkZvv8kOmrkU0mXhICswO7iIFDrCSUYHjQl7J+E0bIqk+f7hHIq+CT
         Zox5XVTzElW9cxLSwdNC4asjm9RQQvUjd30umjdN5HQVKHvJDe3cO7rUJrs1ougonlnF
         3BqA==
X-Gm-Message-State: APjAAAUmRxrIlsv2zA4wBUC5u0edmCM4CP5wS4fsGIkj2tEXD6cHe9QF
        siQQNU37s0oCTEgYxC9UdJ+BSVAfWIlm0Q==
X-Google-Smtp-Source: APXvYqx45B7bcri5T6wlLnPE8KZVDkr+XMKRyVhkBwooRjze70ibSIV+007Jbnhwa122SaOFsqx14A==
X-Received: by 2002:a63:8f09:: with SMTP id n9mr36708595pgd.249.1562161183708;
        Wed, 03 Jul 2019 06:39:43 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id p1sm2704621pff.74.2019.07.03.06.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:39:42 -0700 (PDT)
Subject: Re: [PATCH] null_blk: add unlikely for REQ_OP_DISACRD handling
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org
References: <20190702032027.24066-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0760ecc6-feef-16b0-dc45-1e86c3b3d09e@kernel.dk>
Date:   Wed, 3 Jul 2019 07:39:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190702032027.24066-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/19 9:20 PM, Chaitanya Kulkarni wrote:
> Since discard requests are not as common as read and write requests
> mark REQ_OP_DISCARD condition unlikely in the null_handle_rq() and
> null_handle_bio().

We should let normal branch prediction handle this. What if you
are running a pure discard workload?

In general I'm not a huge fan of likely/unlikely annotations,
they only tend to make sense when it's an unlikely() for an
error case, not for something that could potentially be quite
the opposite of an unlikely case.

-- 
Jens Axboe

