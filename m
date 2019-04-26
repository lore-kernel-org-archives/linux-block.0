Return-Path: <SRS0=I+xz=S4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E15EC43219
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 12:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA85C2084F
	for <linux-block@archiver.kernel.org>; Fri, 26 Apr 2019 12:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="csKgkKtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfDZMeP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Apr 2019 08:34:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35495 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfDZMeP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Apr 2019 08:34:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id y67so3051572ede.2
        for <linux-block@vger.kernel.org>; Fri, 26 Apr 2019 05:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h9Qvxw4CKconppiqk0DxMblQ7mmN22jDdhn77epRE0M=;
        b=csKgkKtEWslrrdAjohfzZyAITl+p8Un6rA7lhOdMtDOb+WzhGEK/BvjCNDD0eeb3eL
         KZI5hinbR9VrHR6rNlb/1L2SogfpAhP1zLYfYHk47ixSzHFfjA/QZ9jnCHQG1SpaMtpJ
         4CAK0vEt/kCm1sm90SyZatHtXl5BfTlpabCrUxT6o2bCeVanfHkTeBPOAA/VBnV+ittM
         C9ZKekLzngVDSc9Xt4aiYgpJyZqxK1Zc2cZFMFlUCyZVxpsIhq6c041xW5jFt2jKcWUg
         wQg0hx0PaHtNhwWUNj4xyiyHJry6Lzy1LLUJhBUIbkjYVKAMB4gjfpvIR8qHZ5/ZYqSJ
         ixzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h9Qvxw4CKconppiqk0DxMblQ7mmN22jDdhn77epRE0M=;
        b=WcUrGwN5//QjHzL+pKeo6UfdXhvRXX0Fhx0obfCShR8GYwUdS8shWZUwhTZaR7TIEj
         o3crvBNw8Jv/Oi88XKM9quebi4Kpb1JN+YuKEsJarNNv8tX85KW+SE5+365DjUvzZ3Ri
         laba/fOns3L9YnCCDxuPIq8MlVcapk/fpb/w//bohAO3nSD84A0DVJRpj8FhzUshk+VZ
         jZPMinmwzvWVY85mwGx6jAsaBKPEMNVxDYeHe2fHhGIQqtsb3Ntmkr2kjuFZCGSFI06C
         oRlCKkdIOXjAwAJ+Lvr3JgPydfPt6IhA9yw4ggdS+5iTpq0VbT1iNVdlszcjByrEZmAA
         lFgQ==
X-Gm-Message-State: APjAAAVCtF551bVl/bn+d/fecDrTMD2S74Gp9G7DkIaDYPxUX2BRqzwK
        lFZD3/bGRa7hFQPlO0cZOjU28AIpb/A=
X-Google-Smtp-Source: APXvYqzKOHpBt1phsmMWjQKWTz4cfExiEqFAWh5KacyqbKlcQQCHqieEoV2awcxrwZuMy6FEt5KKxg==
X-Received: by 2002:a17:906:1ed2:: with SMTP id m18mr11000666ejj.106.1556282053755;
        Fri, 26 Apr 2019 05:34:13 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id n15sm752388ejl.52.2019.04.26.05.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 05:34:12 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] lightnvm: next set of improvements for 5.2
To:     Igor Konopko <igor.j.konopko@intel.com>, javier@javigon.com,
        hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org
References: <20190416101648.10045-1-igor.j.konopko@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <34c1c987-f208-8e28-cb76-26cb7a9ec07d@lightnvm.io>
Date:   Fri, 26 Apr 2019 14:34:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190416101648.10045-1-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/19 12:16 PM, Igor Konopko wrote:
> This is another set of fixes and improvements to both pblk and lightnvm
> core.
> 
> First & second patches are the most crutial, since they changes
> the approach to the partial read path, so detailed review is needed
> especially here.
> 
> Other patches are my other findings related to some bugs or potential
> improvements, mostly related to some corner cases.
> 
> Changes v3 -> v4:
> -dropped patches which were already pulled into for-5.2/core branch
> -major changes for patch #2 based on code review
> -patch #6 modified to use krefs
> -new patch #7 which extends the patch #6
> 
> Changes v2 -> v3:
> -dropped some not needed patches
> -dropped patches which were already pulled into for-5.2/core branch
> -commit messages cleanup
> 
> Changes v1 -> v2:
> -dropped some not needed patches
> -review feedback incorporated for some of the patches
> -partial read path changes patch splited into two patches
> 
> Igor Konopko (7):
>    lightnvm: pblk: IO path reorganization
>    lightnvm: pblk: simplify partial read path
>    lightnvm: pblk: recover only written metadata
>    lightnvm: pblk: store multiple copies of smeta
>    lightnvm: pblk: use nvm_rq_to_ppa_list()
>    lightnvm: track inflight target creations
>    lightnvm: do not remove instance under global lock
> 
>   drivers/lightnvm/core.c          |  75 +++++---
>   drivers/lightnvm/pblk-cache.c    |   8 +-
>   drivers/lightnvm/pblk-core.c     | 159 +++++++++++++----
>   drivers/lightnvm/pblk-init.c     |  37 ++--
>   drivers/lightnvm/pblk-rb.c       |  11 +-
>   drivers/lightnvm/pblk-read.c     | 376 +++++++++++----------------------------
>   drivers/lightnvm/pblk-recovery.c |  35 ++--
>   drivers/lightnvm/pblk-rl.c       |   3 +-
>   drivers/lightnvm/pblk.h          |  23 +--
>   include/linux/lightnvm.h         |   1 +
>   10 files changed, 333 insertions(+), 395 deletions(-)
> 

Thanks Igor!

Picked 1, 3, 6 and 7. Could you please rebase 2 and 5? I'm still 
noodling over 4.

-Matias

