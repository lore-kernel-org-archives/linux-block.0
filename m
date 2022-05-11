Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CD0C433EF
	for <linux-block@archiver.kernel.org>; Wed, 11 May 2022 18:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346198AbiEKSW6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 May 2022 14:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346203AbiEKSW5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 May 2022 14:22:57 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3EF179C0C
        for <linux-block@vger.kernel.org>; Wed, 11 May 2022 11:22:55 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id s14so2672425plk.8
        for <linux-block@vger.kernel.org>; Wed, 11 May 2022 11:22:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FiCuLfhaB4d6yT8vbEHfthl+5WCQeyqRiAwpLhOuP90=;
        b=xWYpbaNb22u+deriS17idZ9T6DdX1velWB2ts8FCHdOrGot1FnNwDG4I12ZkdaNFz5
         pAlYgq3ssZyzalvDeO0p29YOIoPTnsjykm9JfMCe40p7tVgapFdrkXDWmIUiN0UQXbbZ
         rEXYYi+g2d+L/p39A+VoQiEvgVFfSysporo9YbaHF4MxPFN2/5KIIe1KFpUJOLv3zmiG
         KNDJ8zpY3ljc4zupysB2XCwqGecqL9y+3vASyMo5thDMCiBfAAWCCpQyEhnZFiMVjxY8
         8YVsa2NoPBN4szc0eQ9qyytewNIj0Yx8bmd961bv9oLbcsV3T6tfPgCMW5gaF4RTIx27
         +55A==
X-Gm-Message-State: AOAM53052rVXBOIUGQmu/ur7l2m5Fetf0lCeRFDJkAvW3/8OXR5waNsK
        MBiF0nP+EVM/fa93kfrQaHQ=
X-Google-Smtp-Source: ABdhPJyi/GYhP3zaSAlvFb9UeH2K90qjiQi15GpjlLj+LDF3YxIi8zUCyGkF+6YJJdFkoQt05Xh6ZQ==
X-Received: by 2002:a17:902:9a4c:b0:156:6735:b438 with SMTP id x12-20020a1709029a4c00b001566735b438mr26572266plv.46.1652293374845;
        Wed, 11 May 2022 11:22:54 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:78c5:5d65:4254:a5e? ([2620:15c:211:201:78c5:5d65:4254:a5e])
        by smtp.gmail.com with ESMTPSA id 5-20020a17090a190500b001d77f392280sm240407pjg.30.2022.05.11.11.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 11:22:54 -0700 (PDT)
Message-ID: <71af1a93-1950-b480-afbb-d61b6590f6fe@acm.org>
Date:   Wed, 11 May 2022 11:22:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] blktests: replace module removal with patient module
 removal
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     osandov@fb.com, linux-block@vger.kernel.org
References: <YlogluONIoc1VTCI@bombadil.infradead.org>
 <c584cf40-2181-2617-92aa-bcdbc56a5ab8@acm.org>
 <Yl2KU6vLxawrIXi/@bombadil.infradead.org>
 <1293a7e7-71d0-117e-1a4f-8ccfc609bc43@acm.org>
 <Ynv2BaRJcL0I3vAR@bombadil.infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Ynv2BaRJcL0I3vAR@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/11/22 10:44, Luis Chamberlain wrote:
> I suspect you ran into the issue of the refcnt being bumped by anything
> multipathd tried, and not being able to remove the module, but  if it is
> adding *new* mpath devices that would seem like a bug which we'd need to
> address. The point to the patient module removal is to keep on trying
> until the recnt  is 0 and if that fails wait and keep trying, until the
> the timeout. Anytihng userspace does, say multipathd does, like
> bdev_open(), would be yielded to.
> 
> So I'd like to keep this change as it is exactly the sort of hack I am
> chasing after with this crusade.
> 
> Let me know how you'd like to proceed so I can punt a v3.

Please implement the patient module removal and the stop_srp_ini() behavior
changes as separate patches such that the stop_srp_ini() behavioral changes
can be reverted easily in case these would trigger a regression.

Thanks,

Bart.
