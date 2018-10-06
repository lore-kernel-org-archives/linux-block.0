Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44876 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbeJFIOi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Oct 2018 04:14:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id z21-v6so8677035edb.11
        for <linux-block@vger.kernel.org>; Fri, 05 Oct 2018 18:13:20 -0700 (PDT)
Subject: Re: [V2 PATCH 0/2] lightnvm: pblk: retrieve chunk metadata on erase
To: javier@javigon.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <afc7d53c-b514-293d-f876-f2bdaa3c5dbb@lightnvm.io>
Date: Sat, 6 Oct 2018 03:13:17 +0200
MIME-Version: 1.0
In-Reply-To: <1538637235-25469-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 10/04/2018 09:13 AM, Javier González wrote:
> Changes singe V1:
>    - remove sanity checks on the fast path
> 
> This patchset implements support for retrieving chunk metadata on reset.
> This is the base for implementing wear-leveling and allowing chunks to
> shrink at runtime.
> 
> Javier
> 
> Javier González (2):
>    lightnvm: pblk: add helper for printing chunk state
>    lightnvm: pblk: retrieve chunk metadata on erase
> 
>   drivers/lightnvm/core.c      | 44 ++++++++++++++++++++++++++++++++++--
>   drivers/lightnvm/pblk-core.c | 54 +++++++++++++++++++++++++++++++++-----------
>   drivers/lightnvm/pblk.h      |  9 ++++++++
>   3 files changed, 92 insertions(+), 15 deletions(-)
> 

Right now there isn't a way in the spec to tell if the drive supports 
this feature or not, and DSM Reset doesn't support it either. Making it 
a bug in the spec. Until the updated spec is out, I like to avoid adding 
this feature into the kernel.

The Get Log Page approach can be used for wear-levelling information. 
Similarly for knowing when a chunk shrink, pblk can't rely on a chunk 
not shrinking at runtime (and reporting early close error), so in the 
case this happens, pblk can either continue business as usual, or resync 
with the drive.
