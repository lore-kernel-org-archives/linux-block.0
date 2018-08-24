Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: MQ-BFQ crashing on battery mode
To: Massimo Burcheri <massimo@burcheri.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <1534926011.18658.29.camel@burcheri.de>
 <a43c5bdd-06ec-ae23-ebd3-bda8c0ea4f5c@kernel.dk>
 <1535092156.11909.8.camel@burcheri.de>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <f2983f77-8cc7-2734-9acb-c2cea4a90bd8@oracle.com>
Date: Fri, 24 Aug 2018 15:12:50 +0800
MIME-Version: 1.0
In-Reply-To: <1535092156.11909.8.camel@burcheri.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Massimo

On 08/24/2018 02:29 PM, Massimo Burcheri wrote:
> On Wed, 2018-08-22 at 11:42 -0600, Jens Axboe wrote:
>> Any chance you can try 4.18 at least?
> Of course, I tried the kernel.org sources now, sys-kernel/vanilla-sources-4.18.3 
> on Gentoo. The issue is the same.

In the first mail of this thread, you said:
"
Switching all devices to "none" scheduler did not help
"

So this issue should not related with io scheduler.

Would you please share the entire dmesg log or backtrace you got on 4.18.3 ?

Thanks
Jianchao
