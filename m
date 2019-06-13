Return-Path: <SRS0=P8f/=UM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 894B9C46477
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D157207E0
	for <linux-block@archiver.kernel.org>; Thu, 13 Jun 2019 15:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Bo0PlQP8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfFMPi3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:38:29 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:39546 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfFMKGZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jun 2019 06:06:25 -0400
Received: by mail-ot1-f44.google.com with SMTP id r21so18393103otq.6
        for <linux-block@vger.kernel.org>; Thu, 13 Jun 2019 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JgKtp+EVGe0+8Rc9lPcH24Uo2h5Omb1JSYyyLbVl3aU=;
        b=Bo0PlQP8Crp3OFg26PDH6POmMArttBDrAlU+wwo7QxP0IYimixiOB982bo/8/rg374
         cvsh0vzg24JnvfdLjIPaLSCi9NzOdxxee8Vlrvq5nhkoX0fe22rPQVE3XL9/ccgBtxJg
         ilAtAeaKCHViTiN354G58cC6h6rKM08Sm13+yVE51HyF/45EBYGBplFhEA1+vJEobGor
         KQ0orhQt0FNVgoiCc467Zt5dH/knGL3kR6wxZBULJ3B3vLpzL8Re8hXbgN2FvGyI8Gmt
         xGDJbX6xV8+6q6cutYCzMGB4GGp5/vAiVUsAkDKBF/T8ndtZ2u+oHxDty2gDh9Ve/PY4
         mx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JgKtp+EVGe0+8Rc9lPcH24Uo2h5Omb1JSYyyLbVl3aU=;
        b=oUFdbobXemgE2Va8p6EGAx7cxC11wY0DdBSf3BRcPuVEo+FKLFExeKhx2VWTvLs6iX
         d/b4ekhU+Ch2hSO1KGwdvwE9vlthClXlpKyhyQHPhbXKl2PNzi/TlsWU6K681pkiaRBA
         GBOadxpXyVfUsD8/9b3gk/YbEv2eFRU5O3iESqRHkl4ni+qHEQTmbZ6Qn0MLmCGWk1bX
         WQiaZrr5fcf9ZRtvn1epD4dgEWV14OkK0VS3JcG+LRjnzeghJg2ef100/9Ym7gMBk3y8
         rw875o4bPnsWRsq44pZuEPbcuupFhwaUAr0NrEOIf/sEGAnyYecw/V+L6xdBhFLDmzsq
         BpZw==
X-Gm-Message-State: APjAAAUnan/LZfxyyTyuYo6ny96kokGSwGnPghegx2P2GMMm9RiShUvr
        E9f3e6iWczet7G+AFiVkVp1CHg==
X-Google-Smtp-Source: APXvYqzYLFkrTVkgnHY4W6nYMSsB9WdZG16Yj2xmRUCUrhdWBhgSPErFYawiIGsEv/xg9cp39VdTFQ==
X-Received: by 2002:a05:6830:1250:: with SMTP id s16mr3169397otp.158.1560420384602;
        Thu, 13 Jun 2019 03:06:24 -0700 (PDT)
Received: from [172.20.10.3] (mobile-107-92-59-183.mycingular.net. [107.92.59.183])
        by smtp.gmail.com with ESMTPSA id j204sm820809oif.37.2019.06.13.03.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 03:06:23 -0700 (PDT)
Subject: Re: alternative take on the same page merging leak fix v2
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20190613095529.25005-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <00c908ad-ca33-164d-3741-6c67813c1f0d@kernel.dk>
Date:   Thu, 13 Jun 2019 04:04:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613095529.25005-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/13/19 3:55 AM, Christoph Hellwig wrote:
> Hi Jens, hi Ming,
> 
> this is the tested and split version of what I think is the better
> fix for the get_user_pages page leak, as it leaves the intelligence
> in the callers instead of in bio_try_to_merge_page.
> 
> Changes since v1:
>   - drop patches not required for 5.2
>   - added Reviewed-by tags

Applied for 5.2, thanks.

-- 
Jens Axboe

