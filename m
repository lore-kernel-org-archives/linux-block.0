Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F068C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 20:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1BA214D8
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 20:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zDaXDHyd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbfA2UhN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:37:13 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56014 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfA2UhN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 15:37:13 -0500
Received: by mail-it1-f195.google.com with SMTP id m62so6727924ith.5
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 12:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BrCsiE5YweTTO2omkHOQBxNIbZ09smSVXXDlRhXTh5A=;
        b=zDaXDHydIApr2pKQDxFICgd6Qk/gk+3LASEqgRSpsoZxUm6P52sKhlTK+T0QeR+4mc
         cr/PvBmYMYyrOUe0VWSvsUW7uqOessAt0c/NzdWdXia84M5RM+/+qr2LDFkHPo3YF193
         Fwu63JIhEGs9ZTl65mRdTezppbPbo0gZsnPgFH94PMm3yxwChnWqtTB6AOFoUvsGa1Cf
         I2iqApzBrDuPyXVdzYOVJ2pfpxNmbC2c/rXW3l1gwcqI0V9mvCYuw9YZuw/IRY9r9saX
         BO5hcWC5cOoardN9GDD+DDStHIcSkYtYYLDyG7ZNWnW2S4f9o0OKQElu+TO44dfoYxbT
         qIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BrCsiE5YweTTO2omkHOQBxNIbZ09smSVXXDlRhXTh5A=;
        b=b/JIswj/VzB9LGutmhKlkO1d/L6T41QyW8QAxkXGtE2E9MyEG4xAJwQCu0W9nGs0ML
         TDhmgJnhs1EaCyfxJaQIZkAiGZ+l3Sw83XTo/Ij539UI4judw5UtRn+rif1OqFJKrjU4
         sz1vTJd9uEZuhv7a3SR1qlYoBpQsQIbV69gWVRZ9WRfw7gmTAlCzULto+wWtRl1qwcVK
         rQXqcYNRRJew52YnBtSk92SzzbKPxadEfjXdvJDerqEAIqDSX3Sxk8ZIWxZTSlHH6Qrq
         wJrn4APQA0kwRd2xhK6Y3ixZ3g0XRO+78l24kc69b90dttW5dWh7bH2QM4CNylIDqDPD
         eAmQ==
X-Gm-Message-State: AJcUukd9fZLBoPd5+Kmj3RQT8DaBDdgz8h9j3tEBfv/WICwYlVtO3L5Z
        ylKr101lwPA04FEIX+AOMW5Rbg==
X-Google-Smtp-Source: ALg8bN5o5Ze4G6hXNoZWl5FHqK+Sc4XzzGlXfyNuqzj3781xy6i+RE2NO1Dl2hqrpMI8Xn6TTrs6uA==
X-Received: by 2002:a05:660c:54d:: with SMTP id w13mr4113258itk.50.1548794231884;
        Tue, 29 Jan 2019 12:37:11 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t11sm14484426iop.88.2019.01.29.12.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 12:37:10 -0800 (PST)
Subject: Re: [PATCH 07/18] io_uring: support for IO polling
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, avi@scylladb.com
References: <20190128213538.13486-1-axboe@kernel.dk>
 <20190128213538.13486-8-axboe@kernel.dk> <20190129172414.GA15347@lst.de>
 <f21fc281-bbaa-3af5-3d64-a55933f1cbfb@kernel.dk>
 <cd1b43b7-7116-e53c-91fa-168e6c249e63@kernel.dk>
 <x49o97zi4ml.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <79f9f2e3-7e7d-00fa-5ce6-36787d66f865@kernel.dk>
Date:   Tue, 29 Jan 2019 13:37:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <x49o97zi4ml.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/29/19 1:35 PM, Jeff Moyer wrote:
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> On 1/29/19 11:31 AM, Jens Axboe wrote:
>>>> The code looks a little clumsy to me.  Why not:
>>>>
>>>> 	while (!list_empty(&ctx->poll_list)) {
>>>> 		int ret = io_do_iopoll(ctx, nr_events, min);
>>>> 		if (ret)
>>>> 			return ret;
>>>>
>>>> 		if (!min || *nr_events >= min)
>>>> 			return 0;
>>>> 	}
>>>>
>>>> 	return 1;
>>>
>>> I think you messed up the 0/1 here, how about this:
>>>
>>> 	while (!list_empty(&ctx->poll_list)) {
>>> 		int ret;
>>>
>>> 		ret = io_do_iopoll(ctx, nr_events, min);
>>> 		if (ret < 0)
>>> 			return ret;
>>> 		if (!min || *nr_events >= min)
>>> 			return 1;
>>> 	}
>>>
>>> 	return 0;
>>
>> Or I did... I think yours is correct.
> 
> maybe document the return code?  ;-)

It is sort-of documented - <= 0 means "don't call me again", either
because of an error (< 0) or because we have what we need. 1 means
"I might have more".

But yes, maybe a comment...

-- 
Jens Axboe

