Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC61EEB562
	for <linux-block@archiver.kernel.org>; Fri,  8 Sep 2023 18:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbjIHSjq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Sep 2023 14:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjIHSjp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Sep 2023 14:39:45 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA69110CA
        for <linux-block@vger.kernel.org>; Fri,  8 Sep 2023 11:39:08 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-56f8334f15eso206188a12.1
        for <linux-block@vger.kernel.org>; Fri, 08 Sep 2023 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694198290; x=1694803090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oNgNOfTdYwbjd4PNLanFnphvBlBTZnc77El/quqL3m8=;
        b=G2FuMS2AHt6RgUEAL7kI0x/Ze5/n/IodDpejYICJowGKlkG+Tksb5UMcrRysl9XK2W
         CuX0QN9fPfERVJVqXobkT0VGIEd5H1oH7EOrsLga3p0dsQhw12s5s6EjOLqx+0Mv+eCj
         7q97Fh7MR5CXf6ZpDJlxWbe3UKj7UDRvenNW98ItSB/3/PVEQM2Pst9jOu7gsord0lYZ
         yBMP65i5HkTAkkiogw0yR/YaqTX62Zy/XpVLeUoG9gUBsiYQeciXUw3zMmNbO4lP7sMV
         Ma76nZxyxHgcQLH/dnG6B1CAt/hKqJp47Glvtcb+jfBg8UxAAN98euN1H4C9icw6RhMC
         fRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694198290; x=1694803090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNgNOfTdYwbjd4PNLanFnphvBlBTZnc77El/quqL3m8=;
        b=UhgIydSrREquFLsMfOet+fGocvtNYj4st5h4NjKJTpd3tZBDdcUitCU/GmXyYo8oHm
         IP45LSczokFv4S2Go5a8MdbwJa5egb0Pzn1Ly00AhFIivK/tPaQQBVZ+5U0/+TWM3h3h
         uVTF5LNEXhCWCXnPi9gfLSvMpkLrk/D/t1RHVTe+aQg4OsSqpB6REgneU13LenhnUHCE
         gxpcGY7Fp+SEY7NgZug4EVOjMuBx7UYm8vnvU354XTYs95guqOvsfc52jqa5EUI4OPs/
         2Ic07xHecI1PGJShNyzHy1NRoIuJFzbLXCCcQbIRkZynUhv96Hs9JePlUZXWMMQ/E4Eq
         Laqw==
X-Gm-Message-State: AOJu0Yw61SU7nGeoRZ+CueJrBr0LLJn/bWPDF0rZvc1zshvhQMfbOc+1
        y7YO1BR68Q6GKyV+zC5ydiQ1TQ==
X-Google-Smtp-Source: AGHT+IHTX9ZZx08YvuQBTs1uYS/lar+KHBch4uy/fbt1CHDwQT9BuSsbxjk6CIFexr8qdwmGJFQFzw==
X-Received: by 2002:a05:6a21:194:b0:13f:65ca:52a2 with SMTP id le20-20020a056a21019400b0013f65ca52a2mr3924171pzb.5.1694198290545;
        Fri, 08 Sep 2023 11:38:10 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e12-20020a62aa0c000000b00687a4b66697sm1669127pff.16.2023.09.08.11.38.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 11:38:09 -0700 (PDT)
Message-ID: <e1910f8e-5bcd-4c1c-a751-e4a530282b6b@kernel.dk>
Date:   Fri, 8 Sep 2023 12:38:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3 RESEND] generic and PowerPC SED Opal keystore
Content-Language: en-US
To:     gjoyce@linux.vnet.ibm.com, linux-block@vger.kernel.org,
        jarkko@kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, jonathan.derrick@linux.dev,
        brking@linux.vnet.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au,
        nayna@linux.ibm.com, akpm@linux-foundation.org,
        keyrings@vger.kernel.org
References: <20230908153056.3503975-1-gjoyce@linux.vnet.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230908153056.3503975-1-gjoyce@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/8/23 9:30 AM, gjoyce@linux.vnet.ibm.com wrote:
> From: Greg Joyce <gjoyce@linux.vnet.ibm.com>
> 
> This patchset extends the capabilites incorporated into for-6.6/block
> (https://git.kernel.dk/cgit/linux/commit/?h=for-6.6/block&id=3bfeb61256643281ac4be5b8a57e9d9da3db4335) by allowing the SED Opal key to be seeded into
> the keyring from a secure permanent keystore.
> 
> It has gone through numerous rounds of review and all comments/suggetions
> have been addressed. The reviews have covered all relevant areas including
> reviews by block and keyring developers as well as the SED Opal
> maintainer. The last patchset submission has not solicited any responses
> in the six weeks since it was last distributed. The changes are
> generally useful and ready for inclusion.

Best time to resend is generally once the merge window is closed again,
as I won't start applying patches for the next release before that
happens. I'll try to remember to pick this one up for 6.7.

-- 
Jens Axboe

