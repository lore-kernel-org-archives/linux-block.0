Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14233C7EE24
	for <linux-block@archiver.kernel.org>; Mon,  5 Jun 2023 23:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjFEXSN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jun 2023 19:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjFEXSM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jun 2023 19:18:12 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6042A7
        for <linux-block@vger.kernel.org>; Mon,  5 Jun 2023 16:18:10 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f13c41c957so482870e87.1
        for <linux-block@vger.kernel.org>; Mon, 05 Jun 2023 16:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686007089; x=1688599089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8zPGauo5IGjlOWoNI867DR+5xDWdnkel73bVvbsYF4=;
        b=kNCJNrQaloiSy6rISafnL0UHsyXmtwdzJWM+cBgdRg/lIQFJbj6dbub47OvtJy73PY
         PokFZbjgHRGlyYfdo9uTQiwfgr2FBAJprAUp1iN6IG+P0AcJzZi1G/6hX1vPXkzaPml6
         EYuR4Q1rJLbUStyJkTfo2YLMUQ/gK5lBfgUu0sJmcbYlnDkCMGNDjm+JhCJ7+ZH2RJcr
         nVrmcnE25rFKmernUGvvqPcTY33NrBdDp8pBAT5FXmsVGACOPmYbLE2iVtTJfXclMY5j
         cc+a5895jTnrTyHEb8KEVNuGZUDp8YHsKrOWDJs/6cTXoZQwC4UL5ca3X3gzo3TAskeT
         aiig==
X-Gm-Message-State: AC+VfDzmNgWCVykJu6DLgA/CbTFGU6+0/W6VowYq/WJV+Ea7lW/YXp1H
        XQ+Q1wJKWLZx5nd6YwX4ONg=
X-Google-Smtp-Source: ACHHUZ7tOjpGDR3uN2PYKuKb/jOyQ8HhYJZo5JSdlYn6jaDtFqS3lf+BuCv5YljQjhIP1bN6l2BhfQ==
X-Received: by 2002:a05:6512:4c1:b0:4f6:2246:aac4 with SMTP id w1-20020a05651204c100b004f62246aac4mr137014lfq.6.1686007088908;
        Mon, 05 Jun 2023 16:18:08 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id a26-20020a056512021a00b004f60be0c685sm1264785lfo.123.2023.06.05.16.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 16:18:08 -0700 (PDT)
Message-ID: <446c46d8-fbc7-ecd2-8efa-1c9497e16851@grimberg.me>
Date:   Tue, 6 Jun 2023 02:18:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Content-Language: en-US
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1685495221-4598-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6fbgjc5ykve3jyko4vlzudrnwueou4ehgn6n2dtihjko3qv7ww@sqlyuxx4ijt5>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <6fbgjc5ykve3jyko4vlzudrnwueou4ehgn6n2dtihjko3qv7ww@sqlyuxx4ijt5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On May 31, 2023 / 09:07, Yang Xu wrote:
>> Since commit 328943e3 ("Update tests for discovery log page changes"),
>> blktests also include the discovery subsystem itself. But it
>> will lead these cases fails on older nvme-cli system.
> 
> Thanks for this report. What is the nvme-cli version with the issue?
> 
>>
>> To avoid this, like nvme/002, use _check_genctr to check instead of
>> comparing many discovery Log Entry output.
>>
>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> 
> The change looks fine to me, but I'd wait for comments by nvme developers.

I'm ok with this change, but IIRC Chaitanya wanted that we keep checking
the full log-page output...
