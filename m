Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF14C433FF
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 13:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B41F20665
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 13:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="c3ijjhIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406016AbfHBNg7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:36:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41480 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404870AbfHBNg5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Aug 2019 09:36:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id x15so25745975pgg.8
        for <linux-block@vger.kernel.org>; Fri, 02 Aug 2019 06:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U3jPLfm3ofwMgO759g2VpsFRe3iCYn6Dwae+C5pZ458=;
        b=c3ijjhIUXrIFVfz+16YNMWgA4OjuY0cHBqda1mZ4ngjXG4gV42jbIwwt8CT5Ejx1++
         rD8qa2R4b7095x++1mVHj6mIevPE+vP/+ojHqYy/vRhRboqoXZiXLGxtjee69v0HhaWI
         MKZOJepl89tsdrN1aRhTlPC1k49mxuly+VjY2f16KoX4ufM84AvcaKLvpRr98f00MAta
         X9zsMtowviAooCF6V8983kDqBMG79kn6/ysfbny2VtjWbObrBY5Bm6GyLMycyzlfken0
         EP4KXWqPdMvW3B7zcVLqzCn5ex2di59vGBrwwt64llCjmtZ6a/k/QuCxP70gWvtXY+zU
         DgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U3jPLfm3ofwMgO759g2VpsFRe3iCYn6Dwae+C5pZ458=;
        b=pJdI3tiZSZx0nE2f8GlTKfV8pspr+AdsXUMEDgiKz/SMtQ1wieci19dgUMyHBvQs8O
         O8m1v9CJui7a2AQCKNYtjAciHvY7XE0ZEgMvY7JzNy/1/dXQdpvjK7e9//GhuSJid7sl
         KJGzkrYMX+N9oX+Xs7V5Z6i7qNWOOENFLSc716abbBG21Hd5TJE4pZ5YpBnAEU6SjeSS
         m3RkojD0flZE2iRjXavYQC/cjuM/13hDi3OkNc4wp6jLxo2HZf1FKsqqIeOKORT8JVwG
         CBo7KR3GnRvMBKe2FCtQ+jawant5cRFvXu1KyYdn1s2t7KKJUkKaOjCNmMsiHogp50WB
         dgFA==
X-Gm-Message-State: APjAAAWRemME4jObwQe4c72P2XJs489jyCrcvquzX/t0H1yfyNIUnXYZ
        gcJHjWcVhj2EGZ0OPUE9D+8=
X-Google-Smtp-Source: APXvYqx024JtT6h+CIqiXxuy/WdmCLbvFCiN3AE5RgAojmeLIymyEWklLgaBdPFCGqrszPi4ygvAFQ==
X-Received: by 2002:a65:5082:: with SMTP id r2mr97758250pgp.170.1564753016781;
        Fri, 02 Aug 2019 06:36:56 -0700 (PDT)
Received: from [192.168.200.229] (rrcs-76-80-14-36.west.biz.rr.com. [76.80.14.36])
        by smtp.gmail.com with ESMTPSA id f8sm42308919pgd.58.2019.08.02.06.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 06:36:56 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] Optimize bio splitting
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20190801225044.143478-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d3e2bb78-138b-0d35-93fb-6e9d5b0ed0f2@kernel.dk>
Date:   Fri, 2 Aug 2019 07:36:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801225044.143478-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/1/19 4:50 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> This patch series improves bio splitting in several ways:
> - Reduce the number of CPU cycles spent in bio splitting code.
> - Make the bio splittig code easier to read.
> - Optimize alignment of split bios.
> 
> Please consider this patch series for kernel v5.4.

Applied, thanks.


-- 
Jens Axboe

