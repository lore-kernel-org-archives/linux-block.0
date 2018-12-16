Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF55C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF152082F
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 16:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="irez5tiW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeLPQnO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 11:43:14 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35805 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbeLPQnO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 11:43:14 -0500
Received: by mail-pf1-f194.google.com with SMTP id z9so5166046pfi.2
        for <linux-block@vger.kernel.org>; Sun, 16 Dec 2018 08:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hEpn1KWPhpHa/0cbsSQGfvzga3r92vtv+cTmIofl6X4=;
        b=irez5tiWT7JUD395b+SmjDpM81AzIQBauRUMVJowZQyICchAHrfHfn6ELfkMH0e5X/
         pbZOw1NaGLs2nHSe83zi4n2u9P1yINnk92fH7/jXU7a1PjQOPV4nLymo3qbolPEfNMyD
         mzwty90q5k026iDe/n6CjhiIc7699vWdjroizsHSrm/RzC1wID/8DVeUSnNTX5OE9FUl
         lxRf7M30WT7NSW8v4Yabq3shze9YVcG/4vNNxQ+GRDsQMaZCyjVfKFnYcz7lgwY2BN75
         wRSdTjJs68ZbCRWSFsgVpTCistob+h0y0mVsl0tqPDLAR+61Pw8imgWsKAVRprhs3xBS
         xuQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hEpn1KWPhpHa/0cbsSQGfvzga3r92vtv+cTmIofl6X4=;
        b=O6Kur3MiSFUSggwm7K0rQXh8WQgxP0VEzLEz7OMtCAisXYwhkpAzbxe9TlqkX6ejuP
         xgSZ3/B26yw3/2Wgmk5zyi9AOIJ2N45d95Pp/1tlzryW7KVORTJf0noSMAivIXH7AUnK
         7LVV2CQd0kmOPIF6gN3yChbiM/ynyV03n400wDPcH1gbZLIqj/yuiUrtJ77CnxHAGZmb
         Lg+i6gd85PgGs1Ay7bYTtiXtTxhlTogZV21CaZtFvmIsVPeb9TNt4KIDYVqY79uJOAvn
         5JuXTnMomE0F89Rt4XCt1/FWdTnrueu/R+vjpChsv+wuqrZvx9nJz0twzmAsHfknZjCO
         tdPw==
X-Gm-Message-State: AA+aEWbDjgFn5Cl67inFfNAO1cAHMPzvNJGBqoZCGvimHGIS25ODUjk7
        t5vS386ofdlL9khr2OqiGQHfiA==
X-Google-Smtp-Source: AFSGD/V5u7wloeJFpwZFBwLevE1NdDFSxERg0qFcr7dr1B+Vn/xklYEK8Sx4Urx984F6Xz/P9DO9Yg==
X-Received: by 2002:a62:ae12:: with SMTP id q18mr9955658pff.126.1544978593723;
        Sun, 16 Dec 2018 08:43:13 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id k129sm12752206pgk.29.2018.12.16.08.43.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 08:43:12 -0800 (PST)
Subject: Re: [PATCH 23/26] block: implement bio helper to add iter bvec pages
 to bio
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org, jmoyer@redhat.com, clm@fb.com
References: <20181213175645.22181-1-axboe@kernel.dk>
 <20181213175645.22181-24-axboe@kernel.dk> <20181216164015.GC13234@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c4a8618a-2603-541d-6fca-43c78e0a9ca4@kernel.dk>
Date:   Sun, 16 Dec 2018 09:43:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181216164015.GC13234@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/16/18 9:40 AM, Christoph Hellwig wrote:
>> +	do {
>> +		size_t size;
>> +
>> +		bv = iter->bvec + iter->iov_offset;
>> +		size = bio_add_page(bio, bv->bv_page, bv->bv_len, bv->bv_offset);
> 
> Overly long line here.

Will fix.

>> +		if (size != bv->bv_len)
>> +			break;
>> +		iov_iter_advance(iter, size);
>> +	} while (iov_iter_count(iter) && !bio_full(bio));
> 
> bio_add_page already does the bio_full check for you.

get_pages does the same thing, but I guess it makes more sense there since
we'd have to undo if we could not add.

-- 
Jens Axboe

