Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9C4C76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 09:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjDKJIP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 05:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDKJHy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 05:07:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFA84ECA
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 02:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681203949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AS36IWSFVbiOBrCnV47eJqwBIOUe7kqgEAV+sdpsB7E=;
        b=cZJWk78jf6enDtkR4jEjT/0oVOSZUEIXsMMfUXFWt870QtbUbmtzW1QFzJ7N6nAHbyayzW
        MDW/Oc95vIAtjAE4D5zqRBHqDLLrpqEhFKw2mJv7vMYMVDRf2NO4Sue52GrpdNhHx+i+/Y
        zN13LrS16jwZ7iLE+yP56Kc3YSnIeVs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-kVE6w_OkM1Kd_YNAe2SItQ-1; Tue, 11 Apr 2023 05:05:48 -0400
X-MC-Unique: kVE6w_OkM1Kd_YNAe2SItQ-1
Received: by mail-wm1-f72.google.com with SMTP id u14-20020a05600c19ce00b003f0331154b1so13699826wmq.3
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 02:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681203947;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AS36IWSFVbiOBrCnV47eJqwBIOUe7kqgEAV+sdpsB7E=;
        b=5hzXFf9ng3/M07PPeKo5uvHJEUu/QtkDxM9F8bfEdUYIXp2gXo++q0QRaxrt9rFDOl
         23KHAYVZ63C2dPvrkMXtllS3oPOXssrh6gYVcLj6lzEttZ7Zr1fTf/huBnprIlLoTyTH
         Jy5DhRbICjFYSKujPP7EBDvNu2JlDFjHFKXfrUGKgweQ6d78TIpI9ycmSOgfJuhkdABg
         horzSaQGFfke299ULGVkK9GphO1LLoLvp4OokS6FyG1I5dft+RpI66OjeXUSo0mv2bQN
         EZVrrqSsDPweEceqVUwpi/01fu+7f8Ru+hcAu5MYJnrmRfghFmA/2PseHooJZOpC3o+g
         7OZA==
X-Gm-Message-State: AAQBX9c3A0+sbZ+7NIOxr1COl6nq78nbbPxIdpSemWfARiJlVe/U8Ino
        N+4lO9AtSBoUlepX1Q2s92oB4I9ITHbjKTwcblMOYMqr4tx7LdcUnsmYaghPuYH0HGBP+vgsueg
        8ta+Chfao8j1j93c9WWs1CL7zjjX/jA==
X-Received: by 2002:a1c:7211:0:b0:3dc:55d9:ec8 with SMTP id n17-20020a1c7211000000b003dc55d90ec8mr8671005wmc.41.1681203946985;
        Tue, 11 Apr 2023 02:05:46 -0700 (PDT)
X-Google-Smtp-Source: AKy350bWeHHqcNBPTYnBvdYVgV3k6Wx+xVE4fvTcccIhh6GocA+QQxWLHhRhZItTXZDLnCudLmjuew==
X-Received: by 2002:a1c:7211:0:b0:3dc:55d9:ec8 with SMTP id n17-20020a1c7211000000b003dc55d90ec8mr8670986wmc.41.1681203946654;
        Tue, 11 Apr 2023 02:05:46 -0700 (PDT)
Received: from [192.168.50.108] ([83.240.60.42])
        by smtp.gmail.com with ESMTPSA id q5-20020a7bce85000000b003ede3e54ed7sm16323001wmj.6.2023.04.11.02.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 02:05:46 -0700 (PDT)
Message-ID: <afd88a2d-7705-88cc-4079-c4413318d9f0@redhat.com>
Date:   Tue, 11 Apr 2023 11:05:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org
Cc:     bluca@debian.org, axboe@kernel.dk, hch@infradead.org,
        brauner@kernel.org, jonathan.derrick@linux.dev
References: <20230406131934.340155-1-okozina@redhat.com>
 <20230406131934.340155-2-okozina@redhat.com>
 <c19a93cc-2a37-4ca8-37f4-e5eee830fa4f@gmail.com>
Content-Language: en-US
From:   Ondrej Kozina <okozina@redhat.com>
Subject: Re: [PATCH 1/1] sed-opal: geometry feature reporting command
In-Reply-To: <c19a93cc-2a37-4ca8-37f4-e5eee830fa4f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 06. 04. 23 22:32, Milan Broz wrote:
> 
> On 4/6/23 15:19, Ondrej Kozina wrote:
>> Locking range start and locking range length
>> attributes may be require to satisfy restrictions
>> exposed by OPAL2 geometry feature reporting.
> 
> ...

>> +	dev->align_required = (geo->reserved01 & 0b10000000) ? 1 : 0;
> 
> I am not sure if we can use 0b prefix as it is compiler extension (not in C standard, IIRC).
> 
> Anyway, align_required returns always 0 for my test drives even when discovery shows ALIGN = 1.
> Does it mask the correct bit?

Yikes, sending a fix right now and my apologies for the rushed patch.

O.

> 
> Other geometry attributes work correctly.
> 
> Milan
> 
> 

