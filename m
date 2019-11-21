Return-Path: <SRS0=S5B1=ZN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3676C432C0
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 17:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FE5206DA
	for <linux-block@archiver.kernel.org>; Thu, 21 Nov 2019 17:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CPrrDF1H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfKURAx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Nov 2019 12:00:53 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:36914 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfKURAx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Nov 2019 12:00:53 -0500
Received: by mail-il1-f170.google.com with SMTP id s5so3988099iln.4
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2019 09:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ogzEOLkqeZaOFs3MCF+gg0bfstSDrwD8uCycA8ygSjI=;
        b=CPrrDF1HsnZN0n/eD1GN4evTWXSUeg0FBnY2/QZPm98YnGgYDB/SYVDUoqhT7z7Bsf
         1l2ry62zLduWgfAjYzUEJ3xI/a1BWQdRxYrq9Ut47DefN87i8S8WFe4HslAxiGd77y1z
         G190A0+eDcOWIfuXEnT7vCsHqxTS51wrIHSQXO3LbB4c+t41UGZfka4GtDrsDcmDlymG
         8viqSneLv2lykIML1vHflXMttwGX7lhGAwdgF3hBbBE+Jj8M8EyzRK3Czf3gregR0g46
         GeMtXVDJtYc6yX0Z8gdmw6D0q5GdPlqWF1AtayORluihsNgCq7RLQLVX+lC40pt9BjIt
         4Vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ogzEOLkqeZaOFs3MCF+gg0bfstSDrwD8uCycA8ygSjI=;
        b=Gsna5OWeB1z4yDdCiX+dKAqiuUBWxYgB7YBg1Ye4sXaheL3jEfk3atm24baCR8e2AK
         7QtUgLjx30CUCstpSNRQOMWd/NCl1PatKTbB0aqJ8IM2efrmHHyXwY4/0gyWt+7A8Acx
         AKKq4RpNakSP/ESn9hHwTRxvE+WN/9vdbm39g4jthafwtgEYktKi90lXO7wc1506aqsd
         ZewbEZZDlq+EFmAm8RF/FsHQqiWqnWElnBB64DsHPjx8pMmiQ1z4xivpsf+iEbsVM16l
         /umaNTXcMO2Sqg7a3d2bn1r1YKOJSUblobyznUp+r/60DjHACBEX8P81RPEdrP9Z5kgc
         0kGA==
X-Gm-Message-State: APjAAAVO0+jy8+l5/pJBRo3Riw7UPfvnVfsgGYg0r0wi2L8ZGFFjla89
        bKqByKymBcLGBWpK2vKAfcqtnHAaMUjbdg==
X-Google-Smtp-Source: APXvYqxdCoTlwAv839O65jiBoEeBwFPz8JEnCJx9jP1+UnfushZMTH1E6VmnxGekVVSRnfaC2Txrvw==
X-Received: by 2002:a92:de4f:: with SMTP id e15mr11446167ilr.50.1574355649903;
        Thu, 21 Nov 2019 09:00:49 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r25sm1433103ilb.16.2019.11.21.09.00.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 09:00:49 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Single nbd fix for 5.4-final
Message-ID: <f8df6a8b-5326-9367-0592-0220322a3bfe@kernel.dk>
Date:   Thu, 21 Nov 2019 10:00:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a single fix for an issue in nbd introduced in this cycle. Please
pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20191121


----------------------------------------------------------------
Sun Ke (1):
      nbd:fix memory leak in nbd_get_socket()

 drivers/block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Jens Axboe

