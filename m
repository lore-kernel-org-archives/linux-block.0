Return-Path: <SRS0=Z/SB=V4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208FBC32751
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 14:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23FB20659
	for <linux-block@archiver.kernel.org>; Wed, 31 Jul 2019 14:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387833AbfGaOro (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Jul 2019 10:47:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39212 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387593AbfGaOro (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Jul 2019 10:47:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so65945204edv.6;
        Wed, 31 Jul 2019 07:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:reply-to:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ubWzJdlkwL/Chec9E0P0hzGft3Ntgy1XLQyj9u7gDwc=;
        b=KPa/3Cl3HBqITKrHDkVRZfTkeiyw64TZEGGc4npNCO4NzTQtrbFviw4L/+jR8UzbMs
         3NckDcUPOFu9aAOFcbKdcpRCz1ATIPJely033DTjhNoluetB7G0lUFXpAk64InMQcWHY
         6A5PG2EbR5nSGaP+CjUhj1PEUbjXON03e/dQ3tn0Tp1v10W02B/BrWmJMr1Txn/A++8B
         rMLlfX55m3JYNITYHg6o7F6ZMT0WDzWxwEmjpmOm7JWNvPvmU6iQ36yVkvEegF2AadYo
         uWVdehgQBI+NvkYvR3F4T8JsVm80Gqqq1lIdaS7le8gKDQ1grOZF1SBHv9Tj11RB7s2G
         MiWA==
X-Gm-Message-State: APjAAAVkwySSiwprdX1ckbgFhWiXv/fvpEKIFjFvip5DnaRVJtjEVIlf
        NMocyhA2UF3Q45/LwZXozjdHmHfVfd4=
X-Google-Smtp-Source: APXvYqxSla+dlVxzyaG79utC0CR7YpEexYWGUdqgv1FjY5DJvgCu3Nr9WvGvceU/eA0aMUXNNcnu4w==
X-Received: by 2002:aa7:cf90:: with SMTP id z16mr6187491edx.228.1564584461846;
        Wed, 31 Jul 2019 07:47:41 -0700 (PDT)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id o18sm16891954edq.18.2019.07.31.07.47.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 07:47:41 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: floppy: take over maintainership
To:     Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Will Deacon <will@kernel.org>,
        Greg KH <greg@kroah.com>,
        Alexander Popov <alex.popov@linux.com>, efremov@ispras.ru,
        Denis Efremov <efremov@linux.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
References: <20190712185523.7208-1-efremov@ispras.ru>
 <20190713080726.GA19611@1wt.eu>
 <ec0a6c5e-bdee-3c26-f5d2-31b883c0de5d@ispras.ru>
 <CAHk-=wi=fHuiQg1fMzqAP9cuykBQSN_feD=eALDwRPmw27UwEg@mail.gmail.com>
 <nycvar.YFH.7.76.1907172355020.5899@cbobk.fhfr.pm>
Reply-To: efremov@linux.com
From:   Denis Efremov <efremov@linux.com>
Message-ID: <57af5f3e-9cfe-b6d8-314c-f59855408cd5@linux.com>
Date:   Wed, 31 Jul 2019 17:47:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YFH.7.76.1907172355020.5899@cbobk.fhfr.pm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi All,

On 18.07.2019 01:03, Jiri Kosina wrote:
> On Wed, 17 Jul 2019, Linus Torvalds wrote:
>
>> I don't think we really have a floppy maintainer any more,
>
> Yeah, I basically volunteered myself to maintain it quite some time
> ago back when I fixed the concurrency issues which exhibited itself
> only with VM-emulated devices, and at the same time I still had the
> physical 3.5" reader.
>
> The hardware doesn't work any more though. So I guess I should just
> remove myself as a maintainer to reflect the reality and mark floppy.c
> as Orphaned.

Well, without jokes about Thunderdome, I've got time, hardware and
would like to maintain the floppy. Except the for recent fixes,
I described floppy ioctls in syzkaller. I've already spent quite
a lot of time with this code. Thus, if nobody minds

-- >8 --
From: Denis Efremov <efremov@linux.com>
Subject: [PATCH] MAINTAINERS: floppy: take over maintainership

I would like to maintain the floppy driver. After the recent fixes,
I think I know the code pretty well. Nowadays I've got 2 physical 3.5"
readers to test all the changes.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6426db5198f0..6c49b48cfd69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6322,7 +6322,8 @@ F:	Documentation/devicetree/bindings/counter/ftm-quaddec.txt
 F:	drivers/counter/ftm-quaddec.c
 
 FLOPPY DRIVER
-S:	Orphan
+M:	Denis Efremov <efremov@linux.com>
+S:	Odd Fixes
 L:	linux-block@vger.kernel.org
 F:	drivers/block/floppy.c
 
-- 
2.21.0


