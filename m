Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42990 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbeHEUpN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Aug 2018 16:45:13 -0400
Received: by mail-ed1-f65.google.com with SMTP id r4-v6so4008917edp.9
        for <linux-block@vger.kernel.org>; Sun, 05 Aug 2018 11:39:45 -0700 (PDT)
Subject: Re:bcache-tools repo?
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <20180315104240.24647-1-colyli@suse.de>
From: Rolf Fokkens <rolf@rolffokkens.nl>
Message-ID: <a0f8c2c5-6717-36d7-7ee8-ee1720eef268@rolffokkens.nl>
Date: Sun, 5 Aug 2018 20:39:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180315104240.24647-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

I'm the maintainer of the bcache-tools package for Fedora, and bcache 
tools has been quiet for a while so I wasn't paying attention. But I 
accidentally noticed there's stuff going on again with bcache tools. I 
did a quick search in the mail archives to see where the new 
bcache-tools git repository is (I think 
https://bcache.evilpiepirate.org/ doesn't point in the right direction), 
and I'm not able to find it.

Could anybody point me to the git repo that contains the latest 
bcache-tools?

Thanks!

Rolf

On 03/15/2018 11:42 AM, Coly Li wrote:
> Recently I recieve a bug report that bcache does not work on IBM s390x,
> I find the problem is from endianness support and checksum calculation.
>
> Both user space tools and Linux kernel code should be fixed, this patch
> set is the modification to user space tools.
>
> Ideas of this patch set are,
> 1, super block members should be swapped to little endian before writting
>     down to media.
> 2, super block members should be explicitly swapped to little endian
>     before calculate checksum.
> 3, checksum also should be swapped to little endian before writiting down
>     to media.
> 4, checksum is checked before super block members being swapped into CPU
>     byteorder.
>
> The first 3 patches are preparation and the last patch does big endian
> support.
>
> NOTE: Linux kernel code also needs to be patched, this patch set just
> makes new created bcache devices in a correct byte order.
>
> Coly Li
> ---
>
> Coly Li (4):
>    bcache-tools: change bcache.c:crc64() to non-inline function
>    bcache-tools: only set/display sb.bucket_size for cache devices
>    bcache-tools: print more super block information in bcache-super-show
>    bcache-tools: add CPU endianness support
>
>   bcache-super-show.c | 52 +++++++++++++++++++++-----------
>   bcache.c            | 75 ++++++++++++++++++++++++++++++++++++++++++++-
>   bcache.h            | 19 +++++++++---
>   byteorder.h         | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>   make-bcache.c       |  5 +--
>   5 files changed, 212 insertions(+), 26 deletions(-)
>   create mode 100644 byteorder.h
>
