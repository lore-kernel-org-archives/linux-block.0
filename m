Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-bl2nam02on0059.outbound.protection.outlook.com ([104.47.38.59]:28874
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966330AbcKAOYI (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Nov 2016 10:24:08 -0400
Subject: Re: [PATCH 10/16] fs: decouple READ and WRITE from the block layer
 ops
To: Christoph Hellwig <hch@lst.de>, <axboe@fb.com>
References: <1478007617-18715-1-git-send-email-hch@lst.de>
 <1478007617-18715-11-git-send-email-hch@lst.de>
CC: <linux-block@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <8da714d4-067a-6fdf-0ac2-0d89a2980071@sandisk.com>
Date: Tue, 1 Nov 2016 08:23:54 -0600
MIME-Version: 1.0
In-Reply-To: <1478007617-18715-11-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 11/01/2016 07:40 AM, Christoph Hellwig wrote:
> +/* generic data direction defintions */
> +#define READ			0
> +#define WRITE			1

Hello Christoph,

If you have to resend this patch series, please fix the spelling of 
"definitions".

Thanks,

Bart.
