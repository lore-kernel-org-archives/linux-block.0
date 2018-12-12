Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73214C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 19:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB5C2084E
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 19:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JHLeoTeZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB5C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbeLLTPh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:15:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42565 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeLLTPh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 14:15:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so9315360pfr.9
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 11:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=EYgd8qT+yjLbYVWZZ+88svlf8bryEemogR5V3KQg5VQ=;
        b=JHLeoTeZ/p72TQ5eficf7wbYOpHK0czHiJGbMLPnjaT3zP/53Utz5kSX+S/bP0ZxsT
         TGXHRlxNnLnurn2eyn4PZlsPyleuwAOpLu1UsnMnbgti/v9OBQYQ8bVrvrqiwdOar/JQ
         kltfgQflK4QvFQ1eu+W7iAN6ZcJozvcAgCHVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EYgd8qT+yjLbYVWZZ+88svlf8bryEemogR5V3KQg5VQ=;
        b=EgB3/Y3yXyWejLhIenB+FqcxmSJuwqGYo9iyu73/gpP8cN9LyxMdCguhh3/MOTnTZG
         ZCiuGpdtB4xqYjQN5i9Spk+k8X2BgJnkpGYAm92hL186BwmybXIbl5PLY/+aQ/HGsYZT
         vJScF2aSkhqekFkv1ELcgtiQRS9GLOZdS2S7/LUZqrGoCzz+X9poAlU8HbsU1n6BX1np
         5qvC/iL+IWn2puN9ZYu+8Syw7NdaoXn9w2KtNlAuh1GGE5a+mqbEKCwKi0nNY8HHHGKO
         v2lWGSuSYhhwZjKYEskawbIDPDwlWwHwI8ITqlrIcD4a2Gyr7nglvWPZRm1b5pkHC+4T
         slIA==
X-Gm-Message-State: AA+aEWYo5NbB9amJD+l3bhyvDJ6F9sfly4bo9T9bnt4vUwqceW/R1Fdr
        c+N02LwR2hiMlAtn6uVCys/xOA==
X-Google-Smtp-Source: AFSGD/XY+gIxvIkmo+Ho8BoqSchk3vKjhPE8S8tIN2f8CYFt+Eycd7IwqQw0ze4ikW1uUQAnCKGAdA==
X-Received: by 2002:a63:db02:: with SMTP id e2mr19367327pgg.419.1544642135807;
        Wed, 12 Dec 2018 11:15:35 -0800 (PST)
Received: from [10.69.52.190] ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d202sm30005107pfd.58.2018.12.12.11.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 11:15:34 -0800 (PST)
Subject: Re: [PATCH v2 0/5] implement nvmf read/write queue maps
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181211233519.9350-1-sagi@grimberg.me>
 <477ef7e7-bc81-5c27-84ba-27c75989bdc4@broadcom.com>
 <be43de64-eb4b-c116-85f2-8c5d5a62e3c1@grimberg.me>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <ea1c9217-c9dc-082b-dbc9-45b98e5d467c@broadcom.com>
Date:   Wed, 12 Dec 2018 11:15:33 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <be43de64-eb4b-c116-85f2-8c5d5a62e3c1@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 12/12/2018 9:58 AM, Sagi Grimberg wrote:
>
>> Sagi,
>>
>> What other wins are there for this split ?
>>
>> I'm considering whether its worthwhile for fc as well, but the hol 
>> issue doesn't exist with fc. What else is being resolved ?
>
> I've pondered it myself, which is why I didn't add it to fc as well
> (would have been easy enough I think). I guess that with this the
> user can limit writes compared to read by assigning less queues as
> jens suggested in his patches...

not enough to interest me.  I also would prefer to not require more 
queues - it only increases the oversubscription requirements on the 
target, which is already a major issue on real shared subsystems.

Thanks

-- james

