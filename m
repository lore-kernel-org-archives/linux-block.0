Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8231C4338F
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 21:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D92E60F14
	for <linux-block@archiver.kernel.org>; Fri, 13 Aug 2021 21:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbhHMVoE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbhHMVoD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Aug 2021 17:44:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2FFC061756
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 14:43:36 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id u21-20020a17090a8915b02901782c36f543so22645889pjn.4
        for <linux-block@vger.kernel.org>; Fri, 13 Aug 2021 14:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HuUumrZYiKAzBzF0sW+u1OW6Lfy1mA15+NB+MoHyf+s=;
        b=CjsVk80qM1XlZveL/Mlj8VxPIm4ZUyf7jHYDMeExwhdsMlUVRA4fBYlTm2bvrA2Fej
         9B0teYw36ZWPJM/RZ43xC63wT1OEANtfl5YhgBMIX/DwsNfZ8woXWEqW1CwR3kqK7WeJ
         sk30VAgOSJg6vAlzuZn/+3fhplAEupfwDG2sIFFxz1ThhqMNwxcAlYjaTjnrCjuUmCr4
         h9+2h443Guf0EwsZFUe74Vo2f21uDyTWuhdgHTTRlHpnQe3/ZCk0EtwcHKm0AL+JVV0c
         KBT/0KWIsLEM7JqKUs0UGNNjp/TpqiTt7OoKVJb1zSGPB1EgGDFQaEV/ik4HlRPWK86n
         xF8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=HuUumrZYiKAzBzF0sW+u1OW6Lfy1mA15+NB+MoHyf+s=;
        b=OuO/3YKoSmFbSKO15giYlxwCaySK3gDTXG9Qe9RFaByMWUUhH3cIUcd0sWat173pQT
         DmELKda1XbiHJ9yKITyHPhbFnokB2GSLitNAN+rAauIQu1D5RMyofS22ChAYrI4PQfHn
         2o/UmDZ7bPkPdbTW9g+/c5dsz3ULT8RhPH1MkyHoI8zDmDAmorxYmstSzXqir86SkiHS
         Sf1IzlWpnr2RnhJWwf9wP3B5RBKfIsp4Ft0igxlZ8neGDCedv/UkpJpwoCLEafMLkHpa
         LpXa/yuKxtETWWD3yKowfM4UCL0mKXpwwhcZ4fRD3zD55/OY25szTNOq+oC9+Vv33las
         ZDNg==
X-Gm-Message-State: AOAM532pIM+Qasfui+VmUWafR6YCC9S7i+J7XQmXN+GCsp2OrIDfgvRX
        ordNCsQIllu3HO2d+cpyjdM=
X-Google-Smtp-Source: ABdhPJziVlUZ2Qgb79ttoQIrY+CbNOID2gkdFhRSY8uI7ejKnPr9QyThfLbTwUdlFDt10sWk0shSMw==
X-Received: by 2002:a17:90a:2c05:: with SMTP id m5mr4642506pjd.32.1628891016132;
        Fri, 13 Aug 2021 14:43:36 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e44d])
        by smtp.gmail.com with ESMTPSA id x16sm1235681pgc.49.2021.08.13.14.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 14:43:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 13 Aug 2021 11:43:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
Message-ID: <YRbngn3f0eXtNi27@mtj.duckdns.org>
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
 <035f8334-3b69-667d-be91-92dcab9dc887@acm.org>
 <YRQhlPBqAlkJdowG@mtj.duckdns.org>
 <00e13a7b-6009-a9d7-41ba-aae82f5813de@acm.org>
 <YRVfmWnOyPYl/okx@mtj.duckdns.org>
 <631e7e18-52ca-9bec-0150-bac755e0ff24@acm.org>
 <YRV1JkkxozEb4YO6@mtj.duckdns.org>
 <DM6PR04MB7081F2D0E8579489175DF363E7FA9@DM6PR04MB7081.namprd04.prod.outlook.com>
 <YRad3tQaZfR8v7lb@mtj.duckdns.org>
 <5527319b-ba0c-00a3-19cf-612f2e2b073d@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5527319b-ba0c-00a3-19cf-612f2e2b073d@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 13, 2021 at 10:17:42AM -0700, Bart Van Assche wrote:
> On 8/13/21 9:29 AM, Tejun Heo wrote:
> > The problem with complex optional hardware features is often the
> > accompanying variability in terms of availability, reliability and
> > behavior. The track record has been pretty sad. That isn't to say this
> > won't be useful for anybody but it'd need careful coordination in
> > terms of picking hardware vendor and model and ensuring vendor
> > support, which kinda severely limits the usefulness.
> 
> I think the above view is too negative. Companies that store large amounts
> of data have the power to make this happen by only buying storage devices
> that support I/O prioritization well enough.

The problem usually is that there always are other ways to skin that
cat which don't depend on having complex optional features. So, the
comparison isn't just about or among devices that support such extra
feature but with other solutions which don't need them in the first
place. Throw in the many inherent problems in expanding hardware
interface such as variability and timescale mismatch (hardware changes
a lot faster than software stack), the long term result tends to skew
pretty clearly.

Thanks.

-- 
tejun
