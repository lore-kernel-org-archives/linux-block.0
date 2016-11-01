Return-Path: <linux-block-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:53660 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424432AbcKAOas (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Nov 2016 10:30:48 -0400
Date: Tue, 1 Nov 2016 15:30:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@fb.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/16] fs: decouple READ and WRITE from the block layer
        ops
Message-ID: <20161101143046.GA17690@lst.de>
References: <1478007617-18715-1-git-send-email-hch@lst.de> <1478007617-18715-11-git-send-email-hch@lst.de> <8da714d4-067a-6fdf-0ac2-0d89a2980071@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8da714d4-067a-6fdf-0ac2-0d89a2980071@sandisk.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Nov 01, 2016 at 08:23:54AM -0600, Bart Van Assche wrote:
> On 11/01/2016 07:40 AM, Christoph Hellwig wrote:
>> +/* generic data direction defintions */
>> +#define READ			0
>> +#define WRITE			1
>
> Hello Christoph,
>
> If you have to resend this patch series, please fix the spelling of 
> "definitions".

Thanks Bart, that's one of my favourite misspelling that I keep getting
wrong again and again..
