Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46140 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935346AbeEXISw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 May 2018 04:18:52 -0400
Received: by mail-pg0-f67.google.com with SMTP id a3-v6so432818pgt.13
        for <linux-block@vger.kernel.org>; Thu, 24 May 2018 01:18:52 -0700 (PDT)
Subject: Re: [PATCH 0/3] lightnvm: Error paths handling
To: Igor Konopko <igor.j.konopko@intel.com>
Cc: linux-block@vger.kernel.org, marcin.dziegielewski@intel.com
References: <20180523122956.24137-1-igor.j.konopko@intel.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <6228b2a5-fc4b-ede8-83fd-0613283961c3@lightnvm.io>
Date: Thu, 24 May 2018 10:18:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180523122956.24137-1-igor.j.konopko@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/23/2018 02:29 PM, Igor Konopko wrote:
> This patchset provides a proper handling for some of the errors which
> are not gracefully handled right now.
> 
> Igor Konopko (3):
>    lightnvm: Proper error handling for pblk_bio_add_pages
>    lightnvm: Handling when whole line is bad
>    lightnvm: Fix partial read error path
> 
>   drivers/lightnvm/pblk-core.c | 10 ++++++++--
>   drivers/lightnvm/pblk-read.c |  8 ++++----
>   2 files changed, 12 insertions(+), 6 deletions(-)
> 

Thanks Igor! Applied for 4.18.
