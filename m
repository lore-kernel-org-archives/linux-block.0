Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036F0C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B399B20834
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 17:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="soPGEWXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B399B20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeLAEYc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:24:32 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39350 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeLAEYb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:24:31 -0500
Received: by mail-io1-f65.google.com with SMTP id k7so5117063iob.6
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 09:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8uD6DgnkarekeadHOSWYrvZ1Lgkqje++Eny7aMTqTww=;
        b=soPGEWXiyycvQPSIGWVrHlTjJWp/UL9Rq3X+n7VJ8Qwhi5kXPA/xWm+LhcmurdLe4N
         m9T+bYWU86maJ5qneOnd+TqfSJkZSchmQ5nbuwwbnXONhDEo/BkleKwUwKCt1wFz7yWS
         mR6D9S1MEe6zfqoad4VdRGFGw8SvHgGPUgjVosPOIZZguAO+t75t+HcP37ub0p7Tdhdx
         Z0ysl7okRY1Umw5dUF5fxurF2KupwtadZof0znXqTXphpa1ggnH/kKW6tgAg3iKN9bME
         BHHQu2dJKeq2ZGbBqn+CHfvuQJcbXP2CdBcCVRAB/7iawKLa5In7/8vcWkNXp1olCxo3
         mj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8uD6DgnkarekeadHOSWYrvZ1Lgkqje++Eny7aMTqTww=;
        b=FwZUzCdeUrYBgpUGb8fkI1dsjO25ksdQwWqP5YcLSjcq4Wrf7k2jnwb+aKh4gtLSlY
         JEGmraJh1qoQityK+EkiALcUgPQ7RNXGqasaqLcNLJc96imbmSHV+PzPl9TRM+f7ME/6
         V9Ei9IXnISwteQiqapiO4/M2ol8G8ZEsbR+izEyz+6pPZEIrXyYB7SILVMItu/WOfjq/
         85LydZj5JsUyPDr3urR4a6hkukdQtczJMdTxMYL0r8tX4jUNwnGP5Xnc/J9OrPBjnoJ7
         YlW2Qt+F6b1TfneWLckyLyAL9uzMyxWdC887WIY1pa/o8fNLVcRc1UmaSaPf5+CWqOLX
         6vEw==
X-Gm-Message-State: AA+aEWa/CiaK0tLNNIWItLjuvb8zLMHvB3vM17+wsId9Ujz11vRFoOrx
        9Z4JBril2rdvpzaK5S82EIcUeg==
X-Google-Smtp-Source: AFSGD/UWLBVVHzpxCgklShlUfBhibHiWhTwpT0qxeUYTlvwNKQDLUDGM6vkKeiRympsDsDZ6I3dHKg==
X-Received: by 2002:a5e:9706:: with SMTP id w6mr5051437ioj.86.1543598073188;
        Fri, 30 Nov 2018 09:14:33 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h16sm2712750ith.25.2018.11.30.09.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 09:14:32 -0800 (PST)
Subject: Re: [PATCH 02/27] aio: clear IOCB_HIPRI
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
References: <20181130165646.27341-1-axboe@kernel.dk>
 <20181130165646.27341-3-axboe@kernel.dk> <20181130171336.GA17030@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75612cc8-aa98-92b9-4a0d-02564add9c3f@kernel.dk>
Date:   Fri, 30 Nov 2018 10:14:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130171336.GA17030@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 10:13 AM, Christoph Hellwig wrote:
> I think we'll need to queue this up for 4.21 ASAP independent of the
> rest, given that with separate poll queues userspace could otherwise
> submit I/O that will never get polled for anywhere.

Probably a good idea, I can just move it to my 4.21 branch, it's not
strictly dependent on the series.


-- 
Jens Axboe

