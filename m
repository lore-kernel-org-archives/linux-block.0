Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-by2nam01on0077.outbound.protection.outlook.com ([104.47.34.77]:18896
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751084AbdALVSR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 16:18:17 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH 03/10] block: move rq_ioc() to blk.h
Date: Thu, 12 Jan 2017 21:18:14 +0000
Message-ID: <1484255880.2720.13.camel@sandisk.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
         <1484170803-9311-4-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-4-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-11 at 14:39 -0700, Jens Axboe wrote:
> We want to use it outside of blk-core.c.

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
