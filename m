Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37A5C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E8320834
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AtsKXDHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E8320834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeLAEUR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:20:17 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36177 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbeLAEUQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:20:16 -0500
Received: by mail-io1-f65.google.com with SMTP id m19so5122176ioh.3
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 09:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rfDN/MQ2YhRKebhhLMzJ9llVYPJUkljZojXbMFNb6yQ=;
        b=AtsKXDHXFVbqS8hThx1soIlUV4gOhFaQmo3TI+oUcyA05Qk1evpM4wRwpE8AZ98WK3
         v4WlTGHFxbP9fP4H7nHAkMAzOsYVLvZlYjbvq0T2fY4VImXgGXVJR94p8m8G/uIa3iav
         DYVoPxmIpbTuxLGkz6X+ydTKkSzuu0TXMhUeTLL6AbcU9FMaVV09Rd4GfVlVZfmqh8aD
         vYA9i8CURc1aVesjDMUICMSBR1fe9cBCS/FesmObzQaq/iJVYjD23BKZeLuzcvc8z+yy
         3fTKq7RhZjdlnRAmEzoU5VVeHc+Rxzvf7zX2LG1jlGCCd0Rgc3T3NoUa04eLB7efsl5m
         hGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rfDN/MQ2YhRKebhhLMzJ9llVYPJUkljZojXbMFNb6yQ=;
        b=NG+g7Iel7Y6M/CLD7PHkRCUcPVj5c5cExPB9CRQJyp9XCcUe/vKSgEq+kOQloQXdr4
         T3VybpPSz4Izy2MpbW4nsG1khfaU0hdlKerU9GPwlH2q0UfDD99ypwM5KnAafvOyZHGX
         TlkYqbmCeq0UKBUG4XEc6RW5r9kBX+qDDrQ3wg1HoXaA+U9YReYvIqXHaJPe0QCsx8fa
         2SyYTxEDI4hV3asKHHv6v1CaRtDWtVjoFb7WA5VUKsgzXevxUniOWfUpq6ur+8YB6i8Y
         oYEEi7HKdMhn8AtBi09C9yTUEOPzZmrXKGQn+BdVVdEA4fbhTquFmE+pRGBh4IxMCvAN
         b5YA==
X-Gm-Message-State: AA+aEWZVvZJPttJgsW0Klm1uEN9aNoPte7S3vVPEh0CRyeDhxhLIBH0B
        h/n0x8nP138Yka05WDPOCj0nDOkno50=
X-Google-Smtp-Source: AFSGD/UBpyhKMYN86DhSbzAAsD5hTAmlrPGf6m+E6gu8mNC4XzLJepIgA8EXEkbPzTHJhkuQjCKlUQ==
X-Received: by 2002:a6b:1807:: with SMTP id 7mr5186151ioy.167.1543597818615;
        Fri, 30 Nov 2018 09:10:18 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l3sm2968359itb.43.2018.11.30.09.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 09:10:17 -0800 (PST)
Subject: Re: [PATCH] block: fix single range discard merge
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Guangwu Zhang <guazhang@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
References: <20181130163818.6540-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9a3e2660-14d9-63ff-5700-def1656fee50@kernel.dk>
Date:   Fri, 30 Nov 2018 10:10:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130163818.6540-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 9:38 AM, Ming Lei wrote:
> There are actually two kinds of discard merge:
> 
> - one is the normal discard merge, just like normal read/write request,
> and call it single-range discard
> 
> - another is the multi-range discard, queue_max_discard_segments(rq->q) > 1
> 
> For the former case, queue_max_discard_segments(rq->q) is 1, and we
> should handle this kind of discard merge like the normal read/write
> request.
> 
> This patch fixes the following kernel panic issue[1], which is caused by
> not removing the single-range discard request from elevator queue.
> 
> Guangwu has one raid discard test case, in which this issue is a bit
> easier to trigger, and I verified that this patch can fix the kernel
> panic issue in Guangwu's test case.

Yikes, good catch! Applied for 4.20.

-- 
Jens Axboe

