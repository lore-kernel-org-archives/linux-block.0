Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B601C433F5
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 18:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbiCaTBY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbiCaTBX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 15:01:23 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBC31BD81A
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 11:59:35 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id z7so636836iom.1
        for <linux-block@vger.kernel.org>; Thu, 31 Mar 2022 11:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=ipWbtJSeprD8JL4tVlpN/eHHk6XD/ZYq3pFkTa23DvI=;
        b=0NCpjxVB+dWiGumo7ptXb4R+kBSxYBNzlCJFoDrHXxMhxhiJ7O9oSjUf0kWfVvPXU2
         Iw7RbnCyEwoUpRdps/IqkgOI7S7zAvlB4c2Ilf0ineQzPljDMed49SveLcA6OnHXNvyG
         pZRUlwrD2qij4FhEi31qbqqHauJFPmC86FMXtUewd0TTtc4LBOl9JKTdmkJdzQmm208C
         /gFBPQ8N+Tw1eNKpzi8as9VQ7YmiuknuQnbC02CXvuezL9WprAS+yni6cZ3tgjGH9v9r
         Ppmnr2mQrBOL09VHBQRAeyt3T8s1YMviEV4xQL/PogQRtjEOQ/mZ6sWwP3C/cekUE5k9
         WyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=ipWbtJSeprD8JL4tVlpN/eHHk6XD/ZYq3pFkTa23DvI=;
        b=p1iX272IGxHX1cNf56Hz2Pvlmm/VO4w55kmFAQ1WwEJ+//OLV9GvWu1UktneVQU6DR
         LlNxsmSlJYOAH+w4WvPXccSWZt+NPeM39+QgsswcRlpgfJGAsGkHNLpu7jj4W1Zo12YP
         nz9xhWRvk7IhTWbl44ySrX4gxDnBMkFQyJTGsV4MzKFoNqSwIPe/APUHEN7ssauZQAD4
         TVU/nH0NmpXND0Z4sE3fMff7zVIMCVIhvXjsp2QVGhaNjLZJCmokacnocVczQUJQdMR/
         e6rHw1jJZAhxRJtWI1CmlUlj9p4Ibiqpx43l4sWUGSV8SMJxgcVXtdmiRh3Cyf4af72u
         5VnQ==
X-Gm-Message-State: AOAM532qaeZucMcbusayFwyYchvJBtyWWYvhoXtmABQL+8wqSGVAXY94
        8xAf06hQ/Hy8nP7otMTB63eS+0P2mJ9J9Uey
X-Google-Smtp-Source: ABdhPJxqYmk0HBczgGNml6Bhr/D+kTxlL2S5eCyqjBCIddKnbs6kQquos6zAL4FTpHQLkjpoaouaTw==
X-Received: by 2002:a6b:e20a:0:b0:648:b6aa:6615 with SMTP id z10-20020a6be20a000000b00648b6aa6615mr15018715ioc.209.1648753174927;
        Thu, 31 Mar 2022 11:59:34 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v3-20020a92ab03000000b002c9d9d896eesm118783ilh.68.2022.03.31.11.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 11:59:34 -0700 (PDT)
Message-ID: <93d0879e-4dac-01db-b29b-d53721076d45@kernel.dk>
Date:   Thu, 31 Mar 2022 12:59:33 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] blk-wbt: remove wbt_track stub
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     trix@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220331185458.3427454-1-trix@redhat.com>
 <d5bb15f0-6531-383f-8e78-0dad58828689@kernel.dk>
In-Reply-To: <d5bb15f0-6531-383f-8e78-0dad58828689@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/22 12:56 PM, Jens Axboe wrote:
> On 3/31/22 12:54 PM, trix@redhat.com wrote:
> 
> Not sure how you sent this patch, but there's no body, just an
> attachment. Regular tooling doesn't like that.

Actually b4 likes it just fine, it just wasn't on lore yet. But
for future patches, please do send with git send-email or similar.
I could not view the patch without first saving the attachment
and opening it separately.


-- 
Jens Axboe

