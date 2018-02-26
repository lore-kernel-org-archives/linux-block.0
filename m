Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41110 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751586AbeBZSYi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Feb 2018 13:24:38 -0500
Received: by mail-lf0-f65.google.com with SMTP id m69so23649303lfe.8
        for <linux-block@vger.kernel.org>; Mon, 26 Feb 2018 10:24:37 -0800 (PST)
Subject: Re: [PATCH V3 00/19] lightnvm: pblk: implement 2.0 support
To: Javier Gonzalez <javier@cnexlabs.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
 <93f1a727-55bf-ff7c-bc05-70cc9f5f9f27@lightnvm.io>
 <87859168-A64E-4FF6-9F7E-174A903704D0@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <398381af-7c17-4e57-1d07-f50051c05430@lightnvm.io>
Date: Mon, 26 Feb 2018 19:24:34 +0100
MIME-Version: 1.0
In-Reply-To: <87859168-A64E-4FF6-9F7E-174A903704D0@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/26/2018 07:21 PM, Javier Gonzalez wrote:
>> On 26 Feb 2018, at 19.19, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 02/26/2018 02:16 PM, Javier González wrote:
>>> # Changes since V2:
>>> Apply Matias' feedback:
>>>   - Remove generic nvm_id identify structure.
>>>   - Do not remap capabilities (cap) to media and controlled capabilities
>>>     (mccap). Instead, add a comment to prevent confusion when
>>>     crosschecking with 2.0 spec.
>>>   - Change maxoc and maxocpu defaults from 1 block to the max number of
>>>     blocks.
>>>   - Re-implement the generic geometry to use nvm_geo on both device and
>>>     targets. Maintain nvm_common_geo to make it easier to copy the common
>>>     part of the geometry (without having to overwrite target-specific
>>>     fields, which is ugly and error prone). Matias, if you still want to
>>>     get rid of this, we can do it.
>>
>> I do, the variables should go directly in nvm_geo. Thanks.
> 
> Ok. Is the rest ok with you?
>
I'll go through it when the rebase is posted. Most of the patches is 
dependent on the first patch.
