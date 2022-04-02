Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5990C433EF
	for <linux-block@archiver.kernel.org>; Sat,  2 Apr 2022 18:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244984AbiDBScz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 Apr 2022 14:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244957AbiDBScx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Apr 2022 14:32:53 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10E71FCCC
        for <linux-block@vger.kernel.org>; Sat,  2 Apr 2022 11:31:00 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id i27so5020945ejd.9
        for <linux-block@vger.kernel.org>; Sat, 02 Apr 2022 11:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=yVkaLknBvRBwN4ktBQx+5mt3efFWTJA3G/qnhrpEL3eazb6zVkt6PTE78aD6IvCTzW
         6c1Vgwq6s0d1SQjg0ovI/y/qg9BvOiVKpmPnWG3e7mGFOrsfcIy+pgRZ5vrIa1qRkRPM
         dMa8PVVojayyClTk+1T4Y+HLzdBps7ERwlnZWtiISGwoKUalS0O5mZg9Ll1HfzZNkynR
         OvB9JaqRE8ZzEe0AC6+Rn/RtYfflcjzKmybRJDefGuKTgp677ld1JAAnUZE/iJV7HfXJ
         atH0tN/RKylR7wDSb015QfKVbFaizAzv0fxvOU6e/RRUOuuAGvGWNGLlzjULTSpK2fHe
         cc5A==
X-Gm-Message-State: AOAM5319IRimiDYW1nw/jxFZ2MPg/7G211nhuYT8ujCDeKjW6q2STGB5
        TqoL8g9x9sKXvMykyBzqzN4=
X-Google-Smtp-Source: ABdhPJw2KHq1maylWaEjPp7SzFzrO/3Fjl+D+1nRD4C7N0rehiUOu+/91MSdf9C+7CYV7gN7EKIumA==
X-Received: by 2002:a17:907:9622:b0:6e0:b38b:df18 with SMTP id gb34-20020a170907962200b006e0b38bdf18mr4590801ejc.182.1648924258955;
        Sat, 02 Apr 2022 11:30:58 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.129.dynamic.barak-online.net. [85.65.206.129])
        by smtp.gmail.com with ESMTPSA id h9-20020aa7c949000000b0041b4d8ae50csm2762005edt.34.2022.04.02.11.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 11:30:58 -0700 (PDT)
Message-ID: <b3a78dd7-acbb-43da-7e0e-0b01f658d30a@grimberg.me>
Date:   Sat, 2 Apr 2022 21:30:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH blktests] nvme tests should use nvme_trtype when setting
 up passthru target
Content-Language: en-US
To:     Alan Adamson <alan.adamson@oracle.com>, linux-block@vger.kernel.org
Cc:     linux-nvme@lists.infradead.org, osandov@fb.com
References: <20220331214526.95529-1-alan.adamson@oracle.com>
 <20220331214526.95529-2-alan.adamson@oracle.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220331214526.95529-2-alan.adamson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
