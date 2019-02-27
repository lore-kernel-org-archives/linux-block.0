Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A59C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 15:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79FC21850
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 15:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Vxg/r4+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbfB0PyI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:54:08 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36596 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbfB0PyH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 10:54:07 -0500
Received: by mail-it1-f196.google.com with SMTP id v83so10594226itf.1
        for <linux-block@vger.kernel.org>; Wed, 27 Feb 2019 07:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K4Dp5k+gvirPro+34aMEjcwbb/zI+el2EFUTyihJlPs=;
        b=Vxg/r4+UUXdD4in0d4HCu+9n+XrCv9nczJmX/6CP46Ok5VXhG69Qo2KtteZA2o3YyZ
         m9golu1yvbpgeejYvymkw/xkjBWdjPXPMnvAMT23XVPQIV1EuDgTmcYmLHeWBNPA+aL0
         4H1utIV+x3J/rYhAVKimaKJyouGy43dJ3PEOgvxy7+68QVmycSFDV2D8l6tyzeXZGE0c
         m3oA0wKNRZgoTS4j8hwoHGy46iKGtRAR1BzGxvTVHercfOMZFBhGQN8Bg1f0Caoflhzi
         46IDXlgpRB3Ddup78IHizCSpjusMaYgNWFfdfo03V461REuuTAbc18r1jtHh9xl7X7vx
         sq2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K4Dp5k+gvirPro+34aMEjcwbb/zI+el2EFUTyihJlPs=;
        b=Jfc8PDVXF6fAk0uCyQd7dm7Lls0k2BhbPJhHjU4YBlHfe3AQ6JKklPQnYRK1l2LtaC
         DD9xbvV3ax4545uVXOLQSOpQ/+jfv+DzkT/SCKpvp1vMFU3kYcTFL6AE1cXBom6FH0lv
         MrbPWPI4T5NvtCLX28T41nSLSt4ebNu4bD1Sk4rNxqyAmYIiWXW199vQ/iuGnwpZhHMC
         kkMZ1lYFCEjrB3CkMvNazZdugArcdzobmFDCPyJa/rR4qRi3YGeL08VcE1Bg7EMWB0F4
         tTAo6rJeaJz1VLxu4ry0MzbU70hFf/jcROFvhjtniKGGPkxgD1vWPzHTIB0UlmeyDkxU
         OskQ==
X-Gm-Message-State: AHQUAuawQiYyq+zoJnGj0S8U7RJxIezo6K8q3rLciDKr6te5t49HX99Z
        IjjcN5LkfcLd57ogZR7RGgO8cDOvGFkWPQ==
X-Google-Smtp-Source: AHgI3IZv2a7s1qbhKcyfDoTEHY8m/2KirvW0Sq06UwRWYg8O6MnknYayXfggEq7J+vHD1VPud5NN9g==
X-Received: by 2002:a24:47c9:: with SMTP id t192mr1519783itb.64.1551282845737;
        Wed, 27 Feb 2019 07:54:05 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x84sm1262324ita.32.2019.02.27.07.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 07:54:04 -0800 (PST)
Subject: Re: [PATCH 0/4] block: optimize for single-page bvec workloads
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20190227124013.4828-1-ming.lei@redhat.com>
 <922211dc-2a0d-d030-b072-7bd3e7f6fdcf@kernel.dk>
 <20190227154129.GA10141@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6fb199fc-bc6b-9b04-21e2-72ac8b8bd019@kernel.dk>
Date:   Wed, 27 Feb 2019 08:54:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190227154129.GA10141@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/27/19 8:41 AM, Ming Lei wrote:
> On Wed, Feb 27, 2019 at 06:25:30AM -0700, Jens Axboe wrote:
>> On 2/27/19 5:40 AM, Ming Lei wrote:
>>> Hi,
>>>
>>> The 1st patch introduce bvec_nth_page(), so that nth_page() can
>>> be avoided if the bvec is single-page.
>>>
>>> The 2nd and 3rd patch adds fast path for single-page bvec case.
>>>
>>> The last patch introduces a light-weight helper for iterating over
>>> pages, which may improve __bio_iov_bvec_add_pages(). This patch
>>> is for io_uring.
>>
>> This reclaims another 2%, we're now at 1585K for the test case.
>> Definite improvement!
> 
> BTW, could you test the following patch against the 4 patches?

No noticable difference with this one, though it looks like an
improvement from a code inspection point of view.

-- 
Jens Axboe

