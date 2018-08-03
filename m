Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41204 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbeHCOdx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Aug 2018 10:33:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id v22-v6so3936425lfe.8
        for <linux-block@vger.kernel.org>; Fri, 03 Aug 2018 05:37:44 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: move device L2P detection to core
To: javier@cnexlabs.com
Cc: igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180803085449.3436-1-mb@lightnvm.io>
 <31319710-8A72-49DC-9CFA-521CA06843F3@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <9349be00-4d14-9b25-ed11-fb9244428d7f@lightnvm.io>
Date: Fri, 3 Aug 2018 14:37:41 +0200
MIME-Version: 1.0
In-Reply-To: <31319710-8A72-49DC-9CFA-521CA06843F3@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 08/03/2018 02:16 PM, Javier Gonzalez wrote:
>> On 3 Aug 2018, at 10.54, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> A 1.2 device is able to manage the logical to physical mapping
>> table internally or leave it to the host.
>>
>> A target only supports one of those approaches, and therefore must
>> check on initialization. Move this check to core to avoid each target
>> implement the check.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
> 
> 
> I see where you want to go with these changes, but the way targets are
> layered on top of the LightNVM subsystem does not align with it.
> LightNVM can support different OCSSD versions and capabilities, but that
> does not mean that a target (e.g., pblk) does. The way I see it, core
> should only check for (i) the drive to expose itself in a known revision
> and (ii) the reported structures to be consistent. However, specific
> functionality is not for core to check upo.

Why try to initialize a target, if we already know that it is incompatible?
