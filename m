Return-Path: <SRS0=93Gy=OS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46B7C07E85
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 18:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9428420855
	for <linux-block@archiver.kernel.org>; Sun,  9 Dec 2018 18:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbdlBO5V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9428420855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbeLISCB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:02:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35954 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeLISCB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 9 Dec 2018 13:02:01 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so4256193pfc.3
        for <linux-block@vger.kernel.org>; Sun, 09 Dec 2018 10:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NCFQPGs8xYVO9XriecZKCj9M/MfA2FR7yuzniLj19ik=;
        b=UbdlBO5VpytWjLS/+ly+eHH0EwLNi9YI9ubZS8T6KbqNAN1M5ntwDBlHaCCrKIFgKe
         oDAXr8U72KYjKiRI585QScNDmzpeUyuZwui+TVAI5tEmExy6lwudwLsbs3H8WboRkozK
         hhKAi96ySo7+dQRSuveFoZNiDFQRMl9MaqDKUXB8bCJoaHZvdgzpdrVZ3o/KOG/bLoWq
         DikpxfZgCVFdaMoswubWjYJCaL4Cj4UeJd5C5qs0P9yI/rUgAGPk8ag0OBfdWBkGWIZV
         zuRaAXozTMs532ZZxPCGil9NKEVxDYXXHZdtDTzr0IwRsH10cwtARgA94IcFG3r+LUas
         aEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NCFQPGs8xYVO9XriecZKCj9M/MfA2FR7yuzniLj19ik=;
        b=gYEyG3s+hQYxQZGPYtLSKwxRKHOCxmmNaqgwmTQKFS2+lWbvxKcJpP/p9GTlCdMc7y
         Ynwcc0HdoMrDff97n2e52WSyZDHyHw/uVfwisvb3JDXjSV9P53lOLzlTQ9otvVFXNrov
         7qt7mb/69PfkGNFCHkAF/MA3ftdd2kUw7Zhbr6L8NYJI+QkW+m6sNhw97SRRlauiFnym
         b1fc3nBYP8AlRxu8YA21JmIDF1LiPa5WAQw/idVRMkc1SUvFMa2k6o4/s8tjlrFSzBha
         YO9fuHDRcOFSFPoTxqD34OCxQg1elJNIXULI+LbP4mMtNJTGt89tVrMW7pPg10URzeUp
         04fg==
X-Gm-Message-State: AA+aEWay0Lx1jzVjslmV30Q3WRozKUk2QJuZz8vDmLnAdU3wZ5Ud10Nl
        KoNtf2n6+x81EVRG2oF4mJ8x8JYN
X-Google-Smtp-Source: AFSGD/VFJy8jTaYYy1yS9zUYBZl1Vq7a+x+x2IfpATGI4UUJ2sCEYDx5AFn1CKtg8rZyHZL1T2SZWw==
X-Received: by 2002:a63:36c4:: with SMTP id d187mr8124830pga.404.1544378520514;
        Sun, 09 Dec 2018 10:02:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q195sm12369499pgq.7.2018.12.09.10.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 10:01:59 -0800 (PST)
Subject: Re: [PATCH] sbitmap: silence bogus lockdep IRQ warning
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20181209165847.GA31213@roeck-us.net>
 <f57e00fe-9f59-e1c2-2af3-8c41ebe1fe51@kernel.dk>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5b742063-76c4-ba63-e50c-5e4dfe1dbe42@roeck-us.net>
Date:   Sun, 9 Dec 2018 10:01:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f57e00fe-9f59-e1c2-2af3-8c41ebe1fe51@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/18 9:50 AM, Jens Axboe wrote:
> On 12/9/18 9:58 AM, Guenter Roeck wrote:
>> On Sun, Dec 09, 2018 at 07:26:47AM -0700, Jens Axboe wrote:
>>>
>>> Ming that lockdep spews the following trace. What this essentially says
>>> is that the sbitmap swap_lock was used inconsistently in IRQ enabled
>>> and disabled context, and that is usually indicative of a bug that will
>>> cause a deadlock.
>>>
>>> For this case, it's a false positive. The swap_lock is used from process
>>> context only, when we swap the bits in the word and cleared mask. We
>>> also end up doing that when we are getting a driver tag, from the
>>> blk_mq_mark_tag_wait(), and from there we hold the waitqueue lock with
>>> IRQs disabled. However, this isn't from an actual IRQ, it's still
>>> process context.
>>>
>>> Mark the swap_lock as not needing validation to silence this warning.
>>>
>>
>> checkpatch says:
>>
>> $ scripts/checkpatch.pl jens2
>> ERROR: lockdep_no_validate class is reserved for device->mutex.
>> #357: FILE: lib/sbitmap.c:68:
>> +		lockdep_set_novalidate_class(&sb->map[i].swap_lock);
>>
>> ... which I think explains the warning I am seeing with this patch applied.
> 
> Try the other patch I sent out earlier, that should work.
> 

Ok, I am lost. No idea which patch you refer to. I'll just wait for the problem
to disappear from -next, or report it again if it shows up in mainline.

Thanks,
Guenter
