Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908C9EB64D9
	for <linux-block@archiver.kernel.org>; Tue,  4 Jul 2023 05:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjGDFqM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jul 2023 01:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjGDFqK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jul 2023 01:46:10 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DCEE49;
        Mon,  3 Jul 2023 22:46:09 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1a28de15c8aso4845929fac.2;
        Mon, 03 Jul 2023 22:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688449568; x=1691041568;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcEVFhl1iaF6kMRGfX9TgsXUMpIVaCzfcOfsi1WLm6M=;
        b=qXcrXdNtelE703zLJCt9HLMHu7p0Y8apvSfHLri3bGNVvO+XD3OGK/3rZTh3LDNPz3
         D3jqkv7SdXveLlHkVH/BEv2SMQgUxSr9Y76rbxH2at1lsTOErlviAt/ct52vK/gEMcVa
         P71iac7YdDeJAc1nRGAqm93SeU08zZuhjIW4P9BX/4n/ElUptEcWZ8qcbkQ741e7IN9I
         KY1m2871Jepbg6a5f7+JzI7Ni0g/i5CvxTCWUACTtZMieyo48Po0J6PCdAqLcytNbICV
         5Am0P1RUwWliv2q/6recOC/MnKMPbUIn5HpmaIICLmpJ36tfnWe9JJQbxAR4f6UEs1ml
         nrGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688449568; x=1691041568;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vcEVFhl1iaF6kMRGfX9TgsXUMpIVaCzfcOfsi1WLm6M=;
        b=Xwud2uiLePoip2wul8a3eHYoqfCklnX1HDv1oxMkJRezRmDlTexRnxU/+cgDpNM5nJ
         4Hinv3wEIvu1c6bcu1aYUuqZONUsIgGzRoQPAuMcwjpBubjLzJ+jFOw+bauBVRwIbUOA
         efN9RgeyG4Q+eyC47iZGnoknxNd6FBC1/5le+d0RQB6rNZE2EbY6/HnUm6SZGu/KC5oM
         58QbJN9NS0hznvMnf2d4YHUUc5PvnLbVd/9StxkYk9SOkRczG8bejHg7Ej3bxuWYVWRZ
         iuKuyBqA99WZ28j2Lx1SxDRRsheCjjKc0Q9er0bIPpEwxUVCyJQwjzt81Wl1GzdkN0/2
         oaUA==
X-Gm-Message-State: AC+VfDz6ceT/LpRd5CIc67IOKPEXK/feC8E642pnk7r8YolpMYPVKjZ5
        cJbnsAzae1n1JiN8V9nAwIbxnQKFDQ9LAA==
X-Google-Smtp-Source: APBJJlH9YRejbU5mL6Q3rW7VMOyOVFeOz4EA14+d0zmYbowj3mrlcd/63BI63y8rV8FZi6XINpEVKg==
X-Received: by 2002:a05:6870:9114:b0:1b0:89e0:114f with SMTP id o20-20020a056870911400b001b089e0114fmr13029386oae.31.1688449568320;
        Mon, 03 Jul 2023 22:46:08 -0700 (PDT)
Received: from [10.1.1.24] (222-152-184-54-fibre.sparkbb.co.nz. [222.152.184.54])
        by smtp.gmail.com with ESMTPSA id fu14-20020a17090ad18e00b00262d079720bsm6595588pjb.29.2023.07.03.22.46.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2023 22:46:07 -0700 (PDT)
Subject: Re: [PATCH v2] block: bugfix for Amiga partition overflow check patch
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-block@vger.kernel.org, axboe@kernel.dk
References: <20230703230752.13394-1-schmitzmic@gmail.com>
 <4ca9e263e6042219ee46a1f57642306c6886168a.camel@physik.fu-berlin.de>
Cc:     linux-m68k@vger.kernel.org, chzigotzky@xenosoft.de,
        geert@linux-m68k.org, hch@lst.de, martin@lichtvoll.de,
        stable@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <ceb8d743-cb3e-f813-fc1b-0025de9c7fb3@gmail.com>
Date:   Tue, 4 Jul 2023 17:46:00 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <4ca9e263e6042219ee46a1f57642306c6886168a.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Adrian,

Am 04.07.2023 um 17:08 schrieb John Paul Adrian Glaubitz:
> On Tue, 2023-07-04 at 11:07 +1200, Michael Schmitz wrote:
>> Partitons that did overflow the disk size (due to 32 bit int
>   ^^^^^^^^^ typo

Thanks, that or a dodgy keyboard, meh...

Will send v3 ...

Cheers,

	Michael

>
> Adrian
>
