Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12F1C4332F
	for <linux-block@archiver.kernel.org>; Thu,  8 Dec 2022 16:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiLHQ1B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Dec 2022 11:27:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiLHQ1A (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Dec 2022 11:27:00 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6666578EB
        for <linux-block@vger.kernel.org>; Thu,  8 Dec 2022 08:26:59 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id z9so1226203ilu.10
        for <linux-block@vger.kernel.org>; Thu, 08 Dec 2022 08:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lLNYG7Z5yfhFRfHKNccnXxuMC8fmolMqOdSQBS5UEp8=;
        b=jTLzBnJM4FphLJwgz02AcUaTB4lri7p07bjeDGShPEzJo3yU+xkwLJvl35ydq84be1
         cn7Cn3B3x1d/qbSgKp+z9WknPKgOXfAaWWYnKO673RvQpxd9XkdIuu9bkTQJioUdRCY+
         CTZy/fPxcnQdIMXzkm3WL2D9c7Rbu0id7X0HqI18F340auNgft+37WmPN1W+6HS/b7Ge
         vTPaAmbeWPb0LMwVf/W0Z3FO/FkZRUvKeeBFwrrVS0kG567YkX++mkQY3/FGjw1m2X2v
         B1+03jAEurAUg3HC1gRGEOyQjteLYMTSTRh1FHs39yyT4DcqtSsQKq8YMv3H++MfoLRE
         ZhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lLNYG7Z5yfhFRfHKNccnXxuMC8fmolMqOdSQBS5UEp8=;
        b=Mq1TK6w/C8eMRibaKZRlwukVkFDlr65bBNetvQibK9VCDeqmJc/2OPmgWrcSzAXQXH
         brwHxdxNC5/gcLdMEJSGPCMTdRxlW5CWR/acFqXR/defDe2+R1kUa9/J/31TrTiOflFV
         mxYdwgQOjU90NahAIjMMF1DqROOeXYfzcyLhvNh+/eTLcENN8UzdxR+H94dSmyO4lrJG
         ImGPLCyz/XaPBgazkcWNn+TPekO9/IBRBUPOWrTIXfSMCyqx+y1HjXbpXhMFzDPXYrKw
         mUj/thbZ2owDqNCxPLmlYPFhzrPGd9Bn6phWOswa0p9vppx08lYrAS1B9lshzXOkh3zY
         Bxaw==
X-Gm-Message-State: ANoB5pnW7HT/T0zY2//vJTQnSxiU6tTx6/Ni+NJQaRswmHDTYxaAfFce
        WMVKzEW8SAGrXIsHrjwYG/EqkA==
X-Google-Smtp-Source: AA0mqf4I6Poabn6rhRsJ47rUKzZQmFeb8LPY22vlJn0/WYD/A/CA5nKLA7Pj6YVkjlru0GVzVv07Dg==
X-Received: by 2002:a02:a04e:0:b0:375:b099:e48e with SMTP id f14-20020a02a04e000000b00375b099e48emr41641039jah.319.1670516819048;
        Thu, 08 Dec 2022 08:26:59 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d39-20020a026067000000b00389e42ac620sm8852119jaf.129.2022.12.08.08.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 08:26:58 -0800 (PST)
Message-ID: <2dab17f3-65de-e237-4374-7040d945404c@kernel.dk>
Date:   Thu, 8 Dec 2022 09:26:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] blktrace: Fix output non-blktrace event when blk_classic
 option enabled
Content-Language: en-US
To:     Yang Jihong <yangjihong1@huawei.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, acme@redhat.com, mingo@elte.hu,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221122040410.85113-1-yangjihong1@huawei.com>
 <e5654353-9850-beb5-cf72-7a7473a14743@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e5654353-9850-beb5-cf72-7a7473a14743@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/22 6:34 PM, Yang Jihong wrote:
> Hello,
> 
> PING.

Get your company email fixed so that messages don't get marked as spam,
that would help ensure your patches are more visible.

-- 
Jens Axboe


