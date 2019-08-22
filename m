Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEF5C3A59E
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 01:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D62B22D6D
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 01:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWuCPOff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfHVBlD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 21:41:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44207 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727875AbfHVBlD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 21:41:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so2384934plr.11;
        Wed, 21 Aug 2019 18:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cmve+98ILYTXN2zA6jhwjwq7AFTYXqn7fwxiy9UT/Ts=;
        b=hWuCPOffRan2AGULbNSKephnvby1c2MzZxz7PPZEFiQqVP6e5/NiMjhfeTPGGLzlXH
         CiAg6OmnQde2UJC0UAhDtUH45xb3y7FaEjCeB1L48V5vUN0yyW4pEBZ7azbbzitlWAzf
         SaDlv5JN4MxUxOZegKKO3IAud18NVo00Wo1AjglbcerGldexxaLZ7oXjofxZxKX5/1r1
         UOgKczcNxFoGFuWvaAGrsKv3IjZIOSVL9Xk3A3K9TCN3nKj0aN5jGO4n/8WFuaub0tjl
         TitTK6kZlj5A+IdIz88HY4RCpVz/Bwqwf+bIjHt7/mh5K8n4q7ey7rJQz8sVz5NHAoSx
         MnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cmve+98ILYTXN2zA6jhwjwq7AFTYXqn7fwxiy9UT/Ts=;
        b=dkKG+f7VOL5fzNncm8aBcMs1OkfqjZzecHF9MXM3i9KHrZ1Rq3f1Fc+zvlMaOYLsTq
         3eXUl4hWcf4LILK/51bCT1SeBzSMu7+khJrLkX29FuXyxjOuylzgEzJb1U6BMZ6nvsWE
         IkJoJYExoxsSEi7ywTqRWOuUAMXjsFrWO4UbydhVDHpqQ5rkhCn1/nMlH5HMD3Q9HzHC
         AY1NevpRz0ga61S8eDWEUHuTzwHHXfDVJ59kOBJn0p0ZQjbLGKAVrpxtzIYC5f1JC/Yi
         DAetD7f+igRoOMdfMCIsUk4Ke7RL5hwiNQcXT6R7VVC6YxRDvJ1eMC1P65L+39V1TIlc
         7AuQ==
X-Gm-Message-State: APjAAAUv/NBmSy/HpoDHATQkIKe/JnfqEKeMJ2T4AG+joQ7iOsqn9gE8
        oSPO+/4V0C+1pFxoZEhJI9I=
X-Google-Smtp-Source: APXvYqxq78ERkQnesCE27keqgm9VHMwNknJ4whikJ1lXfQRlmnUyMbQIWWy39ey8xL4tPtoTkV1L/w==
X-Received: by 2002:a17:902:3281:: with SMTP id z1mr4422916plb.302.1566438062630;
        Wed, 21 Aug 2019 18:41:02 -0700 (PDT)
Received: from [0.0.0.0] ([47.244.239.6])
        by smtp.gmail.com with ESMTPSA id a128sm25045067pfb.185.2019.08.21.18.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 18:41:02 -0700 (PDT)
Subject: Re: Issues about the merge_bvec_fn callback in 3.10 series
From:   Jianchao Wang <jianchao.wan9@gmail.com>
To:     linux-block@vger.kernel.org, linux-raid@vger.kernel.org
References: <S1732749AbfE3EBS/20190530040119Z+834@vger.kernel.org>
 <e93566fe-febf-5e99-d3e9-96a0c1f6ba13@gmail.com>
Cc:     axboe@kernel.dk, neilb@suse.com, songliubraving@fb.com
Message-ID: <c91b2d29-1c5c-68a6-0471-32c21c5a93c4@gmail.com>
Date:   Thu, 22 Aug 2019 09:41:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <e93566fe-febf-5e99-d3e9-96a0c1f6ba13@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Would anyone please give some comment here ?

Should we discard the merge_bvec_fn for raid5 and backport the bio split code there ?

Thanks in advance.
Jianchao


On 2019/8/21 19:42, Jianchao Wang wrote:
> Hi dear all
> 
> This is a question in older kernel versions.
> 
> We are using 3.10 series kernel in our production. And we encountered issue as below,
> 
> When add a page into a bio, .merge_bvec_fn will be invoked down to the bottom,
> and the bio->bi_rw would be saved into bvec_merge_data.bi_rw as the following code,
> 
> __bio_add_page
> ---
> 	if (q->merge_bvec_fn) {
> 		struct  bvm = {
> 			.bi_bdev = bio->bi_bdev,
> 			.bi_sector = bio->bi_iter.bi_sector,
> 			.bi_size = bio->bi_iter.bi_size,
> 			.bi_rw = bio->bi_rw,
> 		};
> 
> 		/*
> 		 * merge_bvec_fn() returns number of bytes it can accept
> 		 * at this offset
> 		 */
> 		if (q->merge_bvec_fn(q, &bvm, bvec) < bvec->bv_len) {
> 			bvec->bv_page = NULL;
> 			bvec->bv_len = 0;
> 			bvec->bv_offset = 0;
> 			return 0;
> 		}
> 	}
> ---
> 
> However, it seems that the bio->bi_rw has not been set at the moment (set by submit_bio), 
> so it is always zero.
> 
> We have a raid5 and the raid5_mergeable_bvec would always handle the write as read and then
> we always get a write bio with a stripe chunk size which is not expected and would degrade the
> performance. This is code,
> 
> raid5_mergeable_bvec
> ---
> 	if ((bvm->bi_rw & 1) == WRITE)
> 		return biovec->bv_len; /* always allow writes to be mergeable */
> 
> 	if (mddev->new_chunk_sectors < mddev->chunk_sectors)
> 		chunk_sectors = mddev->new_chunk_sectors;
> 	max =  (chunk_sectors - ((sector & (chunk_sectors - 1)) + bio_sectors)) << 9;
> 	if (max < 0) max = 0;
> 	if (max <= biovec->bv_len && bio_sectors == 0)
> 		return biovec->bv_len;
> 	else
> 		return max;
> 
> ---
> 
> I have checked   
> v3.10.108
> v3.18.140
> v4.1.49
> but there seems not fix for it.
> 
> And maybe it would be fixed until 
> 8ae126660fddbeebb9251a174e6fa45b6ad8f932
> block: kill merge_bvec_fn() completely
> 
> Would anyone please give some suggestion on this ?
> Any comment will be welcomed.
> 
> Thanks in advance
> Jianchao
> 

