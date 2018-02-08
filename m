Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38826 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751574AbeBHJms (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Feb 2018 04:42:48 -0500
Received: by mail-lf0-f65.google.com with SMTP id g72so5506193lfg.5
        for <linux-block@vger.kernel.org>; Thu, 08 Feb 2018 01:42:47 -0800 (PST)
Subject: Re: [PATCH 0/4] lightnvm: base 2.0 implementation
To: Javier Gonzalez <javier@cnexlabs.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180205121505.27563-1-mb@lightnvm.io>
 <DA4E2087-F1E8-4903-9B53-95CFECD6B868@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <8b50ed33-226a-760a-e888-51ff573b9557@lightnvm.io>
Date: Thu, 8 Feb 2018 10:42:44 +0100
MIME-Version: 1.0
In-Reply-To: <DA4E2087-F1E8-4903-9B53-95CFECD6B868@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/08/2018 10:35 AM, Javier Gonzalez wrote:
>> On 5 Feb 2018, at 13.15, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> Hi,
>>
>> A couple of patches for 2.0 support for the lightnvm subsystem. They
>> form the basis for integrating 2.0 support.
>>
>> For the rest of the support, Javier has code that implements report
>> chunk and sets up the LBA format data structure. He also has a bunch
>> of patches that brings pblk up to speed.
>>
>> The first two patches is preparation for the 2.0 work. The third patch
>> implements the 2.0 data structures, the geometry command, and exposes
>> the sysfs attributes that comes with the 2.0 specification. Note that
>> the attributes between 1.2 and 2.0 are different, and it is expected
>> that user-space shall use the version sysfs attribute to know which
>> attributes will be available.
>>
>> The last patch implements support for using the nvme namespace logical
>> block and metadata fields and sync it with the internal lightnvm
>> identify structures.
>>
>> -Matias
>>
>> Matias Bjørling (4):
>>   lightnvm: make 1.2 data structures explicit
>>   lightnvm: flatten nvm_id_group into nvm_id
>>   lightnvm: add 2.0 geometry identification
>>   nvme: lightnvm: add late setup of block size and metadata
>>
>> drivers/lightnvm/core.c      |  27 ++-
>> drivers/nvme/host/core.c     |   2 +
>> drivers/nvme/host/lightnvm.c | 508 ++++++++++++++++++++++++++++++++-----------
>> drivers/nvme/host/nvme.h     |   2 +
>> include/linux/lightnvm.h     |  64 +++---
>> 5 files changed, 426 insertions(+), 177 deletions(-)
>>
>> --
>> 2.11.0
> 
> Thanks for posting these. I have started rebasing my patches on top of
> the new geometry - it is a bit different of how I implemented it, but
> I'll take care of it.
> 
> I'll review as I go - some of the changes I have might make sense to
> squash in your patches to keep a clean history...
> 

Thanks.

> I'll add a couple of patches abstracting the geometry so that at core.c
> level we only work with a single geometry structure. This is they way it
> is done in the early patches I pointe you to before. Then it is patches
> building bottom-up support for the new features in 2.0.
> 

Yep, I was expecting that. I skipped that part since it went into pblk 
and you already had some patches for it.

> Javier
> 
