Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D9CC6FD18
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 09:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbjDSJfY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 05:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbjDSJfX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 05:35:23 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA4113846;
        Wed, 19 Apr 2023 02:35:12 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-2f4d0fc8df4so853382f8f.0;
        Wed, 19 Apr 2023 02:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681896910; x=1684488910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sWY1I1ouoHv+2nnWuzegkDW1CdXzXe2ZWoPGTCpomo=;
        b=VPB06pad+ipYRd1BBTBcHytzm4WTXOJygQVAbbeu0IeMmR/GQEJbl2rPcI6GF5oJK7
         U2mdaEIOZimtyyJP2j4O5CYoXXXiA0WqKZcrbIUKvKKxp7jKdjx/FzpZEJPZvT2bqxOJ
         XJiq0XhoSpNnIAVVxJ1qYe6uSnC4acw/y+TihbP6bLdHTqQTCj8ZKELs9qdoRafZxMVP
         Wn9mzUaGq2bfaVHmm4B47cnJu9/wsnljql1dyHw2vAfPK0gGAg2/Onh4uCYL1MsBf1D2
         wl8omScuTHy+4O/ueW+BOYDBMe9IlpZ+KonNTlPV1V80PTg8ObxeTx4Yvy1PrFKa8EBl
         AgoQ==
X-Gm-Message-State: AAQBX9dZ6NyjBeEmA3zfh5vqsAxns+SGgM8U4zrMCgwI0ukpn9lMvjsJ
        ScHrgQo6h1nA6RZCg0lYfjA=
X-Google-Smtp-Source: AKy350ZwhuxxJWTKUjlgixT4N2ciSdmd6sKtnqLbDals7lQi48bSv7DKA2JD7JxtmJFBt1aMbuu8Hw==
X-Received: by 2002:a05:6000:112:b0:2f9:ee11:e5c3 with SMTP id o18-20020a056000011200b002f9ee11e5c3mr6340073wrx.2.1681896910530;
        Wed, 19 Apr 2023 02:35:10 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4743000000b002f9e04459desm8458477wrs.109.2023.04.19.02.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 02:35:10 -0700 (PDT)
Message-ID: <088e9b60-3092-2642-b3c3-2248e2e51cd6@grimberg.me>
Date:   Wed, 19 Apr 2023 12:35:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/4] nvmet-fcloop: unblock module removal
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230418130159.11075-1-dwagner@suse.de>
 <nlogr5rdxqvilsz4iolktfpdvflvvithwaoa3vrx2fsjqlho4q@4upw7jq3aem2>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <nlogr5rdxqvilsz4iolktfpdvflvvithwaoa3vrx2fsjqlho4q@4upw7jq3aem2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> nvme/041 (Create authenticated connections)                  [failed]
>> nvme/042 (Test dhchap key types for authenticated connections) [failed]
>> nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
>> nvme/044 (Test bi-directional authentication)                [failed]
>> nvme/045 (Test re-authentication)                            [passed]
> 
> I suppose these should be disabled for fc as all this is tcp specific.

Umm, no their not...
