Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84605C7EE24
	for <linux-block@archiver.kernel.org>; Tue,  6 Jun 2023 06:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjFFGpi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jun 2023 02:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjFFGph (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2023 02:45:37 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311AC91
        for <linux-block@vger.kernel.org>; Mon,  5 Jun 2023 23:45:36 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3f6148e501dso10137495e9.1
        for <linux-block@vger.kernel.org>; Mon, 05 Jun 2023 23:45:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686033934; x=1688625934;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ykdUDEsPsbdvXzXMVfKKjWXS0D8trIGOxCsakNyee0=;
        b=HEYT0fpkcRQ5NCSOiNp1fzlJP/cVJzzPA66VbQH6243t7Ftts+YafkJyI5S5wDFewL
         XQwuuO8rLI1JEGO0HqQDjNzmpW6tDH9mX0eW9xahB8sghb8DseAWSgU3Zramuif9Kjnv
         zD+QH/HUoO8if8GrJob2N5XuHnDXDHWuCUh3qKtqqN7FBNf5xr/rRNKeknltoy+r/rSd
         rCrQTJlDNlqbpx+jooHp+Fkc/kAwK2xhj0GO35CRxjc40HDAIz9aOla2azD0Cce+mL8z
         W7uuvUTwmEUqcTNMgesReDPARHb6hW51jkxlRIzI4VcTnYd2nOjVcFwa01gvS//gX4UB
         RgDQ==
X-Gm-Message-State: AC+VfDwIsFL5IhQRpZSg/eybSMUsfTb3XBVlsvKOMCLojS4gNkGRygOB
        MdcoI3q+DYDN5MzsGtl7p9A=
X-Google-Smtp-Source: ACHHUZ4AIZ31+XwAvtHDKg/howeFqJ8dJ8R9XuUcJjYvbLutbnBHTWtN3eteTsrZ19vYo8IJPG/mcQ==
X-Received: by 2002:a05:600c:1c89:b0:3f6:335:d8e1 with SMTP id k9-20020a05600c1c8900b003f60335d8e1mr1296776wms.2.1686033934420;
        Mon, 05 Jun 2023 23:45:34 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c00cc00b003f7678a07c4sm6195601wmm.29.2023.06.05.23.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:45:34 -0700 (PDT)
Message-ID: <18855542-e07b-70c0-ccd9-2fa0f0d2df86@grimberg.me>
Date:   Tue, 6 Jun 2023 09:45:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Content-Language: en-US
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1685495221-4598-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6fbgjc5ykve3jyko4vlzudrnwueou4ehgn6n2dtihjko3qv7ww@sqlyuxx4ijt5>
 <446c46d8-fbc7-ecd2-8efa-1c9497e16851@grimberg.me>
 <eadb2514-f06d-7cb2-2cdb-04a6226edac8@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <eadb2514-f06d-7cb2-2cdb-04a6226edac8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> On May 31, 2023 / 09:07, Yang Xu wrote:
>>>> Since commit 328943e3 ("Update tests for discovery log page changes"),
>>>> blktests also include the discovery subsystem itself. But it
>>>> will lead these cases fails on older nvme-cli system.
>>>
>>> Thanks for this report. What is the nvme-cli version with the issue?
>>>
>>>>
>>>> To avoid this, like nvme/002, use _check_genctr to check instead of
>>>> comparing many discovery Log Entry output.
>>>>
>>>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
>>>
>>> The change looks fine to me, but I'd wait for comments by nvme
>>> developers.
>>
>> I'm ok with this change, but IIRC Chaitanya wanted that we keep checking
>> the full log-page output...
> 
> the original testcase was designed to validate the log page internals
> and  that correctness cannot be established without looking into the log
> page.
> 
> but given that how much churn this is generating eveytime something
> changes in nvme-cli or in kernel implementation I'm really wondering is
> that worth everyone's time ?
> 
> Sagi/Shinichiro any thoughts ?

Also back then I thought it'd create churn because the log page output
is not an interface.
