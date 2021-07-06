Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A8C07E96
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 12:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F4F8619B9
	for <linux-block@archiver.kernel.org>; Tue,  6 Jul 2021 12:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhGFMco (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jul 2021 08:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245171AbhGFMMa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jul 2021 08:12:30 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B781DC061762;
        Tue,  6 Jul 2021 05:00:26 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id h1-20020a17090a3d01b0290172d33bb8bcso1373648pjc.0;
        Tue, 06 Jul 2021 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vrJqpbX+WWnMqAWnWXX6YjNds91UcrnpbpdIVx8fXWI=;
        b=ccoO4qSCaNLuC6Ruooedshrw/mmQ/wzbQbvFchhCRtKnlNncae0TDfWSjBMdaSoJh6
         7O2nS7DskIYbvnRwlDgLPpmEhSXlr3XWUeHmnERD95qLqndGyXAa+Z84gmpmusJ/fPMS
         ZGUDiCWo91YVbc1jSBptfohZnZArDIB8GlWMGs9QuEsUPzHlekA0zQKD8LCqxa78+Vne
         UopKgOJ3lh/6jmGv3jR/zKiYMz1VmM1EWjTvyMkSFiMPmqwpivQy9LLCWpoz9tQQT25x
         w90VIMGSfYO/4l53g8e+CdFthM1nSzNIzxA5vNh4+gdQDxL3CNh3VVTynBlsysE5JU+t
         4siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vrJqpbX+WWnMqAWnWXX6YjNds91UcrnpbpdIVx8fXWI=;
        b=RlEiCA3rVtTFUkeqPCXgoioz2RTOlyVlWoHFo6eQbQyHMTJPY+KXA4h/iOMJC/6Cxc
         j5l1Mv1gNE7bFRYs76eUe8yE8EH3c6xelh3geX5GeHcjbreN394BIB6C4wovnEZ8z6XX
         mm4M3lgIzg6mphdSuCAu6pWe5X/ZumDFhBiUCLQTokVQrELvf2X4W8YFXyjaFQMY5FNE
         cuNyxt96dFTJEzihAyvuQc8S2m0ihT4U6PeDPsNd7uWNSOs0mEY89PRVeXJmUPi7jUi7
         Tjb4nj0umKYX7zHAOO4SWivU0xzgHg7ifJto5xksbz9s8PmOGUlpTz2hAGNqFl42h0gw
         cI6w==
X-Gm-Message-State: AOAM533va3o8e+JrzUG0Qd+d6oh+lVllL/9o5Hyks/hDd18+7xVrnOWq
        8dN71xNuADQvRTmw+giq6cMoU0/fVU6ZVxe0
X-Google-Smtp-Source: ABdhPJxzROSEFb31vpIuXWTOuM1UhmLn8mNFGLDCdL6iFim6982PAotoXnhyrxlvumxXYlTIuKhFeQ==
X-Received: by 2002:a17:90b:1904:: with SMTP id mp4mr19774531pjb.29.1625572825663;
        Tue, 06 Jul 2021 05:00:25 -0700 (PDT)
Received: from [127.0.0.1] ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id w14sm20344583pgo.75.2021.07.06.05.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 05:00:25 -0700 (PDT)
Subject: Re: [PATCH v3] block: fix the problem of io_ticks becoming smaller
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1625521646-1069-1-git-send-email-brookxu.cn@gmail.com>
 <YOPpM6et9rFNrBOn@infradead.org>
From:   brookxu <brookxu.cn@gmail.com>
Message-ID: <38566226-a5d3-35c3-3e06-cdf7f3f71609@gmail.com>
Date:   Tue, 6 Jul 2021 20:00:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YOPpM6et9rFNrBOn@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



Christoph Hellwig wrote on 2021/7/6 13:25:
> On Tue, Jul 06, 2021 at 05:47:26AM +0800, brookxu wrote:
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> On the IO submission path, blk_account_io_start() may interrupt
>> the system interruption. When the interruption returns, the value
>> of part->stamp may have been updated by other cores, so the time
>> value collected before the interruption may be less than part->
>> stamp. So when this happens, we should do nothing to make io_ticks
>> more accurate? For kernels less than 5.0, this may cause io_ticks
>> to become smaller, which in turn may cause abnormal ioutil values.
>>
>> v3: update the commit log
>> v2: sorry, fix compile error due to the missed ')'
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> 
> The change looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Although I still have trouble understanding the commit log, especially
> the last sentence.

Thanks for your time，5b18b5a73760 ("block: delete part_round_stats and
switch to less precise counting") Merged in 5.0-rc1. Before that, we relied
on in_flight to count the disk's io_ticks，as follows:

static void part_round_stats_single(struct request_queue *q,
				    struct hd_struct *part, unsigned long now,
				    unsigned int inflight)
{
	if (inflight) {
		__part_stat_add(part, time_in_queue,
				inflight * (now - part->stamp));
		__part_stat_add(part, io_ticks, (now - part->stamp));
	}
	part->stamp = now;
}

The value of io_ticks should increase monotonically before the count wraps
around. However, due to the reasons mentioned above, the interrupt on the
IO submission path may cause the time obtained before the interrupt to be
less than part->stamp after the interrupt returns, resulting in the value
of io_ticks becoming smaller than the previous value. If the user task
periodically samples /proc/diskstats and calculates ioutil, since io_ticks
increases non-monotonously, the difference between adjacent times may be
negative, which in turn makes ioutil abnormal.Fortunately, this problem
can be easily circumvented.


