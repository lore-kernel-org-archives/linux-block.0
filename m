Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2nam02on0071.outbound.protection.outlook.com ([104.47.38.71]:38301
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750760AbdALVTE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 16:19:04 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH 04/10] blk-mq: un-export blk_mq_free_hctx_request()
Date: Thu, 12 Jan 2017 21:18:54 +0000
Message-ID: <1484255920.2720.14.camel@sandisk.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
         <1484170803-9311-5-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-5-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-11 at 14:39 -0700, Jens Axboe wrote:
> It's only used in blk-mq, kill it from the main exported header
> and kill the symbol export as well.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
