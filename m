Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFEEC5B57D
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 02:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE53206E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 02:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MKfDNkbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfGCCeE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 22:34:04 -0400
Received: from mail-pl1-f182.google.com ([209.85.214.182]:39798 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCCeE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 22:34:04 -0400
Received: by mail-pl1-f182.google.com with SMTP id b7so340561pls.6
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 19:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t5yPtRjTOFSfJoMHMCSkek8mrEgFqerNmil1XFrNTIs=;
        b=MKfDNkbEiDbgB07fc0pBTYcSw+1a9gGh9t2UwQyCb/H3nvt/uOyNjgMgmldzdz+IZA
         MmNMyeOJ19V+28WBjC8keGqQj0fPpc9xJQKqJyk3/SEM0TGK+GOG22WdDRDQJ08NzZIh
         rpchh0GSO1k2EVelRN4bQ45geGnQs8fyZnm2uHKF5QhSo0Twhyp6QcOZZ2C1MWiZ17yW
         rY+PqGlYJFiyIrrV9hya5l0lOsQA1RQrBMboHPMmrNOgIN4QGBDQo2oduxoTJ//vVB97
         pI28ovKGs/rrniS/I82dk9IK3n1audlKEyBg3COeg34PbQr44CVcwBS2Weaf+x3CMUms
         SfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t5yPtRjTOFSfJoMHMCSkek8mrEgFqerNmil1XFrNTIs=;
        b=qrd3zCxmYYmzo736bWZEva8OaPm5y4rt6DzriaUUNiJSJnBhmvMNJ2Fiw+NzXNIsRj
         pmmfHQEmGeuif8yFY/eUQGFdXuocti7KeINQP0Qg0rivAgZcyb55KLDUi0HB+4m3oEvV
         +OxmirMR3L49AVnC/JRt5LAnW2g0Gz3n2ig8dGvTKKO/WbeYJfBddbzuZrWctUeJ+8Qo
         ijbE1BZe/uCmrpEbSfJfNS0UfR9h2PqaCJlVf4dXR1iqZCJ3n547Z7zZ5/Bw/Qzhqzha
         G6gNQ0pkxC9/bHbEJ8AMn83zvxJ7vVgOHQYdaS/+ds+AXERdkUnjPZ1QjcdYloT+jWD/
         hPMQ==
X-Gm-Message-State: APjAAAW4etUxOxb8oXiI8hi9Y8M7/IQBW84i/0MEGbRo4VeiPBANaWJa
        6LcSe2q4RxTuMLnkqwXXApPxnA==
X-Google-Smtp-Source: APXvYqzf1HRPP08XYWVStujcGy39p+TsTB2UWFtJI4FpPttGgoO292XJFi/Dcb6RVIYfiWuI91b7mg==
X-Received: by 2002:a17:902:549:: with SMTP id 67mr38900406plf.86.1562121243731;
        Tue, 02 Jul 2019 19:34:03 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id p7sm420403pfp.131.2019.07.02.19.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 19:34:02 -0700 (PDT)
Subject: Re: [PATCH, RESEND 0/2] Simplify blk-mq implementation
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20190701154730.203795-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7bff723f-0a66-d1a1-9309-8e120ab420d3@kernel.dk>
Date:   Tue, 2 Jul 2019 20:34:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190701154730.203795-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/19 9:47 AM, Bart Van Assche wrote:
> Hi Jens,
> 
> While reviewing the blk_mq_make_request() code I noticed that it is possible
> to simplify the implementation of that function. Please consider these patches
> for kernel v5.3.

Applied, thanks Bart.

-- 
Jens Axboe

