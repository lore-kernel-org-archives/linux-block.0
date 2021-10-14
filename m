Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367C5C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FCC66109F
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhJNPwR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbhJNPwQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 11:52:16 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0377C061570
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:50:11 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id j8so3983313ila.11
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2mPqLdWjD5h15PQZqG3Zun+L/WwZ7fjlywceYvDUoE0=;
        b=jORmHQZ3xkpVe11WYS5yL/0Yf7nq0PtC11NKgfKP+ns5rczHNZokeOLNwLYhGX3yKh
         XtAEF3dHca1mf84uc4X7DOjqmsfR0M4dymARfU5h0K7pKCn2wGw+TS1Cn9fgr1kDsfYd
         VXEMgzHst8dsJ43iLE84xzAMActz+uSVDhcmf8wzVu4vGAeYCSJ2GJWy5a43R/vQDxS/
         ugKeKjOx3p63GEiXGdS06kVUTY5SSJjPPjcBXqeLd5hTkyw/D9AIchKfB9j4TUY6cPoF
         iILGTw2hTfTTYFfSDFcVylcB8l7EgMDKVxUzefnnaWlpgSHSwEcpTVg6WYYZPySNUDb4
         LqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2mPqLdWjD5h15PQZqG3Zun+L/WwZ7fjlywceYvDUoE0=;
        b=0P1S7l3hxzbL9HQwr3n0SpUpVpoJQNdxk4IfLlNFArXrCf62KLvbuki4O9A5WIkyTS
         aSQAdh0uQWpNMBvzYw2Ql+bAAVDOwyOJ5daURJZA5sX1YV3HB86eBB9RpkEC5QIqVZpA
         kLznMmHTul9S4D8J19lmaikcDBISujRpg0MizxZp82iqbDtnNkAfyRDWVMVJRCG9F/5r
         UaA1CaFLDYEnVHJ1qN91prp1OyBVnLVSVTsLBKoN6pdDgsMtxUSUI1y6NmFArWvoFeUX
         L5q04bl0msPo7jS2jSVsq4hzKLYxyfOpBN2aqTo855JVRSiOq0PSd/4VAGNV1opZWWxN
         7xkw==
X-Gm-Message-State: AOAM533rItBPXLKhBKj0Di/4sJoDeLf7yjaMRjQJDC42NNR+Miyr3IcF
        Z4YoRI0dfev+smfKf8q8rjJ7fiU0SCLaPQ==
X-Google-Smtp-Source: ABdhPJwpSF2f074jYuBV+Hd6L06Gn+BmA+UlYTkaRaDxcVdgL4TPaRvuGWTr+ptvf8K59VFRhIBJwQ==
X-Received: by 2002:a05:6e02:190c:: with SMTP id w12mr3051421ilu.226.1634226610928;
        Thu, 14 Oct 2021 08:50:10 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r17sm1315993ioj.43.2021.10.14.08.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:50:10 -0700 (PDT)
Subject: Re: [PATCH 1/9] block: define io_batch structure
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211013165416.985696-1-axboe@kernel.dk>
 <20211013165416.985696-2-axboe@kernel.dk> <YWfEALs4P+bGQtY9@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1db96336-fad5-b2bc-98c8-33336790e785@kernel.dk>
Date:   Thu, 14 Oct 2021 09:50:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWfEALs4P+bGQtY9@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 11:45 PM, Christoph Hellwig wrote:
> On Wed, Oct 13, 2021 at 10:54:08AM -0600, Jens Axboe wrote:
>> This adds the io_batch structure, and a helper for defining one on the
>> stack. It's meant to be used for collecting requests for completion,
>> with a completion handler defined to be called at the end.
> 
> Isn't the name a little misleading given that it is all about
> completions?

It is for completions, but I'd rather just keep it short for now.

> 
> Also I wonder if this should be merged with the next patch as that's
> sortof a logical unit.

Actually was like that before, I can fold them again.

-- 
Jens Axboe

