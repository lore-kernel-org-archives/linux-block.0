Return-Path: <SRS0=MRnn=WT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9054C3A5A1
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 01:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06D0233A2
	for <linux-block@archiver.kernel.org>; Fri, 23 Aug 2019 01:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jgRpaP00"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732419AbfHWBbS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 21:31:18 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:37231 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732066AbfHWBbS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 21:31:18 -0400
Received: by mail-pg1-f170.google.com with SMTP id d1so4764338pgp.4;
        Thu, 22 Aug 2019 18:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AaXsnTKtP47oXajBmBJsGeysTzR1VLn1aOYPmPT/Cxc=;
        b=jgRpaP005EM+92VoDdLUy1cI28P0HLP7FHmXE4Uwb6paFQ0sg4BdAQZmccpC1YVlSA
         n6/LAMsKfD8Sz3SXVimjrDeMj/tWeR/B00ARbGfkCsAr73H2gsswLOl5NZa51gSYfT+G
         DZbAK6HecdJy09ZQp6Vv6+jdMAtpwGgPHeyxgKyqFPkqia304OkdMN8m6Ap9+0YfkOxS
         OBdS1JDeCRaXcH4Fp0YSdVgtFTSl0c3tNK59TSok7qklmLz+wEqJ1NewuaupdCFl2e+Q
         d3TQMUPqtA05NT/C9oo3BOZjz2D0zNmWyqAumaZReZekTsU7/FYk+Qe7AjsRaRArdZri
         P4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AaXsnTKtP47oXajBmBJsGeysTzR1VLn1aOYPmPT/Cxc=;
        b=Y2RoPSK7V7G1DM5MQb61UdXKuKVgrLx6BB1fusA2pcM6bm6V93Q9zmgIvpsNbVeC0V
         n4M5R172+kKXzF9VYH4QlwdfoCSaVn00xuU3OThWXQnv0H0aLaE6jZhOGou24Rm98lZw
         yn+O1It0+NnLOoCa9ItE6GKuWJVc7KvzWhZtpTIuJnwSV+SPIhIyfXDPktXDnaYvEZqn
         u/UOg17BzeZYo+3XSWE3ZzMolfaGBy/dp7o3cEMRwvSQyj7FdnV0G1WkKB6idTWDB+Y3
         mDd0Q39WLNQ1xI0U5O7dadVt4D5AF1lVgAIilZYfdHP70f/d3EV2egmDhK/vOM1ZKyUR
         Z+wg==
X-Gm-Message-State: APjAAAWaCFhPqoxyaTPg76+GUIR+rndMOgcDOjbGKNPUY0UiSGtfA2xh
        l69Nt4yr4frWs2+Ip6RCyH0PNhoc
X-Google-Smtp-Source: APXvYqzUbIea0jV6eJh+QH0EdGJXt58bi1sw8oOkAmGt2fPpmSqgKACoVuJoMziTn06uA1hWtmk/Kg==
X-Received: by 2002:a17:90a:1a8d:: with SMTP id p13mr2703732pjp.15.1566523876969;
        Thu, 22 Aug 2019 18:31:16 -0700 (PDT)
Received: from [0.0.0.0] ([47.244.239.6])
        by smtp.gmail.com with ESMTPSA id d3sm786901pjz.31.2019.08.22.18.31.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 18:31:16 -0700 (PDT)
Subject: Re: Issues about the merge_bvec_fn callback in 3.10 series
To:     NeilBrown <neilb@suse.com>, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org
References: <S1732749AbfE3EBS/20190530040119Z+834@vger.kernel.org>
 <e93566fe-febf-5e99-d3e9-96a0c1f6ba13@gmail.com>
 <878srkheuq.fsf@notabene.neil.brown.name>
From:   Jianchao Wang <jianchao.wan9@gmail.com>
Message-ID: <63dde895-3e52-52a1-7e6d-69f5ca06ebd7@gmail.com>
Date:   Fri, 23 Aug 2019 09:31:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <878srkheuq.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Neil

Thanks so much for your suggestion.

On 2019/8/23 9:04, NeilBrown wrote:

>> I have checked   
>> v3.10.108
>> v3.18.140
>> v4.1.49
>> but there seems not fix for it.
>>
>> And maybe it would be fixed until 
>> 8ae126660fddbeebb9251a174e6fa45b6ad8f932
>> block: kill merge_bvec_fn() completely
>>
>> Would anyone please give some suggestion on this ?
> 
> One option would be to make sure that ->bi_rw is set before
> bio_add_page is called.
> There are about 80 calls, so that isn't trivial, but you might not care
> about several of them.
> 
> You could backport the 'kill merge_bvec_fn' patch if you like, but I
> wouldn't.  The change of introducing a bug is much higher.
> 

I have killed the raid5_mergeable_bvec and backport the patches that
could make the chunk_aligned_read be able to split bio by its own.
Then I just need to modify the raid5 code and needn't to touch other part
of the system, especially the block core.

It seems work well till now.

Thanks again
Jianchao
