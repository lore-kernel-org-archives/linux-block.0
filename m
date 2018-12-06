Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9EBC04EB9
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 02:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FE8208E7
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 02:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bHUph2Px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FE8208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeLFCNH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:13:07 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40951 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbeLFCNH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 21:13:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so10994834plq.7
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 18:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IlX4COLuXhS84PiplK1JgQzzPPPlMO8iinbwMD+UQSM=;
        b=bHUph2PxeN+0WfzB8t37tP/Sr6/m7Sgjp6rH71yrydqSnnMgfDms2VGf4etoOW2dhV
         0V2SKr7lrsLaX94GfOOLBvVOk8O4I1ppvm1NWjlkUDLnvP1GqEcvHpBcEZtxNxJL69ma
         SyrcEF746M9xf0tP6qPc5L7g4h8Azj5n3hcW2OcHN/NixVAWI6GWosUJ8EqeWw3HuViv
         EHi+0AC3P2e/fO4AvwHJkt7LNvwlC9c+R1v7vbx9kHB35S/QXS0IJYaFLCaTkgDmUPLQ
         Su00bMbpwlBAygKT4ulqtcF1ztBa1ibz9G2zFeoAqeSTEHp0+SV9rC0mg2RwaPjurYZG
         Jqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IlX4COLuXhS84PiplK1JgQzzPPPlMO8iinbwMD+UQSM=;
        b=AnsKbCgLJrOXM9883jzuD4Qctycgc6P/hztaicxV4RVhaa5vOGfhPQV3x8RP+bQ6H7
         GPYtipkx4IoljjfPo6Va/tVVdzBbDROBDDhQCRam4RY748b++K8VpW81mB2olazclHuf
         hKE5foH/a30YJlMtEPA1+3bsUL9+MJ+xR13QVkm4odOVxzA66y6X3zcss2NFTps78rH1
         KPXTwQuwq9af2DKefpJotpZJW++KRKTFeVOr2Ob0KOOq1q25cKVgokVAJMia8d8kBc5x
         DURFTH57aATLSUHfgNAJeWCPA9RbYdfBlxxLylw3W0gw3eqkzmB5EgOIBGIaW3HkdCZz
         +30w==
X-Gm-Message-State: AA+aEWb2iCSW0bVsIF+1npipbE8lRjuVQ5a/5s17fSbB0mtM1ye2xmWG
        fH/uZZVjPGiDGA17N5AHagMQew==
X-Google-Smtp-Source: AFSGD/UaLa/fO+0XZcgFS9Pe37TPN+HixJ/8c81G4is6DEPNfzh+Q8m4NtPuswpQeZRRmZgZ2+MRIQ==
X-Received: by 2002:a17:902:2468:: with SMTP id m37mr7651319plg.314.1544062386223;
        Wed, 05 Dec 2018 18:13:06 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b202sm30793449pfb.88.2018.12.05.18.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 18:13:04 -0800 (PST)
Subject: Re: [PATCH V9 3/4] blk-mq: issue directly with bypass 'false' in
 blk_mq_sched_insert_requests
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1543995842-20704-1-git-send-email-jianchao.w.wang@oracle.com>
 <1543995842-20704-4-git-send-email-jianchao.w.wang@oracle.com>
 <6cb12913-3575-d3aa-ff08-f89bcb38b3d6@kernel.dk>
 <b57bbedf-bc7e-7b8d-2217-3e8628ab657c@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e25a0ba3-356a-35d9-e22b-63ba124f555a@kernel.dk>
Date:   Wed, 5 Dec 2018 19:13:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <b57bbedf-bc7e-7b8d-2217-3e8628ab657c@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 6:11 PM, jianchao.wang wrote:
>> And why aren't we just using the list_empty() check like before, and not
>> having to add the inval cookie value?
> 
> Because we use 'bypass == false' here, so blk_mq_try_issue_directly
> will take over the request totally, so the request will always be
> removed from the list and finally, the list must be empty.
> 
> There is another way to identify the result of blk_mq_try_issue_directly.
> Currently,
> for the 'bypass == true' case,
>     it always return BLK_STS_OK,
> for the 'bypass == false' case,
>     it return the actual result, except for 'force == true' case
>     where the request has to be inserted into hctx dispatch list
>     and return a BLK_STS_OK.
> 
> We could let the 'bypass == true' case also return the actual result to
> show what has been done in the blk_mq_try_issue_directly and thus we could
> get the actual result of the last request.
> 
> Would you mind we handle it like this ?

I like that, sounds better than adding a new qc type.

-- 
Jens Axboe

