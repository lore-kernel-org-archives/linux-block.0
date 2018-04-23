Return-Path: <martin@lichtvoll.de>
From: Martin Steigerwald <martin@lichtvoll.de>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, bart.vanassche@wdc.com, tj@kernel.org, ming.lei@redhat.com, stable@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: start request gstate with gen 1
Date: Mon, 23 Apr 2018 10:39:27 +0200
Message-ID: <2502316.XbMSM6V44W@merkaba>
In-Reply-To: <3737bdcd-f04b-4510-2673-baa6dcdcb557@oracle.com>
References: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com> <2612135.Ur0PZolWSD@merkaba> <3737bdcd-f04b-4510-2673-baa6dcdcb557@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-block@vger.kernel.org>

Hi Jianchao.

jianchao.wang - 17.04.18, 16:34:
> On 04/17/2018 08:10 PM, Martin Steigerwald wrote:
> > For testing it I add it to 4.16.2 with the patches I have already?
> 
> You could try to only apply this patch to have a test. :)

I tested 4.16.3 with just your patch (+ the unrelated btrfs trimming fix 
I carry for a long time already) and it did at least 15 boots 
successfully (without hanging). So far also no "error loading smart data 
mail", but it takes a few days with suspend/hibernation + resume cycles 
in order to know for sure.

Thanks,
-- 
Martin
