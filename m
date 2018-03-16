Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f42.google.com ([209.85.160.42]:41548 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbeCPSyA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Mar 2018 14:54:00 -0400
Received: by mail-pl0-f42.google.com with SMTP id b7-v6so2362406plr.8
        for <linux-block@vger.kernel.org>; Fri, 16 Mar 2018 11:54:00 -0700 (PDT)
Subject: Re: [PATCH 07/16] bcache: Reduce the number of sparse complaints
 about lock imbalances
To: Bart Van Assche <bart.vanassche@wdc.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-8-bart.vanassche@wdc.com>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <300ff76d-2772-045c-7488-a8afd48db36e@lyle.org>
Date: Fri, 16 Mar 2018 11:53:58 -0700
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-8-bart.vanassche@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/15/2018 08:08 AM, Bart Van Assche wrote:
> Add more annotations for sparse to inform it about which functions do
> not have the same number of spin_lock() and spin_unlock() calls.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

LGTM, applying.  -mpl
