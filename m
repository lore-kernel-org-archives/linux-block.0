Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246B6C43219
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 15:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F312147A
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 15:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KB7oSCUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfD3P1T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 11:27:19 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:40437 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfD3P1T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 11:27:19 -0400
Received: by mail-io1-f50.google.com with SMTP id m9so6185075iok.7
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2019 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ML6TAWz0Xc6iDLbt62Pin6KVbCz+ta0B9Pv1H1i4wB4=;
        b=KB7oSCUhUQfv6pLmfVRXmJPhxM0gNjRo4Q+2AyYFd3VUCAVVjRXaPxvF5pvZRLi8A0
         g0MeNdja3YTcZB+MrzzWszKmCmlyzsoyeUzkRP9wJ/ehgIHpPnKJHHfLDcf2KAu2mQmh
         fURuMFB8jpzozkNaZ09yTL+b0sdfq3azA0cftiXFAiZVbJizIciW5i0UsDDzvlkSFBNz
         GzExfcGd3gB0X08eu/w4BOkMAkA2l0Gz6EuzfnIFDrMdPl6BazW1OoN17plID8fNVawO
         A8M9EM62xiIbxum8QTusrrfj24LPgIJWiQntpUpRNd0SyrSS1h1b1PTK1gTRXbaW7uGI
         CgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ML6TAWz0Xc6iDLbt62Pin6KVbCz+ta0B9Pv1H1i4wB4=;
        b=rx24R0hHxUlFJjjknEWrjPldKRxR5DIkl7iFSqqYczzgQAvmkFBv4KGdPDAgsLhyhh
         PlnhwjOFztytBG71aTXqSW9yp/gxIRH0oH7Xt0keIlfZcHNuKAK1vMJkW8WMbS+SCOnF
         j8lT1QDGmChgjiONLsy/JhGCNRrUHNxoYC+PQeG/Y1vapK5xXiSTRbJtOk+XFWyZMmMB
         Ni5ZSsOYGaFdO9lKQTpo1IO/qlWgva84mkYBaQWK7Vdi9Os+Ih3qTmGHsamXnptqs6eV
         HIgWeHqnzaBOJGx2v61sKjAry0RuHIMlzYylaATDhOYuBn8hjDTpoPFzwogjcyX3IlwF
         rWuw==
X-Gm-Message-State: APjAAAWKC5jBjl1UUBbQX7YybYxDApZmuCJNSiP8Eut4ZHhUs2VWtcno
        8yZlR98UlGB4jg0zgLAFo/v+eCxOTrSRDA==
X-Google-Smtp-Source: APXvYqxTjKfGDHnktaChiJ8g+KwwvNKjH6Q50Dj0hpXLsljyKGogFioylG5VhCNepuPHRzBj+U7ppw==
X-Received: by 2002:a6b:4102:: with SMTP id n2mr5322565ioa.256.1556638037567;
        Tue, 30 Apr 2019 08:27:17 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 1sm1689381ity.9.2019.04.30.08.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 08:27:16 -0700 (PDT)
Subject: Re: bio_add_pc_page cleanups
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20190425070435.3478-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e715830-8ed1-8825-97e7-c1b9ac8252f5@kernel.dk>
Date:   Tue, 30 Apr 2019 09:27:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425070435.3478-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/25/19 1:04 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> please take a look at these trivial bio_add_pc_page cleanups.

LGTM, applied.

-- 
Jens Axboe

