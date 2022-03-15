Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F124C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 08:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345701AbiCOIGH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 04:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiCOIGE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 04:06:04 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668F6443FB
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 01:04:53 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id n33-20020a05600c3ba100b003832caf7f3aso894666wms.0
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 01:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=eEExz7tgoZCuFW6nrYsWZ2wn9+tgpSIcBdR1bn7LSfc=;
        b=SP1uf1zVQhgAezJTD751wTpR5vKI4FoTW3g+qXjzAHifxAV6hUoF5hOV3TyglTFs66
         GW4lFcUr7Fv4KnwulTlQbve0hnuNcgZuc0PSa6C+dv0zaveklUn1lIQe3yR1iRIvhZ52
         Zdk3QAzUNGwWfZIn6A8LVNuiUtAiM8o5+pn4Lp0axFNcwwoDSwgIwsSORJfeIIAlKWam
         Gfjxl28O+pry1WQlzaogozHwPfTFrdgRqQgg0ohWmILsgz36/znad4R7wUcbwE7FNPIH
         K7eo4i43f6NHrwijQDu7ceFBcUzj1ITVnAjF2U5EpKgH0p5itm/w/VIF3b1A6WJgspD/
         FpwA==
X-Gm-Message-State: AOAM532t4pR7RtGabGuLrVkmfEI1Ykv36lCYspHh7DFDEPzS69wUsh/4
        glyrBvoyBRVIRlUoWpop3qM=
X-Google-Smtp-Source: ABdhPJzq/mpPbr5+SkH1JZMYFGknAvSVPdSh/v15ouaHRjnmmHuJpUqFhTwAidBvcwW5q9kvXtssRA==
X-Received: by 2002:a05:600c:20a:b0:389:9d03:3439 with SMTP id 10-20020a05600c020a00b003899d033439mr2226228wmi.48.1647331491945;
        Tue, 15 Mar 2022 01:04:51 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c358400b00389f61bce7csm2592467wmq.32.2022.03.15.01.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 01:04:51 -0700 (PDT)
Message-ID: <c6d862ce-9f3d-d89f-dee5-fd40b096dbf2@grimberg.me>
Date:   Tue, 15 Mar 2022 10:04:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
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
 <0b85385b-e8cf-2ab3-ce22-c63d4346cc16@acm.org>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <0b85385b-e8cf-2ab3-ce22-c63d4346cc16@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> So I hear there is a desire to do this. So I think we should list the
>> use-cases for this first because that would lead to different design
>> choices.. For example one use-case is just to send read/write/flush
>> to userspace, another may want to passthru nvme commands to userspace
>> and there may be others...
> 
> (resending my reply without truncating the Cc-list)
> 
> Hi Sagi,
> 
> Haven't these use cases already been mentioned in the email at the start 
> of this thread? The use cases I am aware of are implementing 
> cloud-specific block storage functionality and also block storage in 
> user space for Android. Having to parse NVMe commands and PRP or SGL 
> lists would be an unnecessary source of complexity and overhead for 
> these use cases. My understanding is that what is needed for these use 
> cases is something that is close to the block layer request interface 
> (REQ_OP_* + request flags + data buffer).

pasting my response here as well:

Well, I can absolutely think of a use-case that will want raw nvme
commands and leverage vendor specific opcodes for applications like
computational storage or what not...

I would say that all the complexity of handling nvme commands in
userspace would be handle in a properly layered core stack with
pluggable backends that can see a simplified interface if they want, or
see a full passthru command.
