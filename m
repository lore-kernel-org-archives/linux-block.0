Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f53.google.com ([209.85.160.53]:40829 "EHLO
        mail-pl0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeCNTJi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Mar 2018 15:09:38 -0400
Received: by mail-pl0-f53.google.com with SMTP id ay1-v6so2242743plb.7
        for <linux-block@vger.kernel.org>; Wed, 14 Mar 2018 12:09:38 -0700 (PDT)
Subject: Re: [PATCH v7 8/9] bcache: add io_disable to struct cached_dev
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Junhui Tang <tang.junhui@zte.com.cn>
References: <20180227165557.20442-1-colyli@suse.de>
 <20180227165557.20442-9-colyli@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <91ef62e7-1a59-8c5c-1347-ebb28a56f285@lyle.org>
Date: Wed, 14 Mar 2018 12:09:36 -0700
MIME-Version: 1.0
In-Reply-To: <20180227165557.20442-9-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/27/2018 08:55 AM, Coly Li wrote:
> If a bcache device is configured to writeback mode, current code does not
> handle write I/O errors on backing devices properly.
> 
> In writeback mode, write request is written to cache device, and
> latter being flushed to backing device. If I/O failed when writing from
> cache device to the backing device, bcache code just ignores the error and
> upper layer code is NOT noticed that the backing device is broken.

lgtm, applied
