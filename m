Return-Path: <SRS0=keWk=7B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCB2C433E1
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614A420657
	for <linux-block@archiver.kernel.org>; Tue, 19 May 2020 15:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vppHI2i2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbgESPnK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 May 2020 11:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbgESPnK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 May 2020 11:43:10 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91349C08C5C0
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 08:43:09 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id k22so26587pls.10
        for <linux-block@vger.kernel.org>; Tue, 19 May 2020 08:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nTb00k1/dYvI4ehiN9PDOKgU2zbif57VigXWm2jH9AA=;
        b=vppHI2i27NdgOWWLq2UDBrm/mCYt7NDDwesYS0rru2gKS4ak/42IG5kLc6YqbaYgGp
         PI+ZKuO0J0sWjTtfd4JSbt7PspOd2P7NQMPnzpdRCQiWePp8X15/Epd+YqyMYqkU11Vf
         cGcN0sIFstOkBsUPEOkHfWptJJUlPfUjLSeKM8ri1cmtjtP2wU3P3U/S1BIukqe4JQIJ
         LoT2Ok/roJRTFOl8ZSFHtTTWVF0taiuEb31BBVFL1TreIFmTJGUqrcGO/4SKSAqR8d4D
         XNzNPk9wb/48xRtwq2NnXC8dGMYfCnqH7O+0sk7oPVCBOf2+xqLAV8hRiCMtbOU555Uy
         3DDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nTb00k1/dYvI4ehiN9PDOKgU2zbif57VigXWm2jH9AA=;
        b=ZYArSJ5yzVW3LZPNKVvgKmmd48TidNdpCUqVJbvG9uAt42+XYJxHTRshofR2Gq34jX
         7ia5aTSgSU84vS2H9fWYEsA+nbBpKBCNdDspYNwTkXVCgreLqVoB+RkTb1KI4WSXxTbd
         HuXFhF0dN/BOLrib+j1RBxB+2GpYWmrLh+CkeB9sXrEjWSsk/g1INeWK7vWqqhfGLpcv
         +1QVW/geYV9q65aGymG8EQvnTGaf1sqPWKlYIWngzUH8olqb8/pUN7SjW8lOjbvCd55I
         tCqMolq5o+jGWIXghAYNwY/6JHWdljZ5rZqDO/IOlF9BH+nbxKtRMKEX2tZ4/gy+PSMW
         1QMg==
X-Gm-Message-State: AOAM530HLAjjMoZ1CiKjxmk2b5j8uEu8B3EBqOxE9Eou93bFGRrfC0mI
        q+waNsHhOGGtvWsAZwBIl3mhvUXNOB8=
X-Google-Smtp-Source: ABdhPJyWOI3g0LJSG1KSr6cdneey6cTyOCfVNtGaVT6Bf3cfmpFWygdmlXDPvqRgOLW/2SDRg32FPg==
X-Received: by 2002:a17:90a:a484:: with SMTP id z4mr162864pjp.214.1589902988805;
        Tue, 19 May 2020 08:43:08 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:14f4:acbd:a5d0:25ca? ([2605:e000:100e:8c61:14f4:acbd:a5d0:25ca])
        by smtp.gmail.com with ESMTPSA id g9sm10396957pgj.89.2020.05.19.08.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 08:43:08 -0700 (PDT)
Subject: Re: avoid a few q_usage_counter roundtrips v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20200516182801.482930-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aa30fd0d-e107-f99d-3979-f6e0199f6a61@kernel.dk>
Date:   Tue, 19 May 2020 09:43:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200516182801.482930-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/20 12:27 PM, Christoph Hellwig wrote:
> Hi Jens,
> 
> the way we track reference on q_usage_counter is a little weird at the
> moment, in that we often have to grab another reference in addition to
> the current one.  This small series reshuffles that to avoid the extra
> references in the normal I/O path.
> 
> Changes since v2:
>  - increase the q_usage_counter critical section a bit in
>    blk_mq_alloc_request_hctx
> 
> Changes since v1:
>  - rebased to the lastest for-5.8/block tree with the blk-crypt addition

Applied, thanks.

-- 
Jens Axboe

