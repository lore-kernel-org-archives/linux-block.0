Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35730 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936362AbcKWMQR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2016 07:16:17 -0500
Received: by mail-wm0-f52.google.com with SMTP id a197so75283015wmd.0
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2016 04:16:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH 0/8] lightnvm: simplify media manager V2
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <jg@lightnvm.io>
In-Reply-To: <a61ef190-d698-d388-55e0-3f406f6181b9@lightnvm.io>
Date: Wed, 23 Nov 2016 13:08:06 +0100
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <AF90E9BB-7E1E-45A8-B6D9-A66976E477D8@lightnvm.io>
References: <1479730237-20797-1-git-send-email-javier@cnexlabs.com>
 <a61ef190-d698-d388-55e0-3f406f6181b9@lightnvm.io>
To: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

> On 23 Nov 2016, at 13.06, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 11/21/2016 01:10 PM, Javier Gonz=C3=A1lez wrote:
>> V2:
>>  - Fix 2 bad memory free on error rrpc init error handling. Reported =
by
>>    kbuild.
>>=20
>> This patchset simplifies the generic media manager interface and =
moves
>> lun and block functionality to lightnvm targets. This makes that
>> rrpc-specific functionality is not exposed on the media manager. This =
is
>> done in preparation for the pblk target.
>>=20
>> Javier Gonz=C3=A1lez (8):
>>  lightnvm: move block provisioning to targets
>>  lightnvm: remove get_lun operation on gennvm
>>  lightnvm: remove debug lun statistics from gennvm
>>  lightnvm: eliminate nvm_block abstraction on mm
>>  lightnvm: eliminate nvm_lun abstraction in mm
>>  lightnvm: introduce helpers for generic ops in rrpc
>>  lightnvm: introduce max_phys_sects helper function
>>  lightnvm: use target nvm on target-specific ops.
>>=20
>> drivers/lightnvm/core.c      | 154 ++++++-----
>> drivers/lightnvm/gennvm.c    | 612 =
++++++++++++++++++++-----------------------
>> drivers/lightnvm/gennvm.h    |  20 +-
>> drivers/lightnvm/rrpc.c      | 443 +++++++++++++++++++++----------
>> drivers/lightnvm/rrpc.h      |  62 ++++-
>> drivers/lightnvm/sysblk.c    |  65 +++--
>> drivers/nvme/host/lightnvm.c |  14 +-
>> include/linux/lightnvm.h     | 217 +++++++--------
>> 8 files changed, 885 insertions(+), 702 deletions(-)
>=20
> Thanks Javier. Picked up for 4.10. Please note I fixed up an
> initialization bug with null_blk device in the "lightnvm: introduce
> helpers for generic ops in rrpc" patch.

Great. Thanks!

Javier=
