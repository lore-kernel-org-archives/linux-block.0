Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C8BC4332F
	for <linux-block@archiver.kernel.org>; Thu, 31 Mar 2022 04:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiCaEP3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 31 Mar 2022 00:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiCaEOt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 31 Mar 2022 00:14:49 -0400
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5686229EE29
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 20:49:20 -0700 (PDT)
Received: by mail-pl1-f173.google.com with SMTP id j8so12093912pll.11
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 20:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=f9a8/jSLsAP43/Zszox61+3swgBvx/QRujNi2n4B5LA=;
        b=qZ5YCdnzf194KJx0fxyacdfq+lyYD3NsgIIa0ugHNFE0Oib8BD73CXfXsIFmdcjKNv
         e6CDn7mjWSDIfMZuHpD6zyn0KCdx0a79BOmXnky4W6lpaDbcG8duT48M9GXqR4mS00AV
         QzpN4vUJjbU4whXjfNQn7tCjbwkt6b9Rz8HHqq8QDomTkTdBl/J+y+8cEN7IcFBxeYqR
         A3DIheg6amA6NwEdqXC6GN6xR0SovagYRBsQI+cCGCpnNoWUMDMOdJnfhmPar9hkfwAo
         3WWhxT9TeEXiMiK9vDX+FRhOaqUqGmSHSn33gDFuH+Ew42Q35OGiwZ1FZAdRfBLETGND
         qSgw==
X-Gm-Message-State: AOAM53238FSGSqLbc6H2rzxoxjDJOMb6sLWbtu7uGo/yF4Jt8P1GwTTe
        pv+CBWoAS8hhYohAGE2Sdck=
X-Google-Smtp-Source: ABdhPJwA9iGDZBPyhWb8A78ChnUp2lOzN/Gaq7u4GT3McHz+zuxs5OxmB6tDAoGbAiYRV0c8MGxlEg==
X-Received: by 2002:a17:90a:fd13:b0:1c9:ee13:d122 with SMTP id cv19-20020a17090afd1300b001c9ee13d122mr3716430pjb.226.1648698559613;
        Wed, 30 Mar 2022 20:49:19 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd? ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id a32-20020a631a20000000b003756899829csm20415133pga.58.2022.03.30.20.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 20:49:18 -0700 (PDT)
Message-ID: <0c3b9efe-018b-7d60-7226-c93cafc0de3e@acm.org>
Date:   Wed, 30 Mar 2022 20:49:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org,
        linux-block@vger.kernel.org,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        linux-mm@kvack.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de> <YkCSVSk1SwvtABIW@T590>
 <87o81prfrg.fsf@collabora.com> <YkJTQW7aAjDGKL9p@T590>
 <87bkxor7ye.fsf@collabora.com> <YkO4rFBHCdjCJndV@T590>
 <87tubfpag3.fsf@collabora.com> <YkUGImrOCAzMT2t5@T590>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YkUGImrOCAzMT2t5@T590>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/30/22 18:38, Ming Lei wrote:
> The topic has been discussed for a bit long, and looks people are still
> interested in it, so I prefer to send out patches on linux-block if no
> one objects. Then we can still discuss further when reviewing patches.

I'm in favor of the above proposal :-)

Bart.
