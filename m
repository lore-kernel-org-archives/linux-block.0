Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED09BC76188
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 03:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C574621951
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 03:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="u1l+2EvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbfGVDrh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Jul 2019 23:47:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36983 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfGVDrg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Jul 2019 23:47:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id i70so6244095pgd.4
        for <linux-block@vger.kernel.org>; Sun, 21 Jul 2019 20:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9o6bZ2n3+H/MsrmcixRdm2ofnIv2ZOY84Uiyry3kaos=;
        b=u1l+2EvA1iQPv2nlnxB1rB5dnDVrlO9B1R3ogjQlSRSijMNtJlyi5ZsiZQRgjegqk1
         FdaJJHavfDG4KBkKpsczEa26RgSbQMGU7f9o0PffGGQT5mMviuGXe7JJApXQOutpuPCO
         NgLxM0beWWMbXpkJgk+4bpLCIX4ZuSqCTXi3qKP8vH6Cf9OZtFhETkM4xcm7Ua4gCoB+
         sNtJ+OrkPNx1gJwaoKyYSptVhZSpVqZWSfNBjuw5g4K19uFq7M6WPIBsI9Qg7ulRrTz7
         +1O1DdVz+GyWHj2qyQguROGMPueotSNOWjVmyEcAzhrkw79GhcJvMn4RG7hYJyQKc4g6
         u1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9o6bZ2n3+H/MsrmcixRdm2ofnIv2ZOY84Uiyry3kaos=;
        b=LnbSAzDQXBfgxCs47n0OszH0871tXmzgvj8WR7KqI+UThN51ASZMJsIaDYvfwULlU6
         iZILezWxV7DtHmLWaqoO7G6gEUayOgGUgDYO0f7XJ2hr0TjkvsFHHsjJTbL3uMNW5XmJ
         rGdGLkBhPMhhlIfsjt/LdFyy3pBkNgYbwmMW2eYYxLOL3ZmXxuRmhpmlGPDCRIZubIHP
         Pz3aNh/50veOGom2TpGikE6H7arJ3mIUqNf+3bjZVQ+flSWyPBHdbWLqOJuACY2FlCgR
         1xi7ywj7NLToNMtzei6Z5KuZzoqCxynoCxazjZJZ+QCleAN0xuu1Fgz8ulrcifBFdNKV
         664g==
X-Gm-Message-State: APjAAAUQoi5dPM2rlZWINuuKleoW2XXxCOxAyYTFO9ouKMQ0BoeCd0CU
        ZN+5B1zpHGFoeIilRK8EjFH6C8NYzyY=
X-Google-Smtp-Source: APXvYqz8+NP/2tKb4ey+j8Pl5INNU53U3Lek6banvegS1KTpOyyCJFAp21Ys6BmSUKaFBlpQw6rUcg==
X-Received: by 2002:a63:b904:: with SMTP id z4mr68130151pge.388.1563767254355;
        Sun, 21 Jul 2019 20:47:34 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id 201sm46298844pfz.24.2019.07.21.20.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jul 2019 20:47:32 -0700 (PDT)
Subject: Re: [PATCH v2] track io length in async_list based on bytes
To:     Zhengyuan Liu <liuzhengyuan@kylinos.cn>
Cc:     linux-block@vger.kernel.org
References: <1563762207-749-1-git-send-email-liuzhengyuan@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <81ce0923-af96-1687-f67d-9f33f0cd33fd@kernel.dk>
Date:   Sun, 21 Jul 2019 21:47:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563762207-749-1-git-send-email-liuzhengyuan@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/21/19 8:23 PM, Zhengyuan Liu wrote:
> We are using PAGE_SIZE as the unit to determine if the total len in
> async_list has exceeded max_pages, it's not fair for smaller io sizes.
> For example, if we are doing 1k-size io streams, we will never exceed
> max_pages since len >>= PAGE_SHIFT always gets zero. So use original
> bytes to make it more accurate.

Thanks, applied.

-- 
Jens Axboe

