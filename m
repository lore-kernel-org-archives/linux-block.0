Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3389CC6FD18
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 07:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjDSHeR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 03:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjDSHeD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 03:34:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF7861BE
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 00:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681889596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qFk0SDi3a5cx1k87dtvoTAIyvSTI1GDLMwxUDSm0tzU=;
        b=dB7f7hbvdZAsEb/EgLNmXg7p9D92KIydp/t2WNlID+8HlzEhTPzJOjLB15XmtFBPyXtjLG
        eNT1mxmBvh6X52ixR8v7/dI2fhqDoruELq5hWbMEvu42y0Cmw6GnXFl8G7VbnmF1EAjYIW
        DWxl8V6imq1OLNrKNmUUHkhu2mBCLkc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-U82PXjPFPf-w6uPV_k6IMA-1; Wed, 19 Apr 2023 03:33:15 -0400
X-MC-Unique: U82PXjPFPf-w6uPV_k6IMA-1
Received: by mail-wr1-f70.google.com with SMTP id q9-20020adfab09000000b002f513905032so2983330wrc.2
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 00:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681889594; x=1684481594;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFk0SDi3a5cx1k87dtvoTAIyvSTI1GDLMwxUDSm0tzU=;
        b=KcmjTLdSTbsBhZ3G0BpgsJmd2dEflHcKY0tDDujHocSHbrdHPNYdsrmtJ91R8XrLNf
         9YcikUT+11EHqlee5v+LVm4dJCiIW4EpULlH0zmoohjoX4nkoyr64ZW3wU/27vtzBJNZ
         BJNu8QmjhoI9MhlxdqwbM8B/JdTKc2CD4nq/dzfhVNSnsp6DiQMD3la0ZkuQNefMQwI1
         qc32eQOWRxLZ5A1+jrPKqSOO0N4E/JVY9o06SM8sWXO6SIuMS+4+zSguEbnos0xGLjTT
         wQh1RIdyOCxEEo8GmD5rUwoaIHxXDC1JQ1ZMq6C8pBpPljQyYZYECcqdUD/+of547MtO
         cwiA==
X-Gm-Message-State: AAQBX9dp7+zw+GGjtRAFNegxL/Uxls98ZyYYD/TVDLzGc1pn+D8lzmOo
        je45yMiXJE3/cRaTXLZELkbOPsq7mrsdGu1BR7Joc438Zqxa6XityAycwQF2n7Vki05uNppXscw
        VFdQBpJINZyNx3hPOY/p8BA==
X-Received: by 2002:a05:600c:22d9:b0:3f1:72ee:97b7 with SMTP id 25-20020a05600c22d900b003f172ee97b7mr8545922wmg.15.1681889594275;
        Wed, 19 Apr 2023 00:33:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350YBAVtRpOTsSTqGfNCvK/e0agfpLarrgNXcpFi//za/NhDLDVp4b73+IECdM9SXUlK0O4AKzw==
X-Received: by 2002:a05:600c:22d9:b0:3f1:72ee:97b7 with SMTP id 25-20020a05600c22d900b003f172ee97b7mr8545904wmg.15.1681889594031;
        Wed, 19 Apr 2023 00:33:14 -0700 (PDT)
Received: from [192.168.50.108] ([83.240.60.42])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c211300b003f17316ab46sm1259908wml.13.2023.04.19.00.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 00:33:13 -0700 (PDT)
Message-ID: <c3443f2a-e74c-4dd0-178b-4e46e3114744@redhat.com>
Date:   Wed, 19 Apr 2023 09:33:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     axboe@kernel.dk
Cc:     bluca@debian.org, gmazyland@gmail.com, hch@infradead.org,
        brauner@kernel.org, jonathan.derrick@linux.dev,
        linux-block@vger.kernel.org
References: <20230406131934.340155-1-okozina@redhat.com>
 <20230411090931.9193-1-okozina@redhat.com>
From:   Ondrej Kozina <okozina@redhat.com>
Subject: Re: [PATCH v2 0/1] sed-opal: geometry feature reporting command
In-Reply-To: <20230411090931.9193-1-okozina@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11. 04. 23 11:09, Ondrej Kozina wrote:
>    sed-opal: geometry feature reporting command
> 

Hi Jens,

could we get this in 6.4? It's the last kernel bit we'd like to have to 
move further with userspace code discussed here:
https://gitlab.com/cryptsetup/cryptsetup/-/merge_requests/461

Kind regards
Ondrej

