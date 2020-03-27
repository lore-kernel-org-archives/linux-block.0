Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CA3C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 15:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A2F20748
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 15:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Sjpfqm3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgC0PxV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:53:21 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:35318 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgC0PxV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 11:53:21 -0400
Received: by mail-pg1-f181.google.com with SMTP id k5so2554499pga.2
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2020 08:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sWk+hApPwex2IKKy9wQGNeWq5d+BD3CZyZ8lOi8iJYI=;
        b=Sjpfqm3APBWDQwQ00ym5Ogfva4349koZT1DMWkCBMPXBWsww9/fwwRFW8NJwBQpo6M
         dtKicKjRNLcZsxeUPJ9D8Nq79dI6QhzGKfj1sfHksqdTicPze2p2n6JFsqhKVObMdiOz
         bpxkZsM3WP2O3DyCYzkD5tKX3H0nZADxst/XkunducEjmRAYyuCTUvmeQGnTzs/wX414
         f8iOA8bjfZ4BHleGemKc9km4lFYe9cxdKM+qUmJ2OZpQyYlADHtKhbSwTbE52Bham3SE
         2AJ/1tpLU897oJ6oPooau0u4Ep/yPdYLreJv3vyYOdNwQ78xe1SHaygNbBN0iG4TqEYS
         WcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sWk+hApPwex2IKKy9wQGNeWq5d+BD3CZyZ8lOi8iJYI=;
        b=NPToYJqjYNuXKpZhrUByZ8hF/gmu7cjzChn0oOA5mJR2qE8ezykuUu9746Kzwy5Fkl
         iiwJ7MAb1BLRpx4EJJnhspmEhsSDZlbXR22JLv8OVk5YRxT8zlc1RxzAT3bHk6DmXMBQ
         OR/gHVeG9hhwpAXDk8CRmXG4QGfbrSo9j1VFEDVrTqKtydLJzw7oPdEmA3J4VDT8a5t7
         cnA4A6HbtZ1CZo5jhDvq1cpK9bi0XIs1WWAJLrpRKTqV0XNyxnbpz+LngUeVM1qFB8O6
         oJv1XA1cMUs4Vf2KR3uIgwKz1cieF1DbuF5avCI0O6VZNYPbqYt+q5YkBxNmrNIqCM2Q
         kJ3Q==
X-Gm-Message-State: ANhLgQ2kNdf61PnijEiSDu09xLOw5nWu2vptKUm9V3Fj9kzpZmPREFB3
        OI5GjNGRhx3lLWL9/KtIhCeenaDidpyyww==
X-Google-Smtp-Source: ADFU+vuTgeJ3+x9d7VGsaoGJIXdNgMMdesEQxfqDGXyq5dTlpp/aOASkik/jnESepAtaKr0b7+yq/w==
X-Received: by 2002:a62:3207:: with SMTP id y7mr15223301pfy.270.1585324399159;
        Fri, 27 Mar 2020 08:53:19 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id r70sm4406361pfr.116.2020.03.27.08.53.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 08:53:17 -0700 (PDT)
Subject: Re: simplify queue allocation
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20200327083012.1618778-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b1123d19-0c4a-5d3d-d0d4-0a412830c2b0@kernel.dk>
Date:   Fri, 27 Mar 2020 09:53:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200327083012.1618778-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/27/20 2:30 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series ensures all allocated queues have a valid ->make_request_fn
> and also nicely consolidates the code for allocating queues.

This seems fine to me, but might be a good idea to shuffle 4/5 as the
last one, and do that one inside the merge window to avoid any potential
silly merge conflicts.

-- 
Jens Axboe

