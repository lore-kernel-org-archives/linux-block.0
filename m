Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:40796 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbdKQEC6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Nov 2017 23:02:58 -0500
Received: by mail-pg0-f51.google.com with SMTP id u3so994040pgn.7
        for <linux-block@vger.kernel.org>; Thu, 16 Nov 2017 20:02:58 -0800 (PST)
Subject: Re: [PATCH] bcache: recover data from backing device when read
 request hit clean
To: Rui Hua <huarui.dev@gmail.com>, Coly Li <i@coly.li>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <CAPGwLLNwG+kLT9_QaCL5PBLS0a6K-x-iog+ON2pArUQWr1rWTg@mail.gmail.com>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <1c715cc2-b656-36a8-4017-55052937df82@lyle.org>
Date: Thu, 16 Nov 2017 20:02:55 -0800
MIME-Version: 1.0
In-Reply-To: <CAPGwLLNwG+kLT9_QaCL5PBLS0a6K-x-iog+ON2pArUQWr1rWTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi, Rui Hua--

On 11/16/2017 07:51 PM, Rui Hua wrote:
> In this patch, we use s->read_dirty_data to judge whether the read
> request hit dirty data in cache device, it is safe to reread data from
> the backing device when the read request hit clean data. This can not
> only handle cache read race, but also recover data when failed read
> request from cache device.

I haven't read over all of this yet, to understand the read race.  But
this change can't be safe-- read_dirty_data only is set to true if the
metadata on the cache device is correctly read.  If that fails, the flag
may not be set and we could read stale data on the backing device.

Mike
