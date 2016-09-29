Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 29 Sep 2016 10:40:59 +0200
From: Tejun Heo <tj@kernel.org>
To: Adam Manzanares <adam.manzanares@hgst.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/3] block: Add iocontext priority to request
Message-ID: <20160929084059.GB11087@mtj.duckdns.org>
References: <1475000096-6148-1-git-send-email-adam.manzanares@hgst.com>
 <1475000096-6148-2-git-send-email-adam.manzanares@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1475000096-6148-2-git-send-email-adam.manzanares@hgst.com>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Tue, Sep 27, 2016 at 11:14:54AM -0700, Adam Manzanares wrote:
> Patch adds association between iocontext and a request.
> 
> Signed-off-by: Adam Manzanares <adam.manzanares@hgst.com>

Can you please describe how this may impact existing usages?

Thanks.

-- 
tejun
