Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04BEC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EF920851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jEjlkQGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68EF920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbeLMUMC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:12:02 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:37453 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbeLMUMC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:12:02 -0500
Received: by mail-it1-f173.google.com with SMTP id b5so5854126iti.2
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 12:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mX2ALEwjE1rpKxMZZtMIe1LvqvpMJ3rKLrSyCou1id8=;
        b=jEjlkQGN8givBGPjlUEXTo+FQpexfTdZ+nzzWkkJuWhddHY0A5OKm3jcz3H4XtgsMO
         HqDWxzcaSqNnjg2N+J8W0PnlpJqR9YVJrtmf29gzwtyg69TJjZSdhRbBIHvwKi8r58lP
         BUZPZ9bLzeRpcN+S+8SHLvQO72MR1CTPxEEOJ0RgAqyXOKn8hYIAWkUowvBrIuOAOndg
         RCQNivzTe31s5IGNkLGFGfD1JUhBZ47lyfecT77UfE9AKgliik8istrSgwD4rfBYjBmo
         KfIwK+mCWJQcqEj1pbsOnXbjDZg9CPKzf7jvmFxsPwPkG6TxKKNBByziPMbjUCCcw6rn
         wRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mX2ALEwjE1rpKxMZZtMIe1LvqvpMJ3rKLrSyCou1id8=;
        b=qHbKqhglT095B9IEzdpzFhyB0vIng1869p4CBh07XJTbDf0L/ID2HqXoHxo0/Ns0T0
         lwIfnZBRXjXSCcx2+xei+Ch1MHsZKoz58REGnP4LkDtCvlrW3Wv+agt2upT4KqVJsZ4s
         RGxzyVmKk+UFQaCZYcxlGN3x3sEssVET0qN3InAzxmecn2MzcDXq29pLOzDJr5c984lm
         cNz2cP5REK254g7oldwErSb5C9k9nbgKyLFbTnoA3K1ffj6JmChJcWf+gvBlppfx7MGN
         cYlyYIzk77qpy99uDWuTitW7XIELxn0YbcYqeafj2aytyAimYvCE9J0E9ksS/Tw5cPKV
         Vpvg==
X-Gm-Message-State: AA+aEWYBU/dMOkEGXHeLeSjB2BQJx9AlkisfJhQD9H5c03bpqsJhEecR
        Pf8ApPWNDZ3lzbVGWLFmaQPBkQ==
X-Google-Smtp-Source: AFSGD/VWeYU9uI2KQMGoEP+rIeXreT5Nl4KRvMvUuSC+HiHdrbhXDJL0OgR3zblRXtpeYLbKDepOAg==
X-Received: by 2002:a02:1a0a:: with SMTP id 10mr198790jai.50.1544731920696;
        Thu, 13 Dec 2018 12:12:00 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h14sm1085023ior.41.2018.12.13.12.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 12:11:59 -0800 (PST)
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
 <fb17d794-c682-3261-cbad-94ce4c14eea1@kernel.dk>
 <BD7FB879CC136E419544C8E2AE7B9C30227F0B@IN01WEMBXA.internal.synopsys.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6309baec-bb1f-4986-6872-a70047fbc469@kernel.dk>
Date:   Thu, 13 Dec 2018 13:11:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <BD7FB879CC136E419544C8E2AE7B9C30227F0B@IN01WEMBXA.internal.synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/18 1:04 PM, Ladvine D Almeida wrote:
> On 13/12/18 7:42 PM, Jens Axboe wrote:
>> On 12/13/18 12:39 PM, Ladvine D Almeida wrote:
>>> Suggest to take a look into the article https://urldefense.proofpoint.com/v2/url?u=https-3A__lwn.net_Articles_717754&d=DwICaQ&c=DPL6_X_6JkXFx7AXWqB0tg&r=z00zRD9ARrwHpe-XSl1OtUp1uNKGYoXI1G2DhOaDDBI&m=-pGzV3wdSje337vKOYoYB6NgU_DGDmQvfQ9egLDRYNQ&s=c4FXsrwD0BLAjE4UC47R2ngLnx_DP5jiOr0dtZ7tGsw&e=
>>> My real concern is how to achieve it without any modifications to the
>>> bio.(because key slot information has to finally reach the target block
>>> device)
>>
>> Guys, you both need to edit when you reply, wading through 650 lines of
>> text to get to this...
> Jens, Thanks for your reply. I will take care of it next time onwards. :-)
> 
>>
>> You obviously can't modify the bio if you don't own it, but you could
>> clone it and then you have storage in ->bi_private.
>>
> 
> I agree. I can clone the bio in the crypto target and use bi_private.
> But, when i finally submit the bio and it reaches the target block
> device, the information stored in bi_private is lost.

I don't follow, what do you mean it's lost? It's persistent from
bio setup to end_io time.

-- 
Jens Axboe

