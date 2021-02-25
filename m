Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4556C433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Feb 2021 15:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9925364EB7
	for <linux-block@archiver.kernel.org>; Thu, 25 Feb 2021 15:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhBYP6r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Feb 2021 10:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhBYP6q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Feb 2021 10:58:46 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6127CC06174A
        for <linux-block@vger.kernel.org>; Thu, 25 Feb 2021 07:58:04 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g11so1321465wmh.1
        for <linux-block@vger.kernel.org>; Thu, 25 Feb 2021 07:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HTEp27ZNB/VIL5Wwc1HQRqf6ZorVyEspIjtn3xeL9W0=;
        b=aZikez9cYeIMFSF0rE2oEcbpGLEn3mH6UDHddIRligtWUj+PtRyEHe9ibboq/4U8M3
         mBz3bO/Bves8lGnENdHMqVGUxNfHWtgJvNJNNgy68J9eONo6zpQ6hra5YNr75CI14hft
         n9X4ojJFLHQs4sk8GBws/UtQZXDG2bFay/rPsWaW0OnkNVhCmdjrz4aauZAjVdai7bue
         s34s2/EAuYQTDHSyO9xYJxCpe+TAgjcz6tXppgtG8tCHDr89JM9WCkOl3QpCXHRmdCCS
         HdqI+V3dGWgxDSjsbJqQR8ztrFzBIhD6x+heOnEPB4KIzG4wfTKasLn9aGbGpztYF72G
         F8pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HTEp27ZNB/VIL5Wwc1HQRqf6ZorVyEspIjtn3xeL9W0=;
        b=nmL5QejM+NKYZJmQtgTeOs9yFcCn+v7ltDmgrK20Oe3d7iqQvvsx5B8QUmNoxhlLzU
         4xxAjoNg3qTZdU5ESMR68hcA/PsgW63lsr6YHvyPwldP2qXLfiFz3ax9XGSC4omecg4E
         K2sF/eHkfC4mkpIvIssQKruoao49lkj1ESJTp/KQTik+v2/vzFBD4ypE1suCst2WgVDh
         XGp54HyW7qqgBViCv0YMP22OSOZmEndqTxCZNqH9Xm0rrK6uLL56MtiNRjlJB8kMAj9C
         e88CwKAilPWYjuv83vBJySMyfvlEMj/RQmhPYCEnCIy2BRuzK3Y9YtZQx47sIYxPHUQx
         ys7g==
X-Gm-Message-State: AOAM532ZMh5UpQSqfdDcLk8feJoQU4yZqVyoejW7W6RCx1rRS0fSmemj
        CAnwLX4Z2rmM28uN7Cs2y1a+vjnsM+x6fw==
X-Google-Smtp-Source: ABdhPJymRQM/RQkQUCShsPIWjBy7sexfLrBD1t+yZhVR/HXz1+HZOCpzBFUR41DvqYPhX+Cv/STLUQ==
X-Received: by 2002:a1c:7fd8:: with SMTP id a207mr3484641wmd.40.1614268683107;
        Thu, 25 Feb 2021 07:58:03 -0800 (PST)
Received: from [192.168.0.13] ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id w13sm10387508wre.2.2021.02.25.07.58.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2021 07:58:02 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH BUGFIX/IMPROVEMENT 1/6] block, bfq: always inject I/O of
 queues blocked by wakers
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <23cc8281-a869-b260-ba0c-22127db2019b@kernel.dk>
Date:   Thu, 25 Feb 2021 16:58:59 +0100
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1653E35E-CFEF-437C-9D52-4E004ED1CAFF@linaro.org>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
 <20210126105102.53102-2-paolo.valente@linaro.org>
 <23cc8281-a869-b260-ba0c-22127db2019b@kernel.dk>
To:     Jens Axboe <axboe@kernel.dk>
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



> Il giorno 26 gen 2021, alle ore 17:17, Jens Axboe <axboe@kernel.dk> ha =
scritto:
>=20
> On 1/26/21 3:50 AM, Paolo Valente wrote:
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 445cef9c0bb9..a83149407336 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -4487,9 +4487,15 @@ static struct bfq_queue =
*bfq_select_queue(struct bfq_data *bfqd)
>> 			bfq_bfqq_busy(bfqq->bic->bfqq[0]) &&
>> 			bfqq->bic->bfqq[0]->next_rq ?
>> 			bfqq->bic->bfqq[0] : NULL;
>> +		struct bfq_queue *blocked_bfqq =3D
>> +			!hlist_empty(&bfqq->woken_list) ?
>> +			container_of(bfqq->woken_list.first,
>> +				     struct bfq_queue,
>> +				     woken_list_node)
>> +			: NULL;
>=20
> hlist_first_entry_or_null?
>=20

I didn't find any such function.  There is a list_first_entry_or_null,
but it's for circular doubly linked lists.

I'll wait a little bit for your reply, then send a V2 with this patch
unchanged.

Thanks,
Paolo

> --=20
> Jens Axboe
>=20

