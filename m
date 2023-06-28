Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125ECEB64D7
	for <linux-block@archiver.kernel.org>; Wed, 28 Jun 2023 08:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjF1I0N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Jun 2023 04:26:13 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:41191 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbjF1IXt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2023 04:23:49 -0400
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-98273ae42d0so147651366b.0
        for <linux-block@vger.kernel.org>; Wed, 28 Jun 2023 01:23:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940628; x=1690532628;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TgDpH4Pmwhb+8zfjClR8p7ZuBuHg8+1VxoH4Zuhey8c=;
        b=c7Sp+cOf/MknbHhi2eb8uJcH1yidQ0IjmsutiCw5lLqer6jof4AC13xZkLAMFwKtOl
         IjEl3wEYnQz0KjCCQUYTB6mZpd++0OaL5dkGIH8e7P3CNPxI0VYRLYA8XxnRlaX2JLja
         TxZn0j6YBSPnJTpMuXaFrcfEN2m/t+U2F5q1w/2dlS7YFFgpxdzNB9S9a/dqtKO5OW3v
         oUKTW/5woiSDT41F4taBE/gd9VzUwyLe/LS+Bzjy+xJc6QqS3aXRsS8sUofesto0NI77
         pGwfL3KjHv7H6YtQekP1gkDVjtTHjjgyoMzzkwvwMhhCihLDjnqhtPhkLXgMb/qFBbd7
         lPbQ==
X-Gm-Message-State: AC+VfDyvTMMIlwzVSb9jKZd4XYCCuOdZoMb4UeXurlep2z/EQWmV/wJJ
        ZKJnNMgrVT+ZbcrqYuFIyKwitSQ3DxQ=
X-Google-Smtp-Source: ACHHUZ6GHUInBdAHlPN+IxSwvJD+GK8guEKBNogTrcD/Je2luO4EeLOd05efMHol+TegiL+EaAvCwQ==
X-Received: by 2002:a1c:ed17:0:b0:3f5:f543:d81f with SMTP id l23-20020a1ced17000000b003f5f543d81fmr35619270wmh.3.1687937093793;
        Wed, 28 Jun 2023 00:24:53 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i6-20020adffc06000000b00313e421c620sm11678649wrr.54.2023.06.28.00.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 00:24:53 -0700 (PDT)
Message-ID: <b3377b27-28de-c8ed-d45a-c3f241c24415@grimberg.me>
Date:   Wed, 28 Jun 2023 10:24:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me>
 <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
 <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
 <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs9=8fPRtXj4uyjN9MV1OMNNXwcVGte7CDnFxXYYbnnX0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> Yi,
>>
>> Do you have hostnqn and hostid files in your /etc/nvme directory?
>>
> 
> No, only one discovery.conf there.
> 
> # ls /etc/nvme/
> discovery.conf

So the hostid is generated every time if it is not passed.
We should probably revert the patch and add it back when
blktests are passing.
