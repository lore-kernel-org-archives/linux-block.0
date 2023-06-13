Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7053BEB64D7
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 20:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjFMUeN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 16:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjFMUeM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 16:34:12 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A3C135
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 13:34:11 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-4f642ecd8c1so1149267e87.0
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 13:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686688449; x=1689280449;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wuGhny5hsKLzce/C/qbgMqj8TH9cCCK1tE6kjfQ+WY=;
        b=Hspx++HfJ1Q7Q0rAV2GSTVldb/vS3Oa03agYnbcrLSvJjSFBQRuXX2pj31JtxGqXRc
         6ZvvSLPhIccHEIrh/s4wHobWg0U5eQf0OhzrHO1p978c2HHqc5bm9fahlY8tfBarhf/v
         A3p9r95Nt9FvPcpjvbVk5SmLfm6mlBGeBZrw8PO17r0tJbSf5Cv3ms4LsTVb9Y7/Q014
         sq00i3jftCkiJJMfvxHW4sRO8ci0XzegDwT4NGz5e2RSEUbzZmpnFQyJSHFOLPzHWmzL
         ZL57gzcybLRp8b2Gv4zyXajZk+zthC8Rsd0fDXStui9Et/4I0+7RDcXqnfsxYgFPKCb6
         Z/7g==
X-Gm-Message-State: AC+VfDw1DAaALnRRbUw0nNS2yBsEX+eyD6p23RMyq8zE2Y4rUJYEWg8A
        /Iq6wkjWd3qf/uCN8k3ifqo=
X-Google-Smtp-Source: ACHHUZ7CbPWFbJl1TsFH/qBGM3J6KaEiV3j3MUWjw1DLl1z3gWHod6EgSPbJTxX1J+xKFaQioQViZw==
X-Received: by 2002:ac2:43c4:0:b0:4f3:ab15:aea with SMTP id u4-20020ac243c4000000b004f3ab150aeamr5837044lfl.2.1686688449009;
        Tue, 13 Jun 2023 13:34:09 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id g9-20020a19ac09000000b004f7642f638csm41050lfc.192.2023.06.13.13.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 13:34:08 -0700 (PDT)
Message-ID: <4c40b502-4309-d601-d8bc-18042c3f490c@grimberg.me>
Date:   Tue, 13 Jun 2023 23:34:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] nvme: don't freeze/unfreeze queues from different
 contexts
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
        Chunguang Xu <brookxu.cn@gmail.com>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
 <20230613005847.1762378-3-ming.lei@redhat.com>
 <ZIiAKhi5Vmc0Fc9W@kbusch-mbp.dhcp.thefacebook.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZIiAKhi5Vmc0Fc9W@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> And this way is correct because quiesce is enough for driver to handle
>> error recovery. The only difference is where to wait during error recovery.
>> With this way, IO is just queued in block layer queue instead of
>> __bio_queue_enter(), finally waiting for completion is done in upper
>> layer. Either way, IO can't move on during error recovery.
> 
> The point was to contain the fallout from modifying the hctx mappings.
> If you allow IO to queue in the blk-mq layer while a reset is in
> progress, they may be entering a context that won't be as expected on
> the other side of the reset.

That still happens to *some* commands though right?
