Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41891 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbeCPSvv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Mar 2018 14:51:51 -0400
Received: by mail-pf0-f193.google.com with SMTP id f80so4490405pfa.8
        for <linux-block@vger.kernel.org>; Fri, 16 Mar 2018 11:51:51 -0700 (PDT)
Subject: Re: [PATCH 03/16] bcache: Annotate switch fall-through
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-bcache <linux-bcache@vger.kernel.org>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-4-bart.vanassche@wdc.com>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <6b450db5-c8b4-7c54-026e-52316494b1a4@lyle.org>
Date: Fri, 16 Mar 2018 11:51:49 -0700
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-4-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/15/2018 08:08 AM, Bart Van Assche wrote:
> This patch avoids that building with W=1 triggers complaints about
> switch fall-throughs.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

LGTM, applying.
