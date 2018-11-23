Return-Path: <SRS0=Lvn3=OC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CDCC43441
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A220120861
	for <linux-block@archiver.kernel.org>; Fri, 23 Nov 2018 18:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CnPv63mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A220120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeKXFHa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Nov 2018 00:07:30 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40237 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725751AbeKXFHa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Nov 2018 00:07:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so3674002pfo.7
        for <linux-block@vger.kernel.org>; Fri, 23 Nov 2018 10:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=g2KGJi/DftlDDPLglqV55veX9ii2pkDC+PqZW6GAGHc=;
        b=CnPv63mbJQxr3yV5ElPQM47J3CVsj1wONIjDhRa5DWMUjx3TgChclwb6jtXCWZDecx
         C1mAKqkbtTM8Q73Lyo8BxQhrWPk0KZsAYAFGFJb8FEuFdKOX/IdwRHsLZixfRIwvMkiv
         Msm65EqlgWGcKMpz7HZct9T6xfFp6yZWOvKM1H677ZzYhhizfeb3BSG5th9H0ui24uwL
         +2sXtAXMThwkkL1sisE5IBoiHqpJURouZAI4uBqcf7bHogDqRDQptnw9FR5Cae/4U3gm
         5Ri2B/WkrAOm4Eezk6TC/XPU1R4mm6EbYy6rJGUJT3A7DGJ0El/LjoMFKrFoYR5Bg3uR
         1sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=g2KGJi/DftlDDPLglqV55veX9ii2pkDC+PqZW6GAGHc=;
        b=jzEiTk7RnQAEQ5Nckc78O9t3/HjBOm+wfr4ojtMy8Kfn5dj+pR3kflpy+4ORro93+L
         J8aCEgbT9UmV8V77qp1ZF6SfxBqiwHwMBiw4lzBRRasoIXHMPgWMTeOmeIjPHCG32R0m
         S3+HZpx4Im+zHBwvIoWnaquWEv02h43wzCx41S/N40Oz80GF/YWfhHtOfO7cc/zyKlmj
         HiI2pQzdEoeJsL5VlkNhxHCXe/BxygBMCScdYOqyY/CXb9kCPOvzqky3N4WWX6AU12UW
         N2GZdvE52976GxVkr8e0EMu++sb9d/PvgtgfxIwHN2X7SukrR75pCfbR05wk3d7MoOfp
         EHcQ==
X-Gm-Message-State: AA+aEWaoi7O7BEpaKVI5EinjIM0O7nunt39KxHrSqR4EAvtXAKnPD7+g
        004un6wXQyyJi+npoPYkuOIlemVRTVw=
X-Google-Smtp-Source: AFSGD/WpTl3ebF4PtRoT8rzOOuNea3qxIXP84qaCgmtOO2Bxf7KUOlYd0kcsu97CeZoajOLqCskA6A==
X-Received: by 2002:a63:7cf:: with SMTP id 198mr15283529pgh.129.1542997327584;
        Fri, 23 Nov 2018 10:22:07 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id 64-v6sm101294569pfa.120.2018.11.23.10.22.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 10:22:06 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fix for 4.20-rc4
Message-ID: <d4234f36-e387-7eaa-85e8-dbd2eba422f8@kernel.dk>
Date:   Fri, 23 Nov 2018 11:22:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Just a single fix for this week, fixing an issue with nvme-fc.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20181123


----------------------------------------------------------------
James Smart (1):
      nvme-fc: resolve io failures during connect

Jens Axboe (1):
      Merge branch 'nvme-4.20' of git://git.infradead.org/nvme into for-linus

 drivers/nvme/host/fc.c | 73 +++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 63 insertions(+), 10 deletions(-)

-- 
Jens Axboe

