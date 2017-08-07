Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750751AbdHGMyQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 7 Aug 2017 08:54:16 -0400
Date: Mon, 7 Aug 2017 14:54:13 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Anton Volkov <avolkov@ispras.ru>
Cc: tom.leiming@gmail.com, axboe@fb.com, osandov@fb.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        ldv-project@linuxtesting.org, khoroshilov@ispras.ru
Subject: Re: [PATCH] loop: fix to a race condition due to the early
 registration of device
Message-ID: <20170807125413.GZ3978@linux-x5ow.site>
References: <CACVXFVN-pKP5zePBvUtKkpEkOi=1fr+ePsudxbciN993BHGzNA@mail.gmail.com>
 <1502109470-2945-1-git-send-email-avolkov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1502109470-2945-1-git-send-email-avolkov@ispras.ru>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Aug 07, 2017 at 03:37:50PM +0300, Anton Volkov wrote:
> +err_out:
>  	return err;

Any reason you can't just use return err; at the respective callsites?

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
