Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF24C433E2
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 03:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5CA20693
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 03:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gPz/3XVz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgIADmI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Aug 2020 23:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgIADmH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Aug 2020 23:42:07 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C07C0612FE
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 20:42:07 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 31so1905875pgy.13
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2020 20:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Iqh713BuLY/SsXtL6H9Ki9IOIFAs+wB18b19Z5A1dNQ=;
        b=gPz/3XVzsPDmEcu2ukO9tEwHPGTjflYfFvEVXY1devvlZ2ACzpY2TIPUA2XA86zowX
         A+GTDgXp+lQnhMeq/glk2buZEsCYJKFeouvjFhBxTwEo9WMBGpfHn9eBkqVY35BB0Mt2
         q2wYWzCbSSIAdP4oUFnCYlFQ7vUQiZRRIUY6HzHJwZRZBWcHgNEqfjrAEPpAeGkvgu0C
         eSRA0LVSAs4WWHa3nERkvkhsSGGv52ASKzwgQrvOM2rxo0gKP2m2uozDNABo4ixKTgcK
         fhkyHWIqCqCQLQr0kmPpY9xydl+qJDq1KOQgKR6hSMNUkzqWKd7+ooHbZWd78VnlWFCS
         0L3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Iqh713BuLY/SsXtL6H9Ki9IOIFAs+wB18b19Z5A1dNQ=;
        b=mkx1Yb8RjFYwDo3NvXYLI4NGmhkChtQci5UiVklZ7e/vYaKVrbzaC/wRvyLOvGHv8t
         2rhHoKo/rlDnG5SCfjm1GdsBPJLKe2dj9/ADAulPVY4+IHQOmfxaWzMFKDt64y9hZhtv
         V/qW3G//t7poxsiauUGhqVZexx+H+4g+XpbamcmIKEVOyWp8CVShF3GZCKM9WOykWgND
         aIpcDLf1W7VHqOSesuLhKoIlr9H1TiaV2B7Te8WYHhht1oeZQ6orsBCd0lu7ZEa7u1Eg
         8ncLITVji85wrpTBRHEAOa/0YXrkB1i1x4jvVwHT73EK+aUWziluUSoaJbOwqCFGYTtF
         za8A==
X-Gm-Message-State: AOAM532WUib9vOqnLsmAkyvReEudIty/pzszxtgfEeJmK8DByU5X9DUB
        QBSqtenJxdzAQdIS40HCWzMIcw==
X-Google-Smtp-Source: ABdhPJw1brQC8Q8uta0zP4Ir/egNvX3mYmWEqJYppwG/SU7RQpYjkw4miQ0XDZ8XMhRUflEscBUvwQ==
X-Received: by 2002:a65:6790:: with SMTP id e16mr3876105pgr.14.1598931727087;
        Mon, 31 Aug 2020 20:42:07 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id fz19sm9632pjb.40.2020.08.31.20.42.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 20:42:06 -0700 (PDT)
Subject: Re: [PATCH] block: Fix inflight statistic for MQ submission with
 !elevator
To:     Ming Lei <tom.leiming@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-block <linux-block@vger.kernel.org>, kernel@collabora.com
References: <20200831153127.3561733-1-krisman@collabora.com>
 <CACVXFVM21GWTrWs=6w3OXm7vQ-gmR_3PGss+9TE=swVN-Uzn7Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1b0ad48b-bc94-269f-1899-e49f3d1802e2@kernel.dk>
Date:   Mon, 31 Aug 2020 21:42:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVM21GWTrWs=6w3OXm7vQ-gmR_3PGss+9TE=swVN-Uzn7Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/31/20 7:18 PM, Ming Lei wrote:
> On Mon, Aug 31, 2020 at 11:37 PM Gabriel Krisman Bertazi
> <krisman@collabora.com> wrote:
>>
>> According to Documentation/block/stat.rst, inflight should not include
>> I/O requests that are in the queue but not yet dispatched to the device,
>> but blk-mq identifies as inflight any request that has a tag allocated,
>> which, for queues without elevator, happens at request allocation time
>> and before it is queued in the ctx (default case in blk_mq_submit_bio).
>>
>> A more precise approach would be to only consider requests with state
>> MQ_RQ_IN_FLIGHT.
>>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>> ---
>>  block/blk-mq.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 0015a1892153..997b3327eaa8 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -105,7 +105,7 @@ static bool blk_mq_check_inflight(struct blk_mq_hw_ctx *hctx,
>>  {
>>         struct mq_inflight *mi = priv;
>>
>> -       if (rq->part == mi->part)
>> +       if (rq->part == mi->part && rq->state == MQ_RQ_IN_FLIGHT)
>>                 mi->inflight[rq_data_dir(rq)]++;
> 
> The fix looks fine. However, we have helper of
> blk_mq_request_started() for this purpose.

Why does it look fine? Did you see the older commit I referenced? I'm
not saying the change is wrong per se, just that this is the behavior
we've always had, and making this change would deviate from that. As
Gabriel states in the follow up, it's either changing the documentation
or the patch.

When replying to patches that have had previous discussion, please
reference that when making followups. That makes for a more productive
discussion on how to proceed.

-- 
Jens Axboe

