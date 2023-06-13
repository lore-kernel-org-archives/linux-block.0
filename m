Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 541F7C88CB6
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 08:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239738AbjFMISd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 04:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234523AbjFMISc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 04:18:32 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A497EA;
        Tue, 13 Jun 2023 01:18:31 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-786e637f06dso319939241.2;
        Tue, 13 Jun 2023 01:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686644310; x=1689236310;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8XVg5YXBoH5FNScoL8k9Pg7kZZRZzfodNUpxQL7gdQ=;
        b=dEkSI88ph3eqwDsiiklCOWvmaxs4Y2OEJSBi38G1Y2K38ldvw5UaPL+FIkCo+jT5kM
         YQeMxNIDQjyUOtntq68hoyw7Yhk7+t79kK/RMpqO3REhDOUKYUaFCx4BBSmRI681PEYI
         eGjZbHSW95DqVmBfGiY18GOlXXj8PpOUcrYpfmOG0mdiZWFNk8+sykZ+trR/1bEbuHe2
         a2d93g7TJjyb3VgfMKoBPVeXfAe2vnOhBMq0wHG5/nBoMm0GOR8ZFxH1gcrn6GDSTDV6
         aWzW9hmAp67RMb/ixJQveXu1JzeQF+d/fyJeiH2HhbCMKU08aKEkGoEuFO7Hc39L2TQS
         xRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686644310; x=1689236310;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y8XVg5YXBoH5FNScoL8k9Pg7kZZRZzfodNUpxQL7gdQ=;
        b=aDIjAth0JsZxQ8kqEqH0YXzfS8xOK5pmDn0qHfWrB7+tXtLYrbE5r13qjm73eitfrE
         d30/3Ake6VTQpD6YewGoglI9RJSgjlMjkMSHmcqEIpjwwRPzmjercMXpia7YmgWoyusm
         3JrKKnhbQ/8s/EJZ6zrVQo9JQasEl2BecfqG+p4Xg66gW1+BItZHLHOp/ZEb0Nbn12ch
         y+QoD0aW+a20W/41MY8bgWc+g8QxneZxTALGxSTU2+Dn8mwkkXHntXnMnlzDDAULdvGp
         Ju++177zDuadAIOZI4/Ss1JB3hfUwxWOaVxgB3D13tR/23mUGWxWyfuNGvfKgcXBqq1N
         pmaA==
X-Gm-Message-State: AC+VfDxQPujDmwxk3vaeCLVusUdtFgVsHWaC4VXELz/I4E5AwCRtNAgL
        IVWifMuUMw1PuNcAZWNvBl7koW7f8B4=
X-Google-Smtp-Source: ACHHUZ4voX7iTh51klNue83aX2CivhCY0py+HkU5KXMNlWoJ+FYltS7BmINv1nDTCO16YartVe3Sbg==
X-Received: by 2002:a67:b408:0:b0:43b:5615:9ec0 with SMTP id x8-20020a67b408000000b0043b56159ec0mr5641267vsl.1.1686644310314;
        Tue, 13 Jun 2023 01:18:30 -0700 (PDT)
Received: from [10.1.1.24] (222-152-217-2-adsl.sparkbb.co.nz. [222.152.217.2])
        by smtp.gmail.com with ESMTPSA id w15-20020a63c10f000000b00502fd70b0bdsm9015205pgf.52.2023.06.13.01.18.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jun 2023 01:18:29 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] block: add overflow checks for Amiga partition
 support
To:     Martin Steigerwald <martin@lichtvoll.de>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <1539570747-19906-1-git-send-email-schmitzmic@gmail.com>
 <cf6a3edc-7f9c-7a70-23b0-edf43769d994@kernel.dk>
 <2b924d0b-f278-e422-2a2c-f149265dcf9a@gmail.com>
 <4814181.GXAFRqVoOG@lichtvoll.de>
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <12241273-9403-426e-58ed-f3f597fe331b@gmail.com>
Date:   Tue, 13 Jun 2023 20:18:24 +1200
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <4814181.GXAFRqVoOG@lichtvoll.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Martin,

Am 13.06.2023 um 19:25 schrieb Martin Steigerwald:
> Hi Michael, hi Jens, Hi Geert.
>
> Michael Schmitz - 22.08.22, 22:56:10 CEST:
>> On 23/08/22 08:41, Jens Axboe wrote:
>>> On 8/22/22 2:39 PM, Michael Schmitz wrote:
>>>> Hi Jens,
>>>>
>>>> will do - just waiting to hear back what needs to be done regarding
>>>> backporting issues raised by Geert.
>>>
>>> It needs to go upstream first before it can go to stable. Just mark
>>> it with the right Fixes tags and that will happen automatically.
> […]
>> thanks - the Fixes tag in my patches refers to Martin's bug report and
>> won't be useful to decide how far back this must be applied.
>>
>> Now the bug pre-dates git, making the commit to 'fix'
>> 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ... That one's a bit special,
>> please yell if you want me to lie about this and use a later commit
>> specific to the partition parser code.
>
> After this discussion happened I thought the patch went in. However… as
> John Paul Adrian asked in "Status of affs support in the kernel and
> affstools" thread on linux-m68k and debian-68k mailing list, I searched
> for the patch in git history but did not find it.

I may have messed that one up, as it turns out. Last version was v9 
which I had to resend twice, and depending on what Jens uses to keep 
track of patches, the resends may not have shown up in his tool. I 
should have bumped the version number instead.

I'll see if my latest version still applies cleanly ...

Cheers,

	Michael


> So did it go in meanwhile?
>
> Ciao,
>
