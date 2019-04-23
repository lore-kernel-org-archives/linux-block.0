Return-Path: <SRS0=N4qE=SZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84714C282E1
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 13:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5540B20645
	for <linux-block@archiver.kernel.org>; Tue, 23 Apr 2019 13:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xQBdkq1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfDWN5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:57:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33441 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfDWN5j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Apr 2019 09:57:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so7665872pgh.0
        for <linux-block@vger.kernel.org>; Tue, 23 Apr 2019 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ptG9df4vwjPaPOQkRRnxyizsyhjPNrzwSf6T+zf63p4=;
        b=xQBdkq1VT0hViELCFG+zy8hYcvynUVIttUTduiA0NFiJneucdyfgalCa/2GaQGrezx
         U2p8JD/xtUKSNHqO1Az9UHVbwJzPPaIkvmsJm54XGyCE0dse/AST1e84iaV94+MiAfER
         Vw3vQniuWObYf8sgu7m8hBJVEXlRO6u1dOW7P8UZS+kZ8uBpIY4I3dKyMt5s8mv4mJvU
         5SoYtIm9YLTPm9CRpKpwdt0au/KhG7wb4uZfi1rlXgf0siGCM+zjx/eSK1tNNdwZ5vEs
         dn2DiJPIe5COu5Eh47JOmr7sgjPHXlz7jlAdWYjtk3xmMqVG7ulBBQtWAqMJVaYUuS+j
         or8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ptG9df4vwjPaPOQkRRnxyizsyhjPNrzwSf6T+zf63p4=;
        b=ZEzcY3RCoKHb2OjZMGXgjePEeOgM62LiySmXmoy/kMWCRyhIcLIWURhlnMzGWGlea4
         GxNJIlzWL8BtI9Cx885KoGMSn4MqEi5opBgQcByauhs8IklRXziNuUwoxZ6KLHIYykTi
         JIUhz+8wZBNnz39vxhhOETLCrR/t5MdxJivAnZGGh2fY8nzGOSiZnRqJ2avG4HhJXqWp
         zdpJLpmCXu02y1/BmHpHANbXMBi/SZ1HqOnN5ATNtlTjLeIBYxDutawt3GEt88dyxcZt
         QDDUBqdA7gGRURa0Li0nAWlgU98szBHTouKVTUiWv5pBY33HCbMRVqkFEMRYFUQa2COk
         +8oQ==
X-Gm-Message-State: APjAAAWlq5fsmorEigvMrawdCEEpXtE4eRScZqwKyDKZnF42hAnyoRZE
        OAkDu0IL9NvtKeaJU2yuAik8RA==
X-Google-Smtp-Source: APXvYqzkUPcwgbhdU+CQGy2qVAdo6ygWDUojqCsLZZf6ArByjEl1RD5cHtPIsUx6awIDN7H+d8l+EQ==
X-Received: by 2002:a62:3501:: with SMTP id c1mr2336751pfa.184.1556027858366;
        Tue, 23 Apr 2019 06:57:38 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id j19sm24746583pfr.155.2019.04.23.06.57.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 06:57:37 -0700 (PDT)
Subject: Re: [PATCH V3] block: clarify that bio_add_page() and related helpers
 can add multi pages
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
References: <20190423025104.3843-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8257f229-30e1-4eb9-ff77-ef0e57b8e77c@kernel.dk>
Date:   Tue, 23 Apr 2019 07:57:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190423025104.3843-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/22/19 8:51 PM, Ming Lei wrote:
> bio_add_page() and __bio_add_page() are capable of adding pages into
> bio, and now we have at least two such usages alreay:
> 
> 	- __bio_iov_bvec_add_pages()
> 	- nvmet_bdev_execute_rw().
> 
> So update comments on these two helpers.
> 
> The thing is a bit special for __bio_try_merge_page(), given the caller
> needs to know if the new added page is same with the last added page,
> then it isn't safe to pass multi-page in case that 'same_page' is true,
> so adds warning on potential misuse, and updates comment on
> __bio_try_merge_page().

Applied, thanks.

-- 
Jens Axboe

