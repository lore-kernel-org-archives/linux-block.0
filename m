Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41931 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933746AbeCGROr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Mar 2018 12:14:47 -0500
Received: by mail-pg0-f66.google.com with SMTP id q27so1113241pgn.8
        for <linux-block@vger.kernel.org>; Wed, 07 Mar 2018 09:14:47 -0800 (PST)
Subject: Re: [PATCH v2] bcache: move closure debug file into debug direcotry
To: Chengguang Xu <cgxu519@gmx.com>, tang.junhui@zte.com.cn,
        kent.overstreet@gmail.com
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <1520393001-157614-1-git-send-email-cgxu519@gmx.com>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <3062881a-7548-1986-d8f7-dc1b9599c61b@lyle.org>
Date: Wed, 7 Mar 2018 09:14:44 -0800
MIME-Version: 1.0
In-Reply-To: <1520393001-157614-1-git-send-email-cgxu519@gmx.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/06/2018 07:23 PM, Chengguang Xu wrote:
> In current code closure debug file is outside of debug directory
> and when unloading module there is lack of removing operation
> for closure debug file, so it will cause creating error when trying
> to reload  module.
> 
> This patch move closure debug file into "bcache" debug direcory
> so that the file can get deleted properly.
> 
> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>

Thanks!  This looks much better and is applied.

Mike
