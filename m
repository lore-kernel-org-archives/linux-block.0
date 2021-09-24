Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAA6C433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 17:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 158036124B
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 17:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244845AbhIXRJK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344968AbhIXRIx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 13:08:53 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45208C061764
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 10:07:13 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id b78so8218896iof.2
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UQv2xOGmWnHLLcHLY2cWXxol7T6zqIVLp1QS89P4xLw=;
        b=OHypi8E88DYMoFcUnDxUb0EDi2bbTTm6kAFckn15r1JlUyvXx9n/ubyAUtbusxb8s1
         DimYZUoQMzgHymBHsRAojQ4iWS92Uxne6KwJGO05bsn2gARzfxD+go0KOycj5I6KdbLT
         SwjlIADecuKau2TWliNlT3SOrIfFaeoWctQgF8XLHiDv4S5iSNudm3NBnEdCXho6ia+d
         lOhYcYA7Y9XbveBjVou32R8X22KA1RLLP9gPZLZRTsbu9HoNNnmJM4iL5g/trDhavXDP
         RZ8ABmRA10VCvzqR3rBmTN3y/+f0kQf9X2CZAND+eaL0as3sRwop2ZOGPN5Q2itIpDF2
         mFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UQv2xOGmWnHLLcHLY2cWXxol7T6zqIVLp1QS89P4xLw=;
        b=MSPP8+wml8HEN4eQbNygld81dm5RmqKrHWPLQ+UYHTwuL8jN4tLwu+Pwg+37yADOdc
         pLpYibHRdJQOPwRMVQg4cx11n5GNCo64vV52UGTCRGZmFLGNjmoufW9fU/gCGpdBWOMS
         lcCDxqLBccygQkZ2tsx4g4DUjXGzyUFE8302bfQeFFbR+wF5mMlmNlWfOz1Ag15Xg8vF
         UIcug8iVfDw8LCA0f7JDfl1OHac8fI94xKMNlOjjDqg4k0KtEugcm2HizND1H7nwYRLq
         gkpQAA4NcM/UBybBS84Fa6ZnSKizDealBlOK+lptGZ932o+h/OdWTlpPaDnRWA+/dvMe
         N78A==
X-Gm-Message-State: AOAM531mlTYu8kyP9Atc0Xv/ZMuwWlO2p59Furii5n+w2zXohtxn2knk
        jalqZ9AsspdYQ+dyPyphEioAo347YMQEDyiVCgg=
X-Google-Smtp-Source: ABdhPJzMTJPdbCP3UNawi/9a9OcWdyU+YI5MUBo9m+b63uloGq2RXh3g23kabs4nXRcKQmb3tz8yCg==
X-Received: by 2002:a02:3213:: with SMTP id j19mr10261643jaa.17.1632503232629;
        Fri, 24 Sep 2021 10:07:12 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h5sm4297784ioz.31.2021.09.24.10.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 10:07:12 -0700 (PDT)
Subject: Re: [PATCH V2] block: hold ->invalidate_lock in blkdev_fallocate
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>
References: <20210923023751.1441091-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <11bf93eb-b3fe-5c36-78a5-dde9766602ef@kernel.dk>
Date:   Fri, 24 Sep 2021 11:07:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210923023751.1441091-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/22/21 8:37 PM, Ming Lei wrote:
> When running ->fallocate(), blkdev_fallocate() should hold
> mapping->invalidate_lock to prevent page cache from being accessed,
> otherwise stale data may be read in page cache.
> 
> Without this patch, blktests block/009 fails sometimes. With this patch,
> block/009 can pass always.
> 
> Also as Jan pointed out, no pages can be created in the discarded area
> while you are holding the invalidate_lock, so remove the 2nd
> truncate_bdev_range().

Applied, thanks.

-- 
Jens Axboe

