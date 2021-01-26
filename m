Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419EBC43332
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2AA20684
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 22:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbhAZWAZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732505AbhAZUOy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 15:14:54 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C81C06178B
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:14:14 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 11so11113951pfu.4
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 12:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qEjsyAI3zsxeeAL9SDqR30dDyfOJAEMLL6jZFQpEttk=;
        b=x0MwlPyiRd6qNIb7XiH3QSErb9wGUVymqZjBbsw50RYXJaA3VDsCyf+/x16/1hBeHK
         qrj7yO1MIIBpNCmkAO1e2i+GJ4UzW6Lq3rcX+OO36u0RF6FbY/6vrW6Or/lPrty3i4bW
         yqERrDvRI02lWpfPShD34l6OvU+2mCDC4Ftfyu1iImKeUvb5SO8HUAvVYCeZ0b9zu0b6
         GLajrhR6YmOuOuW66P99eJsb81cwVmuzScYq2uYIjLANrYCTF8+p041zaQk0dyRl5Ids
         HFZYf9qpsz4Jz+cQKyHSzrK2A9+qwVQbYNQC+Ccq0l/eHqnzXJVHnZ6JDBjJlu4/jKeN
         pkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qEjsyAI3zsxeeAL9SDqR30dDyfOJAEMLL6jZFQpEttk=;
        b=YTer3TN4FRW2slP0kBqRCOLP14mbgl3ENynYV0eD2ShLCO544m+4SAwj03EXDVNI1O
         Cg/dMP763/4fK4MB4rxG2P3KH+oL59SQvDbQCuyUXX6LXRxPg0/96rsSjaB3kiuBs8AD
         gQlM4VtRrWmpXMwMK0BBK8/czuB59uIKmoYqukIYrElGFElLqNXQz/yOiEZO3ResG6wc
         p9Yesx/es3EMFXHaxmTm5fEByfxP+2nRiSNAnJUufZMbY9cRbQo73YNxPCy916RXr8Ei
         drEUez9dzSjimlhamOI4m1h5kckuaDInqxPTgHRCJneSKmYg+YkGLJYb3V/D/93RjCdV
         tggw==
X-Gm-Message-State: AOAM5337wIg3oTJIOxcP6k9yU4LoRqbvT1NUlTsCYdQ1zdMA93UxuHIQ
        LgagCEdUeqg+iY/H2/eKWhYh5QHA8TAt2A==
X-Google-Smtp-Source: ABdhPJwSz0/YvEgDMXduskoFYxdDOP4tAGvtJGnPpH4oL4Lki9xu5f7VI9bNqaF9nCuEPkICMBfjOQ==
X-Received: by 2002:a05:6a00:16c7:b029:1b6:68a6:985a with SMTP id l7-20020a056a0016c7b02901b668a6985amr6770914pfc.44.1611692053787;
        Tue, 26 Jan 2021 12:14:13 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id x186sm19005437pfd.57.2021.01.26.12.14.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:14:13 -0800 (PST)
Subject: Re: [PATCH] block: unexport truncate_bdev_range
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210109111332.1132424-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0173995f-29e0-ba65-2c90-61ab2035c693@kernel.dk>
Date:   Tue, 26 Jan 2021 13:14:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210109111332.1132424-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/21 4:13 AM, Christoph Hellwig wrote:
> truncate_bdev_range is only used in always built-in block layer code,
> so remove the export and the !CONFIG_BLOCK stub.

Applied, thanks.

-- 
Jens Axboe

