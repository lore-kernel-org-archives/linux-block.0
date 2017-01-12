Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam03on0049.outbound.protection.outlook.com ([104.47.42.49]:32804
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750730AbdALVx4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 16:53:56 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH 09/10] mq-deadline: add blk-mq adaptation of the
 deadline IO scheduler
Date: Thu, 12 Jan 2017 21:53:48 +0000
Message-ID: <1484258011.2720.22.camel@sandisk.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
         <1484170803-9311-10-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-10-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-11 at 14:40 -0700, Jens Axboe wrote:
> This is basically identical to deadline-iosched, except it registers
> as a MQ capable scheduler. This is still a single queue design.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
