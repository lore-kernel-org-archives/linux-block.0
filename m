Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:1849 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbeH2Ss3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Aug 2018 14:48:29 -0400
Subject: Re: [PATCH 0/3] lightnvm: pblk: support variable OOB size
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
        mb@lightnvm.io
Cc: marcin.dziegielewski@intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
References: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
From: Igor Konopko <igor.j.konopko@intel.com>
Message-ID: <106d492e-4f09-7af5-d89a-75c204f3da38@intel.com>
Date: Wed, 29 Aug 2018 16:51:06 +0200
MIME-Version: 1.0
In-Reply-To: <1535537370-10729-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org



On 29.08.2018 12:09, Javier González wrote:
> This patchset adds pblk support for variable metadata sizes on the out
> of bound area.
> 
> Igor, Marcin, you sent a patch some time ago implementing a similar
> functionality, but it never got re-posted after review. Can you test
> this and see if it works for your case? I did not implement support for
> outlined metadata for the case where the reported OOB area is 0. It
> should be pretty simple to do that on top of these patches though.
> 

Sure, we will test that and let you know. I was busy last time and due 
to that I never repost it. I will do this on top of your patches, 
hopefully soon.

> Thanks,
> Javier
> 
> Javier González (3):
>    lightnvm: use internal allocation for chunk log page
>    lightnvm: do no update csecs and sos on 1.2
>    lightnvm: pblk: support variable OOB size
> 
>   drivers/lightnvm/pblk-core.c     | 60 ++++++++++++++++++++++++++++++----------
>   drivers/lightnvm/pblk-init.c     | 16 ++++++++++-
>   drivers/lightnvm/pblk-map.c      | 19 +++++++++----
>   drivers/lightnvm/pblk-read.c     | 55 ++++++++++++++++++++++--------------
>   drivers/lightnvm/pblk-recovery.c | 34 ++++++++++++++++-------
>   drivers/lightnvm/pblk.h          | 18 +++++++++---
>   drivers/nvme/host/lightnvm.c     | 26 +++++++++++------
>   7 files changed, 164 insertions(+), 64 deletions(-)
> 
