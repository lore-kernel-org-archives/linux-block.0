Return-Path: <SRS0=L3Py=WS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D426C3A5A1
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 14:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714E321848
	for <linux-block@archiver.kernel.org>; Thu, 22 Aug 2019 14:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732126AbfHVOyL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:54:11 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42831 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfHVOyL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Aug 2019 10:54:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id y1so3603981plp.9
        for <linux-block@vger.kernel.org>; Thu, 22 Aug 2019 07:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i+1K6o+xU0wds7U7OAi01E44/TiWnXscnx9OSYa+MG0=;
        b=VO5TXOMozfcPD2VPTV1pbD7BgA8DRLYH9crrEcloJDeEku5vw2v4myiJEV5GgHd8ER
         QsQcfhDbd191hm1Qt5ya7GJCliJWXYquifXGZqEyqfK+RAFJqvTcr6Uce/MiUABP9CMM
         OJh3lUEaqQOiwTm0Qe2ntpZ+Z9nY6xFDIZPN/etU4JYxPe4QdXqjIJK72DJICS3GzPgy
         ixNfpr6Wo7+m1NyXJ4qjRKCbSFFzqG7/Ldb0NadHGITT+BuEvTp/fAHsjA2Q7SEHpeBi
         7dobnMcaIBL4raFtHoOIKqrqrvAMRYa2l82b4X0Mp8yqu28mNU3R6h5TpK1D6wFvU1/Q
         klwQ==
X-Gm-Message-State: APjAAAX+Ted9qhb9Q4QiChdQlp80/CtcStYsi3rf+t32lmmF7g2gOA0b
        B1CvJ7qTIeXftLjq1QOpl+hqSjPx
X-Google-Smtp-Source: APXvYqyohRjKZ4KXdfXIBFPjU8WL1cOSwB9E0BFtzjjJ+lJkVPQTG7Do0Qfcz7kEGueVSlOSODhXTw==
X-Received: by 2002:a17:902:ba81:: with SMTP id k1mr41599208pls.213.1566485650551;
        Thu, 22 Aug 2019 07:54:10 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c12sm28539818pfc.22.2019.08.22.07.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 07:54:09 -0700 (PDT)
Subject: Re: [PATCH] tools/io_uring: Fix memory ordering
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Roman Penyaev <rpenyaev@suse.de>,
        Julia Suvorova <jusual@redhat.com>
References: <20190820172958.92837-1-bvanassche@acm.org>
 <20190822131406.GH20491@stefanha-x1.localdomain>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <03b1e141-3e52-8df6-943a-97192f7a34a0@acm.org>
Date:   Thu, 22 Aug 2019 07:54:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822131406.GH20491@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/22/19 6:14 AM, Stefan Hajnoczi wrote:
> On Tue, Aug 20, 2019 at 10:29:58AM -0700, Bart Van Assche wrote:
>> Order head and tail stores properly against CQE / SQE memory accesses.
>> Use <asm/barrier.h> instead of the io_uring "barrier.h" header file.
> 
> Where does this header file come from?
> 
> Linux has an asm-generic/barrier.h file which is not uapi and therefore
> not installed in /usr/include.
> 
> I couldn't find an asm/barrier.h in the Debian packages collection
> either.

There two flavours of the asm/barrier.h header file present in the 
kernel tree. I think that the arch/*/include/asm/barrier.h header files 
are intended for kernel code and that the tools/include/asm/barrier.h 
header file is intended for the user space code in the tools directory.

Bart.
