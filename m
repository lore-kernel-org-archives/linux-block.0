Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:46225 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750810AbeB0S3Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 13:29:24 -0500
Received: by mail-pg0-f42.google.com with SMTP id r26so2604044pgv.13
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2018 10:29:24 -0800 (PST)
Subject: Re: [PATCH v7 0/9] bcache: device failure handling improvement
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <20180227165557.20442-1-colyli@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <d49160a9-cfee-1547-f08a-dcf83daba6f6@lyle.org>
Date: Tue, 27 Feb 2018 10:29:21 -0800
MIME-Version: 1.0
In-Reply-To: <20180227165557.20442-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Coly Li--

On 02/27/2018 08:55 AM, Coly Li wrote:
> Hi maintainers and folks,
> 
> This patch set tries to improve bcache device failure handling, includes
> cache device and backing device failures.

I have applied 1, 2, 4 & 6 from this series to my 4.17 bcache-for-next
for testing.

Mike
