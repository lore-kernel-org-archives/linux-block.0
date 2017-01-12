Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0071.outbound.protection.outlook.com ([104.47.40.71]:37408
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750797AbdALVWu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Jan 2017 16:22:50 -0500
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "osandov@osandov.com" <osandov@osandov.com>
Subject: Re: [PATCH 06/10] blk-mq-tag: cleanup the normal/reserved tag
 allocation
Date: Thu, 12 Jan 2017 21:22:43 +0000
Message-ID: <1484256148.2720.17.camel@sandisk.com>
References: <1484170803-9311-1-git-send-email-axboe@fb.com>
         <1484170803-9311-7-git-send-email-axboe@fb.com>
In-Reply-To: <1484170803-9311-7-git-send-email-axboe@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-01-11 at 14:39 -0700, Jens Axboe wrote:
> This is in preparation for having another tag set available. Cleanup
> the parameters, and allow passing in of tags fo blk_mq_put_tag().

It seems like an 'r' is missing from the description ("tags fo")?

Anyway:

Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>=
