Return-Path: <SRS0=t87n=EI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E99C00A89
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 21:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722CB208B6
	for <linux-block@archiver.kernel.org>; Mon,  2 Nov 2020 21:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="T1OsrJPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgKBVZX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Nov 2020 16:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgKBVZX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 Nov 2020 16:25:23 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B972C0617A6
        for <linux-block@vger.kernel.org>; Mon,  2 Nov 2020 13:25:23 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id p93so15809352edd.7
        for <linux-block@vger.kernel.org>; Mon, 02 Nov 2020 13:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ErXtsrQtnPHS/yrrmKnFAGpvVrStovvmDs/h6X+o2Kk=;
        b=T1OsrJPXcFFSGtp8F7h+S/7uD+v2lSE76hmz6zjXYRDWFmaoxNDX/bvbmvtwczmW13
         Ky1c1qR+7TXGyzI+dJc0AZvcJvrQDDplA1jQjh/9db/RXYP9c3siY42KD7AuQsiLHQhn
         AWOHg4K4CVLz2vct+GPiGSKzt1CRyax7GIm+V3bQjUqFWnuWe8VkhL3gspcGzpTVHHHr
         cNI+WuDmonBPY5deLYY55XjEd7hnVvkqy1a2Nr0r9ygrI8oTDIigUGkhLlxUADlbB2SP
         5A3PlsNqXBrUfrxFIJW+4n5+IIO7n1mlkMk1jX6pEGVwRBIQD8mvRd9aKDp4+N4kF68K
         tNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ErXtsrQtnPHS/yrrmKnFAGpvVrStovvmDs/h6X+o2Kk=;
        b=QaxUCUqNOWBn/BHTJbpwHGptyFgxKPw5osN7Xp8hsq7ZF/L/44V6ODXS43ITCtsRrF
         zXXMUNURKGtDPPhz3HCjKowVpSuH6THmBezZ42gm8d9rj8C0Qurz98TIS3dJFyKvMrGF
         yZgYTYJ7Pw+gmtaYvegHkB/kMjfKS7RjPK1fQDcASiR8AUaFYg0cXhXS5h+/SsZARL9n
         PVcQOhvffKPv7H+fbBIizlOuKcF1lTtei+6g3vXbrrRaYxLFqoStvSAR+/MtOnc61H7Z
         MsNCLSFADXtWtlEauWcGMI0z2JFd6hDi5e6n2ocPCA4KEFNoU5D5zQ0rPVwRijbEJSjz
         vUYQ==
X-Gm-Message-State: AOAM530b1/B/ehLvornCdxADu6sITjHVBzh2H29/BS0HxxsJWJHDVzQl
        jJE6oja45FRKYdjG0/fvnyO4Vg==
X-Google-Smtp-Source: ABdhPJy+GKJTD8cN2G1oG+Nx4+B0Mh1+7ZE6Qn3hgyNAOyoFgGPObmuvSlpuAwDy6D65aYu0wftNDg==
X-Received: by 2002:a50:8d48:: with SMTP id t8mr19008866edt.228.1604352321965;
        Mon, 02 Nov 2020 13:25:21 -0800 (PST)
Received: from localhost (5.186.126.247.cgn.fibianet.dk. [5.186.126.247])
        by smtp.gmail.com with ESMTPSA id bn25sm2240600ejb.76.2020.11.02.13.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 13:25:21 -0800 (PST)
From:   Javier Gonzalez <javier@javigon.com>
X-Google-Original-From: Javier Gonzalez <javier.gonz@samsung.com>
Date:   Mon, 2 Nov 2020 22:25:20 +0100
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "Klaus B. Jensen" <k.jensen@samsung.com>
Subject: Re: nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201102212520.4nbq47wkbn6fmrsc@MacBook-Pro.localdomain>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102163000.GA203505@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201102163000.GA203505@localhost.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02.11.2020 16:30, Niklas Cassel wrote:
>On Mon, Nov 02, 2020 at 04:15:01PM +0000, Javier Gonzalez wrote:
>>
>> From: Keith Busch <kbusch@kernel.org>
>> Sent: Nov 2, 2020 16:45
>> To: Javier González <javier@javigon.com>
>> Cc: linux-nvme@lists.infradead.org; linux-block@vger.kernel.org; hch@lst.de; sagi@grimberg.me; axboe@kernel.dk; joshi.k@samsung.com; "Klaus B. Jensen" <k.jensen@samsung.com>; Niklas.Cassel@wdc.com; Javier Gonzalez <javier.gonz@samsung.com>
>> Subject: Re: [PATCH V2] nvme: report capacity 0 for non supported ZNS SSDs
>>
>> On Mon, Nov 02, 2020 at 02:22:14PM +0100, Javier González wrote:
>> > Changes since V1:
>> >    - Apply feedback from Niklas:
>> >        - Use IS_ENABLED() for checking config option
>>
>> Your v1 was correct. Using IS_ENBALED() attempts to use an undefined
>> symbol when the CONFIG is not enabled:
>>
>> Oh. Ok. Will return to that.
>
>Keith is correct, sorry for that.
>
>https://www.kernel.org/doc/html/latest/process/coding-style.html#conditional-compilation
>
>"Thus, you still have to use an #ifdef if the code inside the block
>references symbols that will not exist if the condition is not met."
>

No worries. Thanks for pointing this out - I had seen code with
IS_ENABLED(), but I had not done the necessary reading to determine if
it was something I should use or not. Now I know :)
