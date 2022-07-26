Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F946C433EF
	for <linux-block@archiver.kernel.org>; Tue, 26 Jul 2022 03:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiGZD6r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jul 2022 23:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiGZD6r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jul 2022 23:58:47 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72467FD12;
        Mon, 25 Jul 2022 20:58:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o20-20020a17090aac1400b001f2da729979so2537073pjq.0;
        Mon, 25 Jul 2022 20:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=1HXAxcsQDaKzPYbXHjeo23Nx3+uF4ILpuxYJOUyBV+c=;
        b=mJ6XQskAN/ytTCTp9Om7ol8kp+yyo6jn1CMz0b+qF5y6hFlFHpdFxJrw4MkXtbilvJ
         vCM2i7vWNiM1msNztKlzHX+sIiVQY4weW+AQbpPmx60YiK/voihf87AKoQSrQy/w1vcT
         R1+t3Jrn4e1fcTCAZRq3ng7xVh9yuf46+fqlO+G3YbJlGdUjGZDtF9Ffy+KfvTErGmno
         Mf/J79pjatLr6QN5AZ4E2grw8uwl3Frt/KUjUtgahdAHbvcfQ/68pJgTTiVXflFUlfgW
         I7vBxgdD+nt7nsnopPn6C0VPLLtryhNn/YEpzG4cQyBcQoy62ek4TXQzxB3rGXqmdVRq
         qhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1HXAxcsQDaKzPYbXHjeo23Nx3+uF4ILpuxYJOUyBV+c=;
        b=cP+JhrZMGV5XDAkmwFPh9BpjekO/f6KBUpGuTK392hRilQG7p9dmMPqkT2zUnuTen8
         xivfSQdFMRyEwm4GW3H6YwCK4xpmUSnonOn9ZQOQb+8k8bb+S3I4yqZ7hsKzVejgrpRL
         hqk5G0u68krVdxqfrFU8UpiRGbNWH4w6zIABoAOo4XmRNyPvHQsgnP+Cj0cQmTXzZKPw
         l/3kPBDjqAAToH8/mr18XaU13N/6P3niO51YWlPvhr05vA+aPFGUrN6sObvha5ibDyQG
         XSj3E643RkLFiQI1eIzJC0Jt0ybTXScgFKjYpGT64fa3OwzYoVeVBKel0jW+OvKVyR9C
         AqOA==
X-Gm-Message-State: AJIora/L5Bk8lAYL1QJUBj2vNUE0Kzz+qAP5V1djZ+cemnMHEn7J1eVx
        pq+Hf96S7YsOjm+9wDlbzxlD0NhsZgw=
X-Google-Smtp-Source: AGRyM1tZaQf/khRoTm2qfT30SAaoCz74Jzmwm6+GtQi0n9i9kDiG9COqGG+yBqYyFKOR++by3YQI7w==
X-Received: by 2002:a17:90b:3841:b0:1ef:f0ac:de55 with SMTP id nl1-20020a17090b384100b001eff0acde55mr36061649pjb.35.1658807925986;
        Mon, 25 Jul 2022 20:58:45 -0700 (PDT)
Received: from [10.1.1.24] (222-155-0-244-adsl.sparkbb.co.nz. [222.155.0.244])
        by smtp.gmail.com with ESMTPSA id y4-20020a623204000000b0052bc48b6010sm8445849pfy.188.2022.07.25.20.58.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 20:58:45 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
To:     Jens Axboe <axboe@kernel.dk>,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-block@vger.kernel.org
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <1539570747-19906-3-git-send-email-schmitzmic@gmail.com>
 <2265295.ElGaqSPkdT@ananda> <5e45c2a8-b35e-9a15-18e6-2e3a7ad00f5f@kernel.dk>
 <e0b99db6-ab3e-1c6d-d431-99cee32c1ced@gmail.com>
 <71d9f2fe-42d1-2a09-a860-702b42a3a733@kernel.dk>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <0bf2e4f9-a1c1-3847-a2b5-d9b9eaaa783a@gmail.com>
Date:   Tue, 26 Jul 2022 15:58:40 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <71d9f2fe-42d1-2a09-a860-702b42a3a733@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Am 26.07.2022 um 15:40 schrieb Jens Axboe:
> On 7/25/22 7:53 PM, Michael Schmitz wrote:
>> Hi Jens,
>>
>> there's been quite a bit of review on this patch series back in the
>> day (most of that would have been on linux-m68k IIRC; see Geert's
>> Reviewed-By tag), and I addressed the issues raised but as you say, it
>> did never get merged.
>>
>> I've found a copy of the linux-block repo that has these patches, will
>> see if I can get them updated to apply to current linux-block.
>
> Thanks, please do resend them and we can get them applied.

Will do - running final compile tests.

Cheers,

	Michael


