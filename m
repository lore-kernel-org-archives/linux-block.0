Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EC7C433DB
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 12:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6BBA61492
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 12:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbhA1MB7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Jan 2021 07:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhA1MBM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Jan 2021 07:01:12 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B1BC061573
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 04:00:31 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q7so5080461wre.13
        for <linux-block@vger.kernel.org>; Thu, 28 Jan 2021 04:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2XXL4h9NnmPDiM+gAOQisenEXGZMzrY7cFHRe46G/D4=;
        b=PRWHME6RHzks/gHmg5ubTI36jgToPNzQymXsEYiO2T0Bq3k+iTONZvxTSAGH/8yrxx
         P3ua82/zLckNCjgk5NOmCVqUSeqsF32+giP++vjVRhwAlLb3h4YBEyTz4cBOUDaccmJc
         mA7Xa9b/vt338mX5lC4Pn4CXDp1O2AJ4D3e2n2Ktro/fsZo4Jeb7DTLH/lCRQXDf8AjQ
         5yv9k5onJ/oRs5dVlgl379AW/MC4uxHj3IbwDXDhhZdCcxmxUS6PXFL642KVpA8orWc+
         M98+pee7fkcFUvriplJ28R+ZgEhZ1PhylTRioXmxp+D+7J79GPO0xrq9oqPb7oouE+iX
         b9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2XXL4h9NnmPDiM+gAOQisenEXGZMzrY7cFHRe46G/D4=;
        b=XcR2uOQZMdyxSKQV3HIwKNCqd/WPGIAn9mOj3QnStBVDRl5fvoO0vgelFpOHJA/FNf
         Vggb8KUWZ0MSLkEGrCgeFpnSTD52iqIMejh6cOf8fNZVyM94jOLTX6ciTM7cFXH8hy8J
         5GiM1yqj99vvHoTTv21UP5+bQGxgSrY3+gQ0iOH8v/1fV5NswdmHej0GAg3JHU86D6Bd
         HxMLBF3MkawlqGhRI1Z51WcqZxe1AVjrH6BZF4vqT3SxMpvtjkUNvQ7zU3Kv9m/K0xRo
         xvLVXGfP8SvUulw1FU8LvBPjJHVFohE59zeTAUWFVWVtBrL3uPb6odZUAz6f5TZrsCnz
         aW7g==
X-Gm-Message-State: AOAM5302spd8lh+bKmfcHVcIY5wsa+JcaVQ66lJeVrX9ZSrhwkWNCitP
        wlEyM+5O8/5OJ6VEmGPVez8=
X-Google-Smtp-Source: ABdhPJxNBsk6fO54lxA682kBv3yXheTmxZiJVZJRBMnH3RHYW80D3GceHFC6LFQtWo7SNwjYBBowhA==
X-Received: by 2002:adf:f60b:: with SMTP id t11mr16211301wrp.401.1611835230240;
        Thu, 28 Jan 2021 04:00:30 -0800 (PST)
Received: from [192.168.8.160] ([148.252.132.131])
        by smtp.gmail.com with ESMTPSA id i59sm6998646wri.3.2021.01.28.04.00.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 04:00:29 -0800 (PST)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <cover.1609875589.git.asml.silence@gmail.com>
 <53b86d4e86c4913658cb0f472dcc3e22ef75396b.1609875589.git.asml.silence@gmail.com>
 <20210127171610.GA1733363@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [RFC 2/2] block: add a fast path for seg split of large bio
Message-ID: <8f9c29ff-e7f1-d553-7b48-8b6ad690a7b2@gmail.com>
Date:   Thu, 28 Jan 2021 11:56:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20210127171610.GA1733363@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 27/01/2021 17:16, Christoph Hellwig wrote:
> On Tue, Jan 05, 2021 at 07:43:38PM +0000, Pavel Begunkov wrote:
>> blk_bio_segment_split() is very heavy, but the current fast path covers
>> only one-segment under PAGE_SIZE bios. Add another one by estimating an
>> upper bound of sectors a bio can contain.
>>
>> One restricting factor here is queue_max_segment_size(), which it
>> compare against full iter size to not dig into bvecs. By default it's
>> 64KB, and so for requests under 64KB, but for those falling under the
>> conditions it's much faster.
> 
> I think this works, but it is a pretty gross heuristic, which also

bio->bi_iter.bi_size <= queue_max_segment_size(q)

Do you mean this, right? I wouldn't say it's gross, but _very_ loose.

> doesn't help us with NVMe, which is the I/O fast path of choice for
> most people.  What is your use/test case?

Yeah, the idea to make it work for NVMe. Don't remember it restricting
segment size or whatever, maybe only atomicity. Which condition do you
see problematic? I can't recall without opening the spec.

> 
>> +		/*
>> +		 * Segments are contiguous, so only their ends may be not full.
>> +		 * An upper bound for them would to assume that each takes 1B
>> +		 * but adds a sector, and all left are just full sectors.
>> +		 * Note: it's ok to round size down because all not full
>> +		 * sectors are accounted by the first term.
>> +		 */
>> +		max_sectors = bio_segs * 2;
>> +		max_sectors += bio->bi_iter.bi_size >> 9;
>> +
>> +		if (max_sectors < q_max_sectors) {
> 
> I don't think we need the max_sectors variable here.

Even more, considering that it's already sector aligned we can kill off
all this section and just use (bi_iter.bi_size >> 9).

-- 
Pavel Begunkov
