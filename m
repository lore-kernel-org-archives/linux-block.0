Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8051DC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C4B522419
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 15:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rQhvAUZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C4B522419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732866AbeKOBgw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:36:52 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38393 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732450AbeKOBgw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Nov 2018 20:36:52 -0500
Received: by mail-io1-f67.google.com with SMTP id h4so7879520iom.5
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 07:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iiHlD7ESB9YQd4GkJVfHHlmSDTapsawYgJwgWIw17h0=;
        b=rQhvAUZYgf5lNy0hnHjJSOGzJ4lm2cHZFuwDU3Cp1MAQ5xjDXfkl1JKUC7nTMu8SXW
         ZI75e/hfG5wOA+Ke26+VHNGKQgHFzKN7Oajw6ylrYcrAav4ekJIJCQvRXnk7D31V5RxV
         lz7FfcUzyCRq7Xk2SkBoO7xemToHOJiYazWijp3L+7MLoUK/lMoVx+YDATk30UcbcYaw
         NJMdEGFW/hKY8mkyuHx8XqkjAC4eAoIGVzHz03b8eP4BSaFqQ8G22MXBhn22XbQPsQCs
         Z8P2M2HiGBQDAD72G/aeSW0aDQ9RzFxIHuX20iXstk+7yLa1FiPXP5Tt/XJuUF4n+EL/
         hx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iiHlD7ESB9YQd4GkJVfHHlmSDTapsawYgJwgWIw17h0=;
        b=CXvbdR3zQcqCqla7ECkEZ9+s12UdcQNuOD4KxCL2gGKhsS8C0KEEcA4jclF4bSwfyI
         VDe+cJN6gZp3644ZQcaQDgmmxwHjD1/cqxbf36hD0VZhBHEjpcJDF0ZpSg8OIHsJxDFl
         U0nmJvS6jEfvLWjSImeNrUGFrvoAI6HgbJs1riK8t+mzfXARZBz1IFeUgvZiN+dGbFi/
         Q1p87/hHkdkiadkZHFDKqVatUt6xz91/9W5sTnCV/vQgu7sgjxfQRUvJX4KHgo0CsaDA
         NDt7VLt/zjoNFYhO3vG4gh2kKlCblFgawOW436QR3HpH8g7YfCRuxiGz3eQHWyS5Bx2U
         tOzg==
X-Gm-Message-State: AA+aEWYlutsdALY9+dp5IRefXBMViAUpRhiLDDgJUhe5OY6mOkwLT6WL
        eHu8qFMUn46deLK3SM7OD6SiUG+NTb4=
X-Google-Smtp-Source: AJdET5dtVirWLxqayjBuBORa7MIBXT8oJnbRhdO0ln8HyqwmHzAWxbbx/BbeEuleGJrgu72/2CZaHg==
X-Received: by 2002:a6b:e80a:: with SMTP id f10-v6mr1754858ioh.296.1542209589176;
        Wed, 14 Nov 2018 07:33:09 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c10sm3050892iok.23.2018.11.14.07.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:33:07 -0800 (PST)
Subject: Re: [PATCH 3/6] blk-mq: embed blk_mq_ops directly in the request
 queue
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20181110151317.3813-1-axboe@kernel.dk>
 <20181110151317.3813-4-axboe@kernel.dk>
 <20181114152053.GA22186@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <130070cd-e0d1-e75e-4341-7c1b26d1531e@kernel.dk>
Date:   Wed, 14 Nov 2018 08:33:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181114152053.GA22186@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/14/18 8:20 AM, Christoph Hellwig wrote:
> On Sat, Nov 10, 2018 at 08:13:14AM -0700, Jens Axboe wrote:
>> This saves an indirect function call everytime we have to
>> call one of the strategy functions. We keep it const, and just
>> hack around that a bit in blk_mq_init_allocated_queue(), which
>> is where we copy the ops in.
> 
> What amount of difference does this patch make?
> 
> This really defeats the whole constification, which doesn't hinge
> on the const attribute itself, but on having the static ops in
> a read-only mapped section.  So unless it is a real measurable
> and big enough difference I'm against this patch, and if there is
> a real an measurable difference we might have to find other ways
> to archive this goal.

It's measurable. It doesn't defeat the const at all, the mq_ops
is still const and is never modified outside of when the queue
is allocated. The only difference is of course that it is no
longer residing in a read only mapped section, which is a shame.

I'll try and do some specific numbers.

-- 
Jens Axboe

