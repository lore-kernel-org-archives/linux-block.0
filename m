Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D58DC433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 21:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 719C120772
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 21:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="n5evo17B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgGAVqy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgGAVqy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 17:46:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C00AC08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 14:46:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f16so1188536pjt.0
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wjONa7q82dzBsUQaW0ebDLJ1j4kgUElOsbxfyx3mH18=;
        b=n5evo17BBwVoWpvhdLVOyCCCktGfOSXzRcLN/nE5aoxR3NgpgwHv0HTfeoaEAUxO9I
         1lBdKlCBU1cky5h9jPhcL2z6rB8K9KyAkqMcVPc/vzCy7KUPLcM7EnYUyKli5tdnBQWz
         tpAgWbkz9Y11/zvTeneBsn7bfUb/OKFR4yFAlluegkx5SGXJs2mJr+fF8HT9zPPYx9z3
         msQf2PnVdrRudiCuJf1CytyUnDd1vxrrX/5MP16qi+oqM5x/Jq5WnRibSNuGWvIIfI5F
         K9icn6z7wqIvmKLK2G5MHMY2/RsNhiZMA+6lilfvlRmVU89MDOHZP/mFkZ0bkcee3Xpi
         SGWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wjONa7q82dzBsUQaW0ebDLJ1j4kgUElOsbxfyx3mH18=;
        b=paE7eU61n3ZYa6/UDnCMi2pokx/aDRG/kvU8fwBSZ414Fvapcbevnfdf3S8ecb7ceK
         961okorM0HmovkpTR81ap96hx+xKKZfknSmaKwtjqZmb4jggsBjPE0ZPwdTo4VCLYOP7
         6CQO+4HzwkkkUOfhNDunl3VzXu2wis8MMiAbyJz3KtNzq45GYRLLc9wMlpDne8uZhw3j
         VJAWljpPZ1iXLjMtFc4n9Eu+lZiOuomVABndg76pGBiqxRIU4cRS0TZevAELR+yQpXYF
         00f5nv+udaIQnejkIYY7dQjIU6j2XQutZ6sjlLZqkiF0aVwC7217pzQiv6TN+94zyN2h
         W4/A==
X-Gm-Message-State: AOAM530kqnpQw26CCMGykjDf58z01qul689aysw4M0YLU1W7z85AkrpB
        5OcX4IZ8fPoS2z2rC4jas3RdZwmJMPrm2Q==
X-Google-Smtp-Source: ABdhPJxXytNT3jXaCwJP+y0SmkkKMnuTy8Urt5BDcN+WR8BUrQKg+XEGsqmMswdWD9K51WoU44zxXg==
X-Received: by 2002:a17:90a:d3d6:: with SMTP id d22mr29607106pjw.184.1593640013666;
        Wed, 01 Jul 2020 14:46:53 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ab5a:d4e:a03a:d89? ([2605:e000:100e:8c61:ab5a:d4e:a03a:d89])
        by smtp.gmail.com with ESMTPSA id i20sm6934752pfd.81.2020.07.01.14.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 14:46:53 -0700 (PDT)
Subject: Re: [PATCH] null_blk: add helper for deleting the nullb_list
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20200701042653.26207-1-chaitanya.kulkarni@wdc.com>
 <SN4PR0401MB3598CBDDC91C894992996DA29B6C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BYAPR04MB49657173EED97FAE92FEE156866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <812af519-7bb3-586d-14dc-d3a529b49b69@kernel.dk>
 <BYAPR04MB4965B21154FC796B1D4AAB07866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe505644-0cd0-0fa4-3dc9-aebc3e299660@kernel.dk>
Date:   Wed, 1 Jul 2020 15:46:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965B21154FC796B1D4AAB07866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 3:38 PM, Chaitanya Kulkarni wrote:
> On 7/1/20 12:08 PM, Jens Axboe wrote:
>>> Can we add this ?
>> Please don't ping me for something trivial just a day after posting
>> it. I'll queue it up, but it's not like this is a stop everything
>> and get it in kind of moment.
> 
> Okay I'll keep in mind unless it is stopping something important.

You also missed a signed-off-by line, so I can't commit it as-is.

-- 
Jens Axboe

