Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4528FC04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 19:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2C22177B
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 19:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="g2DLIktk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbfEITAR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 15:00:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34318 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbfEISvr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 May 2019 14:51:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id w7so1583146plz.1
        for <linux-block@vger.kernel.org>; Thu, 09 May 2019 11:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O93f2LTd2RzZTjDNtYVogNWJjgQuNQaMHMBdRk2XAMI=;
        b=g2DLIktkwFYrdi+KqiW8wno2niWEuEz8GfglRim1rE8cbtgGbtBQupL5sebGfvLE7h
         6b37b+AaGf/1ib6vWx+wG+CB+AePlbXciD4ucibaevAaBC0123+99tsSLap6DrIrrQz2
         I0r+yOkbqFte6nQ9h8MeZf4NMaCFTzP6OW0YsHtEM2hDAImzEBFrmrOAoLaHtuOEshnS
         GftadQV0XOARxAk6n18pbZxFFv+qnw1vuu0reNm5T6u1hLL8bFEB8sfeAJ2P6n1QfQur
         K8SFX9UWr+Cq7i9U/T/O0AO9m3dYJ6QbxLn/1cKSV1S0IjXAMzehxEa1pyHBN2ETdVM4
         oxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O93f2LTd2RzZTjDNtYVogNWJjgQuNQaMHMBdRk2XAMI=;
        b=LNwnnA4Dj24RHzKpgQSm9qYwoUx7o6OZYeU0ovHJO6iM1rB4niESWJTQgDXgShJhVY
         Os8gnkw6xIWjrgaaszjiJeeYZ9CM1gNfSApqMlEM+v8XvdwjvgcuY7Be1AIW7DRtF5RK
         Ddvm5r0zo4UX8ruMmS1iPa8GI3UgmaZkQacvvE+TBm38twvoOusV+NkkBBkj51Zv5P9Q
         vHV4fGlQPg3WIJwbFhvHMR3QmwiKWqlOFewAawzZf5uxTkva0z9mE26bJQegErAW+X4w
         Tg6HoGNui5qMc5r2LI5m0Dl5XdcEINhcP1EBo60o2LhsFb3WiKnsGg1Vm8PzykpKsXox
         SPcw==
X-Gm-Message-State: APjAAAUySCulTcgMHBEJDs3xNLB8/vvZfdDDrzimRd9q+vW7G9RiQseH
        CnPHVakLJ7nC2zWVlfQicWM5AUvWi89jGA==
X-Google-Smtp-Source: APXvYqywmwB6HuzE2uC+tqtwoAs9ogvKbiqbYzImsjvrazcIA77IW9F+tn9D/Maq9YUEPpx20VSqWg==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr7441759plb.281.1557427906548;
        Thu, 09 May 2019 11:51:46 -0700 (PDT)
Received: from ?IPv6:2600:380:7612:320a:c991:fbc8:e3a6:409f? ([2600:380:7612:320a:c991:fbc8:e3a6:409f])
        by smtp.gmail.com with ESMTPSA id r138sm7040292pfr.2.2019.05.09.11.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 11:51:45 -0700 (PDT)
Subject: Re: [PATCH] brd: add cond_resched to brd_free_pages
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <alpine.LRH.2.02.1905091252300.19234@file01.intranet.prod.int.rdu2.redhat.com>
 <64c82900-aa9b-9093-82cb-30f179eda803@kernel.dk>
 <alpine.LRH.2.02.1905091448260.6131@file01.intranet.prod.int.rdu2.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1578b998-40c4-52de-938f-8ef9e04cbf6d@kernel.dk>
Date:   Thu, 9 May 2019 12:51:43 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.02.1905091448260.6131@file01.intranet.prod.int.rdu2.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/9/19 12:50 PM, Mikulas Patocka wrote:
> 
> 
> On Thu, 9 May 2019, Jens Axboe wrote:
> 
>> On 5/9/19 10:54 AM, Mikulas Patocka wrote:
>>> The loop that frees all the pages can take unbounded amount of time, so
>>> add cond_resched() to it.
>>
>> Looks fine to me, would be nice with a comment on why the cond_resched()
>> is needed though.
>>
>> -- 
>> Jens Axboe
> 
> OK - here I added the comment.

Great thanks, applied.

-- 
Jens Axboe

