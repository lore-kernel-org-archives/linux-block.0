Return-Path: <SRS0=rGXo=AK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4658BC433DF
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 20:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F79C20663
	for <linux-block@archiver.kernel.org>; Mon, 29 Jun 2020 20:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sBo/plCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbgF2Uoe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731604AbgF2Uoe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Jun 2020 16:44:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9667C061755
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 13:44:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so8835252pgo.9
        for <linux-block@vger.kernel.org>; Mon, 29 Jun 2020 13:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M3QthORRdap7uePjYDD6EUMlZVeBiBfn2hBvzp0RgVQ=;
        b=sBo/plCrM45knQQw5z1l9yXjznWo8QUrZzPeGgAx6kkopampAhti95z3uTzkXmaouI
         u+zByAddEWRv52u8q/iwz7k1EkcuX42AzyCwKUpmVBW5AhU+ZnKUB3jyLvR3SEtIkFhV
         TyNoehk72Pep+92LU5BqnSH2w9Ltzl+Sjr0tVrxVE4hRonSo3IwLonrdpzQQZLhUzGbX
         BRzeFgJcMc4sq73177byDuF50iaMX0RnBVq+777YaQ/QEDnZAZgJsBgQU3sUMy8xS5jO
         y7CNu/RKmYpsAoFUtTDQ16kfXCSArC/sLmkDGb2oSGoCYau1jS24JYEbhEGo58zba3Or
         w9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M3QthORRdap7uePjYDD6EUMlZVeBiBfn2hBvzp0RgVQ=;
        b=NKToAroEPWHp3k2Yn2wNquq0/fK6pf5rmbPm4w+nPsvpTLliLCzpgmaQwWVgqWQhml
         Fo5uj00VWMZjJjQ2aYiWR5W06j0QrVDD7UxU/FA8h0LPdfEJLYARJO36sRW7XDY5+fy2
         6BhY0Yueq2I7l9LHadsFWXcb4rt5wR05Eqe6NUzwEq2Ms6RPdwpKZ6GEI1Qummq2B9xH
         9ls2JACzMZnyat34DMH9G9EqxUh3w06+b4WBdB1Z4LCoRRvnWsK9wmDPO4smR1tGiYgv
         tEQ7aTEXZS5DU+iydJWUeYiwJ0TDPOlMaVAXkbNY4UZV2DlQ9oGyNzZw+DVkrOVi0HOy
         XkpQ==
X-Gm-Message-State: AOAM530/lfbUGt+g2CoHJyvaq/eTqsQl18+o8yvYAxbhgZSNFW3dnysK
        EzFmCxO247GqogWqMgPtKECsicfIyrse/w==
X-Google-Smtp-Source: ABdhPJx6rE9/kXrSq5MDpQDtFIhYyLRntn016y2ubV45YJNLpkNBk63lHBNKeASd9PXahtW67m2Dvg==
X-Received: by 2002:aa7:8582:: with SMTP id w2mr6373151pfn.34.1593463472983;
        Mon, 29 Jun 2020 13:44:32 -0700 (PDT)
Received: from [192.168.86.197] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id t188sm500340pfc.198.2020.06.29.13.44.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 13:44:32 -0700 (PDT)
Subject: Re: [PATCH] block: Set req quiet flag if bio is quiet
To:     Ming Lei <tom.leiming@gmail.com>,
        Aleksei Marov <alekseymmm@mail.ru>
Cc:     linux-block <linux-block@vger.kernel.org>
References: <bdef634a3a41dbecfd3d74f6bd25332445772902.camel@mail.ru>
 <CACVXFVObNuK=Uii_Tm2pSEEm2RAeECeha97-q=+XkDsuD6Vmsg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6611337f-f73e-7c7a-d8b0-428121e659b2@kernel.dk>
Date:   Mon, 29 Jun 2020 14:44:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVObNuK=Uii_Tm2pSEEm2RAeECeha97-q=+XkDsuD6Vmsg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/27/20 2:00 AM, Ming Lei wrote:
> On Sat, Jun 27, 2020 at 2:12 AM Aleksei Marov <alekseymmm@mail.ru> wrote:
>>
>> The current behavior is that if bio flagged as BIO_QUIETis submitted to request based block device then the request
>> that wraps this bio in a queue is not quiet. RQF_FLAG is not
>> set anywhere. Hence, if errors happen we can see error
>> messages (e.g. in print_req_error) even though bio is quiet.
>> This patch fixes that by setting the flag in blk_rq_bio_prep.
>>
>> Signed-off-by: Aleksei Marov <alekseymmm@mail.ru>
>> ---
>>  block/blk.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/block/blk.h b/block/blk.h
>> index b5d1f0f..04ca4e0 100644
>> --- a/block/blk.h
>> +++ b/block/blk.h
>> @@ -108,6 +108,9 @@ static inline void blk_rq_bio_prep(struct request
>> *rq, struct bio *bio,
>>
>>         if (bio->bi_disk)
>>                 rq->rq_disk = bio->bi_disk;
>> +
>> +       if (bio_flagged(bio, BIO_QUIET))
>> +               rq->rq_flags |= RQF_QUIET;
>>  }
> 
> BIO_QUIET consumer is fs code, and RQF_QUIET consumer is block layer,
> so you think
> the two consumers' expectation is same?

They should be the same, the intent is to say "don't log errors on this
piece of IO".

Would be much nicer if RQF_QUIET was just inherited naturally in
req->cmd_flags from bio->bi_opf, like we do for the shared parts.
Pretty confusing to have two different sets of flags and needing
to inherit them independently, also more inefficient.

-- 
Jens Axboe

