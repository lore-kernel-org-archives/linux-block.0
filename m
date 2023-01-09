Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E24DC54EBD
	for <linux-block@archiver.kernel.org>; Mon,  9 Jan 2023 23:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234809AbjAIXw3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 18:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjAIXw2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 18:52:28 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AB1EAA
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 15:52:28 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id v23so6454660plo.1
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 15:52:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy1IJ8Y7S2KIN4w3t0xp+/jKgYIkoIkkj2NIhgDo0R0=;
        b=M8yxUWclZBopFxn1c/ETil1lpMsVLm2BC4IklPs8cCkA9kWSa3ydzG8eHWWlZo7UU1
         eZsUCCqxSJYb3tCa5BuYntdA4UyQxAh3AO0Hc1RwLk0JfmYQ/oJLYZ67mif1Y65UPubY
         feuZKFQVPxm13KSpOcy0ympsYteblqlQxURSJboQzp/Kj50yVLThkzh5O3nCx+sjLuZR
         JpQcsDhi1BN8tn6TJlKnLbEj5PGcZ/HV7pna8QvREe58ri9vKWQX2CLhbICjjvx3B4MP
         pZvEHoTub97HCxjlxbfB6JJAa1kGbwg31VoHDwFpc9COrmcpjO2zEV0WXwDGCqrPtHNs
         fGEg==
X-Gm-Message-State: AFqh2kpH9qpVyUvvROXrEcVRucWbcC/k316u0nzXvRzx9Qo+idqwQpwR
        klF2FQM86OZPpYjoMTL0gKS59CeMRRQ=
X-Google-Smtp-Source: AMrXdXv4FCp01I0b45DhbGMAmde5i+CzOwsaGbqqryEgGvtYJ3vKMk2jhfrywnEN7/WB1cvQrEJm5A==
X-Received: by 2002:a17:903:2283:b0:192:8b51:a9f5 with SMTP id b3-20020a170903228300b001928b51a9f5mr73442781plh.68.1673308347649;
        Mon, 09 Jan 2023 15:52:27 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:9f06:14dd:484f:e55c? ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id z7-20020a63e547000000b00476d1385265sm5613034pgj.25.2023.01.09.15.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 15:52:26 -0800 (PST)
Message-ID: <22912d92-dd0f-8fc9-8dc5-10a81866e4ee@acm.org>
Date:   Mon, 9 Jan 2023 15:52:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/8] block: Introduce the blk_rq_is_seq_zone_write()
 function
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-3-bvanassche@acm.org>
 <7b90e9e6-4a32-eb0d-bb42-8cd0a75159f9@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7b90e9e6-4a32-eb0d-bb42-8cd0a75159f9@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 15:38, Damien Le Moal wrote:
> On 1/10/23 08:27, Bart Van Assche wrote:
>> +static inline bool blk_rq_is_seq_zone_write(struct request *rq)
>> +{
>> +	switch (req_op(rq)) {
>> +	case REQ_OP_WRITE:
>> +	case REQ_OP_WRITE_ZEROES:
> 
> REQ_OP_ZONE_APPEND ?

I will add REQ_OP_ZONE_APPEND.

Thanks,

Bart.

