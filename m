Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36D7C4338F
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 11:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41F760F37
	for <linux-block@archiver.kernel.org>; Mon, 26 Jul 2021 11:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhGZK4v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jul 2021 06:56:51 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:33679 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhGZK4u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jul 2021 06:56:50 -0400
Received: by mail-qt1-f173.google.com with SMTP id b1so6811231qtx.0;
        Mon, 26 Jul 2021 04:37:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ou6g7ULdPAc17oghO1CMeF4ayldg09pZ1OB9dj1bTYQ=;
        b=OapUGS4AgiYBAwCAY+q4FKVDQA2lG7jVv1v72W7KG0lSkH/68h0lfKIOcP0aZlLTN4
         oFg9HU0qyGkuZG879Y6poGJRVFhcN8Y/WM+HAbADBoHWpb/peNLVS6NnDRqeiGSIo6nU
         1lY9sUfUFDSHHkgtTjuY0qfUQ4C+FSyFfPB8NYpQS3rWs1byVGuoEEzWv+UDXMugEnfN
         hv4ymZfQl3UbRfPl3ckI+ldF7ExQljefpAKYoixj22otfcRjrhfzTa09oirXASbzmnab
         bIyZ/Vi/hh2gckEXQe9EBaXXaip7TsoPMdUCpVbVbiaUi97gQCY2XyyNTkLrwnk/WMwq
         ajIw==
X-Gm-Message-State: AOAM531AS2FV61SQJDf/TUJBub4c06Iy77pnmFCFigN19dAAbCfL4U+g
        Wc88GicDOGEt4MsqheVzzPk=
X-Google-Smtp-Source: ABdhPJzIVvhP3UemJXGFswcqA0gxGDaztqVkCGxlsiIWY8HMwJrOr+6qohH87lFBt6Zgr3l78oO1nA==
X-Received: by 2002:a05:622a:1112:: with SMTP id e18mr14761402qty.17.1627299434833;
        Mon, 26 Jul 2021 04:37:14 -0700 (PDT)
Received: from [192.168.140.89] ([46.175.31.194])
        by smtp.gmail.com with ESMTPSA id f11sm15194435qtp.85.2021.07.26.04.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 04:37:14 -0700 (PDT)
Subject: Re: [BUG] FLOPPY DRIVER since 5.10.20
To:     dmarkh@cfl.rr.com, markh@compro.net, linux-block@vger.kernel.org,
        Linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jkosina@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <de10cb47-34d1-5a88-7751-225ca380f735@compro.net>
 <e49603c2-ac36-12b0-57cf-ff5ab30115bc@linux.com>
 <f5501a7c-4387-259d-66d2-f10db0cf36ff@cfl.rr.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <f1277dcb-6bf8-b149-ad4e-68a4109d4e67@linux.com>
Date:   Mon, 26 Jul 2021 14:37:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <f5501a7c-4387-259d-66d2-f10db0cf36ff@cfl.rr.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 7/26/21 2:17 PM, Mark Hounschell wrote:
> On 7/26/21 3:57 AM, Denis Efremov wrote:
>> Hi,
>>
>> On 7/23/21 9:47 PM, Mark Hounschell wrote:
>>>
>>> These 2 incremental patches, patch-5.10.19-20 and patch-5.11.2-3 have broken the user land fd = open("/dev/fd0", (O_RDWR | O_NDELAY)); functionality.
>>
>> Thank you for the report, I'm looking into this.
>>
>>> Since FOREVER before the patch, when using O_NDELAY, one could open the floppy device with no media inserted or even with write protected media without error. "Read-only file system" status is returned only when we actually tried to write to it. We have software still in use today that relies on this functionality.
>>
>> If it's a project with open sources could you please give a link?
>>
>> Regards,
>> Denis
>>
> This is immaterial but fdutils and libdsk both use rely on this flag. Who can know who else does. The point is it should NOT have been changed.

Yes, I asked this only to add utils and this behavior to the tests.
And be more specific about why we should preserve this behavior in
next commit messages.

Denis
