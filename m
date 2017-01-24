Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35368 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750721AbdAXNh1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 08:37:27 -0500
Received: by mail-wm0-f49.google.com with SMTP id r126so182462997wmr.0
        for <linux-block@vger.kernel.org>; Tue, 24 Jan 2017 05:37:27 -0800 (PST)
Subject: Re: BUG: KASAN: Use-after-free
To: Christoph Hellwig <hch@infradead.org>
References: <0b458b92-62ee-bffc-8f3e-fbd6490b26fd@bjorling.me>
 <20170123172021.GA28446@infradead.org>
 <400b4572-0994-8950-582b-c3372333f6c8@bjorling.me>
 <20170124095209.GA22003@infradead.org>
 <60a5b26d-8819-4e8c-ecfa-b16659b0aa44@bjorling.me>
 <20170124133418.GA18377@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <m@bjorling.me>
Message-ID: <2049899a-e0cc-6eab-5b3c-cf962a6d6229@bjorling.me>
Date: Tue, 24 Jan 2017 14:37:25 +0100
MIME-Version: 1.0
In-Reply-To: <20170124133418.GA18377@infradead.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/24/2017 02:34 PM, Christoph Hellwig wrote:
> On Tue, Jan 24, 2017 at 11:01:42AM +0100, Matias Bj�rling wrote:
>> Yup. That fixes it. Should I put together the patch, or will you take
>> care of it?
> 
> I'll send it out.  Of course with proper reporting credits for you.
> 

Awesome. Thanks
