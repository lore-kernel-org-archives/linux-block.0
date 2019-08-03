Return-Path: <SRS0=u38M=V7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A356EC31E40
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 14:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E822073D
	for <linux-block@archiver.kernel.org>; Sat,  3 Aug 2019 14:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="asL6pZes"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfHCOZO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 3 Aug 2019 10:25:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42889 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbfHCOZO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 3 Aug 2019 10:25:14 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so34788961plb.9
        for <linux-block@vger.kernel.org>; Sat, 03 Aug 2019 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LEY/R4JdluLnEoZvfNetYTGhrvG9h4fW18rpVnCXlkI=;
        b=asL6pZesc361ZotnLed0tzz1szMbohvHSdJFqfd0PxDwCXXPSsa7oMoopjYMMEWRTG
         t5h71rxcDSBf+P2cXRrl1puCHN8n6zsFKQ7o8UCuXvf3s71zaN6S4nEobQ+wnPVuAZ0g
         pQrPRqkYez4fCmOgdW/sB7252oGTS0Jit5JLkPcrX/uK3Y4PkIX5OT2fLl4KOX1qLIsc
         xpAHNWLOUFi1M+rLXAIerlnxCqGL272FInl1/D06SMEoH6EAD2Yns1KDJX7g0WRVYd7U
         zN1szgFYScisFTbizr03lNJHmNsmo7WmflG06vCiKP8UlwX8PvoRg5sW9dSAM+CTl/kT
         LeCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LEY/R4JdluLnEoZvfNetYTGhrvG9h4fW18rpVnCXlkI=;
        b=RWXhwa7CnBIKHdLnisQ1Ov5/6639atK0lrko3SHgOS52TcK1l6pGivr9nhkoa3uKk/
         jvpKEril+JSKimbiQnaOL2X3/k5406ri0/46mbXkxi9JQ6nxFJQnPae4Q4b1QUPZJNso
         TDHS86cLBKsuzzrUwMxesVucFzYYskmeElv0IOI5YNosVkb4LssCf2bOn4LVKWQdX44F
         zmX7YveuPC5CsZx68QS6aOWcJsqRmU/pQ96Ayb09OHQLXnBh7OlMGZr1xpn1VfDQkWHp
         nVzFaSin1BBRoxBvzFe5hpJ7H6I3AOriqE+UFiV50DEylwX/s8BzkLsKyFwD4PdlbwLb
         wbZw==
X-Gm-Message-State: APjAAAUcjscyE4yRiPDkgTfwP80i8Cjo87vX//5LZs8KKmb+qJCSCawq
        4E5V1Vg7D5oOPSGRdw0pxwE=
X-Google-Smtp-Source: APXvYqz4YO6EKT601GVgI0nBFwWu18eMjnstX9qZ+k5GgFpURDn/iSMdj+PjIS8Ab74E6YOHjIOtPg==
X-Received: by 2002:a17:902:ba96:: with SMTP id k22mr139552203pls.44.1564842313932;
        Sat, 03 Aug 2019 07:25:13 -0700 (PDT)
Received: from [192.168.86.24] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id 124sm80764903pfw.142.2019.08.03.07.25.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:25:13 -0700 (PDT)
Subject: Re: [PATCH liburing 0/4] spec: rpmlint fixes in preparation for
 Fedora packaging
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Aarushi Mehta <mehta.aaru20@gmail.com>,
        linux-block@vger.kernel.org, Julia Suvorova <jusual@mail.ru>
References: <20190803084526.3837-1-stefanha@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1ecc837f-6177-c0a9-2d29-13efd29faf28@kernel.dk>
Date:   Sat, 3 Aug 2019 07:25:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190803084526.3837-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/3/19 2:45 AM, Stefan Hajnoczi wrote:
> This series addresses the remaining rpm issues that I'm aware of.
> 
> Jens: Once the patches are merged and you publish a 0.1 release tag I could
> roll the first liburing rpm for Fedora.  liburing itself is in good shape for
> wider consumption but maybe it makes sense to wait for kernel issues to settle.
> There are qemu-iotests failures that are probably kernel bugs (hopefully known
> ones!) and will be investigated soon.

Applied all 4, thanks.

Any pointers to the qemu-iotests failures?

-- 
Jens Axboe

