Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7576BC433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 19:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353227AbhLCTNI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 14:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344093AbhLCTNF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 14:13:05 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F90C061751
        for <linux-block@vger.kernel.org>; Fri,  3 Dec 2021 11:09:41 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id p13so3789442pfw.2
        for <linux-block@vger.kernel.org>; Fri, 03 Dec 2021 11:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1+IcsWlHKhBlBvu1qEIJjd7+fBRe9hWKiFkgC7AgVn8=;
        b=qMOpALv0YRVU6bM2Nhr6i3G9mvYp/1ZI4ftafuss3wOwGmLNPKdIsoygM0ucM2Fwrm
         OKq3jlwH0zvltJrZF3VFrCafFxRtrAkmFuf62J5OpkL99rpcKyj+gYvfPpcGr1gApfoU
         V/nMatv0LE9nrRRq6uQDr9IOj8lySL2OFiWBLRCNI3xUAFwjWUAhyvrsvB+/1FwKnqoc
         9wzTwu231a5+XjRsoLm085ZTfI/f4FolwG6YO5SS2RwMJbuKnoQTEq4IFy4cOoBnPO0i
         42kgZuNUIWUVbHZCna0R6U4RsXSiaKLnqICn+0SMMnIkoCXzxZcQshZAbSLS6Htjqb23
         0GjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1+IcsWlHKhBlBvu1qEIJjd7+fBRe9hWKiFkgC7AgVn8=;
        b=WQdUcjqyyMMTb8w2LYEQPKF4uy78JFJRLS34Tfty3z+qSCCILncYIZiBRThR6mD7n4
         NACkonNZZND7FpeOQlq38o2wRaf0NBm52tYqLNaoeu6sZoWG//NZhV50vC7jzVTicYEh
         RuczD1FFOY+qvlOUp9Br4IJGEHt/xIh/SSeIGSE3aCaam1ocIlI1JNppRFj/OdXfQlGX
         hi6qELJ23O5Vu2JcO0SkwoiPGhPMo/lHtzA/GTpR5SqPnKuCvXvY60ihVLuvR356O79T
         tb1/k/fi4RudiMGnBl+XULORymY6D+NC31JuNDxcJCnGUPHyIe8grJf/jBzjjvlqj23+
         5HWg==
X-Gm-Message-State: AOAM530LGEjTTA7G5j5A5EIKdBEsDb2Fuzm43WH6vUKUIf5U1hr/1/pp
        RJ/WXpFY9yDuCkWTHYlaM8QIGg==
X-Google-Smtp-Source: ABdhPJyumXfOqHJei3KoVpScj60uiK1Xgi20WATKU+zPu3LuTE5MYtc55FZjI9X6SNIWq95ZWNP8Og==
X-Received: by 2002:a63:914c:: with SMTP id l73mr5962074pge.384.1638558581140;
        Fri, 03 Dec 2021 11:09:41 -0800 (PST)
Received: from ?IPv6:2600:380:7445:97b0:c22:6d1:fc86:abf7? ([2600:380:7445:97b0:c22:6d1:fc86:abf7])
        by smtp.gmail.com with ESMTPSA id g21sm4031877pfc.95.2021.12.03.11.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 11:09:40 -0800 (PST)
Subject: Re: [PATCH 1/2] mm: move filemap_range_needs_writeback() into header
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org
References: <20211203153829.298893-1-axboe@kernel.dk>
 <20211203153829.298893-2-axboe@kernel.dk>
 <YapC9cl6qsOAjzNj@casper.infradead.org>
 <f94d0fe4-1fc9-4c2d-f666-8ccf4251b950@kernel.dk>
 <5e92c117-0cdb-9ea6-3f1c-912e683c4e51@kernel.dk>
 <89810ae4-7c9b-ec8f-5450-ef8dc51ad8a4@kernel.dk>
 <97e253f7-d945-0c6b-3d8b-dcf597f04f69@kernel.dk>
 <YapYAt7+r7K0aQ3+@casper.infradead.org>
 <e386e230-4eef-f4da-f327-9b0f1d33fe47@kernel.dk>
 <9cabdcc3-e760-bab5-edfe-ae225e5d4db9@kernel.dk>
 <Yapeosr1ByRBEdgT@casper.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aaccdffc-876d-ab24-787c-09725ca3d929@kernel.dk>
Date:   Fri, 3 Dec 2021 12:09:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yapeosr1ByRBEdgT@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/3/21 11:14 AM, Matthew Wilcox wrote:
> On Fri, Dec 03, 2021 at 11:01:14AM -0700, Jens Axboe wrote:
>> On 12/3/21 10:57 AM, Jens Axboe wrote:
>>>> I'm happy with this, if you just move it to pagemap.h
>>>
>>> OK, I'll try it out.
>>
>> Wasn't too bad at all, actually just highlighted that I missed removing
>> the previous declaration of filemap_range_needs_writeback() in fs.h
>> I'll do a full compile and test, but this seems sane.
>>
>> commit 63c6b3846b77041d239d5b5b5a907b5c82a21c4c
>> Author: Jens Axboe <axboe@kernel.dk>
>> Date:   Thu Oct 28 08:47:05 2021 -0600
>>
>>     mm: move filemap_range_needs_writeback() into header
>>     
>>     No functional changes in this patch, just in preparation for efficiently
>>     calling this light function from the block O_DIRECT handling.
>>     
>>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Great, thanks for the review Willy!

-- 
Jens Axboe

