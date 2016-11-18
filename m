Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35676 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbcKRJdi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Nov 2016 04:33:38 -0500
Received: by mail-qk0-f195.google.com with SMTP id n204so30818800qke.2
        for <linux-block@vger.kernel.org>; Fri, 18 Nov 2016 01:33:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161117103044.GD8295@infradead.org>
References: <CAK0tqik5oMda+Avk17pR8rX_CS0vCpoPPp3LioEtcgyG3Ex8Ww@mail.gmail.com>
 <20161117103044.GD8295@infradead.org>
From: chaitany kulkarni <ckulkarnilinux@gmail.com>
Date: Fri, 18 Nov 2016 01:33:36 -0800
Message-ID: <CAK0tqikMTzZB=RtRW07fuepC1xWb=oBvqR0+FvwT4ifsNcm6+Q@mail.gmail.com>
Subject: Re: [PATCH 3/5] nvme.h: add Write Zeroes definitions
To: Christoph Hellwig <hch@infradead.org>
Cc: axboe@fb.com, "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <keith.busch@intel.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I'll resend entire series with v2 prefix and add whitespaces fix along
with other comments.

On Thu, Nov 17, 2016 at 2:30 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Nov 15, 2016 at 11:06:58PM -0800, chaitany kulkarni wrote:
>> Add the command structure, optional command set support (ONCS) bit and
>> a new error code for the Write Zeroes command.
>>
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>
>
> Unlike the other patches this one looks white space damaged by a mail
> client (and it also arrived out of sequence).
>
> With the whitespaces fixed up this looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
