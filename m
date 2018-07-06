Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:38934 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933517AbeGFRpV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jul 2018 13:45:21 -0400
Received: by mail-qk0-f194.google.com with SMTP id b5-v6so4733969qkg.6
        for <linux-block@vger.kernel.org>; Fri, 06 Jul 2018 10:45:21 -0700 (PDT)
Message-ID: <1530899118.31977.1.camel@redhat.com>
Subject: Re: [PATCH 0/2] null_blk: zone support
From: Laurence Oberman <loberman@redhat.com>
To: Matias =?ISO-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>, axboe@fb.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bart.vanassche@wdc.com, damien.lemoal@wdc.com
Date: Fri, 06 Jul 2018 13:45:18 -0400
In-Reply-To: <20180706173839.28355-1-mb@lightnvm.io>
References: <20180706173839.28355-1-mb@lightnvm.io>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2018-07-06 at 19:38 +0200, Matias Bjørling wrote:
> This series adds support for exposing a zone block device using the
> null_blk device driver.
> 
> The first patch moves core null_blk data structures to a shared
> header
> file. The second implements the actual zone support. The patchset
> adds
> two new options. One to enable the zone interface, and another to
> define the size of the zones to expose.
> 
> Thanks,
> Matias
> 
> Matias Bjørling (2):
>   null_blk: move shared definitions to header file
>   null_blk: add zone support
> 
>  Documentation/block/null_blk.txt |   7 ++
>  drivers/block/Makefile           |   5 +-
>  drivers/block/null_blk.c         | 124 ++++++++++++-----------------
> ---
>  drivers/block/null_blk.h         | 108 ++++++++++++++++++++++++++++
>  drivers/block/null_blk_zoned.c   | 149
> +++++++++++++++++++++++++++++++++++++++
>  5 files changed, 315 insertions(+), 78 deletions(-)
>  create mode 100644 drivers/block/null_blk.h
>  create mode 100644 drivers/block/null_blk_zoned.c
> 

Thank you for this will be very useful.
I will test it to add value.
I dont know the code well enough to review it
Regards
Laurence
