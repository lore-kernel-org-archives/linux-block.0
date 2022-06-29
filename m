Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F311AC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 19:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiF2TiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 15:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiF2TiD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 15:38:03 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC72393F4
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 12:38:02 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id 136so10917092pfy.10
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 12:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SowtfbQg4jm5t+ej3pjlmqBbS1c74VzCN39P2BqzCNE=;
        b=NebTrwc/nl2EBiTeujZA2KPjJ88kkQuC0ZqSQvd0YPebFVis59BZ8opb8VdlfoOPzk
         cqkYhjvm1+nNMWwFiqpkZukbxMeC/YaPQhVHjDqObQyrwhKdO4ZiRkb2PMzI4oH1bkqY
         Y0ZoydBC4JUgMy6hQUS9drDOtn/9ZvzopqLpDflpIy18sXYnAOOwv9wsrs7CQk6yMx/d
         iO8RfNrMYatehQFIWpRUitK/pB/ssPwF6hOv/Nx9ubaP73pgf7hKaj7qjECZ3Bdhq2iW
         0MljJo7jHj6K0/vSdvjavshaSqkW+oikzpfyrljZUGs99veceqT0A3V5HSMxfXciDkMo
         XUHA==
X-Gm-Message-State: AJIora8I+qIJBUtKvRv0lVqm2eO3+KQfd+G5QowlNgt8OkEdKVdHO7pN
        kZlbe3IYGiPwTf1dSaC4vNk=
X-Google-Smtp-Source: AGRyM1t424M+1J58sV4QyJ9NvnUTQV6QYw4Zw29zbn+0fE9EJNQoENXKMKoiDA6uoHSHDZdhTUpSdw==
X-Received: by 2002:a63:ba07:0:b0:40d:77fd:9429 with SMTP id k7-20020a63ba07000000b0040d77fd9429mr4412803pgf.110.1656531481706;
        Wed, 29 Jun 2022 12:38:01 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:3841:49ce:cba5:1586? ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d90400b0016767ff327dsm11796560plz.129.2022.06.29.12.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 12:38:00 -0700 (PDT)
Message-ID: <75aa2055-0f50-47ce-b9cc-8f79eba77807@acm.org>
Date:   Wed, 29 Jun 2022 12:37:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5.20 1/4] block: add bio_rewind() API
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Eric Biggers <ebiggers@google.com>,
        Dmitry Monakhov <dmonakhov@openvz.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20220624141255.2461148-1-ming.lei@redhat.com>
 <20220624141255.2461148-2-ming.lei@redhat.com>
 <20220626201458.ytn4mrix2pobm2mb@moria.home.lan> <Yrld9rLPY6L3MhlZ@T590>
 <20220628042016.wd65amvhbjuduqou@moria.home.lan>
 <3ad782c3-4425-9ae6-e61b-9f62f76ce9f4@kernel.dk>
 <20220628183247.bcaqvmnav34kp5zd@moria.home.lan>
 <6f8db146-d4b3-d17b-4e58-08adc0010cba@kernel.dk>
 <20220629184001.b66bt4jnppjquzia@moria.home.lan>
 <486ec9e2-d34d-abd5-8667-f58a07f5efad@acm.org>
 <20220629190540.fwspv66a4byzqxmg@moria.home.lan>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220629190540.fwspv66a4byzqxmg@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/22 12:05, Kent Overstreet wrote:
> On Wed, Jun 29, 2022 at 11:51:27AM -0700, Bart Van Assche wrote:
>> On 6/29/22 11:40, Kent Overstreet wrote:
>>> But Jens, to be blunt - I know we have different priorities in the way we write code.
>>
>> Please stay professional in your communication and focus on the technical
>> issues instead of on the people involved.
>>
>> BTW, I remember that some time ago I bisected a kernel bug to one of your
>> commits and that you refused to fix the bug introduced by that commit. I had
>> to spend my time on root-causing it and sending a fix upstream.
> 
> I'd be genuinely appreciative if you'd refresh my memory on what it was. Because
> yeah, if I did that that was my fuckup and I want to learn from my mistakes.

I was referring to the following two conversations from May 2018:
* [PATCH] Revert "block: Add warning for bi_next not NULL in 
bio_endio()" 
(https://lore.kernel.org/linux-block/20180522235505.20937-1-bart.vanassche@wdc.com/)
* [PATCH v2] Revert "block: Add warning for bi_next not NULL in 
bio_endio()" 
(https://lore.kernel.org/linux-block/20180619172640.15246-1-bart.vanassche@wdc.com/)

Bart.
