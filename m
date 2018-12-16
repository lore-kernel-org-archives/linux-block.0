Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4CC0C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A42C2084D
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EJP0EsHw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbeLPQh2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:37:28 -0500
Received: from mail-pl1-f176.google.com ([209.85.214.176]:46499 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbeLPQh2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:37:28 -0500
Received: by mail-pl1-f176.google.com with SMTP id t13so4949526ply.13
        for <linux-block@vger.kernel.org>; Sun, 16 Dec 2018 08:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uQelcvQuvxc/OKsiS0eYxCsckrOmZr6nWztNBJgUN8I=;
        b=EJP0EsHwUPRi0O+B9TKl4xfWeNe16P8XDwf7VVn6HhaKH4O/tO/Jj89dyYbF4U44iC
         U0l+dBbpUcHIOAJynYeSyq2pYZ+/GZY3X/O6YcgVfbVqNtBA9TYULDsJK/JKJlHbiqrJ
         rODWoycIVWPR/Vsw6O+fs6esuoseT8KTtszKQy/sMXeVfl8o+hGdJn/PYQXCTrrcHZ9q
         X2UyPanPIa+8P6WCNI+FSyL8qxMpoJJ2VO59sm9SOkROV0ueDqAKZ7HHtv25QTXgps6B
         os1UZrmsAbqph21BYhj2QA1jtydtYi8H8ctmf7ypD2VHc837EqogTj7AGky61cOtAX4U
         3epg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uQelcvQuvxc/OKsiS0eYxCsckrOmZr6nWztNBJgUN8I=;
        b=PUY+RqU5AUJs6/2PFBzfise8/M+ho2GzYbQEVaWx73qivK2u6wNPiHnE4no1FOtSHv
         9ZjOLq51Kw0Y77nfHiInIlCCre0DUFxvnm4hST4SzXrNythdoS+Al9JfB8dv05Lxhtww
         y6JKkMFPUwqg1ldqbsVap3NAAUIChged0g9B7sIM3gXaP0PBOg7/evvh0Qn8Rmxt1G5W
         xLCfpMr1bB8yFGTwYgnj/KM9nadM9MasdtZtFOaRbZ9AF3D2yytdo9xTB9cf7TC9j1gx
         +BSsncjDJsFTGlx8Ibe6+h+RfgVt9P0sPyPzjkmnJ7nqu5w2NK9Xv3VbWrtQrk0b+d1d
         6zUg==
X-Gm-Message-State: AA+aEWZ2L96Vrw0QN9/X6ay2QMYaBbeX1SxdaNuWdAVcC3C3xGgPKIMt
        oHPvCRXcBsWe3ADVWVHTqMZ2OQ==
X-Google-Smtp-Source: AFSGD/XvMBSuwOgTFh5AzOHiyaIOc+Voq1wxDEzKug6JYJX8J5qBPXohJmqkaNVZzE37TcPn5FA5Gg==
X-Received: by 2002:a17:902:bd92:: with SMTP id q18mr9903117pls.167.1544978248031;
        Sun, 16 Dec 2018 08:37:28 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v62sm18642891pfd.163.2018.12.16.08.37.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 08:37:27 -0800 (PST)
Subject: Re: [PATCHSET v8] Support for polled and buffered aio (and more)
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, jmoyer@redhat.com, clm@fb.com
References: <20181213175645.22181-1-axboe@kernel.dk>
 <20181216163405.GA13234@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2c38c940-414f-519a-c938-8d94c249e477@kernel.dk>
Date:   Sun, 16 Dec 2018 09:37:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216163405.GA13234@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/18 9:34 AM, Christoph Hellwig wrote:
> Any chance you could send the series that just optimize the existing
> aio code and don't need new interface as an initial prep series?
> 
> Batching things up should make it a little easier to review, and with
> a little luck those "simple" patches might still make 4.21.  Make
> sure to include Al on the series, please.

Sure, I can do that. So basically all of the optimizations, but none of
the features (like polling)? Would require serious refactoring though,
but not impossible.

Or do you mean everything up to polled IO for old style aio, just
excluding the new ring interfaces?

-- 
Jens Axboe

