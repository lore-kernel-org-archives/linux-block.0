Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751426AbdHGNZE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Aug 2017 09:25:04 -0400
Date: Mon, 7 Aug 2017 15:24:58 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Anton Volkov <avolkov@ispras.ru>
Cc: tom.leiming@gmail.com, axboe@fb.com, osandov@fb.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ldv-project@linuxtesting.org, khoroshilov@ispras.ru
Subject: Re: [PATCH] loop: fix to a race condition due to the early
 registration of device
Message-ID: <20170807132458.GA3978@linux-x5ow.site>
References: <CACVXFVN-pKP5zePBvUtKkpEkOi=1fr+ePsudxbciN993BHGzNA@mail.gmail.com>
 <1502109470-2945-1-git-send-email-avolkov@ispras.ru>
 <20170807125413.GZ3978@linux-x5ow.site>
 <e99d4f73-5d73-8141-558f-c918245abc42@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <e99d4f73-5d73-8141-558f-c918245abc42@ispras.ru>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 07, 2017 at 04:09:12PM +0300, Anton Volkov wrote:
> This is more of a style-oriented suggestion. This kind of template is
> commonly used in other modules.

Yes but there is no point in using gotos here (i.e. cleanup to be done), you
an just return directly.

And yes it is a minor nit.

Anyways,

Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
