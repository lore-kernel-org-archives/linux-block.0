Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67324C6FD1C
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 22:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjCWWve (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 18:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjCWWvX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 18:51:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDFA2CC5B
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 15:51:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so3387963pjv.5
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 15:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679611880; x=1682203880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0OX40ehjV5gIkQr/Q9nraxMiJdzGjqFLifP7n6ggXk=;
        b=TTqPzThDGMupB/gagrp+rTbV3eHSKSSrLjeATpLujyP3BjQhyLVdJPW0nFqfh7lx4X
         /tL5/prrRpFJnHz7NO9yWbSZYuEIbhgoUu+hIfGI0YCk0HO1n6FyPw4xLxD9b87pvVSL
         CK4W5AVwxkz0p8kq6QRhUEa31VKANW6YLLR5YwZwnuwvYDUbDeFzkaD1tIbclly1k12L
         ahS0F94a0rnpiFBIxQyHIiS7ylZ5k+o/htcVsn/9Ucp/a9U4M5NJTvX5L1BCfVR3S3RX
         8wl5iIN2tmHyYrx+Vw8BnXwd2RfKOSW3OFEYaEwQz3LNenf0o4ch+tpXJBuJgtXi4Taf
         1V+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679611880; x=1682203880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0OX40ehjV5gIkQr/Q9nraxMiJdzGjqFLifP7n6ggXk=;
        b=fpjvacWnBZwdhlggMOlNrI4V9wcfbbzslLzPebQVi70NSogP1UpHitPbCJE8fKhTAt
         bs30lXz3jNrCdJEQUjAj4cYk7uqiIbEbF6qYGfVoiT8jgzbfS8IpOrAb6RBUSAwcjpju
         Duja9R/eV7SXMwMjWi/9lgBSNbjtcIlBSlGQHeOCl9ZjAwS0DzpyCRSO3/S0zuP5X0Y8
         6GUClfcnDm5WDGh4f4joEO0/gX4uftRXvzm/+FwF4AUJivo622kKGw6cLQwmlMdMWyhX
         4asBuN3IX5X4d0S0rtYBtIkZBM3OLUr8odol9YFjPiu9jgEnagTl3Clg0VUwA90+Z7im
         YsAA==
X-Gm-Message-State: AAQBX9fnlisAFmwl8JKrKGnJc+wsBotZkVnMtgpromelIgt6z/yzGKMv
        15Uuvg9qZhaa3gPsN+QyGS4p8g==
X-Google-Smtp-Source: AKy350YwB4kYOrekaxdEpI+hPuVho+rJnXECPnSPxRKXmlcV0fNHAsS4nvedwv84jZJ4QD01oSfi+Q==
X-Received: by 2002:a17:903:788:b0:1a1:bf37:7c2e with SMTP id kn8-20020a170903078800b001a1bf377c2emr225398plb.4.1679611879706;
        Thu, 23 Mar 2023 15:51:19 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b0019b9a075f1fsm12871828plb.80.2023.03.23.15.51.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 15:51:19 -0700 (PDT)
Message-ID: <6c507b78-35fb-fe23-51f0-e5bb754679d0@kernel.dk>
Date:   Thu, 23 Mar 2023 16:51:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH RESEND v3] nbd_genl_status: null check for nla_nest_start
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>
References: <20230323193032.28483-1-mkoutny@suse.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230323193032.28483-1-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/23/23 1:30 PM, Michal Koutný wrote:
> From: Navid Emamdoost <navid.emamdoost@gmail.com>
> 
> nla_nest_start may fail and return NULL. The check is inserted, and
> errno is selected based on other call sites within the same source code.
> Update: removed extra new line.
> v3 Update: added release reply, thanks to Michal Kubecek for pointing
> out.

Josef? Looks straight forward to me, though it's not clear (to me) how
this can be triggered and hence how important it is.

> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
> Link: https://lore.kernel.org/r/20190911164013.27364-1-navid.emamdoost@gmail.com/
> ---
> 
> I'm resending the patch because there was apparent consensus of its
> inclusion and it seems it was only overlooked. Some people may care
> about this because of CVE-2019-16089.

Anyone can file a CVE, and in fact they are often filed as some kind
of silly trophy. Whether a CVE exists or not has ZERO bearing on
whether a bug is worth fixing.

So please don't mix CVEs into any of this, they don't matter one bit.
Never have, and never will. What's important is how the bug can be
triggered.

-- 
Jens Axboe


