Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D15C6FA83
	for <linux-block@archiver.kernel.org>; Tue, 27 Sep 2022 16:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbiI0QyY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Sep 2022 12:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbiI0QyG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Sep 2022 12:54:06 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2AC4B0D2
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 09:52:43 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d8so8192781iof.11
        for <linux-block@vger.kernel.org>; Tue, 27 Sep 2022 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Eeyrjvu/e3fFvz7ULrjto8qGu2VqFaHHQOq4egwVqsc=;
        b=G1U5EamS8uaYcVuz7Y1TAsjVm7OvZyrJ26OPJpqR3vLrn+uuIrNHdP0h958veOBppk
         EKxExIrhdIupi98RO9lRe3DpO4A6/Q7MzyIjnbHfVLTq5ti0OZ2bv6d9bffVjpQLPhJD
         VoXGpffNJRG/BFIBA+voRZ+v/e1Sf270SEuGR38Ldh9gfYOgnciq6bR11ieBuHHnzVvG
         C3f0RhttD7YVIMNCoNgA0s7aJT+6g3mANzfkFIVqe6+FMFHyqZcPYNWsvUb8u4AuTgY5
         p/UoA/D0tCjUUSm02rZW4ESJ7ukZlhpAQwSKq7XEqZfxZ1zllSddl6JhQ4JHFl3Jev4W
         DfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Eeyrjvu/e3fFvz7ULrjto8qGu2VqFaHHQOq4egwVqsc=;
        b=on7IFs+SHj8BdJMhuSzcAE8YeqlMdqoQ2udWXTe3dlGVDMPwJaV1XvtfRWVPSWmCqZ
         zYj8WW6Lc4KvnPcCwRA8NqGrce9Y2ku+hnJr9len4vyG38SMwwHknZKAxE9pP9gQIZWe
         5lD0e3HCL90JvbOAEsxaIbYAjpk1BClNR0UFBY4sds6ECz1Y4N3hkjlJrxn+w7Q/uKul
         zli9MCj8mAJeTPc89yRuE6/RaT1hfPnrUtGIRzHZ1pF4eSakj07lRFmVJFkDXNFYNi+9
         cODm+gZV8CkF79/IMrBwg+g28VawUG9Z+S+uXS44ZgziRBxDnlBB1UX7UM3qVCKPwe3Y
         bh5w==
X-Gm-Message-State: ACrzQf1kaN9eSsLrqtHOdsebOe/3xDhcjsr/9GKJVqTRFGPHwjhSFKna
        55PnloDY4ipNzir2fsWNj26Ekw==
X-Google-Smtp-Source: AMsMyM4MclNVF3w+DWPbeAMXaeNL8CpuTs3BBa4xeD1ApwcxODQ9hd0mKjpDXLhbz7VolHv6kJ3lzA==
X-Received: by 2002:a05:6638:12c4:b0:35a:4c21:f675 with SMTP id v4-20020a05663812c400b0035a4c21f675mr14626973jas.143.1664297551612;
        Tue, 27 Sep 2022 09:52:31 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id p185-20020a0229c2000000b0034e9ceed07csm800086jap.88.2022.09.27.09.52.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 09:52:31 -0700 (PDT)
Message-ID: <3c6002c7-cd69-e020-24b8-650aaf9ad893@kernel.dk>
Date:   Tue, 27 Sep 2022 10:52:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] block: modify blk_mq_plug() to allow only reads for
 zoned block devices
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Pankaj Raghav <p.raghav@samsung.com>, linux-block@vger.kernel.org,
        damien.lemoal@opensource.wdc.com, gost.dev@samsung.com
References: <CGME20220925185350eucas1p1fc354429027a88de7e548a3a4529b4ef@eucas1p1.samsung.com>
 <20220925185348.120964-2-p.raghav@samsung.com>
 <YzG5RgmWSsH6rX08@infradead.org>
 <d5975b62-f2e9-dcde-e332-a73cca1f7fbf@kernel.dk>
 <YzG6fZdz6XBDbrVB@infradead.org>
 <2ee6a897-87e7-0592-2482-9928a9a63ff6@kernel.dk>
 <a943acf8-f367-a1ba-0d57-2948a3ade6f4@samsung.com>
 <350366c3-1014-ac32-149f-689134631d73@kernel.dk>
 <6273f2c1-7889-1931-aec6-e567aa4d2d96@samsung.com>
 <fa80eef0-42a4-6ffc-cced-18ecbe5b1f5a@kernel.dk>
 <YzMp+SIsv6Aw4bFW@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YzMp+SIsv6Aw4bFW@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/27/22 10:51 AM, Christoph Hellwig wrote:
> On Tue, Sep 27, 2022 at 10:04:19AM -0600, Jens Axboe wrote:
>> Ah yes, good point. We used to have this notion of 'fs' request, don't
>> think we do anymore. Because it really should just be:
> 
> A fs request is a !passthrough request.

Right, that's the condition I made below too.

>> if (zoned && (op & REQ_OP_WRITE) && fs_request)
>>          return NULL;
>>
>> for that condition imho. I guess we could make it:
>>
>> if (zoned && (op & REQ_OP_WRITE) && !(op & REQ_OP_DRV_OUT))
>>          return NULL;
> 
> Well, the only opcodes we do zone locking for is REQ_OP_WRITE and
> REQ_OP_WRITE_ZEROES.  So this should be:
> 
> 	if (zoned && (op == REQ_OP_WRITE || op == REQ_OP_WRITE_ZEROES))
> 		return NULL;

I'd rather just make it explicit and use that. Pankaj, do you want
to spin a v2 with that?

-- 
Jens Axboe


