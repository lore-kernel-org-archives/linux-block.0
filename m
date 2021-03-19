Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A955C433E6
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 10:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE76A64DFB
	for <linux-block@archiver.kernel.org>; Fri, 19 Mar 2021 10:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhCSKDi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Mar 2021 06:03:38 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:37561 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhCSKDG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Mar 2021 06:03:06 -0400
Received: by mail-ej1-f47.google.com with SMTP id w3so8709191ejc.4;
        Fri, 19 Mar 2021 03:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tf1bp42piR/kgUjUmb5eb/xY/TcOtjsqhzIfj9tnWTc=;
        b=Fg+wiogf8F9ZkULQm4zPBt+n2RybYGPqKEsnuiHnXD4NPMiWjwsWiYLQuhe1udjRyu
         HEFp5t6sQET2Aykcg8B7Oi1aApQjCah50MVF/IsLrdYwzadoX+ejPfMdA3p3bNYf38WP
         +MgLjAWNA3wKx8MX7MEGZ9T1EnsaDi0U6NgqIqi1qmbs37BZR4Ge4KtAOkHhknrljasH
         aA3f59iDXViLcMXBcZOoGXq5Z58XVx5nY2gEjWqVtnhH9slXCtP4MpdK20LEqGiVOXfD
         yfmN8SM1f11dh2Tu+99VvAAA1bHE+A6HCL3DwllEnu//kz59OKXEWI+OEmRAmJZeXzjb
         t9DA==
X-Gm-Message-State: AOAM530ReIei6T5iN4fC18wEDRjEUeGGXED+MnVFBrh+kwLR+AmcXc71
        1W7/rX1OG2GD8/DagWk01igz4liMwXU=
X-Google-Smtp-Source: ABdhPJwkLluKt/Z5PWzK3oJAPrsRuwafX8TnbWne6McKFz3d3Je782fjlCE6GIgfyRCJvSl/CWnJmA==
X-Received: by 2002:a17:906:35cf:: with SMTP id p15mr3349669ejb.379.1616148184358;
        Fri, 19 Mar 2021 03:03:04 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id si3sm3577875ejb.90.2021.03.19.03.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 03:03:03 -0700 (PDT)
Subject: Re: [PATCH][next] loop: Fix missing max_active argument in
 alloc_workqueue call
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210318151626.17442-1-colin.king@canonical.com>
 <13a1d187-4d6d-9e06-b94a-553d872de756@kernel.dk>
 <62cd71bc-86e1-412d-b2b9-716c0f8021be@canonical.com>
 <d32641ca-e34a-2bfd-9b86-28c95546f434@kernel.dk>
 <20210319094759.GH2087@kadam>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <36888c20-48b7-373e-260a-6e8719c0ed60@kernel.org>
Date:   Fri, 19 Mar 2021 11:03:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210319094759.GH2087@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/03/2021 10:47, Dan Carpenter wrote:
> On Thu, Mar 18, 2021 at 02:42:33PM -0600, Jens Axboe wrote:
>> On 3/18/21 2:24 PM, Colin Ian King wrote:
>>> On 18/03/2021 20:12, Jens Axboe wrote:
>>>> On 3/18/21 9:16 AM, Colin King wrote:
>>>>> From: Colin Ian King <colin.king@canonical.com>
>>>>>
>>>>> The 3rd argument to alloc_workqueue should be the max_active count,
>>>>> however currently it is the lo->lo_number that is intended for the
>>>>> loop%d number. Fix this by adding in the missing max_active count.
>>>>
>>>> Dan, please fold this (or something similar) in when you're redoing the
>>>> series.
>>>>
>>> Appreciate this fix being picked up. Are we going to lose the SoB?
>>
>> If it's being redone, would be silly to have that error in there. Do
>> we have a tag that's appropriate for this? I often wonder when I'm
>> folding in a fix. Ala Fixes-by: or something like that.
> 
> I've always lobied for a Fixes-from: tag, but the kbuild-bot tells
> everyone to add a Reported-by: tag.  But then a lot of people are like
> Reported-by doesn't make sense.  And other people are like Reported-by
> is fine, what's wrong with it?

If the original commit is a fix and the fix for it is being squashed,
then Reported-by might mislead.

kbuild-bot tests also patches from list directly, so in such case the
patch can be re-done with a risk of loosing kbuild's credits. But when
the patch is already in the maintainer tree - just create a fixup. You
preserve the development history and the kbuild's credits.


Best regards,
Krzysztof
