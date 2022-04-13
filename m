Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345B6C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Apr 2022 22:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbiDMWsn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Apr 2022 18:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236908AbiDMWsl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Apr 2022 18:48:41 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958B55838E
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 15:46:19 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id 2so3422747pjw.2
        for <linux-block@vger.kernel.org>; Wed, 13 Apr 2022 15:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2cwsdqpMLrDBBUFhHc5jfg8idgOuulANohdziKdAHQQ=;
        b=ac9z8RJrlJfPodcj6I36ZoEsvKGd9ZS3XE4O1uvfRKY4KP5pJuq9721fXyw1kSKwej
         N357MWEQO3p0Sgp1gWr1ek7Fbxak1gulabR0vxdHh6gDc91AjWliJKI5Z5Ozzq7wle+7
         i466+jvGOuNdEAXOc+ULwk0joEX6iOV8Iq6ozWXxrL8YlWe1hHyqDEK2dpCjJluyhCi+
         vNFMYrqaWw4opfnyWdsnH3G8wIhePCmSQjZfuyRn1SsjBJh/+kKkpLHqnP3vVA+RiV7z
         4bwj3oojbYXUQLesVe4x1CXbIlhHSnOPEQFDfzTCdHyxmcqqwFlt2Rc4/mwGkmd52iJU
         Yj8Q==
X-Gm-Message-State: AOAM531esMkASgXb9msoCpsq+Vz48eUgy//GTgq8T92YFKvvMUPXTaQm
        E/QFlVRfaTVf63Tb+sYrKSusUOhBCUfBZw==
X-Google-Smtp-Source: ABdhPJyjcwgXoumWQUd7bG00td/RSuBc9Jphv63JwVZmpO6y5RA/dml1VKvJHFdnXVc2BE5Ty7qjXw==
X-Received: by 2002:a17:90a:5409:b0:1ca:8a21:323b with SMTP id z9-20020a17090a540900b001ca8a21323bmr1024482pjh.135.1649889978757;
        Wed, 13 Apr 2022 15:46:18 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4cb9:acfe:1291:f290? ([2620:15c:211:201:4cb9:acfe:1291:f290])
        by smtp.gmail.com with ESMTPSA id c7-20020a17090ab28700b001ca9514df81sm82313pjr.45.2022.04.13.15.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 15:46:17 -0700 (PDT)
Message-ID: <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
Date:   Wed, 13 Apr 2022 15:46:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: can't run nvme-mp blktests
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     yi.zhang@redhat.com, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org> <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YlcLOM49JsdlBqTW@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/22 10:41, Christoph Hellwig wrote:
> On Wed, Apr 13, 2022 at 10:38:50AM -0700, Luis Chamberlain wrote:
>> On Tue, Apr 12, 2022 at 09:53:12PM -0700, Christoph Hellwig wrote:
>>> On Tue, Apr 12, 2022 at 05:24:04PM -0700, Luis Chamberlain wrote:
>>>> I do have CONFIG_NVME_MULTIPATH=y but I also have:
>>>
>>> I'd suggest to ignore broken tests that require a deprecated option
>>> that will eventually be removed.
>>
>> CONFIG_NVME_MULTIPATH will eventually be nuked?
> 
> You'll only get a single namespace without it once the phaseout is
> complete, yes.  If you want nvme multipathing you'll need it, which
> is the story since day one.
> 
> If Bart wants to test dm-multipath I think his earlier srp_tests are
> the much better choice.

I'm not sure whether the nvme-mp tests test any code that is not yet tested by
any nvme or srp test. How about removing these tests since these tests make
it harder than necessary to run blktests?

Thanks,

Bart.
