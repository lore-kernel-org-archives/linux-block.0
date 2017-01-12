Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam02on0083.outbound.protection.outlook.com ([104.47.36.83]:58404
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750835AbdALVya (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 16:54:30 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH 10/10] blk-mq-sched: allow setting of default IO
 scheduler
Date: Thu, 12 Jan 2017 21:54:20 +0000
Message-ID: <1484258046.2720.23.camel@sandisk.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
         <1484170803-9311-11-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-11-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-11 at 14:40 -0700, Jens Axboe wrote:
> Add Kconfig entries to manage what devices get assigned an MQ
> scheduler, and add a blk-mq flag for drivers to opt out of scheduling.
> The latter is useful for admin type queues that still allocate a blk-mq
> queue and tag set, but aren't use for normal IO.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
