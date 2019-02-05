Return-Path: <SRS0=MQDU=QM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15784C282CB
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 16:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF2A1217D6
	for <linux-block@archiver.kernel.org>; Tue,  5 Feb 2019 16:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vnnSotJq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfBEQ6m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 11:58:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53514 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbfBEQ6m (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Feb 2019 11:58:42 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so10088084ita.3
        for <linux-block@vger.kernel.org>; Tue, 05 Feb 2019 08:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q0JQV5advgTB6KiaCqNe+7SidNtpgdETj4pSQqOAyE4=;
        b=vnnSotJqkU9+cgDGbpIoGPsYbD8Xloafa2b97p3FHrHtwFflb6cQejkNUXrbOlXBFs
         50R2c5kgGGSZrF9wp2m39oMkPFWNCCAJ5ZJKvhfhcZwOQPEt7e9fCw3HZmeuS565m+Cc
         e6EPaFiEpeFFqn1nh/MWEkVgWfmd4cTJnvxT/4iUNF/+Ba7VA1vQH15OwdJTvqKhzrQX
         dSG6pGod1plW/ZM5bpF94sGpYywtyTE1lXUqK5UqV1FwSp2KccwjnZMg7zki7l5qqyjV
         E6kW94rVjlbeEjTzpC0scUfxB0vE3rOYEZn9VOCE55vNGBb5ZiYRQkQ3WF9nAl83oh7H
         aMRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q0JQV5advgTB6KiaCqNe+7SidNtpgdETj4pSQqOAyE4=;
        b=FnRQ7CDfuuyb4spjiBEbV9ndZ887vewyX9q6lyFTP5yUn3+0arJHY9l95Z+7RThcpW
         91v7RtskwmPRAAUHxJoWlaSyruSmRlKONZcS1S6t27DoOM9aYgv1TUVrHye23dOQUXKy
         Pki6rGDYbmyvJukyLnqrOT7TdXW5hwv7YK6bGRZgBKcQ8z1YRdm6FN8OLj7/0Mzfpiic
         8/9QyfgZnAjuOWFhsq6W11JO6914VHPG9bJvc6YHJhMUflxWdIxN4RNh2fU5fNmmEgel
         JGFHOX9Y3YoEXSmEfmjWQ0IfTToKuHk62ctY9r4N+JSkng8MMDvggmk9J+QIiHA4ufZt
         kUkg==
X-Gm-Message-State: AHQUAub0CEtmnMnVX2dejDucOMrx71JnIabfHQbYMANLiNBvzy1QfK4o
        lkF92mtB/8iY6aYmSjLwcN03sg==
X-Google-Smtp-Source: AHgI3IappIygzSAyIltbqUutkyprXfuZT5t9kLg2Xt/+mtLV/U8LPYJy7Slsb9/CWXhBTh1g1ms+0g==
X-Received: by 2002:a6b:5f14:: with SMTP id t20mr3760727iob.268.1549385921371;
        Tue, 05 Feb 2019 08:58:41 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id z124sm3198157itz.42.2019.02.05.08.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 08:58:40 -0800 (PST)
Subject: Re: [PATCH 05/18] Add io_uring IO interface
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, avi@scylladb.com,
        jannh@google.com
References: <20190201152414.23296-1-axboe@kernel.dk>
 <20190201152414.23296-6-axboe@kernel.dk>
 <x49sgx3t9yv.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <90ebd7ce-6821-aa71-fdba-1e59d30f3d69@kernel.dk>
Date:   Tue, 5 Feb 2019 09:58:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <x49sgx3t9yv.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/4/19 4:22 PM, Jeff Moyer wrote:
> Hi, Jens,
> 
> Jens Axboe <axboe@kernel.dk> writes:
> 
>> +static void io_ring_ctx_free(struct io_ring_ctx *ctx)
>> +{
>> +	destroy_workqueue(ctx->sqo_wq);
> 
> You need to make sure sqo_wq is non-null before calling
> destroy_workqueue.

Fixed, thanks.

-- 
Jens Axboe

