Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE31C433ED
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 14:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5826061166
	for <linux-block@archiver.kernel.org>; Mon,  3 May 2021 14:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhECPAh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 May 2021 11:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhECPAg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 May 2021 11:00:36 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F4EC06174A
        for <linux-block@vger.kernel.org>; Mon,  3 May 2021 07:59:42 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id t21so4329043iob.2
        for <linux-block@vger.kernel.org>; Mon, 03 May 2021 07:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6egtxTN5q4QLPOJLRd3y+Z0fKzalIDR3UohhkwtOCM8=;
        b=rMzOccYnjQjJTQplZd4m5b4GYay4fmSvBEXQ0cyrH9TWKEEaxSW7ofFPCXRs6iV6ZV
         gn73VPb/MX5vg1btYyq2Gj38MRIouiIJ+j4GMlahaOcMMPBIAXqGfHAvFgbZPraXTR1Y
         +WcV4bAqr2poTCc3OMyAQpdso+VA272r2vwbSwj368IFnfgMBk7pUWjQ4YYZfWRO/7Xs
         H1rDmVrdkjETcygVtzVSBfcngngQLovheZLeGdIPvPJWR0sR+z2l52KuNSmNoMVppLNR
         AvjKs1NTEeLXCGjD0BIUOLk7xVt68zMFFQACW9XAzHC4MNaclyET0PVR8awjabSMexKU
         vVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6egtxTN5q4QLPOJLRd3y+Z0fKzalIDR3UohhkwtOCM8=;
        b=Fh6zpPYXBYgPCXyc+gDXwMSahziUnnga6ECWuXYYBO+wQroCtKvnoal6e0fKc8A+5i
         ujjIJZkLR1RYM1FA4yWInEeLqXlC9xTnM/bUEEguRaqMwhYhgkqGa4nqRtEYY8NIZumB
         KiTzmwrnbZ9ElzrMPgTPauBeDbCm92PWDo++fDU9spMaAHycNEAhUayQPP52Fd/7F5q/
         DmTEk95aEuQTPtIxV3eLjU4H5Sczs6qNYiU7JWBZBH36V3qx9RqQ0bFLMiPXpnOr1DF0
         7Mk4Kp7l+S6Li2lAQc3NVeCErQyst1pi4RvPp6XCjjYjSYPUDNAGJ6ZD3tiT8LVTQj4z
         oyVw==
X-Gm-Message-State: AOAM532rqEbnnF8VvR43xOS9zGBqzmDlfL+enOIMLhiWcGkrv/fNmZJj
        n71X92qOOoLrb9u/bTlSy/QIWQ==
X-Google-Smtp-Source: ABdhPJwI1R2aI/WV1VcSccFj48I+dXgpwOXLiCW3REwd2nVuBgcj93isKO595yRlv6MPq97L7l7nBw==
X-Received: by 2002:a05:6602:81e:: with SMTP id z30mr15264730iow.90.1620053981968;
        Mon, 03 May 2021 07:59:41 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q26sm273508ioh.42.2021.05.03.07.59.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 07:59:41 -0700 (PDT)
Subject: Re: [PATCH v9] bio: limit bio max size
To:     Bart Van Assche <bvanassche@acm.org>,
        Changheun Lee <nanich.lee@samsung.com>, yi.zhang@redhat.com,
        ming.lei@redhat.com, bgoncalv@redhat.com, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot@kernel.org
References: <CGME20210503101008epcas1p25d6b727dafcf9ff24db6aa41a3f611fa@epcas1p2.samsung.com>
 <20210503095203.29076-1-nanich.lee@samsung.com>
 <72a0b4e7-a374-97fb-ae73-ed24f719da98@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c48d45cc-9c4f-0b6c-51d0-3044e7cdf7f5@kernel.dk>
Date:   Mon, 3 May 2021 08:59:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <72a0b4e7-a374-97fb-ae73-ed24f719da98@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/3/21 8:54 AM, Bart Van Assche wrote:
> On 5/3/21 2:52 AM, Changheun Lee wrote:
>>  struct queue_limits {
>> +	unsigned int		bio_max_bytes;
>> +
>>  	enum blk_bounce		bounce;
>>  	unsigned long		seg_boundary_mask;
>>  	unsigned long		virt_boundary_mask;
> 
> On April 23 Damien Le Moal posted the following comment about the
> bio_max_bytes member: "Please move this below in the structure together
> with all other fields that are unsigned int too." Making that change
> sounds like a good idea to me.

Why? It's next to an enum, so the patch (as it stands) actually fills a
hole in the struct. Moving it would be a mistake and waste more space.

If anything, we should move the bounce member below virt_boundary_mask,
but since this one fills a hole, that's better left as a separate patch.

-- 
Jens Axboe

