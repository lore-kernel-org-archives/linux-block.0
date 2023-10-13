Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAABCDB482
	for <linux-block@archiver.kernel.org>; Fri, 13 Oct 2023 09:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjJMJms (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Oct 2023 05:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjJMJmo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2023 05:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972FB19A7
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2023 02:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697190002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=gGPffOfrtLjrOjGu+lE3q0B9Z/u0aRw7F05czp7mOVo=;
        b=h6txJOO8paUBQQnPUAmDMXhhRkx7xOkLPhj16sJli5E0hivjxvpc+eDOsi9QJTMDxLdOt6
        ynFNlAcYisxcWnv+LxgCWjWryYNbZG+jGnxU71FMmdnoHe925l8ZxjkIVX5MEojz+d3Mr4
        +RAtEi9vA5CqC9WVjrgcrZguUTjz2VE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-eTBNRSFhMTWUek9f1ezHoA-1; Fri, 13 Oct 2023 05:40:01 -0400
X-MC-Unique: eTBNRSFhMTWUek9f1ezHoA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b95fa56bd5so139221166b.0
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2023 02:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697189999; x=1697794799;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGPffOfrtLjrOjGu+lE3q0B9Z/u0aRw7F05czp7mOVo=;
        b=OY9j27N/Pga5CWSb6xOHBbHsfKvwwuf/WVIcoDI8Km9XRzjsLjYIM2Iy5pHEVYreDE
         t/6v7bHeYQJYtQ4sXHAba+YaBVcs6F8MuTiuZ9dyDr2EE8VLIVMHcDNu+J3Tzm3UaGSH
         +Y+KJ7xCsYzfN7yoc7gFtltcLn/aUgAvMYz1KdKLD8pozHLsiT1moUhG8CS8cCv7R8Dr
         HkT066NYdYuEdUJHb2KQGScUNSK3P/oTyl2wp/MsGEO14dopukDdYwn+AGI2YgL4sBKB
         UX5rkR9nHjKfQRxO9q6YcHSXper0xtL+PyGEgURGUbxHBxI2TDEktWsz/9IoLxcmLEoe
         6bdw==
X-Gm-Message-State: AOJu0Yy7hSuq8k/VxJL5Dd24pFzMmReLS6zAcuWzBSb63DNC4mRmx9rI
        UYBSI6pvm26yr6ADYW3I7XRd/Zuwuh3kE1M8Qs0e/GdQuPrK4m+31p9pnZtyXxCFCyjdc+7Cpdw
        PncRcI2T6PwOjjlCHAJ4pQCOWO1bCzEdkvheYLW1r7QRjCgJoYNtWgqaQvMyURWM29CXB743SB0
        7jFCyo
X-Received: by 2002:a17:906:32c8:b0:9a1:abae:8d30 with SMTP id k8-20020a17090632c800b009a1abae8d30mr21119563ejk.47.1697189999531;
        Fri, 13 Oct 2023 02:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmRy1xQBg8hBEtRn5o2LT3RasKjfqYz/5fb73/5kqg1uAEoWgyjj1H/E8wygqcWDsXOgyhdQ==
X-Received: by 2002:a17:906:32c8:b0:9a1:abae:8d30 with SMTP id k8-20020a17090632c800b009a1abae8d30mr21119549ejk.47.1697189999145;
        Fri, 13 Oct 2023 02:39:59 -0700 (PDT)
Received: from [10.43.17.25] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t3-20020a1709064f0300b009b928eb8dd3sm12069381eju.163.2023.10.13.02.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 02:39:58 -0700 (PDT)
Message-ID: <478b9ba6-4ec9-4c37-be83-bed3c4ea672d@redhat.com>
Date:   Fri, 13 Oct 2023 11:39:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix regression in sed-opal for a saved key.
Content-Language: en-US
To:     linux-block@vger.kernel.org
Cc:     gjoyce@linux.vnet.ibm.com, jonathan.derrick@linux.dev,
        axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Milan Broz <gmazyland@gmail.com>
References: <20231003100209.380037-1-gmazyland@gmail.com>
From:   Ondrej Kozina <okozina@redhat.com>
Autocrypt: addr=okozina@redhat.com; keydata=
 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
In-Reply-To: <20231003100209.380037-1-gmazyland@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

On 03/10/2023 12:02, Milan Broz wrote:
> Fixes: 3bfeb6125664 ("block: sed-opal: keyring support for SED keys")

could we please get this in 6.6 in time for final release? This 
regression blocks cryptsetup from correctly locking sed-opal locaking 
range when device needs to be deactivated.

Is there anything that needs to be done for it to get it in 6.6?

Thank you
O.

