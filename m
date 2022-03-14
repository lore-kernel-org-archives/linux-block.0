Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A647C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 19:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiCNTWo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 15:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiCNTWn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 15:22:43 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F531AF1E
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 12:21:32 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id s42so15717278pfg.0
        for <linux-block@vger.kernel.org>; Mon, 14 Mar 2022 12:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=XBeleSpo4k5n0rTQVTQfZZ7q/vMHmp0sZEUmI42WB8k=;
        b=Lp53dBfc2OKxgUlo7RvSg7dkjNEN4hVkVe7VawGwkwHEran20tL2+haIf9UxnqCrAm
         Vh4gSo28gS+vHD/DUnjk4vw8OGOuZINMY9wkJqU4ZGt/xJRq0hN3u0xQXcJ/aHTdpHgd
         fUyAPPTQzPV4uE2idT4cYPeSgLWwY2z0q1hO/2G4BsgEYXwZk8SfNniIqoXcZAR1I8ub
         Hz5FnI6XU62vpfy5vXcxmt+VBBrdgakcqT/PTR5CttPEzEzArNgKIkWXvqdI4dcv+HRN
         PtVPe2fH4YF2SyM2NEGVR3bxYqfDP9cSmT7qBDyVNMR6aNQL+l6TZBVhhlYpraaoN8BY
         6zlA==
X-Gm-Message-State: AOAM532Nr8TZpM6o4tA4afnO0sKr+YGxB/e/Bq7VRGLRcpHcfDHT+ogD
        vXKvE1Fd16sgA3h1RRX+PgQ=
X-Google-Smtp-Source: ABdhPJwsNaYPnfyK7Plv+cpXOVrsj8GkLOWV1LHKoS7ayN9+B/pYc4bWCj1zThJZCMAlVy5JqlMqcg==
X-Received: by 2002:a05:6a00:8cc:b0:4bc:3def:b616 with SMTP id s12-20020a056a0008cc00b004bc3defb616mr24890706pfu.18.1647285692238;
        Mon, 14 Mar 2022 12:21:32 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:d3f4:bcc8:20ea:11af? ([2620:15c:211:201:d3f4:bcc8:20ea:11af])
        by smtp.gmail.com with ESMTPSA id v66-20020a622f45000000b004f129e7767fsm20383575pfv.130.2022.03.14.12.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 12:21:31 -0700 (PDT)
Message-ID: <0b85385b-e8cf-2ab3-ce22-c63d4346cc16@acm.org>
Date:   Mon, 14 Mar 2022 12:21:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From:   Bart Van Assche <bvanassche@acm.org>
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
To:     Sagi Grimberg <sagi@grimberg.me>,
        Mike Christie <michael.christie@oracle.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org,
        linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
 <87bkyyg4jc.fsf@collabora.com>
 <e0a6ca51-8202-0b61-dd50-349e6f27761b@grimberg.me>
 <45caea9d-53d0-6f06-bb98-9174a08972d4@oracle.com>
 <6d831f69-06f4-fafe-ce17-13596e6f3f6d@grimberg.me>
Content-Language: en-US
In-Reply-To: <6d831f69-06f4-fafe-ce17-13596e6f3f6d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/13/22 14:15, Sagi Grimberg wrote:
>
>> We don't want to re-use tcmu's interface.
>>
>> Bodo has been looking into on a new interface to avoid issues tcmu has
>> and to improve performance. If it's allowed to add a tcmu like backend to
>> nvmet then it would be great because lio was not really made with mq and
>> perf in mind so it already starts with issues. I just started doing the
>> basics like removing locks from the main lio IO path but it seems like
>> there is just so much work.
>
> Good to know...
>
> So I hear there is a desire to do this. So I think we should list the
> use-cases for this first because that would lead to different design
> choices.. For example one use-case is just to send read/write/flush
> to userspace, another may want to passthru nvme commands to userspace
> and there may be others...

(resending my reply without truncating the Cc-list)

Hi Sagi,

Haven't these use cases already been mentioned in the email at the start 
of this thread? The use cases I am aware of are implementing 
cloud-specific block storage functionality and also block storage in 
user space for Android. Having to parse NVMe commands and PRP or SGL 
lists would be an unnecessary source of complexity and overhead for 
these use cases. My understanding is that what is needed for these use 
cases is something that is close to the block layer request interface 
(REQ_OP_* + request flags + data buffer).

Thanks,

Bart.
