Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF3EEB64DD
	for <linux-block@archiver.kernel.org>; Sun,  2 Jul 2023 20:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjGBUWi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jul 2023 16:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjGBUWg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Jul 2023 16:22:36 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C12E6;
        Sun,  2 Jul 2023 13:22:36 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55b66ca1c80so1085576a12.0;
        Sun, 02 Jul 2023 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688329355; x=1690921355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVW3hQLj/POWgzvz/VnRYxpv8vGztkCJZVGofNoDyaU=;
        b=R/8ojeTFMTUDNIIkQL8WWMCx5+fy4Vg8bGJwp66+hmR2GyEVPP2T+sLfQUWVth330T
         +4KEFKBKyv8UkEj1bAQj8/VVUNrEKIbSQC7Vy281wjbn5yBgAHwHi7K26xxZDGL3dL9+
         gVGrZWw0WDKGtH57uTkxji03U2E6s88NxeGKckBOoK2rXge/L+CQWA7Vh45iJ9/M9INw
         CO4+df2YcRd9p01JStPGjiKAlEowvzMP5icpt7VsCgszZtIM3RnIB/HYbE2a5UKw4Mk6
         PmR0GkWFHvVZwyqeC6cYxBPr3dVir7A+NfWF3UAlpE6BQPxstaf81Pr+3uUxU1kYY8gz
         hdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688329355; x=1690921355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVW3hQLj/POWgzvz/VnRYxpv8vGztkCJZVGofNoDyaU=;
        b=lNQ3Tl/vUrxYGqz8xgeIzB+ecpNPmqFVR+GBOx1uUnGt5STCXE/Jt5bFU5Ik6DLrt7
         pzQyqmRU1d1NmVVpQ8MvsbeHxivUyUzPoRp5S88KGPqRb/MXmEV0eh651VMwIOf5cY93
         qMU4x3kcIezia07sA+Vcbw5xtow0DZKuXnCnauAm63RzLQ2eUOGiNtfo2n8BCnCRWh/e
         fRcGnDwsJm2+U8R053nZhnmRFgh1EKrv3+OAQSatHcaarU3C80Rn8etODgTKIG/RMf0g
         8MnUa7dfSWg6qRBB32n15uwUGpxMaqkmA/ogQOAScyGrZTI0l049DIK1/d2jpjA9aKCT
         7gyg==
X-Gm-Message-State: AC+VfDxsm97rR+JlOvuY7Ueo2aiJYev/GvKoXEqVWf+x+Fg2sLUA/mNx
        D2CpT498b9zCgxwdSnvuJC8=
X-Google-Smtp-Source: ACHHUZ4df6DcFEeK2Ox2v1FHFgB1vPfE34H10Q6EBm4neB+9MHJKW3MteeqbVxWMHHurMbnvA557uA==
X-Received: by 2002:a05:6a20:938f:b0:124:eea9:668e with SMTP id x15-20020a056a20938f00b00124eea9668emr9604444pzh.41.1688329355280;
        Sun, 02 Jul 2023 13:22:35 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:513b:8e7d:73e7:1424? ([2001:df0:0:200c:513b:8e7d:73e7:1424])
        by smtp.gmail.com with ESMTPSA id b26-20020aa7811a000000b00666b3706be6sm12884104pfi.107.2023.07.02.13.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 13:22:34 -0700 (PDT)
Message-ID: <234f57e7-a35f-4406-35ad-a5b9b49e9a5e@gmail.com>
Date:   Mon, 3 Jul 2023 08:22:27 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
To:     Martin Steigerwald <martin@lichtvoll.de>,
        linux-block@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>
Cc:     axboe@kernel.dk, linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        hch@lst.de, stable@vger.kernel.org,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christian Zigotzky <info@xenosoft.de>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
 <afe14b08-7bab-d81b-fce6-e6408741760a@gmail.com>
 <afc575b6-5f2d-f5cb-31d1-0830d0e369cf@xenosoft.de>
 <1885875.tdWV9SEqCh@lichtvoll.de>
Content-Language: en-US
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <1885875.tdWV9SEqCh@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martin

On 2/07/23 19:55, Martin Steigerwald wrote:
> Christian Zigotzky - 02.07.23, 06:37:50 CEST:
>> On 02 July 2023 at 04:17 am, Michael Schmitz wrote:
>>>   I'm sorry to say I cannot see a new RDB partition bug her, just the
>>> result of undefined behaviour due to overflowing a 32 bit nr_sect
>>> size calculation in the old RDB code.
> […]
>> Thanks a lot for your explanation!
>>
>> Actually, we need your patch because there is a very old bug but there
>> are some endusers with RDB disks with Linux partitions. If I apply
>> your patch to our kernels, then I need an enduser friendly solution
>> for fixing the issue with their file systems.
> I have read through the last mails without commenting. I admit: I do not
> yet get what is wrong here? A checksum was miscalculated? Is this a
> regular thing to happen when using RDB disks with Linux partitions?
I sent instructions to Christian on how to fix his partition table so 
the size mismatch between partition and filesystem (caused by the old 
RDB code) can be avoided, and misreading the checksum calculation code I 
forgot to update the checksum. That's all.

Cheers,

     Michael


