Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E0EC04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D959B2082F
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 20:37:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D959B2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbeLAHsP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:48:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34268 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbeLAHsP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Dec 2018 02:48:15 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so3356925plz.1;
        Fri, 30 Nov 2018 12:37:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fpXoyAHNp4oUkYW8cxxkKRZuAeHGov2+ONvp5PJwX5s=;
        b=jIzfMrxW4BFs/8b5DHwNv4z5ul0LsQ5JbxOqPjma9LoxY1wX6eocchfpt90YVz+eeg
         aIVfTD2ZLJatJ0hCQGrFdLhzfZMXPACzvPp7/1wymjdSTNINtEAuFCarImsxLfFgzWGN
         vkOTyHqAyvXovMPKtroopqD7gVnvKcvoFXOlommdIDc4fZ91Kx/bgoKiZgRcXTVLDUv9
         TmFgFyJj7klv2sO12o3iUfFUzH/Y/mSid2SL8JcW4TEvJNpct5Hj40+b4WHv3Lq1jkPV
         WNbPBHZyTWHfj5J2ZaE7M8kFN0XXHgso6Gr4u3nlb2AN0WC3bokiFVycIKphXKI2tkyn
         kB8g==
X-Gm-Message-State: AA+aEWaVKvNvJBffpaAT5cmZOB/Vg8Y0zn5Sw8Hy25NeBNdZozX7zpMW
        SSVUMKDo7Xcys41iOOhperA=
X-Google-Smtp-Source: AFSGD/XYdBHH+i5nDfRO/uBWHWv0yusJUoxeJ+Eg1rC7MF1sSNIPvgYIQ0bgMVotRDRCRRRK9DeiWw==
X-Received: by 2002:a17:902:4523:: with SMTP id m32mr7023402pld.53.1543610265497;
        Fri, 30 Nov 2018 12:37:45 -0800 (PST)
Received: from ?IPv6:2601:647:4800:973f:7888:b13c:bff:87b0? ([2601:647:4800:973f:7888:b13c:bff:87b0])
        by smtp.gmail.com with ESMTPSA id r6sm12659595pgk.91.2018.11.30.12.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 12:37:44 -0800 (PST)
Subject: Re: [PATCH v4 00/13] TCP transport binding for NVMe over Fabrics
To:     David Miller <davem@davemloft.net>
Cc:     hch@lst.de, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, netdev@vger.kernel.org,
        keith.busch@intel.com
References: <20181127231615.9446-1-sagi@grimberg.me>
 <20181128070116.GB20369@lst.de>
 <133a9650-4413-8692-4200-9d54710e7358@grimberg.me>
 <20181129.181403.1046644111319738364.davem@davemloft.net>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7bfee670-1658-3888-fc00-3d8c1f4a369e@grimberg.me>
Date:   Fri, 30 Nov 2018 12:37:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181129.181403.1046644111319738364.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>> What is the plan ahead here?  I think the nvme code looks pretty
>>> reasonable now (I'll do another pass at nitpicking), but we need the
>>> networking stuff sorted out with at least ACKs, or a merge through
>>> the networking tree and then a shared branch we can pull in.
>>
>> I would think that having Dave ack patches 1-3 and taking it via the
>> nvme tree should be easier..
>>
>> Dave? What would you prefer?
> 
> No preference, if the nvme tree makes things easier for you then
> please do it that way.
> 
> Acked-by: David S. Miller <davem@davemloft.net>

Thanks Dave.
