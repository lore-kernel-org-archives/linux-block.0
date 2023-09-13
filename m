Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27D2EE020B
	for <linux-block@archiver.kernel.org>; Wed, 13 Sep 2023 19:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjIMTQB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Sep 2023 15:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIMTQA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Sep 2023 15:16:00 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5DB1999
        for <linux-block@vger.kernel.org>; Wed, 13 Sep 2023 12:15:56 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-760dff4b701so2489639f.0
        for <linux-block@vger.kernel.org>; Wed, 13 Sep 2023 12:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694632555; x=1695237355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x4zSkAY9ImGwNcCjHTTaJbM5GM/WyQlYdRbd+ef7TV4=;
        b=kOh/X0bJJl0z35u3H62WUDGcZSt1/lxR6W+iTG/8beZF4/8C3cJj0xelG0gNzeXKVL
         xaLrfXlF9Y1lotagvxwKMJgCeuQwStpi7JQSJ40bEVD40EwXnmFybkRCsehQxSddqrPt
         cWJjvLPaYdO59eYQtI4dkAKb4msE33q4D/YXZayeZ6vlgJ5+6oTW9rxt/S+jHpV3Glgh
         UP/NOdbD8qlL3RLy+70aozms5URY3t1HOX5tbxxdLc5tmrpOR5mq7f3a2CyLzsKAE0al
         QdCT3Yu1ZJUTknYp69ufOAvOgY7eN8/TXyX5+FoUtteD3KKM/M2Sp9avROSbKsm6X/nL
         tRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694632555; x=1695237355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x4zSkAY9ImGwNcCjHTTaJbM5GM/WyQlYdRbd+ef7TV4=;
        b=Ppj+gOENTFXZc2V05q84NckxEfVzfYbpXXz64ErFjOe0vD+4nlFrCNot4yMA1jO1Cl
         aCaY76vVacDrB/aGbD0I8ZemppMwYjSd9RTNy2SmfcBuWm8FNUkdm7fKFZroXDOjCygV
         cPzaq0L9MypFYMESuK6V/EnbXzxsYB0rEL5SUQ5bz8RfWM+g7unu9SvPDajzpWgl1X4f
         Z95rxaFIqaPUjgd/d30XzIO+esJH7e1E8o+LhUSStwlmTSinB844+ePmIg/IStQsmOHS
         zjqBkoIOrnb7u0O9qTbXdzUkQhjs664MRHehGboSk3dAV2v4/pntn6T+GSyvhIgGsMbi
         Fuog==
X-Gm-Message-State: AOJu0YzJ1kcCnUOnA0HsUNqaShGEmBKUABamupiXu5UzMyhnl04ynZxI
        j0DJWhpI+EQKtTwVcKU9gwLpmQ==
X-Google-Smtp-Source: AGHT+IHyPlzHEiXrLYtOyG3dd+H5yVcu5Qbi6bs9p/FW1+eqTxe7UgbDnBr+u2tVkyeRzeqLOmvZQw==
X-Received: by 2002:a05:6e02:20c7:b0:34f:9fbc:8c7c with SMTP id 7-20020a056e0220c700b0034f9fbc8c7cmr2722113ilq.3.1694632555483;
        Wed, 13 Sep 2023 12:15:55 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o9-20020a92d389000000b0034f13bcaf9asm3815116ilo.22.2023.09.13.12.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 12:15:54 -0700 (PDT)
Message-ID: <def46b96-b881-4806-bd0c-ca0b0462e72e@kernel.dk>
Date:   Wed, 13 Sep 2023 13:15:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3 RESEND] powerpc/pseries: PLPKS SED Opal keystore
 support
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>, gjoyce@linux.vnet.ibm.com
Cc:     linux-block@vger.kernel.org, jarkko@kernel.org,
        nayna@linux.ibm.com, keyrings@vger.kernel.org,
        jonathan.derrick@linux.dev, brking@linux.vnet.ibm.com,
        akpm@linux-foundation.org, msuchanek@suse.de,
        linuxppc-dev@lists.ozlabs.org
References: <20230908153056.3503975-1-gjoyce@linux.vnet.ibm.com>
 <20230908153056.3503975-4-gjoyce@linux.vnet.ibm.com>
 <20230913185951.GA3643621@dev-arch.thelio-3990X>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230913185951.GA3643621@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/13/23 12:59 PM, Nathan Chancellor wrote:
> Hi Greg,
> 
> On Fri, Sep 08, 2023 at 10:30:56AM -0500, gjoyce@linux.vnet.ibm.com wrote:
>> From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
>>
>> Define operations for SED Opal to read/write keys
>> from POWER LPAR Platform KeyStore(PLPKS). This allows
>> non-volatile storage of SED Opal keys.
>>
>> Signed-off-by: Greg Joyce <gjoyce@linux.vnet.ibm.com>
>> Reviewed-by: Jonathan Derrick <jonathan.derrick@linux.dev>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
> After this change in -next as commit 9f2c7411ada9 ("powerpc/pseries:
> PLPKS SED Opal keystore support"), I see the following crash when
> booting some distribution configurations, such as OpenSUSE's [1] (the
> rootfs is available at [2] if necessary):

I'll drop the series for now - I didn't push out the main branch just
yet as I don't publish the block next tree until at least at -rc2 time,
so it's just in a private branch for now.

-- 
Jens Axboe


