Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1388C77B73
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 17:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjDTRNB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 13:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDTRNA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 13:13:00 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFC7E67
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 10:12:59 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-63b73203e0aso8512996b3a.1
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 10:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682010779; x=1684602779;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvYVbQpslgzKBiIV8gTJMWDW7bIjBpRJEP29g1wCGvM=;
        b=JdKeMXh9P8PQTetzNlR6EshcyxUBGw1F4yxTYSlLENi/kh70iyf0PGVlQRBVgNxPWi
         09toyFPCszTG+kGdWpPTWhuZz+MouTJyUY27DMYEGJ1wkOV05efFiDJDobVkEm2J2rhE
         B2mfw5Bd/tuIB49riXOOm38p8LbWAz/oeEsGmz3dV9wEVNRYDZktpqd/mLDgdpv3OAIP
         x1CM+10hbNaaoFzLfSyEBpMKzRoZFx5/IiOejGdd9SHLlWVpd4r5u5Voi7B0jpeIOoeZ
         zBnkTaO9kWTdIRbH0GU1i46SBvf3dKADzi+jG/bDhzReV27oPkKclD5ON5h39SAwhC/A
         4rlg==
X-Gm-Message-State: AAQBX9c40tvWFo3Q2MDikMoCpxn7K9wnWtzA0oPxRQ1m4sBEqFHDqNKZ
        d7AioXjNAQKirOLu66rx/X4=
X-Google-Smtp-Source: AKy350YY9yimMbOnLZMJHLl1kJcEpVrcmmMsF3IeijameaBBJDY8B8IO7Gi6dZ+eGbNSerIYA6hrJA==
X-Received: by 2002:a17:90a:dc86:b0:249:67dd:5783 with SMTP id j6-20020a17090adc8600b0024967dd5783mr2453090pjv.18.1682010778979;
        Thu, 20 Apr 2023 10:12:58 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:216b:53b9:f55c:cf92? ([2620:15c:211:201:216b:53b9:f55c:cf92])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902900800b001a64475f2b4sm1398559plp.111.2023.04.20.10.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 10:12:58 -0700 (PDT)
Message-ID: <f9d35d19-d0ba-fcb7-e44b-f0b8c55ba399@acm.org>
Date:   Thu, 20 Apr 2023 10:12:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 10/11] block: Add support for the zone capacity concept
Content-Language: en-US
To:     Niklas Cassel <nks@flawful.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-11-bvanassche@acm.org> <ZEEEm/5+i7x2i8a5@x1-carbon>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZEEEm/5+i7x2i8a5@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/23 02:23, Niklas Cassel wrote:
> With your change above, we would start rejecting such devices.
> 
> Is this reduction of supported NVMe ZNS SSD devices really desired?

Hi Niklas,

This is not my intention. A possible solution is to modify the NVMe 
driver and SCSI core such that the "zone is full" information is stored 
in struct request when a command completes. That will remove the need 
for the mq-deadline scheduler to know the zone capacity.

Bart.
