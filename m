Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C39C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 16:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352811AbhLCQ1s (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 11:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbhLCQ1r (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 11:27:47 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963E2C061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 08:24:23 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id r2so3202854ilb.10
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 08:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=90CXXtDpoUXsCo9nfedaj/1T+6Q5B8bTEgHzXVw9Azg=;
        b=BEA/2s/Ki1dcqnOLbISZDLo523f66wo+rNtxnt2qu+NWh6R3o5MfS+plPKn5aoixJR
         S+tZfnVsktxD7YTHpzaC0dGsvg17jNS7AQmNkUaR0m7ErABrxbcTEYDcF5rzLS2Fueqv
         Xznf/x4sNinuDQS4/7lrK5Junm4y7z6Tz8pO9ghLArFrVsiCkf/jeSzY7DtvrlqRUcvU
         G4Iz9n6J4cy3m/7h2zWXUBKCgVBq++B2toAEtGkQRjZ/fzxg2OgE4aLvkRefbVRBAVnD
         G5JtIHAjZM53/RPt1E7CPDh3Pw6kXq0I4bvl10IQhRm1cGzMKUJSLuB74u+zIXGojeKU
         P3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=90CXXtDpoUXsCo9nfedaj/1T+6Q5B8bTEgHzXVw9Azg=;
        b=CN2B96+V6ZOypU13nIV+z+YNVAsWaomWqD2vQTat+XKLKn+gD8/fZrDzGqk2u/k+m6
         aVH72LNA1twx6cg256y3zBULlTE/j2wp23KKnfUEEkzhMk8Ao9lBw4/KyWyJZ20/bYL2
         UFYTsswSId6ZZzBBAS2mcU2erA3kmfiDFARcHg+FsHxMrH+LA8Qykz+29dFRlYnzuc00
         Y7KBQsXHA+kR1Lz8it2R1lBv+rYHsISHHvIJsTly9iRXcktLBKKsc4sLW5RBwUM0/NVk
         lfYVFjUfVTpWYSQUKzFTzniskpl8ThC4pNBQFOQXtUhb+f46hQsyRIxQRgcaNA3wWEFL
         ICVw==
X-Gm-Message-State: AOAM530vEEKmH9c+joud/0HgccC66aIDSiBvOsxEiBA5DjKyOf+wt9Rb
        iEfogopcfXVVNc9lH8+LHLP3D7x/PReCC8Ul
X-Google-Smtp-Source: ABdhPJx5erd2UltLNVhrz213l9bb+UP/nNHH8z+CV9vve2u95cTnxRmr1Rp8cnbM+tVx07fBIXOMyw==
X-Received: by 2002:a05:6e02:2191:: with SMTP id j17mr18775516ila.120.1638548662948;
        Fri, 03 Dec 2021 08:24:22 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s20sm1852941iog.25.2021.12.03.08.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 08:24:22 -0800 (PST)
Subject: Re: [PATCH 1/2] mm: move filemap_range_needs_writeback() into header
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
References: <20211203153829.298893-1-axboe@kernel.dk>
 <20211203153829.298893-2-axboe@kernel.dk>
 <YapC9cl6qsOAjzNj@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f94d0fe4-1fc9-4c2d-f666-8ccf4251b950@kernel.dk>
Date:   Fri, 3 Dec 2021 09:24:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YapC9cl6qsOAjzNj@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/21 9:16 AM, Matthew Wilcox wrote:
> On Fri, Dec 03, 2021 at 08:38:28AM -0700, Jens Axboe wrote:
>> +++ b/include/linux/fs.h
> 
> fs.h is the wrong place for these functions; they're pagecache
> functionality, so they should be in pagemap.h.
> 
>> +/* Returns true if writeback might be needed or already in progress. */
>> +static inline bool mapping_needs_writeback(struct address_space *mapping)
>> +{
>> +	return mapping->nrpages;
>> +}
> 
> I don't like this function -- mapping_needs_writeback says to me that it
> tests a flag in mapping->flags.  Plus, it does exactly the same thing as
> !mapping_empty(), so perhaps ...
> 
>> +static inline bool filemap_range_needs_writeback(struct address_space *mapping,
>> +						 loff_t start_byte,
>> +						 loff_t end_byte)
>> +{
>> +	if (!mapping_needs_writeback(mapping))
>> +		return false;
> 
> just make this
> 	if (mapping_empty(mapping))
> 		return false;
> 
> Other than that, no objections to making this static inline.

Good idea, I'll make that change.

-- 
Jens Axboe

