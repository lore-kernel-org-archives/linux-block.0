Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC73C004D4
	for <linux-block@archiver.kernel.org>; Thu, 19 Jan 2023 19:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjAST23 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Jan 2023 14:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjAST22 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Jan 2023 14:28:28 -0500
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F3293713
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2023 11:28:27 -0800 (PST)
Received: by mail-pl1-f169.google.com with SMTP id p24so3221539plw.11
        for <linux-block@vger.kernel.org>; Thu, 19 Jan 2023 11:28:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmJAnlAt95K35Bv1y5VX9yNdsbwOrlhGc1QwL/wBLNQ=;
        b=V5dnLtA6u14MBFlImUPM5TMDY4Rhg7KKuOhNz1KsGgUSpA0zb9Da1/mKIMu4DYLWzy
         QFaSL5giB0cZZikHr8FeqNpsfyr/VVQw8beAynqDqvHrFW6kcoKLXqoinNPqTA/ZNRlt
         72T/8bps0yBHtjh3q6iBc280Hw8fFXq3U8Ds71TzzE3ZIlFJza0yYyqyCVmluGn0xD3X
         gp7covvIkQHZ7qB4iuc/UggLw/nEl4oGipFzoXysqBCdJpLoEhMyBsBDp/mu7PUktZMO
         KiTNk9l0wHNAqKAMJkEtBYGEug+Hq2z45IYsnNRKRf9eUDUDLkqxENlVld4x0YgAcg7u
         w8HA==
X-Gm-Message-State: AFqh2koyH8XzuHriIfUQKNAAtCZpWkUtOlqPiidQ/3ahitsrfyTEk1nR
        ZGSWF3qMfy15JfilUB0hNYk=
X-Google-Smtp-Source: AMrXdXs3Iac5Qe0UPSy0bjY1LQ/BmgaWToiimu63v79jlnefH6Yc7XxVMte9jDdzB6uxUH2hKThIUg==
X-Received: by 2002:a17:903:1252:b0:194:d9ca:7c56 with SMTP id u18-20020a170903125200b00194d9ca7c56mr1210165plh.58.1674156506543;
        Thu, 19 Jan 2023 11:28:26 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:ff60:f896:307d:56f7? ([2620:15c:211:201:ff60:f896:307d:56f7])
        by smtp.gmail.com with ESMTPSA id j18-20020a635952000000b004cd1f1a14f6sm7281532pgm.86.2023.01.19.11.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 11:28:25 -0800 (PST)
Message-ID: <1f50643c-0f34-4477-789d-f86185330c27@acm.org>
Date:   Thu, 19 Jan 2023 11:28:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] block: Improve shared tag set performance
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Ed Tsai <ed.tsai@mediatek.com>
References: <20230103195337.158625-1-bvanassche@acm.org>
 <Y8hvNmyR3U1ge3H3@kbusch-mbp> <4be69fc0-af32-b552-6a36-f75eb798ca95@acm.org>
 <Y8mQWTRze+SXD7Oz@kbusch-mbp>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Y8mQWTRze+SXD7Oz@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/19/23 10:47, Keith Busch wrote:
> I think the potential performance sacrifice was done on purpose in order
> to guarantee all tagset subscribers can have at least one unblocked
> access to the pool, otherwise one LUN could starve all the others by
> tying up all the tags in long-running operations. Is anyone actually
> benefiting from the current sharing, though? I really do not know, so
> I'm having trouble weighing in on removing it.

Hi Keith,

Hmm ... does reserving tags for one logical unit / namespace really help 
if long-running operations are active on another logical unit or 
namespace? For storage devices where the storage medium is shared across 
logical units or namespaces reserving tags won't help if the storage 
controller is not able to interrupt ongoing medium accesses. For storage 
devices with multiple "spindles" (e.g. a NAS) the tag fairness algorithm 
may help but this is not guaranteed.

How about making it configurable (request queue flag?) whether the tag 
fairness algorithm is active and leaving this algorithm disabled by default?

Thanks,

Bart.
