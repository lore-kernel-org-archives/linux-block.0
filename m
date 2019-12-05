Return-Path: <SRS0=S578=Z3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69931C43603
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 18:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F0A22525
	for <linux-block@archiver.kernel.org>; Thu,  5 Dec 2019 18:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e/CziQ9F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLESay (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Dec 2019 13:30:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43968 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbfLESay (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Dec 2019 13:30:54 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so4792395wre.10
        for <linux-block@vger.kernel.org>; Thu, 05 Dec 2019 10:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N+4IZ1rLNXRP7IPA5B5TlxLLVMsiVBAA5EzVkh4H+yw=;
        b=e/CziQ9F4dnmhMcVRNo4At08g/oYpSc7C5DL10HXdDlq12DYQlC+aR63ngrx1mME/8
         d+7ZCQxURI1ElNLVvn0Wuh/dTvQjxqogqb9U+iE800+f5LTfXjbZyxpzdnzDMGcr9bjm
         Hd2JUqfrovCO2qMcuIED7y8yZrQxjNQomV4/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N+4IZ1rLNXRP7IPA5B5TlxLLVMsiVBAA5EzVkh4H+yw=;
        b=uUwX0tseCBvgu/ZQV7KrQy16H92bS/NDUMLtm9tbfjOlBWZTdzn2XmN3P5JqJ/PyT+
         4SEb5WwgnIP5jpK5rGyzCQm+gFIAql/jye0OTKWM+hvI1MY6AEV7CYLVcUvVSN808PTL
         xFI/iOKp0aMyCMG97PJKsCvV2IPLFH6+W8ZnbRdGOfg1qzQ767sk+9HCqIliS3zEqw5j
         +H2waL06OQpLFo/PvRMSxiF+x8NApgD5FSZ4i0vseChqtpLOcDptHKAcIg6oVqC8ISBj
         MKp5IVOlU5IAX5jm1ibR2WqLthZUAKyLcLyHPgxqAIZj74dx643BnCDVIfznVjqNjaSh
         oXgg==
X-Gm-Message-State: APjAAAWWDzYErn5VXy+gk0d/AHuE0SUpaI+qovHnYdWoXf6FZfOOMAgd
        HGImUMiQuE8dYllB8jzooGhubQ==
X-Google-Smtp-Source: APXvYqwhNgrYMrCcXI06kdbmlgPtrcCDuYTp5TGor1wxfou95Ww3eFBm8x62nAaHSl3qKYdV0d46ig==
X-Received: by 2002:adf:f847:: with SMTP id d7mr12025791wrq.35.1575570651946;
        Thu, 05 Dec 2019 10:30:51 -0800 (PST)
Received: from [10.231.221.227] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id s65sm684589wmf.48.2019.12.05.10.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 10:30:51 -0800 (PST)
Subject: Re: [PATCH] block: fix memleak of bio integrity data
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
References: <20191205020901.18737-1-ming.lei@redhat.com>
 <CAAmqgVN6huL60c9aw41yC6wz6fG0w-T4xR0Tuoz0PqX2BqwKDA@mail.gmail.com>
 <20191205074932.GA21955@ming.t460p> <20191205080915.GB21955@ming.t460p>
From:   Justin Tee <justin.tee@broadcom.com>
Message-ID: <f4f0f90a-0541-a25b-f9a6-f7e0762d6e28@broadcom.com>
Date:   Thu, 5 Dec 2019 10:30:48 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191205080915.GB21955@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/2019 12:09 AM, Ming Lei wrote:
> On Thu, Dec 05, 2019 at 03:49:32PM +0800, Ming Lei wrote:
>> On Wed, Dec 04, 2019 at 09:41:24PM -0800, Justin Tee wrote:
>>> Hi Ming,
>>>
>>> I understand the patch, but I have a concern.
>>>
>>> Is it possible to come across a double-free?  from bio_endio ->
>>> bio_integrity_endio -> __bio_integrity_endio -> bio_integrity_free;  And
>>> then, resuming in bio_endio -> bio_uninit -> bio_integrity_free;.  Maybe
>>> it's even possible queue_work  bio_integrity_verify_fn was scheduled and
>>> called bio_integrity_free from there as well.  So, should also remove
>>> bio_integrity_free from bio_integrity_verify_fn and __bio_integrity_endio
>>> routines?
>>
>> Yeah, double-free could be caused for READ between bio_integrity_verify_fn()
>> and bio_uninit().
> 
> ooops, the above race doesn't exist because __bio_integrity_endio()
> returns false and bio_endio() won't call bio_uninit(). And bio_uninit()
> is only called from bio_endio() when bio_integrity_verify_fn() exits.
> 
> Also we can't remove the bio_integrity_free() from bio_integrity_verify_fn(),
> otherwise this bio may never be ended because bio_integrity_endio() will
> schedule the verify_fn again if bio_integrity_verify_fn() won't clear
> REQ_INTEGRITY.
> 
> So bio_integrity_free() is always called serially, and the flag of REQ_INTEGRITY
> guarantees that it is only freed once.
> 
> I think there isn't such double free you mentioned.
> 
> Thanks,
> Ming
> 
> 
> 

Right agreed, the REQ_INTEGRITY flag is what is guaranteeing freeing 
only once.

Thanks for clearing this up.  I'm good with the patch.

Thanks,
Justin
