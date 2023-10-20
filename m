Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39BCCDB474
	for <linux-block@archiver.kernel.org>; Fri, 20 Oct 2023 16:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjJTQRU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Oct 2023 12:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjJTQRT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Oct 2023 12:17:19 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168E11A4
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 09:17:16 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1c9e072472bso7531375ad.2
        for <linux-block@vger.kernel.org>; Fri, 20 Oct 2023 09:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697818635; x=1698423435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pnUyOVtwtczUA9Fxac+ooOzFfhdkNPufWIH4EAVoJbU=;
        b=DdthBVyN3BoVu5rjI0Z/2plE7eUPcRYY+XKeNcneyfChwdwQMNT7WBdLsgTRCzhELJ
         jwnWXLltC92Da/U/dBR5rr97IxvdRCWDsoZ3reHWI2U2YEh/SunvP4iCNFX4v5JU5fRM
         75oRfF+yFcGAedg857FZGqC8QegjCJASDmLq8pcOGiqBB8W0kTk9+LN9VTjHljO33gD3
         7Gfqrf5sn1KClSqukObcFj45i6owCOnvRHqgBR/pcn/l+W698DKA4Z7SRcIgwcBi5BYV
         MyYPxXOEglpTm3XjSqnFaXkyhmhtwCDY+JvxpuzGVV0PB2FU2J9vCTf2HFnCTEAR7ydA
         IqOQ==
X-Gm-Message-State: AOJu0YyYlP2ZXgzWpHY4i5Ra/HqYn/686yLCfGyyytU+QwPFLhXMgpmu
        KJBLzvdQR864dvDz8jqUNC4=
X-Google-Smtp-Source: AGHT+IGQbmoTyfS2iMdwvIf2ZqPEYYSHVj8DXCgdodJWR2iqzZLdRSVfl7Nmgxw8gXAUMz3d4kBR6g==
X-Received: by 2002:a17:902:eb84:b0:1c3:62c4:7f12 with SMTP id q4-20020a170902eb8400b001c362c47f12mr2770874plg.5.1697818635414;
        Fri, 20 Oct 2023 09:17:15 -0700 (PDT)
Received: from ?IPV6:2601:642:4c08:4945:85f8:4610:95c3:168a? ([2601:642:4c08:4945:85f8:4610:95c3:168a])
        by smtp.gmail.com with ESMTPSA id q11-20020a170902dacb00b001c72f51b84asm1707645plx.52.2023.10.20.09.17.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 09:17:14 -0700 (PDT)
Message-ID: <0d2dce2a-8e01-45d6-b61b-f76493d55863@acm.org>
Date:   Fri, 20 Oct 2023 09:17:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Improve shared tag set performance
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Yu Kuai <yukuai1@huaweicloud.com>,
        Ed Tsai <ed.tsai@mediatek.com>
References: <20231018180056.2151711-1-bvanassche@acm.org>
 <20231020044159.GB11984@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20231020044159.GB11984@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/23 21:41, Christoph Hellwig wrote:
> On Wed, Oct 18, 2023 at 11:00:56AM -0700, Bart Van Assche wrote:
>> Note: it has been attempted to rework this algorithm. See also "[PATCH
>> RFC 0/7] blk-mq: improve tag fair sharing"
>> (https://lore.kernel.org/linux-block/20230618160738.54385-1-yukuai1@huaweicloud.com/).
>> Given the complexity of that patch series, I do not expect that patch
>> series to be merged.
> 
> Work is hard, so let's skip it?  That's not really the most convincing
> argument.  Hey, I'm the biggest advocate for code improvement by code
> removal, but you better have a really good argument why it doesn't hurt
> anyone.

Hi Christoph,

No, it's not because it's hard to improve the tag fairness algorithm
that I'm proposing to skip this work. It's because I'm convinced that
an improved fairness algorithm will have a negative performance impact
that is larger than that of the current algorithm.

Do you agree that the legacy block layer never had any such fairness
algorithm and also that nobody ever complained about fairness issues
for the legacy block layer? I think that's a strong argument in favor of
removing the fairness algorithm.

Thanks,

Bart.
