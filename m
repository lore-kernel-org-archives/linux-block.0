Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E323C77B73
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 23:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjDTXoL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 19:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjDTXoK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 19:44:10 -0400
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6902111
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 16:44:09 -0700 (PDT)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1a6715ee82fso18284485ad.1
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 16:44:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682034248; x=1684626248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MjfLH64jPW4w0/7NkQyWFuGP04rwoNvXbyz5vT2mHp8=;
        b=aTS9NEdJc9u1XHyDtLKF0E11tQwbDXfafzxHF3a0wOQCDeaKvXLS8krT0pFzanWRyY
         0n1QzXpLOG4HGJhYonPJ8BgVeort45jIc6RUS8hEGS3MWnW25gQWiKwlAMg87d3UcM2q
         LLuSSvdI9Blfu/hAxLvJ3f91YoT9w2r2zDunGY2uSu1B9SQU/gEkmvhWxESyVdLOsaVP
         Frf5nypu/ggkJirPc2Gq8f95hFmZRgEtbumadIRqKCMeVZWp7twPLEX2yzip+dRm5lNx
         Cm4v+Qj+ExJJmVEYDfe/xIbY0EoMvcyZ1ssqxvsemGumjFjlNdh8J+avY//ptPv0hF5+
         U7sQ==
X-Gm-Message-State: AAQBX9cxpk0xfjL2jxrWL+mWsHzVOIK2DDGxX0zUrt4WNxDLoRFo9ISe
        PQ9Drx3oGvmNF2qsDtj267M=
X-Google-Smtp-Source: AKy350aRTxMLoeHXqm9echXzCZtovHafCY2XXOkpPKQF4EvoTsqIkTSxx8JQJWxhz75MMBULSua9KA==
X-Received: by 2002:a17:903:2281:b0:1a6:95c3:74a with SMTP id b1-20020a170903228100b001a695c3074amr4254723plh.17.1682034248492;
        Thu, 20 Apr 2023 16:44:08 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902a70800b001a6756a36f6sm1622422plq.101.2023.04.20.16.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Apr 2023 16:44:08 -0700 (PDT)
Message-ID: <490ed061-6d82-f9fb-2050-4a386e2e4c8e@acm.org>
Date:   Thu, 20 Apr 2023 16:44:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 10/11] block: Add support for the zone capacity concept
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>,
        Niklas Cassel <nks@flawful.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Matias Bjorling <mb@lightnvm.io>
References: <20230418224002.1195163-1-bvanassche@acm.org>
 <20230418224002.1195163-11-bvanassche@acm.org> <ZEEEm/5+i7x2i8a5@x1-carbon>
 <f9d35d19-d0ba-fcb7-e44b-f0b8c55ba399@acm.org>
 <141aee35-4288-1670-6424-e6c41c8ef4c9@kernel.org>
 <ec7cdc7d-9eb7-65a4-6ba9-1ae6cf6f43d2@acm.org>
 <a5d9a370-6264-ebdf-f9f8-7b3263c2b6f0@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a5d9a370-6264-ebdf-f9f8-7b3263c2b6f0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/20/23 16:37, Damien Le Moal wrote:
> Why would you need to handle the max active zone number restriction in the
> scheduler ? That is the user responsibility. btrfs does it (that is still buggy
> though, working on it).

Hi Damien,

If the user (filesystem) restricts the number of active zones, the code 
for restricting the number of active zones will have to be duplicated 
into every filesystem that supports zoned devices. Wouldn't it be better 
if the I/O scheduler tracks the number of active zones?

Thanks,

Bart.

