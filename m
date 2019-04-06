Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F22C10F06
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 18:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E213213A2
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 18:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="s36Qhizy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfDFS67 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 14:58:59 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34550 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfDFS67 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 14:58:59 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so5154231pfd.1
        for <linux-block@vger.kernel.org>; Sat, 06 Apr 2019 11:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=992B1/0Wkzkq5Rsb1fVU2au57iNiCG7g0/IQ35kNWfo=;
        b=s36QhizyPqsR6KpC91DW4Fw+hEXeuwcPplTFzCI/wLgkYnO1QMFnL1wi988ARV/Oje
         u768TStgXo0tMVDiN0Mh4WWxeNdpeGapny3r505svUB97nkUm8dMuYVE1gfg8gSDB1tP
         Iy9k6ZoTUk8elR8ssrXXh/wnpeGJuMN1Y1XoJrgVqTpCQPFQRPi47cNSd6Dwn05mVXta
         WOCVdySA5FeVXrWOxZHf59w1t1J+fhrvSnYJakT7nPijEiwPnF2+teMUeM0hfy+HbrgV
         MGOmu3igFkKiZ6x1/YF8KOpo0hpvso+FlAnkoPGgceEH4JsGis3T9+WzmPnwnNYfOegO
         Mgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=992B1/0Wkzkq5Rsb1fVU2au57iNiCG7g0/IQ35kNWfo=;
        b=ECONUrw6S9/2+s0jPhiQqEeN/ZNMkEmSfomtR7zm3uwNIkbCIr40652Oh3IjC7u/Gn
         muLScJbfPdOf2Bia0+bDIIdPhh1THbjLsBrH3tZ6+5EjVgYVA7NCmfB4aXjl5OMy/y/C
         yGEfWFPhTHe/k43FiP6xKwwewz5aDEK5HGCcXqku3pbvRaKm+jcSsWYQTv9qzj/Bx12h
         krC/R/JCgmlPcHWWO30Y/1R1zQX7i4KO8/OVaAG85C3bAR8Xa/1FY5/Eyj6ra7wpPnaS
         pSCQlIPmUWxeDIMg72fTZRPGtFF/+v7BUJC6rcqz8r7KS/LLkPOAyD8YQp1FasxHqWSn
         pobg==
X-Gm-Message-State: APjAAAWijjHx+EagfkzIc/Ur9rhXcTqFvd257vB6tVZx6JGE9evoRKTS
        GN8rHVq0PV9rLrjaMALIGQguT3FDo72Rfg==
X-Google-Smtp-Source: APXvYqyr6n/bl2TPTh3mJ0zhwvehIzR2B0iH9fm35N1zLxRMrCfx1h/APe20zXZ6ywYbfO+lJjRAzA==
X-Received: by 2002:a62:ee17:: with SMTP id e23mr20164700pfi.80.1554577138209;
        Sat, 06 Apr 2019 11:58:58 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p3sm38283290pfn.167.2019.04.06.11.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 11:58:56 -0700 (PDT)
Subject: Re: [PATCH] block: preserve BIO_REFFED flag in bio_reset()
To:     Alex Lyakas <alex@zadara.com>, linux-block@vger.kernel.org
References: <1554555800-14392-1-git-send-email-alex@zadara.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ae3ac0dc-92ef-36f9-ff0d-ef41e6deacb1@kernel.dk>
Date:   Sat, 6 Apr 2019 12:58:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1554555800-14392-1-git-send-email-alex@zadara.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/19 7:03 AM, Alex Lyakas wrote:
> Commit dac56212e8127dbc0bff7be35c508bc280213309 titled
> "bio: skip atomic inc/dec of ->bi_cnt for most use cases"
> made __bi_cnt dependent on the new BIO_REFFED flag.
> 
> bio_reset() does not reset __bi_cnt, but it does reset the BIO_REFFED flag.
> But __bi_cnt depends now on the BIO_REFFED flag, so bio_reset()
> needs to preserve this flag.

Looks good to me, applied, thanks.

-- 
Jens Axboe

