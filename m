Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAADEB64DC
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 19:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjFOTxY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Jun 2023 15:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFOTxX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2023 15:53:23 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9C5268A;
        Thu, 15 Jun 2023 12:53:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b3d0b33dc2so8515ad.0;
        Thu, 15 Jun 2023 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686858802; x=1689450802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDyg1xRS0mTW8IflRZmJ1y6m6hnypMScbqMo1USnW/Q=;
        b=nibjocXHmfrLrqxJj8sFvt7u9VyG8VMGJ6DdYQ+ljrDmj1cjDXX8GowkALr6EAq481
         Aj8z8ITIm3Lnp5PpFcw/Ga6JB0fBr7qE3JeVvU6Nf5eCb56wJ8yVfTOdUYvuT517+Mw1
         snwDi3gYAVr0qmuZMpG/Om/Lxqh/B45g+ERonreTSQsSy1+DfXyD+fs46Xvdsw6kNX71
         Z2O88VDcJwj73Pb3kGP1GTpb6X3XRrsGxft6tKeZlJLNircqItxkQE1HH56PqUochH87
         2yZfPDXD1T4Q01s89jwU/dQVQhRTX4R8suvAULcHWqPl8+mFR1pA5jNv1HeGQUs/j5Oj
         wUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686858802; x=1689450802;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDyg1xRS0mTW8IflRZmJ1y6m6hnypMScbqMo1USnW/Q=;
        b=OrDvdIEN73Yag7CyXNPSWWH4MCY8cT8f0bjm71W3/ABIyJDdJnQYOdwZBQlgJNKYjF
         xjvke2o7surU563SGlpJE+gV4feOZC8TUqQrKmol7F7++xbODJiCXEKIh+ZSZigF6IDQ
         GXJkcPIqDgtSI5S411lwZa/5bPg+BvSH9Os1tqVdi5Zgqd7QV7NnEp5raxcu5YrarHhI
         8SF1jH2mMiDWD6+GRjqx3JUy1dOmb4ToxoggBiX7o49osDTGCz0gG4LYqNjwKfqOVkil
         Ia8pLa/FabGBQtxtFG4IH4bt9JlOLEBcsfwy6JfC0in9U02nFjNY0sryj5mFvjiFadwc
         0aGw==
X-Gm-Message-State: AC+VfDyPJf/qAC6E3C5WQJC5Diwbk+8rIend7mEhmLIHMz/yizOH9PMq
        ieSTiXLsKiRSjEVPUwk4KKQ=
X-Google-Smtp-Source: ACHHUZ5f9Jwb0OQQgGbcS50bZpZR3cRIJmCRpB5LuUiuoZ2cqM1P7md3owTmrvZ3h3afb00ypLngQw==
X-Received: by 2002:a17:902:744c:b0:1b2:466b:a600 with SMTP id e12-20020a170902744c00b001b2466ba600mr55206plt.19.1686858801984;
        Thu, 15 Jun 2023 12:53:21 -0700 (PDT)
Received: from ?IPV6:2001:df0:0:200c:c59a:b7b:526a:7364? ([2001:df0:0:200c:c59a:b7b:526a:7364])
        by smtp.gmail.com with ESMTPSA id b20-20020a170902d31400b001b414fae374sm4104441plc.291.2023.06.15.12.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 12:53:21 -0700 (PDT)
Message-ID: <69ecfff9-0f18-abe7-aa97-3ec60cf53f13@gmail.com>
Date:   Fri, 16 Jun 2023 07:53:11 +1200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v10 2/3] block: change annotation of rdb_CylBlocks in
 affs_hardblocks.h
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-m68k@vger.kernel.org, martin@lichtvoll.de,
        fthain@linux-m68k.org, stable@vger.kernel.org
References: <20230615030837.8518-1-schmitzmic@gmail.com>
 <20230615030837.8518-3-schmitzmic@gmail.com> <20230615041742.GA4426@lst.de>
 <056834c7-89ca-c8cd-69be-62100f1e5591@gmail.com>
 <20230615055349.GA5544@lst.de>
 <CAMuHMdWyQnKUaNtxYjqpxXovFKNPmhQDeCXX=exrqtgOfSFUjw@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
In-Reply-To: <CAMuHMdWyQnKUaNtxYjqpxXovFKNPmhQDeCXX=exrqtgOfSFUjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Geert,

On 15/06/23 19:21, Geert Uytterhoeven wrote:
> Hi Michael,
>
> Thanks for your patch!
>
> On Thu, Jun 15, 2023 at 7:53 AM Christoph Hellwig <hch@lst.de> wrote:
>> On Thu, Jun 15, 2023 at 04:50:45PM +1200, Michael Schmitz wrote:
>>>> And as far as I can tell everything that is a __u32 here should
>>>> be an __be32 because it is a big endian on-disk format.  Why
>>>> would you change only a single field?
>>> Because that's all I needed, and wanted to avoid excess patch churn. Plus
>>> (appeal to authority here :-)) it's in keeping with what Al Viro did when
>>> the __be32 annotations were first added.
>>>
>>> I can change all __u32 to __be32 and drop the comment if that's preferred.
>> That would be great!
> I totally agree with Christoph.

Thanks - now there's two __s32 fields in that header - one checksum each 
for RDB and PB. No one has so far seen the need for a 'signed big endian 
32 bit' type, and I'd rather avoid adding one to types.h. I'll leave 
those as they are (with the tacit understanding that they are equally 
meant to be big endian).

Cheers,

     Michael

> Gr{oetje,eeting}s,
>
>                          Geert
>
