Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F5AC04A68
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 16:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbiG0QDL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 12:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiG0QDL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 12:03:11 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D70491D2
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:03:09 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id w14so1157924ilg.7
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Kn7vJgiUXREzWqLbCLExELR8Al17XFrQ1H1zaGBFXAk=;
        b=RDo+D5uuZNui/lLUnKD6iKIJjqsNl9UqB6nia4bBzpy44LbuF3D4Ww/2ixypuWwT0A
         czKx5ZP+qIgcZJuN5Bu5Vat7221N3kU49gziaMyoxdM/H3z+zSr1CAkdFyawq+M0eT/H
         IgYJROs6ngX4MDNd3IiG8K83pQNdxn1GUjsMCK3mjYRnrW0MVsbzxC9lagXZRZppVk5b
         HHWDkSbv0VGGQovxzrKvwVsnyzxJVZaI/6U3VL75GMFTaloQmeddsY1qrWhzSm4GwvqR
         sanZN7llnLmVAru59KguUk8vqmTNvkqw66doQUjPlHvlxylKE/rxuboZmp6modSGohPu
         XLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Kn7vJgiUXREzWqLbCLExELR8Al17XFrQ1H1zaGBFXAk=;
        b=a/U7bXnTjAoLJwQBK+7oE8tRPjJOkJtmNnbM2sW/MpGXp7814K2qfcTfpZlH/DmniR
         Dj0cwZHGztgmSUoMIo1Q6StEfC78ph7hZHcMS8TX7Rm2ewggyc7kL1SLIc0tWDuSoBNT
         ZxMkI6R8+bblja8OVn5nhTQX3XOIm8P2L/8zpV5AhZfNZiUxmOZRNmAgFPcXXsoZtuWx
         MzwONM9x2s9xkpek7MCfvtt1pK5x812xZpskK1dZAhd/ZsWQ/cmrI2Ph4w4EbqVTf5j/
         mT4zVYgEP3eeEM3SpZMSrDtVpnSpoYPOsL6mtu26FhkogG6dWqD0ukpW8ZJ+fR6a7glp
         o2ZA==
X-Gm-Message-State: AJIora/YigRQyoiDAAPDrTmMsq2OIYhHv58LU++yEMo6F6StyHJG6dkP
        hKv9rZWKJZt9OcSmrp4JhjYsy3mUZe9zBA==
X-Google-Smtp-Source: AGRyM1tdaKCafffU75xIG7zjCGFKhTbAUMFLC37xarEbMmX+EO4FJDAdu/zHXK56fLb682yrLa8OQw==
X-Received: by 2002:a05:6e02:1528:b0:2dd:478f:68b3 with SMTP id i8-20020a056e02152800b002dd478f68b3mr6331482ilu.296.1658937789294;
        Wed, 27 Jul 2022 09:03:09 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h38-20020a022b26000000b003316c1a2218sm7959236jaa.70.2022.07.27.09.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 09:03:08 -0700 (PDT)
Message-ID: <88079819-ac38-4a50-dd1e-7acdfea607f7@kernel.dk>
Date:   Wed, 27 Jul 2022 10:03:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/6] block: change the blk_queue_split calling convention
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block@vger.kernel.org
References: <20220726183029.2950008-1-hch@lst.de>
 <20220726183029.2950008-2-hch@lst.de>
 <219efcde-fbdb-d379-5c14-874490f8c886@opensource.wdc.com>
 <20220727155202.GA18260@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220727155202.GA18260@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/27/22 9:52 AM, Christoph Hellwig wrote:
> On Wed, Jul 27, 2022 at 08:26:13AM +0900, Damien Le Moal wrote:
>>>  		/* there isn't chance to merge the splitted bio */
>>>  		split->bi_opf |= REQ_NOMERGE;
>>>  
>>> -		blkcg_bio_issue_init(split);
>>
>> Is removing this init call intentional ? If yes, isn't that a problem ?
> 
> No.  This was actually added back in the drivers-post tree by
> "block: fix missing blkcg_bio_issue_init" and I messed up the rebase.
> 
> Jens, do you want me to send a fixup, or are you going to do it locally?

Ugh yes I missed that too. Please send a fixup, thanks.

-- 
Jens Axboe

