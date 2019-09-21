Return-Path: <SRS0=12de=XQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40C6C4360D
	for <linux-block@archiver.kernel.org>; Sat, 21 Sep 2019 22:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A990220C01
	for <linux-block@archiver.kernel.org>; Sat, 21 Sep 2019 22:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EXsNMbxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfIUWM0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Sep 2019 18:12:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46502 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfIUWMZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Sep 2019 18:12:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id a3so5759820pgm.13
        for <linux-block@vger.kernel.org>; Sat, 21 Sep 2019 15:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=j5etgA9kyGOm4eFhSPqb4i3S4EbAJgA4Z7lGmy5sPEY=;
        b=EXsNMbxzuiPfTGB13z+H4wwTDqheJY5Ifs4t5iAeg+dFZiy263LI2oU8E79QWwCDMa
         6Hnnp4PN/SVWSOT2zdv1gdV32LqxbuS/S0ZHd8WIhAJbfHx2vzjBzVoBQTfb4EjE639B
         M2uS4jB+6H1mzkmxE9vdSs+oYIxlTwq7Ae6BifiWKgvzR+w8gZO2gH6EAzClABjKuiUY
         7ppimarE1i2Uo/kIEpcW+xwsJWMpJEcER8SIp4Qp7vdAihT0uN5iFLUpoJypNHwLjf3K
         tF5Vc8Hlpn4KOfP1QmNAroPJ4Zz9zWTLtuI1uz5zZevjCx9GLe411VnTgFaSWeJ/ium0
         iiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j5etgA9kyGOm4eFhSPqb4i3S4EbAJgA4Z7lGmy5sPEY=;
        b=UzyXH+Snz/Nw2dWTrSDDTLIVe6jspAF6XlBDQxApqLQXiiOkdTrYVFQhWd2ZITsh1c
         QjCg/dnvoYJpVOBaH9+muxgISlgEQQ75uj6giStUqtoI+YVzywSjj04w10iW670Fwdiv
         KqXEKZ4XJrBOi5COC27PMrbXpuZHC03xNXZxvTOE6ejtBpzp0vNHUA2e0HeLTfDkcMyR
         jrX1ClhoYLA0pkEfb24bujLhxm8dRXD0CDPMnlBxKTYpjYj8SusmIL5M4bWq0un4frW1
         VRG3YyaXLpVzQzd37uMq565d2aI5OlR9zr+FuPQSx+iWQo5PCifW0M97X6kgN3TkkHfx
         k5uQ==
X-Gm-Message-State: APjAAAUegiiXaEit10cLfPOHBNPmVWRZPN5fRIvMFnveOo2lH7f72qet
        tlCBAWrUI8siO+EFHmqrHSuEEA==
X-Google-Smtp-Source: APXvYqxwT6mRV+gRh9Kh2EmaXNDVM2iVl0KLAZFiCyCPiexT8rEDLF6eUPq+uyWai5HZi3NTkyHQfQ==
X-Received: by 2002:aa7:96c1:: with SMTP id h1mr26303549pfq.111.1569103943582;
        Sat, 21 Sep 2019 15:12:23 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id v9sm6802456pfe.1.2019.09.21.15.12.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2019 15:12:22 -0700 (PDT)
Subject: Re: [PATCH 1/1] block: add default clause for unsupported T10_PI
 types
To:     Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
        martin.petersen@oracle.com
References: <1569103249-24018-1-git-send-email-maxg@mellanox.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6e99fefd-ff7c-e3ee-087c-ed42baa7f4f5@kernel.dk>
Date:   Sat, 21 Sep 2019 16:12:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569103249-24018-1-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/21/19 4:00 PM, Max Gurtovoy wrote:
> kbuild robot reported the following warning:
> 
> block/t10-pi.c: In function 't10_pi_verify':
> block/t10-pi.c:62:3: warning: enumeration value 'T10_PI_TYPE0_PROTECTION'
>                       not handled in switch [-Wswitch]
>        switch (type) {
>        ^~~~~~

This commit message is woefully lacking. It doesn't explain anything...?
Why aren't we just flagging this as an error? Seems a lot saner than adding
a BUG().


diff --git a/block/t10-pi.c b/block/t10-pi.c
index 0c0120a672f9..6a1d4128a9d4 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -79,6 +79,10 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
 			    pi->ref_tag == T10_PI_REF_ESCAPE)
 				goto next;
 			break;
+		default:
+			pr_err("%s: unsupported protection type: %d\n",
+						iter->disk_name, type);
+			return BLK_STS_PROTECTION;
 		}
 
 		csum = fn(iter->data_buf, iter->interval);

-- 
Jens Axboe

