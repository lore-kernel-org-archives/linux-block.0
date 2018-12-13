Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9B4C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 19:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 462E920870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 19:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="EPX4fBl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462E920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeLMTme (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:42:34 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34081 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728069AbeLMTme (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 14:42:34 -0500
Received: by mail-io1-f67.google.com with SMTP id w21so2601493ioc.1
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 11:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7apot8fWpYOasMIUwI0FadJYsYG0fNGlbakQC2sa4eI=;
        b=EPX4fBl2zvox6KMlpTsRkXiotK0Ca3EGiCrh/1bDc11qxWMDvPUjUKkoghJn0N/eoZ
         csUlNzFHctXf5Paifnsh3sUXtbknaL/rFdnVwC4QiCpBAF/qcVo2EfLv84tNxrWGHpzM
         wBp6cjvxuCypI7lmiNEEXhP2jfol7/FyPDLzfrPne/0LAstFnh4jn1WG49rLTpJolifQ
         sGb8q/FUimwz1nRMVbG2+zTvlmTV9Cg4+yZL4yygVIKNkbnlYavmuNLx5dm2eMz9kRdf
         cAu3eB8xZxeEcWNFJkkWgM/G43VpVsOlYJJ19vx0lD+hwC842AySJcBECGYTXSS+7NGJ
         7LmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7apot8fWpYOasMIUwI0FadJYsYG0fNGlbakQC2sa4eI=;
        b=sXHj/XJKGzIaB2fivmOfA3IZ2qcph6JLUGMdNgaIKl1pnmSY6CXtubCnk31P5k3Lyq
         GFVTEzhxGpL1OvE4m5cUvybdOmxWbhZEgvstuxH2phdvEMjBrwzcBotPuw3HvrRKHoJH
         fyNw99kfjOKcsIBY5S4kdoc7hsqA2xjhoiMp145EpX1eqa/UVCyf8Yv1s4yGlzzUM8s1
         jKvinchPRzyuEIA+tH8oMXFwpX3AFgNgOWf19QTJ2bje/VlODNGGZrtYX1HORsdl7FFJ
         zJTBSyXDz1FpGqoZUgY582/IJk19DYy1PTLw19eOLnLlomC5rRJEqpyNSv5BthLVpxmC
         ujAQ==
X-Gm-Message-State: AA+aEWbZpV+IgBnhXoTDHQWZR8PCL9gYfAm+V9RnPDX+0g0xtaKONwc9
        CV/EKrKF7t1/u9hR+4eJF2lYoA==
X-Google-Smtp-Source: AFSGD/WGs0wqFgi+0x4VXT1KsypjPcBuuvAQetudj4qM+NDqT14vUuVv5f6Z/Ax0A0gOU1pmESca/Q==
X-Received: by 2002:a5e:8b05:: with SMTP id g5mr86140iok.144.1544730153002;
        Thu, 13 Dec 2018 11:42:33 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h140sm1680572itb.23.2018.12.13.11.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 11:42:32 -0800 (PST)
Subject: Re: [PATCH 2/2] scsi: ufs: add inline crypto support to UFS HCD
To:     Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Parshuram Raju Thombare <pthombar@cadence.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Alan Douglas <adouglas@cadence.com>,
        Janek Kotas <jank@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        AnilKumar Chimata <anilc@codeaurora.org>,
        Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Manjunath M Bettegowda <manjunath.mb@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
References: <20181211095027.GA3316@lvlogina.cadence.com>
 <20181211181647.GC221175@gmail.com>
 <CO2PR07MB2469AD9C0A121EBF94129A11C1A70@CO2PR07MB2469.namprd07.prod.outlook.com>
 <BD7FB879CC136E419544C8E2AE7B9C30227EE5@IN01WEMBXA.internal.synopsys.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fb17d794-c682-3261-cbad-94ce4c14eea1@kernel.dk>
Date:   Thu, 13 Dec 2018 12:42:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BD7FB879CC136E419544C8E2AE7B9C30227EE5@IN01WEMBXA.internal.synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/18 12:39 PM, Ladvine D Almeida wrote:
> Suggest to take a look into the article https://lwn.net/Articles/717754
> My real concern is how to achieve it without any modifications to the
> bio.(because key slot information has to finally reach the target block
> device)

Guys, you both need to edit when you reply, wading through 650 lines of
text to get to this...

You obviously can't modify the bio if you don't own it, but you could
clone it and then you have storage in ->bi_private.

-- 
Jens Axboe

