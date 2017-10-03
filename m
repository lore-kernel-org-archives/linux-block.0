Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:51755 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751882AbdJCNxq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2017 09:53:46 -0400
Received: by mail-vk0-f54.google.com with SMTP id 137so2080574vkk.8
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2017 06:53:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6EA9CAAC-795C-47E9-AB08-35B4B9D9BC39@lightnvm.io>
References: <1507025113-13351-1-git-send-email-hans.ml.holmberg@owltronix.com> <6EA9CAAC-795C-47E9-AB08-35B4B9D9BC39@lightnvm.io>
From: Hans Holmberg <hans@owltronix.com>
Date: Tue, 3 Oct 2017 15:53:45 +0200
Message-ID: <CANr-nt3O=hVWq+KuawvD1nTtq8qoTjAOkz8ciMh7S1CVWvcE0w@mail.gmail.com>
Subject: Re: [PATCH 0/9] recovery robustness improvements
To: =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
Cc: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Cheers!

Thanks,
Hans

On Tue, Oct 3, 2017 at 12:51 PM, Javier Gonz=C3=A1lez <jg@lightnvm.io> wrot=
e:
>> On 3 Oct 2017, at 12.05, Hans Holmberg <hans.ml.holmberg@owltronix.com> =
wrote:
>>
>> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>
>> This patchset improves the robustness of recovery - fixing a bunch of
>> issues that occurs when removing and re-creating a pblk instance.
>> It also adds a couple of debug-only prints to facilitate detection
>> of L2P table corruptions.
>>
>> The patches apply on top of:
>> https://github.com/OpenChannelSSD/linux branch for-4.15/pblk
>>
>> Hans Holmberg (9):
>>  lightnvm: pblk: prevent gc kicks when gc is not operational
>>  lightnvm: pblk: recover partially written lines correctly
>>  lightnvm: pblk: free full lines during recovery
>>  lightnvm: pblk: start gc if needed during init
>>  lightnvm: pblk: consider bad sectors in emeta during recovery
>>  lightnvm: pblk: shut down gc gracefully during exit
>>  lightnvm: pblk: add l2p crc debug printouts
>>  lightnvm: pblk: gc all lines in the pipeline before exit
>>  lightnvm: pblk: correct valid lba count calculation
>>
>> drivers/lightnvm/pblk-core.c     |  3 ++
>> drivers/lightnvm/pblk-gc.c       | 88 +++++++++++++++++++++++++++-------=
------
>> drivers/lightnvm/pblk-init.c     | 47 ++++++++++++++++++---
>> drivers/lightnvm/pblk-map.c      |  7 ++--
>> drivers/lightnvm/pblk-recovery.c | 46 ++++++++++++++-------
>> drivers/lightnvm/pblk-sysfs.c    |  2 +-
>> drivers/lightnvm/pblk.h          |  6 ++-
>> 7 files changed, 145 insertions(+), 54 deletions(-)
>>
>> --
>> 2.7.4
>
> Thanks Hans.
>
> Matias: I picked the patches on for-4.15/pblk on top of the rest of the
> series and fixed some of the commit messages. Also, note that Rakesh's
> patches needed some re-work, so please pick them from this tree instead.
>
> They should apply clean on your for-4.15/core.
>
> Thanks,
> Javier
