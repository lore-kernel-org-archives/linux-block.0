Return-Path: <SRS0=fyvH=WM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E478CC3A59D
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 22:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE5392077C
	for <linux-block@archiver.kernel.org>; Fri, 16 Aug 2019 22:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfHPWLK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Aug 2019 18:11:10 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:42629 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727682AbfHPWLK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Aug 2019 18:11:10 -0400
Received: by mail-pg1-f179.google.com with SMTP id p3so3582471pgb.9
        for <linux-block@vger.kernel.org>; Fri, 16 Aug 2019 15:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9BeqtshRdXM/xAm62Z46+A77Geb2d8faBObQR/vfpxw=;
        b=fHa86avcjmwEnXlpca4nJ1trOQR4eJ1GoACvDIpgGoTs08e92GJwwCcW4iaWDO3IzK
         TKwlDNkbTE1xZsLrLJSqVrsKLNiHREO9oBZZ6SRJ9nujXdWThXyU2lR1H8VE4kko5E+k
         rMMcSkcxJKFM8ed2Z1yRn3SwlQyyQoP8gmOw0RfPGVeWKS76oNvMgj5g2dKfAk/vCWI+
         G1lcWWxSYx6GFVGrz5RRh3oTLNBlZwzIT0V/Nv6POEweDtpprZdZfJpaXXKUuF3XGhA4
         xC4Dj4HkIHqYEswqCDzQYAm76r/MchnHYPkrsYBgd4ZaGbvAmWOzVcbSAKPMDtbFj+m3
         tl0Q==
X-Gm-Message-State: APjAAAXbZyA5uPrbFzTpACF9MZKhZuH3aIxnrB2qOSVkqqnhAb6lseQ6
        cccpBWAP/IgUYlp9NZ1li3AF/SdukKA=
X-Google-Smtp-Source: APXvYqxCi5CBaHrkAoG0aIKBWTaJ+UNb2z7+47M9z/5dmMMQnkX3EKqczvZnRxx0Cv+RVJEOJBgFTg==
X-Received: by 2002:a62:76d5:: with SMTP id r204mr12667682pfc.252.1565993469251;
        Fri, 16 Aug 2019 15:11:09 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id i9sm4408783pjj.2.2019.08.16.15.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 15:11:08 -0700 (PDT)
Subject: Re: [PATCH] block: remove queue_head
To:     Junxiao Bi <junxiao.bi@oracle.com>, linux-block@vger.kernel.org
Cc:     axboe@kernel.dk
References: <20190816211233.22414-1-junxiao.bi@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <78ef5725-5c2c-5bdf-0145-ffaf61e58f04@acm.org>
Date:   Fri, 16 Aug 2019 15:11:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816211233.22414-1-junxiao.bi@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/19 2:12 PM, Junxiao Bi wrote:
> The dispatch list was not used any more as lagency block gone.
                                              ^^^^^^^
                                              legacy?

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
