Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781A4C0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 19:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D71820B7C
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 19:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lGdboEtC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfGAToq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:44:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38302 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfGAToq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 15:44:46 -0400
Received: by mail-io1-f68.google.com with SMTP id j6so31553929ioa.5
        for <linux-block@vger.kernel.org>; Mon, 01 Jul 2019 12:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=au5bHTFzFyS+PnKfWAZmJzOM/aBWyQsp9x8rTigTLlY=;
        b=lGdboEtC8HEdmH1B/LWLni/Cqr0geuKsZamAD0yg3HRnx4a9P6fnOslhKVLyP1nBor
         MQxAbFQB/0VoCn340vrLbrDUS15lHm3cQ23cFn8FPjUCLMFxFmMbYQkIv34IrDqhiMpr
         znxksifhGACTACHTARKoSO7yk/Ny5iDKQzZmOBtBe5uDf32jwEz9xnhDyGtnEUJg7zkN
         DXl2gR+Sl+Oq8P0YH+Ku69ud5fAu5DpjfSgpRjHbg6abL1qdtZRcDKhmjBdW2r9Waj90
         W+J7If66Pyc2Xwufjr4B4/lf+esLbDSpuO6HKhoWXn6/MOzsdNTujxQNYLjoi3Jv3Mm8
         Fiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=au5bHTFzFyS+PnKfWAZmJzOM/aBWyQsp9x8rTigTLlY=;
        b=FkHGvNOvj7atEqWDsB7LyERsaFwVyypJi1M1CBTg79dzfqY3NpQNTo5jpTpHJDzYdb
         FpMzkKJ66vlqvvR6AfdlSMXfmBXhTeIzJYJIm2+DX1DwPneI+IKIPwogSIHZ3yqrF4SG
         ttevLtS2tUjz+C4Zg+8VCLUB3ex5bZ7g7F4+fHZUlnPgdGSqlY4aCqOqttok2PkJLezH
         IvSOS0qcKDlftsKfwlGSz+XNaojpiRrZ9d7g3vmhSDdWGmgWaRvMTLNbq/HVS7fOax2h
         xy0+xxXH72rjuDc7sdAiVq0SjRy40BiQBQc2D+SRLfyRy9F9j8TTawKJJ3iZqQ6QvONn
         6MGA==
X-Gm-Message-State: APjAAAVz4EJ3UKingXFRsDcpzVMm8+Rw4oEOXy4sqE4n2IJAX4uMTrXW
        WWDXLNu9KqoFRaT4jYXZVqTQXA==
X-Google-Smtp-Source: APXvYqzae2gOwhtXt0DDFyhsuvPSFlr1RhLQTJLS3NT0escC7DHUIgg+Ab3PWa0Jbi8B+BX+8vcW5w==
X-Received: by 2002:a6b:b602:: with SMTP id g2mr3718121iof.54.1562010285852;
        Mon, 01 Jul 2019 12:44:45 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z26sm10564478ioi.85.2019.07.01.12.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 12:44:44 -0700 (PDT)
Subject: Re: [PATCH 1/1] sbitmap: Replace cmpxchg with xchg
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <722e1d561f0a49dc464d3a2b1be4c077f7502726.1558625912.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <77f4ee3b-a190-5708-f30b-0c5f2b933b3e@kernel.dk>
Date:   Mon, 1 Jul 2019 13:44:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <722e1d561f0a49dc464d3a2b1be4c077f7502726.1558625912.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/19 9:39 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> cmpxchg() with an immediate value could be replaced with less expensive
> xchg(). The same true if new value don't _depend_ on the old one.
> 
> In the second block, atomic_cmpxchg() return value isn't checked, so
> after atomic_cmpxchg() ->  atomic_xchg() conversion it could be replaced
> with atomic_set(). Comparison with atomic_read() in the second chunk was
> left as an optimisation (if that was the initial intention).

Applied, thanks.

-- 
Jens Axboe

