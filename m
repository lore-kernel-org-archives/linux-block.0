Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0944C433B4
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B654B6139C
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 15:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345668AbhDFPbJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 11:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhDFPbJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 11:31:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D54C06174A
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 08:31:01 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q10so10626830pgj.2
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gWpNTfiTpVy/WA8PqoSAnaQcafoOOwxhfZoskSOFjEw=;
        b=SCrUEAovq5NbMnLqaAjN6u41J1B1+Ruf4M/ZH1ZnzHeepRuPHaSKN+TQaHpPmHimn0
         v+wb2fSokk+65NkYYfn3pSgjt1VvnZQ3oRL4O2FtBmPjMgaSY07AcWmNmtKbQvhL1MDa
         vdcyK+kxoVqiwz9QSEj56QcMVqTh0nlvzo+u6qxdb9/9lgK5VZGAQirHB60gJAlDSYPy
         mUyVY2OIzRSLZUIrVV5cUOUp6yn7RqCOEqSIk63s6Ig686TGpf1wjf6zXg3ed3ceOXGg
         ygjxFl1bcS0u1a4Pb8P01Ww4hxzo6ArMDI/G15p81EodaFkFwMsvhFboRF0fi9qhRfcX
         HcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gWpNTfiTpVy/WA8PqoSAnaQcafoOOwxhfZoskSOFjEw=;
        b=cCSG0pHpcbN9JL9EOkMArEcGA9Bd3axr/kcv99bmjTE4pSUgP7clhmPu20DEFK3Ysl
         bM0reTXaoWdL+TNkX6Ow0/fT4p9igH2pcx5AHviPLx4J1jHW/82lF4og5G8CtzKjMTTO
         ZsKqTGcDXMIHlZ95Q+q6EN9l5cTMor59SLF4WBmiLW7A5mkJcNiEB6HhrwLVUXcOThNm
         qdHnRKJV7uO7ZwdbU9Lw0PujLjf0ao3XyYRbpn/Z7tkFYkDGBJ4DWCSLRHXZ8hL4tbhg
         Dsyo7zjnnWqYRw4TeFyKZEYsv9rT/PYv9+92JhwCEorMpDJqGCq4mFiOohDcALANqOud
         JNug==
X-Gm-Message-State: AOAM532hgasQjUl7VWeGpDG39xl8Z+LsCdAWHlnnKJtQ41dkW0xtyhbl
        /95WWPGwt2iavjQVFPMQoxpYXoz5XtFdqw==
X-Google-Smtp-Source: ABdhPJxN3uIyAuxYacScxp31xlInS/p5jCUAcM2JlseAQZxbfBNfGlKApMj/Huj3Db2ynHaz2XMTjg==
X-Received: by 2002:a65:5584:: with SMTP id j4mr27796826pgs.356.1617723060892;
        Tue, 06 Apr 2021 08:31:00 -0700 (PDT)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id t8sm2090007pfq.59.2021.04.06.08.31.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 08:31:00 -0700 (PDT)
Subject: Re: [PATCH] floppy: always use the track buffer
To:     Christoph Hellwig <hch@lst.de>, efremov@linux.com
Cc:     linux-block@vger.kernel.org
References: <20210406061755.811522-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <879e9ac5-7e31-efbb-bb53-1587b678fc30@kernel.dk>
Date:   Tue, 6 Apr 2021 09:31:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210406061755.811522-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/21 12:17 AM, Christoph Hellwig wrote:
> Always use the track buffer that is already used for addresses outside
> the 16MB address capability of the floppy controller.  This allows to
> remove a lot of code that relies on kernel virtual addresses.  With
> this gone there is just a single place left that looks at the bio,
> which can be converted to memcpy_{from,to}_page, thus removing the need
> for the extra block-layer bounce buffering for highmem pages.

Applied, thanks.

-- 
Jens Axboe

