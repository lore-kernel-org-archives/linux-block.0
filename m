Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34184 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751621AbdG2T5V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Jul 2017 15:57:21 -0400
Received: by mail-vk0-f45.google.com with SMTP id n125so24835172vke.1
        for <linux-block@vger.kernel.org>; Sat, 29 Jul 2017 12:57:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1501258623.2413.3.camel@wdc.com>
References: <149245612770.10206.15496018295337908594.stgit@dwillia2-desk3.amr.corp.intel.com>
 <149245618859.10206.13182319600260215993.stgit@dwillia2-desk3.amr.corp.intel.com>
 <1501258623.2413.3.camel@wdc.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sat, 29 Jul 2017 12:57:19 -0700
Message-ID: <CAPcyv4hc9zBHYtXrzS1XP514dMPcjBxjaSwRnPD8zUig1kCKnA@mail.gmail.com>
Subject: Re: [resend PATCH v2 11/33] dm: add dax_device and dax_operations support
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "toshi.kani@hpe.com" <toshi.kani@hpe.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 28, 2017 at 9:17 AM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Mon, 2017-04-17 at 12:09 -0700, Dan Williams wrote:
>> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
>> index b7767da50c26..1de8372d9459 100644
>> --- a/drivers/md/Kconfig
>> +++ b/drivers/md/Kconfig
>> @@ -200,6 +200,7 @@ config BLK_DEV_DM_BUILTIN
>>  config BLK_DEV_DM
>>       tristate "Device mapper support"
>>       select BLK_DEV_DM_BUILTIN
>> +     select DAX
>>       ---help---
>>         Device-mapper is a low level volume manager.  It works by allowing
>>         people to specify mappings for ranges of logical sectors.  Various
>
> (replying to an e-mail of three months ago)
>
> Hello Dan,
>
> While building a v4.12 kernel I noticed that enabling device mapper support
> now unconditionally enables DAX. I think there are plenty of systems that use
> dm but do not need DAX. Have you considered to rework this such that instead
> of dm selecting DAX that DAX support is only enabled in dm if CONFIG_DAX is
> enabled?
>

I'd rather flip this around and add a CONFIG_DM_DAX that gates whether
DM enables / links to the DAX core. I'll take a look at a patch.
