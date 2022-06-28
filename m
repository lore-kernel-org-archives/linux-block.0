Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D567C433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 12:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbiF1MfP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 08:35:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiF1MfO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 08:35:14 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970912ED77
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 05:35:13 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id l6so10922748plg.11
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=IrDX84KRZKsKpKj5DTV5f5ssGpOVWEQyjPMtbK6Ke8A=;
        b=u5peKV+R+mkhdM4DPvEFbxYDbUvjlQidNZgW7hpYf2ehOjHKop3sOvQXAUQEF4gyRJ
         JPojBBUQpv5TcMOpq4JH0u3xjZiQBer0SHbAk9UVHNtjBydvMvA0DivhDFIT/JH40ikA
         YJtbYWaNIi2vdZs7KvEL7ZjySEmR/elw6X75HkqPJoeYU5twvIkamwyQnuhLVmzEw8KJ
         p/jx6nTeP/xeCTiS/pqG1MH/BGAViz1MnJ9kfJCDqE9efhlQZ71DU2nRwGj+qYQUjneg
         JJKI+fyhIAM9VuCpfYBclRYaM4kBRIYKnrPa/QdpyCL+/oJIoeiTlII6RWGTDTGO6jSz
         CrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=IrDX84KRZKsKpKj5DTV5f5ssGpOVWEQyjPMtbK6Ke8A=;
        b=rdXDWHBH6hTl0Usg+iP08yVIoCLEbZHHGqKSosnTQaDoCk2s9QSUtgFVDdm+t3jchI
         dHkO0epDuXsYVNTU1BTPapN5PdbNA8On8jjr8h1+bxDo/Uy5X/PlGF0+JqN+Wdm2180U
         J/xQZB357gaW+o6AZWZ01vVY0lc7eM9glWqPNv1ONMbZmk3MdfbMMoErk7u1EFAsqYMQ
         pLXCST0/1D4t+hV/+EeENL4O2zS1Y6XP5co9XJIEqzmAdA1DnSVdC9Ef8tzSx20RRkAY
         GzBB9ZEn1eVpcjl8Y0Uslj5KJZwXzvq8Io3c4ahYo4eH1X5dN5RG9A/Z7q7vJTzTIwvL
         zR3g==
X-Gm-Message-State: AJIora9ZotyhwQDYP6X6p95IamaUQIjKU9YDsfU6qk5xwCj83Lg4E38M
        AP81V9UVANLDTp1xVgJSo4oxpg==
X-Google-Smtp-Source: AGRyM1t4qhGVRUSo5Yi2KBjSfewDtU8fqoe/ghv2WmySeGa5w7DTYMfuejGUYIAAxO0iPFNbjS9+jw==
X-Received: by 2002:a17:90b:4cd0:b0:1ec:b260:db49 with SMTP id nd16-20020a17090b4cd000b001ecb260db49mr21712701pjb.193.1656419712969;
        Tue, 28 Jun 2022 05:35:12 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a17-20020aa78e91000000b005251e8d8b73sm9326415pfr.131.2022.06.28.05.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 05:35:12 -0700 (PDT)
Message-ID: <a8427658-4b9f-5486-433e-21c636030e6a@kernel.dk>
Date:   Tue, 28 Jun 2022 06:35:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: fully tear down the queue in del_gendisk
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
References: <20220619060552.1850436-1-hch@lst.de>
 <67dd8d1c-658c-8833-9630-79ade736b348@kernel.dk>
 <20220620060948.GA10485@lst.de>
 <1e3f054e-eec6-be87-7039-e2b4260addc2@kernel.dk>
 <20220628051139.GA22701@lst.de>
 <bb56a578-741a-6eb4-a66f-3c774d0a24da@kernel.dk>
In-Reply-To: <bb56a578-741a-6eb4-a66f-3c774d0a24da@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/28/22 6:29 AM, Jens Axboe wrote:
> On 6/27/22 11:11 PM, Christoph Hellwig wrote:
>> On Mon, Jun 20, 2022 at 05:16:03AM -0600, Jens Axboe wrote:
>>> On 6/20/22 12:09 AM, Christoph Hellwig wrote:
>>>> On Sun, Jun 19, 2022 at 04:21:39PM -0600, Jens Axboe wrote:
>>>>> On 6/19/22 12:05 AM, Christoph Hellwig wrote:
>>>>>> Note that while intended or 5.20, this series is generated against the
>>>>>> block-5.19 branch as that contains fixes in this area that haven't
>>>>>> made it to the for-5.10/block branch yet.
>>>>>
>>>>> Side note - I rebased on -rc3 anyway because of the series that went
>>>>> into -rc2, so we should be fine there.
>>>>
>>>> It depends on elevator/debugfs teardown series that has not made it
>>>> into -rc3.
>>>
>>> Guess we'll rebase for -rc4 again...
>>
>> As you'd done that, can you consider this series now?
> 
> It doesn't apply cleanly. I'll check if it's something minor...

Minor thing in xen-blkfront for the last patch, hand edited the patch:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.20/block&id=8b9ab62662048a3274361c7e5f64037c2c133e2c

-- 
Jens Axboe

