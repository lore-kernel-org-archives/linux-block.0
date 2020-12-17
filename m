Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3C8C4361B
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E35512389E
	for <linux-block@archiver.kernel.org>; Thu, 17 Dec 2020 16:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgLQQgx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Dec 2020 11:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgLQQgx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Dec 2020 11:36:53 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B24CC0617A7
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 08:36:13 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id m23so13311159ioy.2
        for <linux-block@vger.kernel.org>; Thu, 17 Dec 2020 08:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=09t93s/0tac43iDNLCrqnSQrOM08LBiI84jPzbSiLBQ=;
        b=saCVzZHye3JOnY1k8kFFziD6H2PuJsjQrLWKGoMLpwOdCcXcvcXY+oTdvQsYEbradO
         w6M12ICVoFr4j7AJqM81rho8VdA4PPn4xHEdkmYoWasUupEMXbmrjE10VIUsLtPUitc4
         iEf6Okpg1yviIN5ty4hHS/4jWWQOs9Sxm1x7PrhVDx/YOMRXtSBwOT+ukG0yhDjN3jSb
         Ne2i/n3GquTvz3vfPt0sdcrYX6ukcns86UYjixkrbjeE9GaXhO1iLRe2NP9/EQH04nb0
         zsKxpEtdQqvuTI3iTYEH4Nv4G4Q42fQfYyXIQkFF0DqSk8O5T/vw5nene8ErmzdR+dHV
         2oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=09t93s/0tac43iDNLCrqnSQrOM08LBiI84jPzbSiLBQ=;
        b=gkL9+231Nu7mEXGbtM1wrZdylOs4IbLVFSDXpPEMCPbDAmYHPaoInRw8IN6TeMUAil
         l4ia21Z9zxZiis7DkmanWsQXgNSY32hQngJCe9Oi42XCUakjKHhJET1cdq2ZlHHqeWDm
         0e2rlfAovnIItH+j7jYbttIXsmpwgoznfdm62EJyaQ0sbGOxUKqpSdNdQHR+/OpByNv/
         2PM33GbyIsYHfZMfJPOQPrX4KzJu7AgcgMU63wNsazMQKeFaae08GhhSMTTjKbddwGHT
         /ZLHJMMWqTSejLVFk6GCt8qGmNwMkK4fOce7Va7oHxvR77ONL2TyslkEy/2PkitKsgLR
         lO2g==
X-Gm-Message-State: AOAM5313JWR8WhIsoSXTSo1h7MuX6it5biFAVKxxFeKDqXcgKMRps2mv
        EwiDUeIeYCe/i+NPbodRAh2FMiygrTd8zA==
X-Google-Smtp-Source: ABdhPJzoGQ75129HmrOPD9AZJF9ahboeXekr0Phmgl1j/yiPfTgJaaYwBN0xpn2Z+k0yXDmyID4+cw==
X-Received: by 2002:a5d:9641:: with SMTP id d1mr46662618ios.123.1608222972277;
        Thu, 17 Dec 2020 08:36:12 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n77sm14679198iod.48.2020.12.17.08.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 08:36:11 -0800 (PST)
Subject: Re: [PATCH 0/4] Fix DASD control unit updates
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201217155907.36436-1-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <da474562-ece9-4630-15c7-d93634e3b2f3@kernel.dk>
Date:   Thu, 17 Dec 2020 09:36:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201217155907.36436-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/20 8:59 AM, Stefan Haberland wrote:
> Hi Jens,
> 
> please apply the following patches that address problems during DASD
> control unit updates.

Applied, thanks.

-- 
Jens Axboe

