Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f41.google.com ([74.125.83.41]:39779 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeCPSvA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Mar 2018 14:51:00 -0400
Received: by mail-pg0-f41.google.com with SMTP id e3so4409139pga.6
        for <linux-block@vger.kernel.org>; Fri, 16 Mar 2018 11:51:00 -0700 (PDT)
Subject: Re: [PATCH 04/16] bcache: Fix kernel-doc warnings
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-bcache <linux-bcache@vger.kernel.org>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-5-bart.vanassche@wdc.com>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <2694ea85-7567-1224-55b6-838d1644e4c7@lyle.org>
Date: Fri, 16 Mar 2018 11:50:57 -0700
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-5-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/15/2018 08:08 AM, Bart Van Assche wrote:
> Avoid that building with W=1 triggers warnings about the kernel-doc
> headers.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

LGTM, applying.
