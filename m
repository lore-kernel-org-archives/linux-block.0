Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6830CC77B73
	for <linux-block@archiver.kernel.org>; Thu, 18 May 2023 23:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjERXUv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 May 2023 19:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjERXUt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 May 2023 19:20:49 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700CDE49
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 16:20:45 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1aaea43def7so19468695ad.2
        for <linux-block@vger.kernel.org>; Thu, 18 May 2023 16:20:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684452045; x=1687044045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgzax8mPFhor5ZBCVgrw1F/Psabnomd2F3ev+M1dE7g=;
        b=i6cKfl+AlYzI0HNPSuYuaBI8mtZh/fF6VVuw4zCs1ckS1TTt238zuH2kpX9KaXSyRi
         KvA2wVdeK5bqDnw5qaPZNv6fjZNQALd3D7y9oe9jLxOSEV5VlrsBC5Q117rCoh6gh+qp
         REw+V2GkERZwSkGg+95ErOKcayNq19V2ocqnRt/ro3KGe2mlxY84n3KrjUCO4ooflvVs
         meYySmcpkGB0huwkGvNtPiDlICfMruFOrxrfvN5leLZRAM3FKfLjAAY2VBXesy4bMpb1
         SBrfYaLxFMp9ji9NW4JjSvJEu+g8MGD1QV0Ox7PipHOBQVORrKWKbJAUAA6MdXr/li9V
         0KlA==
X-Gm-Message-State: AC+VfDxTAS+Wv9QuL1WZbJ09Gzzuh40SKJ2EMMUKY+u/GPD/K7Hyvltp
        Fwkfil//IYe6YUTcZU9N1iU=
X-Google-Smtp-Source: ACHHUZ6N4r7p6bLQkBAK2K4wt6i5BfSP5bikSz9Hz+p5E0R2VrIjRb6bAyXoHwbGq8uwRoe6ZW2w8w==
X-Received: by 2002:a17:902:a706:b0:1ae:2e08:bacb with SMTP id w6-20020a170902a70600b001ae2e08bacbmr840982plq.10.1684452044748;
        Thu, 18 May 2023 16:20:44 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id n4-20020a170903110400b0019ef86c2574sm1971805plh.270.2023.05.18.16.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 16:20:43 -0700 (PDT)
Message-ID: <ee9bcf21-dafc-3d8d-d90a-b2bd54c5eb24@acm.org>
Date:   Thu, 18 May 2023 16:20:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 01/11] block: mq-deadline: Add a word in a source code
 comment
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Omar Sandoval <osandov@fb.com>
References: <20230517174230.897144-1-bvanassche@acm.org>
 <20230517174230.897144-2-bvanassche@acm.org>
 <f6086451-0811-7f25-035c-9c06fc40b5bd@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f6086451-0811-7f25-035c-9c06fc40b5bd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/18/23 16:11, Damien Le Moal wrote:
> On 5/18/23 02:42, Bart Van Assche wrote:
>> Add the missing word "and".
>>
>> Cc: Damien Le Moal <dlemoal@kernel.org>
>> Suggested-by: Damien Le Moal <dlemoal@kernel.org>
>> Fixes: 945ffb60c11d ("mq-deadline: add blk-mq adaptation of the deadline IO scheduler")
>> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> 
> Replying to this patch as there is no cover letter.
> 
> I gave this series a spin yesterday using a 26TB SMR drive. No issues detected
> and no performance regression that I can see. Tested on top of 6.4-rc2.
> 
> So feel free to add:
> 
> Tested-by: Damien Le Moal <dlemoal@kernel.org>

Thanks Damien!

BTW, it seems like Lore received the cover letter. See also 
https://lore.kernel.org/linux-block/20230517174230.897144-1-bvanassche@acm.org/T/#t.

Bart.

