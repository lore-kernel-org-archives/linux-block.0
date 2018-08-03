Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42290 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbeHCOkO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Aug 2018 10:40:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1-v6so4803372ljc.9
        for <linux-block@vger.kernel.org>; Fri, 03 Aug 2018 05:44:02 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: move device L2P detection to core
To: javier@cnexlabs.com
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180803085449.3436-1-mb@lightnvm.io>
 <31319710-8A72-49DC-9CFA-521CA06843F3@cnexlabs.com>
 <9349be00-4d14-9b25-ed11-fb9244428d7f@lightnvm.io>
 <C29BF7B1-4C9A-47C7-9E5F-AD63356B01BC@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <56562d7c-8deb-4597-4274-5a55ec9327f7@lightnvm.io>
Date: Fri, 3 Aug 2018 14:43:59 +0200
MIME-Version: 1.0
In-Reply-To: <C29BF7B1-4C9A-47C7-9E5F-AD63356B01BC@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/03/2018 02:40 PM, Javier Gonzalez wrote:
>> On 3 Aug 2018, at 14.37, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> On 08/03/2018 02:16 PM, Javier Gonzalez wrote:
>>>> On 3 Aug 2018, at 10.54, Matias Bjørling <mb@lightnvm.io> wrote:
>>>>
>>>> A 1.2 device is able to manage the logical to physical mapping
>>>> table internally or leave it to the host.
>>>>
>>>> A target only supports one of those approaches, and therefore must
>>>> check on initialization. Move this check to core to avoid each target
>>>> implement the check.
>>>>
>>>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>>>> ---
>>> I see where you want to go with these changes, but the way targets are
>>> layered on top of the LightNVM subsystem does not align with it.
>>> LightNVM can support different OCSSD versions and capabilities, but that
>>> does not mean that a target (e.g., pblk) does. The way I see it, core
>>> should only check for (i) the drive to expose itself in a known revision
>>> and (ii) the reported structures to be consistent. However, specific
>>> functionality is not for core to check upo.
>>
>> Why try to initialize a target, if we already know that it is incompatible?
> 
> Yes, that is my point. But the one who knows if the targets supports
> something or not is the target, not the subsystem. Here, you are making
> an assumption knowing the pblk requires the L2P on the host, but that
> could change in the future...
> 

I don't believe it can. It is not supported by the 2.0 specification. 
1.2 is legacy.

I understand this from the perspective when checking for un-even 
configurations using the geometry. But this is a spec incompatibility, 
which I don't think the target should care about.
