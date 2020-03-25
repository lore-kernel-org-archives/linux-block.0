Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA3EC54FD2
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 02:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6554F2070A
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 02:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="z+RXmN+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbgCYCnC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Mar 2020 22:43:02 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38845 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgCYCnC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Mar 2020 22:43:02 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so397662pje.3
        for <linux-block@vger.kernel.org>; Tue, 24 Mar 2020 19:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CS/beafctG+C5hR3ch6Lqy4XowsOGkKfFF2Q+rVKwIU=;
        b=z+RXmN+rxSeajuU//jhrlLEvjpOtUglSociFnWFPOxwZb8AA4oJkkSbbC6SIJ8f7qX
         kSppEjXsxYx90ydHugEEozCgObaO+RlJpzgnlISTOdRjC0M10Efw7mS6gKQgLLHyDUIN
         CPRtgEXUCAfOo38AiXssi8i8eWUlFyXLXbt0AI/+FNJSvXCg4kLc7KpluSTY5spQH9V7
         NwYD/F1iG6DGh5Gk2ME8wCYmqw1oWIlWtHVVmuriltntKT9kRVpaCBDYqW4Cw+WSRQms
         u9+WfsfTCvfwsmavsAT/5Cgos8QusR8Ul+KGqiWic6/MuI+q+YkYaL7ew4BYts2b7CdQ
         B+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CS/beafctG+C5hR3ch6Lqy4XowsOGkKfFF2Q+rVKwIU=;
        b=oCg/viGfg75ZHxlP1MSj/l7wnRXG2E74a3l/iTPGR9IXgbXUKq2XsPeZe0YgrjFfYA
         Pzw9o35E0wCIZ2K8SA7ZlR7pUDRawgxTBsbdOMGelzV+HptxHEzIyBhn/aElb4DDaHiD
         1GF0aS9wEUZiRcdBR662QxBN2xBS8NMuIiWg1pTDZXsk/xu/BSCMogAt/3GMMG3VfHRX
         lHeklVT8qqymovqiUSUHrLutC4kUjNnvkmm5aAZwKDHXN7a94F+mLyHq0YNff2BY4bPL
         onujQjq0FQtJXqR66Cq5rn1ZPqfK/QHuq0BFBKxctCwZ3EjGWJhFgquN3cDGn5XvusDB
         inCA==
X-Gm-Message-State: ANhLgQ2RVWl+jbTLKaxlf5phRNKo87f+oxY8Otl9rtoklinbLDwnsGL6
        uS7GnG137FYv0kkpRb/hw/bzYQ==
X-Google-Smtp-Source: ADFU+vsQ/7y3CNr2IMZW/MIxMb6i127mirIU1vQB5xx9n5L31mCiy9GMW1gtQ1cOxjBP0Du9z6xbow==
X-Received: by 2002:a17:90a:dc83:: with SMTP id j3mr1099475pjv.64.1585104179693;
        Tue, 24 Mar 2020 19:42:59 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id a24sm16827409pfl.115.2020.03.24.19.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 19:42:59 -0700 (PDT)
Subject: Re: [PATCH 1/1] bcache: remove dupplicated declaration from btree.h
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
References: <20200325013057.114340-1-colyli@suse.de>
 <20200325013057.114340-2-colyli@suse.de>
 <6577c33f-5e57-f34a-8bbc-a4c17e124e11@kernel.dk>
 <364bfce6-7bbc-6bfa-fcc1-3dbb97c1acec@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f165ad0c-c78c-d738-269b-8a6433b0bbac@kernel.dk>
Date:   Tue, 24 Mar 2020 20:42:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <364bfce6-7bbc-6bfa-fcc1-3dbb97c1acec@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/24/20 8:32 PM, Coly Li wrote:
> On 2020/3/25 9:57 上午, Jens Axboe wrote:
>> On 3/24/20 7:30 PM, Coly Li wrote:
>>> Commit ab544165dc2d ("bcache: move macro btree() and btree_root()
>>> into btree.h") makes two duplicated declaration into btree.h,
>>> 	typedef int (btree_map_keys_fn)();
>>> 	int bch_btree_map_keys();
>>>
>>> The kbuild test robot <lkp@intel.com> detects and reports this
>>> problem and this patch fixes it by removing the duplicated ones.
>>>
>>> Fixes: ab544165dc2d ("bcache: move macro btree() and btree_root() into btree.h")
>>
>> Applied, but I fixed up the commit sha, not sure where yours is from?
>>
> 
> I should use the sha from your tree, not mine. I just realize with your
> SOB the sha number should change. Sorry for the inconvenience, and I
> will notice such condition next time.
> 
> BTW, you still find such issue by your own eyes, without any extra tool?

Manual inspection, to try and avoid cases where the sha is either too
short, or just plain wrong.

-- 
Jens Axboe

