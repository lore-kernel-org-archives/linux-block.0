Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:59514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbdAXNeT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 08:34:19 -0500
Date: Tue, 24 Jan 2017 05:34:18 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Matias =?iso-8859-1?Q?Bj=F8rling?= <m@bjorling.me>
Cc: Christoph Hellwig <hch@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: BUG: KASAN: Use-after-free
Message-ID: <20170124133418.GA18377@infradead.org>
References: <0b458b92-62ee-bffc-8f3e-fbd6490b26fd@bjorling.me>
 <20170123172021.GA28446@infradead.org>
 <400b4572-0994-8950-582b-c3372333f6c8@bjorling.me>
 <20170124095209.GA22003@infradead.org>
 <60a5b26d-8819-4e8c-ecfa-b16659b0aa44@bjorling.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <60a5b26d-8819-4e8c-ecfa-b16659b0aa44@bjorling.me>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Jan 24, 2017 at 11:01:42AM +0100, Matias Bj�rling wrote:
> Yup. That fixes it. Should I put together the patch, or will you take
> care of it?

I'll send it out.  Of course with proper reporting credits for you.
